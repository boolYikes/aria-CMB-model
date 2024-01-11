### 도커파일: /storage/dee/docker/Dockerfile

> 스크립트: /storage/dee/docker/run, /storage/dee/docker/infer
> 

> COPY 인스트럭션 준비:
> 
> - 훈련결과가 있는 $RESULTS_FOLDER 에서 fold_0 ~ fold_4과 plans.pkl, postprocessing.json을 /storage/dee/docker 로 복사
> 
> ```
> dat/res/nnUNet/3d_fullres/Task999_CMB \
> /nnUNetTrainerV2__nnUNetPlansv2.1 << 요 폴더를 docker 폴더에 복사
> (니프티 들어있는 폴더는 삭제해도 됨)
> ```
> 
> - nnunet site-package의 nnunet/paths.py 수정해서 /storage/dee/docker/ 에 복사(이미 /storage/dee/docker에 넣어둠. (Results_folder 경로 부분 수정해주면 됨)

```bash
# 1. 빌드
cd /storage/dee/docker
# 2.2가 있으면 run 하고 없으면 빌드 함
./run /storage/dee 2.2

# 2. BET 및 Inference
./infer 파일이름(abc.nii.gz) 환자번호(001)
```

### 이미지 업로드 폴더: /storage/dee/Data/b4_strip

### 아웃풋 폴더: /storage/dee/Data/cmb
