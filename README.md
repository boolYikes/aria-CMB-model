# ...
- 파인튜닝에사용한 도커 이미지: CUDA10.1, x86_64, dgx1서버
	- ```docker pull #####```
- 인퍼런스도커 도커 이미지 : CUDA 12.0, x86_64
  	- 광주 서버 도커이미지 #####/#####
	- 빌드는 nnUNet_Workspace의 dockerfile 참조
- 노션 정리
	- https://
- 도커 내에서 ```/scripts``` 및 ```~/.bashrc``` 에 환경변수 및 스크립트 포함

# Train Instructions
1. dgxbox에서
	- ```docker run -it --rm --name nnunet --gpus all -p 8888:8888 -v /storage2:/workspace --ipc=host user/image:tag /bin/bash```
2. ```conda activate nnunet01```
3. 4번 실행에 앞서 ```/storage2/dwseon/dat/raw/...``` 에 데이터가 준비되어있어야 함
4. ```/nnunet/nnunet/dataset_conversion```의 파이썬 스크립트로 전처리를 해도 되긴 하지만 매뉴얼로 파일 구조 정렬하고 dataset.json 만들었음
	- 4.4에서는 ```dataset_conversion/Task999_CMB.py```를 작성해서 사용함. 
5. 파일구조와 제이슨이 준비가 됐다면
	- ```nnUNet_plan_and_preprocess -t XXX --verify_dataset_integrity```
	- XXX는 데이터셋에 부여해줬던 번호임. 여기서는 999 (최대 999이고 dataset_conversion에서 부여된 적이 없는 번호여야 함)
	- 완료되면 ```/storage2/dwseon/dat/pre``` 에 전처리된 텐서와 메타데이터가 저장됨
6. ```/scripts/./train.py```
   스크립트 내에서 파라미터 조정 가능
