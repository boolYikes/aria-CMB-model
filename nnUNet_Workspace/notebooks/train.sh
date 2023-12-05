#!/usr/bin/env bash

folds=(0 1 2 3 4)
plans=("2d" "3d_fullres")
dataset=1
for plan in "${plans[@]}"; do
	for fold in "${folds[@]}"; do
		nnUNet2_train $dataset $plan $fold --npz
	done
done
