# Base
FROM ubuntu:20.04

# Variables
ENV MINICONDA_VERSION=latest
ENV PYTHON_VERSION=3.11
ENV TINI_VERSION=v0.19.0
ARG CMB_VER=latest
RUN export CMB_VER=${CMB_VER} && echo "CMB_VER=$CMB_VER" >> /etc/environment

# Prereq
RUN apt update && apt upgrade -y && \
    apt install build-essential wget vim git curl -y

# Tini for process wrapping and reaping
RUN curl -fsSL https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini -o /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

# Miniconda
RUN curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh -o /tmp/miniconda.sh && \
    /bin/bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh

# Conda with python spec
RUN /opt/conda/bin/conda install --yes conda python=${PYTHON_VERSION} && \
    /opt/conda/bin/conda clean --all --yes

# Conda path
ENV PATH=/opt/conda/bin:$PATH

# BET & nnUNet?
RUN git clone https://github.com/MIC-DKFZ/HD-BET /HD-BET

# Activate and install : BET and nnUNet prolly use slightly diff cuda, so we need sprt env
## BET
RUN /opt/conda/bin/conda create -n bet python=3.9 -y
RUN /opt/conda/bin/conda run -n bet pip install -e /HD-BET
## nnUNet
RUN /opt/conda/bin/conda create -n nnunet python=3.9 -y
RUN /opt/conda/bin/conda run -n nnunet conda install pytorch torchvision torchaudio pytorch-cuda=12.1 -c pytorch -c nvidia
RUN /opt/conda/bin/conda run -n nnunet pip install nnunet

# Insert init script here as needed
## Copy model weights
RUN mkdir -p /dat/pre && mkdir -p /dat/raw
RUN mkdir -p /dat/res/nnUNet/3d_fullres/Task999_CMB/nnUNetTrainerV2__nnUNetPlansv2.1
COPY ./nnUNetTrainerV2__nnUNetPlansv2.1 /dat/res/nnUNet/3d_fullres/Task999_CMB/nnUNetTrainerV2__nnUNetPlansv2.1
RUN chmod -R 755 /dat/res/nnUNet/3d_fullres/Task999_CMB/nnUNetTrainerV2__nnUNetPlansv2.1
## Copy aliases and script stuff
COPY ./.bash_aliases /root/.bash_aliases
COPY ./paths.py /opt/conda/envs/nnunet/lib/python3.9/site-packages/nnunet/

# Tini wrapping
ENTRYPOINT ["/usr/local/bin/tini", "--", "/bin/bash", "-c"]

CMD ["tail", "-f", "/dev/null"]

