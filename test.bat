@echo off
set CUDA_VISIBLE_DEVICES=0

set MODEL_TYPE=%1

rem Diversity and Accuracy Experiments

if "%MODEL_TYPE%"=="Sub_GC_MRNN" (
  echo Using Sub-GC model on COCO (MRNN split)
  python test.py --dump_images 0 --dump_json 1 --num_images -1 ^
   --num_workers 6 --language_eval 1 --beam_size 1 ^
   --gpn_nms_thres 0.55 --gpn_max_subg 1000 ^
   --model pretrained/sub_gc_MRNN/model-60000.pth ^
   --infos_path pretrained/sub_gc_MRNN/infos_topdown-60000.pkl ^
   --only_sent_eval 0 ^
   --use_MRNN_split
)

if "%MODEL_TYPE%"=="Sub_GC_S_MRNN" (
  echo Using Sub-GC-S model on COCO (MRNN split)
  python test.py --dump_images 0 --dump_json 1 --num_images -1 ^
   --num_workers 6 --language_eval 1 --beam_size 1 ^
   --gpn_nms_thres 0.55 --gpn_max_subg 1000 ^
   --model pretrained/sub_gc_MRNN/model-60000.pth ^
   --infos_path pretrained/sub_gc_MRNN/infos_topdown-60000.pkl ^
   --only_sent_eval 0 ^
   --use_MRNN_split ^
   --use_topk_sampling 1 --topk_temp 0.6 --the_k 3
)

if "%MODEL_TYPE%"=="Sub_GC_Kar" (
  echo Using Sub-GC model on COCO (Karpathy split)
  python test.py --dump_images 0 --dump_json 1 --num_images -1 ^
   --num_workers 6 --language_eval 1 --beam_size 2 ^
   --gpn_nms_thres 0.75 --gpn_max_subg 10 ^
   --model pretrained/sub_gc_karpathy/model-60000.pth ^
   --infos_path pretrained/sub_gc_karpathy/infos_topdown-60000.pkl ^
   --only_sent_eval 0
)

if "%MODEL_TYPE%"=="Full_GC_Kar" (
  echo Using Full-GC model on COCO (Karpathy split)
  python test.py --dump_images 0 --dump_json 1 --num_images -1 ^
   --num_workers 6 --language_eval 1 --beam_size 3 ^
   --model pretrained/full_gc/model-33000.pth ^
   --infos_path pretrained/full_gc/infos_topdown-33000.pkl ^
   --only_sent_eval 0 ^
   --use_gpn 0 --noun_fuse 0 --pred_emb_type 2 --gcn_layers 4 --gcn_residual 1 --gcn_bn 1
)

rem Grounding Experiments

if "%MODEL_TYPE%"=="Sub_GC_Flickr" (
  echo Using Sub-GC model on Flickr-30K
  python test.py --dump_images 0 --dump_json 1 --num_images -1 ^
   --num_workers 0 --language_eval 1 --beam_size 2 ^
   --gpn_nms_thres 0.75 --gpn_max_subg 10 ^
   --model pretrained/sub_gc_flickr/model-16000.pth ^
   --infos_path pretrained/sub_gc_flickr/infos_topdown-16000.pkl ^
   --only_sent_eval 0 ^
   --input_label_h5 data/flickr30ktalk_label.h5 --input_json data/flickr30ktalk.json
)

if "%MODEL_TYPE%"=="Sub_GC_Flickr_GRD" (
  echo Using Sub-GC model on Flickr-30K for grounding evaluation
  python test.py --dump_images 0 --dump_json 1 --num_images -1 ^
   --num_workers 6 --language_eval 1 --beam_size 1 ^
   --gpn_nms_thres 0.75 --gpn_max_subg 10 ^
   --model pretrained/sub_gc_flickr/model-16000.pth ^
   --infos_path pretrained/sub_gc_flickr/infos_topdown-16000.pkl ^
   --only_sent_eval 0 ^
   --input_label_h5 data/flickr30ktalk_label.h5 --input_json data/flickr30ktalk.json ^
   --return_att 1
)

rem Controllability Experiments

if "%MODEL_TYPE%"=="Sub_GC_Flickr_CTL" (
  echo Using Sub-GC model on Flickr-30K for controllability evaluation
  python test.py --dump_images 0 --dump_json 1 --num_images -1 ^
   --num_workers 6 --language_eval 1 --beam_size 2 ^
   --gpn_nms_thres 0.75 --gpn_max_subg 10 ^
   --model pretrained/sub_gc_flickr/model-16000.pth ^
   --infos_path pretrained/sub_gc_flickr/infos_topdown-16000.pkl ^
   --only_sent_eval 0 ^
   --input_label_h5 data/flickr30ktalk_label.h5 --input_json data/flickr30ktalk.json ^
   --sct 1 --use_greedy_subg
)

if "%MODEL_TYPE%"=="Sub_GC_Sup_Flickr_CTL" (
  echo Using Sub-GC (Sup.) model on Flickr-30K for controllability evaluation
  python test.py --dump_images 0 --dump_json 1 --num_images -1 ^
   --num_workers 6 --language_eval 1 --beam_size 2 ^
   --gpn_nms_thres 0.75 --gpn_max_subg 10 ^
   --model pretrained/sub_gc_sup_flickr/model-16000.pth ^
   --infos_path pretrained/sub_gc_sup_flickr/infos_topdown-16000.pkl ^
   --only_sent_eval 0 ^
   --input_label_h5 data/flickr30ktalk_label.h5 --input_json data/flickr30ktalk.json ^
   --sct 1 --use_gt_subg
)

pause