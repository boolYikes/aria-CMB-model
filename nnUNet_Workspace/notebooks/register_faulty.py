import SimpleITK as sitk
import numpy as np
import os
# import cv2

#def s_2_cv(im):
#    return sitk.GetArrayFromImage(im)

# TODO: add argparser to get input

test_template = "/workspace/dwseon/dat/b4_raw/001/b4_reg_orig.nii.gz"
target_path = "/workspace/dwseon/dat/b4_raw/002/"
test_target = os.path.join(target_path, "b4_reg_orig.nii.gz")
test_label = os.path.join(target_path, "b4_reg_seg.nii.gz")

template = sitk.ReadImage(test_template)
target = sitk.ReadImage(test_target)
label = sitk.ReadImage(test_label)

# Registration method
reg_method = sitk.ImageRegistrationMethod()
reg_method.SetMetricAsMattesMutualInformation()
reg_method.SetOptimizerAsRegularStepGradientDescent(learningRate=1.0, minStep=0.001, numberOfIterations=100)
reg_method.SetInterpolator(sitk.sitkLinear)

# Derive transform
transform = sitk.CenteredTransformInitializer(template, target, sitk.Euler3DTransform())
reg_method.SetInitialTransform(transform)
final_transform = reg_method.Execute(sitk.Cast(template, sitk.sitkFloat32), sitk.Cast(target, sitk.sitkFloat32))

# Apply transform to target and label
trans_target = sitk.Resample(target, template, final_transform, sitk.sitkLinear, 0.0, target.GetPixelID())
trans_label = sitk.Resample(label, template, final_transform, sitk.sitkLinear, 0.0, label.GetPixelID())

result_target = os.path.join(target_path, "orig.nii.gz")
result_label = os.path.join(target_path, "seg.nii.gz")

sitk.WriteImage(trans_target, result_target)
sitk.WriteImage(trans_label, result_label)
