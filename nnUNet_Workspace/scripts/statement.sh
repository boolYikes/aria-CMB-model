#!/usr/bin/env bash
clear
echo -e "\033[48;5;161mUbuntu18.04\033[0m-\033[48;5;184mCUDA10.1\033[0m-\033[48;5;202mPytorch1.7\033[0m-\033[48;5;45mPython3.6\033[0m-\033[48;5;217mJupyter\033[0m-\033[48;5;135mnnUNetv1\033[0m"
echo -e "----------------------------------------------------------"
echo -e "v\033[38;5;196m4.3\033[0m, by \033[38;5;87mDee\033[0m"
echo -e "Type command '\033[38;5;201mnote\033[0m' to start \033[38;5;217mJupyter notebook\033[0m"
echo -e "Type command '\033[38;5;201mconda activate nnunet01\033[0m' to start the env."
echo -e "Refer to \033[38;5;213mhttps://github.com/MIC-DKFZ/nnUNet.git\033[0m for \033[38;5;135mnnUNet\033[0m"
echo -e "* * * Under composition * * *"
echo -ne "\033[5;31mCUDA\033[0m status \033[5m: ...\033[0m\r"
/root/miniconda3/envs/nnunet01/bin/python -m torch.utils.collect_env | grep 'CUDA.*avail'
echo -e "----------------------------------------------------------"
