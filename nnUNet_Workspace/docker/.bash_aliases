#!/usr/bin/env bash
clear
echo -e "PLACEHOLDER!"
echo -e "Docker image \033[31mv$NAMBA\033[0m"
python --version | grep -E "..*"
echo -ne "Torch: \033[32m" && \
       	python -c "import torch, torch.__version__" && \
       	echo -ne "\033[0m, CUDA: \033[33m" && \
       	python -c "import torch, torch.cuda.is_available()" && \
	nvidia-smi | grep -o "CUDA.*"
