import os
import subprocess

TARG_SET = 1
pre_dir = os.environ.get("nnUNet_preprocessed")
pre_dir = [dataset for dataset in os.listdir(pre_dir)]
pre_dir = pre_dir[TARG_SET-1]
pre_dir = os.path.join(os.environ.get("nnUNet_preprocessed"), pre_dir)

plans = []
for stuff in os.listdir(pre_dir):
    if "nnUNetPlans_" in stuff:
        plans.append(stuff.split("nnUNetPlans_")[1])

FOLDS = [0, 1, 2, 3, 4]
for plan in plans:
    for fold in FOLDS:
        bash = ["nnUNetv2_train", str(TARG_SET), plan, str(fold), "--npz"]
        result = subprocess.run(bash, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print("return code:", result.returncode)
        print("STDOUT:")
        print(result.stdout.decode())
        print("STDERR:")
        print(result.stderr.decode())
