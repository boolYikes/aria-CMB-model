### Finetuning 실행 방법 (도커 컨테이너 시작 후 내부 셸에서 실행한다)

1. 아무 곳에나 준비한 데이터셋을 두고, 환경변수 export
```bash
export nnUNet_raw_data_base="/workspace/dwseon/dat/raw"
export nnUNet_preprocessed="/workspace/dwseon/dat/pre"
export RESULTS_FOLDER="/workspace/dwseon/dat/res"
```

2. nnunet 설치 폴더의 dataset_conversion폴더에서 TaskXXX_YYY.py중 하나를 내 데이터에 맞게 편집 한다 : 999번으로 함

3. `python TaskXXX_YYY.py` 를 실행하면 데이터셋이 제이슨과 함꼐 준비 된다. (환경변수에서 설정한 nnunet_raw… 디렉토리에 들어감)

4. `nUNet_plan_and_preprocess -t XXX --verify_dataset_integrity` 를 실행하면 데이터셋에 적절한 ‘플랜’이 만들어짐 (환경변수 nnunet_preprocess… 디렉토리에 들어감)

5. /scripts/train.py 를 환경에 맞게 (GPU개수 등) 수정해서 실행한다.

6. `nnUNet_find_best_configuration -t 999 -m 2d --disable_ensembling` *를 내 데이터에 대한 플랜 별로 실행한다(앙상블 안되서 먼저 이거 실행 후 수동으로 앙상블 함.)
   *: 2번째 train에서는 —-disable_ensembling 없이도 됨 / 플랜은 3d_fullres만 돌림

7. predict: inference gpus load: 약 2500MB
```docker
nnUNet_predict -i FOLDER_WITH_TEST_CASES \ # 3번에서 json에 imagesTs를 설정해줬다면 해당 패쓰에 생성되어있음
 -o OUTPUT_FOLDER_MODEL1 \ # 원하는곳 지정
 -tr nnUNetTrainerV2 \
 -ctr nnUNetTrainerV2CascadeFullRes \
 -m 3d_fullres \
 -p nnUNetPlansv2.1 \
 -t Task999_CMB \
 --save_npz # 앙상블 위해서 softmax 저장
```

8. ensemble
```docker
# 역시 위에서 --disable_ensembling 안하면 안되는듯. 
# 이 부분은 API안쓰고 수동으로 계산 해야할듯
**# GJ 서버에서 deploy 하면 패키지 버전이 맞아서 될 수도 있음**
nnUNet_ensemble -f FOLDER1 FOLDER2 ... -o OUTPUT_FOLDER -pp POSTPROCESSING_FILE
```
