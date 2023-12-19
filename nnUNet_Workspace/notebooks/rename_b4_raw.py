import os

p = "/workspace/dwseon/dat/b4_raw"

l = os.listdir(p)

for f in l :
    fpath = os.path.join(p, f)
    orig = os.path.join(fpath, "orig.nii.gz")
    seg = os.path.join(fpath, "seg.nii.gz")
    
    orig_to = os.path.join(fpath, "b4_reg_orig.nii.gz")
    seg_to = os.path.join(fpath, "b4_reg_seg.nii.gz")
    
    os.rename(orig, orig_to)
    os.rename(seg, seg_to)
