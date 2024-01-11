# ENVs
export PATH=/opt/conda/envs/bet/bin:$PATH
export PATH=/opt/conda/envs/nnunet/bin:$PATH
export nnUNet_raw_data_base="/dat/raw"
export nnUNet_preprocessed="/dat/pre"
export RESULTS_FOLDER="/dat/res"

# Aliases

# Bulletin
clear
echo -e "--------------------------------"
echo -e "\033[31mB\033[0m\033[32mi\033[0m\033[33me\033[0m\033[34mn\033[0m\033[35mv\033[0m\033[36me\033[0m\033[37mn\033[0m\033[38mu\033[0m\033[39me\033[0m\033[31m!\033[0m"
echo -e "Aria-CMB Demo v\033[31m$CMB_VER\033[0m by \033[31mDee\033[0m"
echo -ne "\033[5mSystem check:\033[0m \r"
$(which python) -m torch.utils.collect_env | grep -E "PyTorch version: .*|CUDA used to build PyTorch: .*|OS: .*|CUDA available: .*|Nvidia driver version: .*" | sed "s/version\|used to build PyTorch//g"
python --version
echo -e "--------------------------------"
