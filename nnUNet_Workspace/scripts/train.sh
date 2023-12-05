#!/usr/bin/env bash
folds=(0 1 2 3 4)
plans=("2d" "3d_fullres")
for plan in "${plans[@]}"; do
	for fold in "${folds[@]}"; do
		# 1. For 1-GPU-Training
		/root/miniconda3/envs/nnunet01/bin/nnUNet_train $plan nnUNetTrainerV2 Task999_CMB $fold --npz
		
		# 2.For Data parallel training
		# CUDA_VISIBLE_DEVICES=0,1,2,3,4 /root/miniconda3/envs/nnunet01/bin/nnUNet_train_DP $plan nnUNetTrainerV2_DP Task999_CMB $fold -gpus 5 --npz
	done
done
