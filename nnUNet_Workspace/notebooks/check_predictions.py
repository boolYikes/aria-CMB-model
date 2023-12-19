import os
import numpy as np
import nibabel as nib

def check(path):
    l = os.listdir(path)
    fin_l = []
    for f in l:
        if ".nii.gz" in f:
            fin_l.append(os.path.join(path, f))

    fin_dic = {}
    for path in fin_l:
        img = nib.load(path).get_fdata().astype(int)
        pnum = os.path.basename(path).split(".nii.gz")[0]
        fin_dic[pnum] = np.unique(img)
    return fin_dic

p2d = "/workspace/dwseon/dat/pred2d"
p3d = "/workspace/dwseon/dat/pred3d"
print("2D result:")
for key, val in check(p2d).items():
    print(f"Patient {key}'s label unique marker: {val}")

print("\n3D result:")
for key, val in check(p3d).items():
    print(f"Patient {key}'s label unique marker: {val}")
