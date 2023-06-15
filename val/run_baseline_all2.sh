export https_proxy=http://10.7.4.2:3128
export PYTHONPATH=/mnt/mmtech01/usr/liuwenzhuo/code/test-code/MSC-dali
/root/miniconda3/envs/solo-learn/bin/python  msc_val_baseline_all2.py \
  --checkpoint_path /mnt/mmtech01/usr/liuwenzhuo/code/test-code/MSC-dali/baseline/checkpoints/resnet50-baseline/last.ckpt\
  --dataset_path /mnt/mmtech01/dataset/lzy/ILSVRC2012 \
  --project msc-val\
  --run_name resnet50-baseline\
  --method resnet50-2

/root/miniconda3/envs/solo-learn/bin/python  msc_val_baseline_all2.py \
  --checkpoint_path /mnt/mmtech01/usr/liuwenzhuo/code/test-code/MSC-dali/baseline/checkpoints/vgg16-bn-baseline/last.ckpt\
  --dataset_path /mnt/mmtech01/dataset/lzy/ILSVRC2012 \
  --project msc-val\
  --run_name vgg16-bn-baseline\
  --method vgg16_bn-2


/root/miniconda3/envs/solo-learn/bin/python  msc_val_baseline_all2.py \
  --checkpoint_path /mnt/mmtech01/usr/liuwenzhuo/code/test-code/MSC-dali/baseline/checkpoints/densenet121-baseline/last.ckpt\
  --dataset_path /mnt/mmtech01/dataset/lzy/ILSVRC2012 \
  --project msc-val\
  --run_name densenet121-baseline\
  --method densenet121-2

/root/miniconda3/envs/solo-learn/bin/python  msc_val_baseline_all2.py \
  --checkpoint_path /mnt/mmtech01/usr/liuwenzhuo/code/test-code/MSC-dali/baseline/checkpoints/mobilenetv2-baseline/last.ckpt\
  --dataset_path /mnt/mmtech01/dataset/lzy/ILSVRC2012 \
  --project msc-val\
  --run_name mobilenetv2-baseline\
#  --method mobilenetv2-2

#      elif args.method == 'resnext50':
#        from torchvision.models import resnext50_32x4d
#        model = resnext50_32x4d(pretrained=True)
#    elif args.method == 'googlenet':
#        from torchvision.models import googlenet
#        model = googlenet(pretrained=True)
#    elif args.method == 'inceptionv3':
#        from torchvision.models import inception_v3
#        model = inception_v3(pretrained=True)
#    elif args.method == 'alexnet':


/root/miniconda3/envs/solo-learn/bin/python  msc_val_baseline_all2.py \
  --checkpoint_path /mnt/mmtech01/usr/liuwenzhuo/code/test-code/MSC-dali/baseline/checkpoints/vgg16-bn-baseline/last.ckpt\
  --dataset_path /mnt/mmtech01/dataset/lzy/ILSVRC2012 \
  --project msc-val\
  --run_name resnext50-baseline\
  --method resnext50-2


/root/miniconda3/envs/solo-learn/bin/python  msc_val_baseline_all2.py \
  --checkpoint_path /mnt/mmtech01/usr/liuwenzhuo/code/test-code/MSC-dali/baseline/checkpoints/densenet121-baseline/last.ckpt\
  --dataset_path /mnt/mmtech01/dataset/lzy/ILSVRC2012 \
  --project msc-val\
  --run_name googlenet-baseline\
  --method googlenet-2

/root/miniconda3/envs/solo-learn/bin/python  msc_val_baseline_all2.py \
  --checkpoint_path /mnt/mmtech01/usr/liuwenzhuo/code/test-code/MSC-dali/baseline/checkpoints/mobilenetv2-baseline/last.ckpt\
  --dataset_path /mnt/mmtech01/dataset/lzy/ILSVRC2012 \
  --project msc-val\
  --run_name nceptionv3-baseline\
  --method nceptionv3-2

/root/miniconda3/envs/solo-learn/bin/python  msc_val_baseline_all2.py \
  --checkpoint_path /mnt/mmtech01/usr/liuwenzhuo/code/test-code/MSC-dali/baseline/checkpoints/mobilenetv2-baseline/last.ckpt\
  --dataset_path /mnt/mmtech01/dataset/lzy/ILSVRC2012 \
  --project msc-val\
  --run_name alexnet-baseline\
  --method alexnet-2

