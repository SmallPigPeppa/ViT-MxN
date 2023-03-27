import os
import torch
import pytorch_lightning as pl
from pytorch_lightning.loggers import WandbLogger
from pytorch_lightning.callbacks import LearningRateMonitor
from pytorch_lightning.callbacks import ModelCheckpoint
from pytorch_lightning.strategies.ddp import DDPStrategy
from args import parse_args
import torch.nn.functional as F


class MSNetValPL(pl.LightningModule):
    def __init__(self, args):
        super().__init__()
        self.args = args
        self.model = BaselineNetPL.load_from_checkpoint(checkpoint_path=args.val_ckpt_path, args=args).encoder
        self.size_list = list(range(args.start_size, args.end_size, args.interval))

    def forward(self, x):
        return self.model(x)

    def share_step(self, x, target):
        y = self.forward(x)
        acc = (torch.argmax(y, dim=1) == target).float().mean()

        result_dict = {
            'acc': acc
        }
        return result_dict

    def validation_step(self, batch, batch_idx):
        x, target = batch
        dict_list = []
        for size_i in self.size_list:
            x_size_i = F.interpolate(x, size=int(size_i), mode='bilinear')
            dict_i = self.share_step(x_size_i, target)
            dict_size_i = {f'{str(size_i)}_{k}': v for k, v in dict_i.items()}
            dict_list.append(dict_size_i)

        all_size_dict = {k: v for d in dict_list for k, v in d.items()}
        # self.log_dict(all_size_dict)
        return all_size_dict

    def validation_epoch_end(self, outputs):
        acc_list = []
        for size_i in self.size_list:
            avg_acc_size_i = 100 * sum([output[f"{size_i}_acc"] for output in outputs]) / len(outputs)
            acc_list.append(avg_acc_size_i)

        self.columns = [str(i) for i in self.size_list] + ['size']
        self.acc_table = [acc_list + ['acc']]


if __name__ == '__main__':
    pl.seed_everything(5)
    args = parse_args()
    val_ckpt_path = args.val_ckpt_path
    model = MSNetValPL(args)
    wandb_logger = WandbLogger(name=args.name, project=args.project, entity=args.entity, offline=args.offline)
    wandb_logger.watch(model, log="gradients", log_freq=100)
    wandb_logger.log_hyperparams(args)
    checkpoint_callback = ModelCheckpoint(dirpath=args.ckpt_dir, save_last=True, save_top_k=2, monitor="val_acc3")
    trainer = pl.Trainer(gpus=args.num_gpus,
                         max_epochs=args.max_epochs,
                         check_val_every_n_epoch=5,
                         strategy=DDPStrategy(find_unused_parameters=False),
                         precision=16,
                         gradient_clip_val=0.5,
                         logger=wandb_logger,
                         callbacks=[LearningRateMonitor(logging_interval="step"), checkpoint_callback])


    dali_datamodule = ClassificationDALIDataModule(
        train_data_path=os.path.join(args.data_dir, 'train'),
        val_data_path=os.path.join(args.data_dir, 'val'),
        num_workers=args.num_workers,
        batch_size=args.batch_size)

    trainer.validate(model, datamodule=dali_datamodule)
    wandb_logger.log_table(key="acc", columns=model.columns, data=model.acc_table)
