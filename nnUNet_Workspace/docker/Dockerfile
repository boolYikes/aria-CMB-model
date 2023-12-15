# Parameterize things later for flexible distro.
# TODO: cuda version arg, 
# Composed by dee
# Property of Neurozen, probably.

# Base
FROM ubuntu:20.04

# Set environment variables
ENV MINICONDA_VERSION=latest
ENV PYTHON_VERSION=3.11.5
ENV TINI_VERSION=v0.19.0
ARG NAMBA
ENV NAMBA=${NAMBA}

# Prereq
RUN apt update && apt upgrade -y && \ 
    apt install build-essential wget vim git curl -y

# Download and install Tini
RUN curl -fsSL https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini -o /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

# Download and install Miniconda
RUN curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh -o /tmp/miniconda.sh && \
    /bin/bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh

# Set the conda and python versions
RUN /opt/conda/bin/conda install --yes conda python=${PYTHON_VERSION} && \
    /opt/conda/bin/conda clean --all --yes

# Add conda to the system PATH
ENV PATH=/opt/conda/bin:$PATH

# Create, activate, install, clean
RUN /opt/conda/bin/conda create -n cu111 python=3.6 -y
RUN /opt/conda/bin/conda run -n cu111 conda install pytorch torchvision torchaudio cudatoolkit=11.1 -c pytorch-lts -c nvidia --yes && \
	conda clean --all --yes

# CUDA 11.1 compat patch
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin && \
	mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
	wget https://developer.download.nvidia.com/compute/cuda/11.1.0/local_installers/cuda-repo-ubuntu2004-11-1-local_11.1.0-455.23.05-1_amd64.deb -O /root/cuda-repo-ubuntu2004-11-1-local_11.1.0-455.23.05-1_amd64.deb && \
	dpkg -i /root/cuda-repo-ubuntu2004-11-1-local_11.1.0-455.23.05-1_amd64.deb && \
	apt-key add /var/cuda-repo-ubuntu2004-11-1-local/7fa2af80.pub && \
	apt-get update && \
	apt-get -y install cuda-compat-11-1 && \
	echo "export LD_LIBRARY_PATH=/usr/local/cuda-11.1/compat:$LD_LIBRARY_PATH" >> ~/.bashrc && \
	rm /root/cuda-repo-ubuntu2004-11-1-local_11.1.0-455.23.05-1_amd64.deb

# Container start env
RUN echo "export PATH=/opt/conda/envs/cu111/bin:$PATH" >> ~/.bashrc

# INIT SCRIPT
COPY ./.bash_aliases /root/

# Set the entry point using Tini
ENTRYPOINT ["/usr/local/bin/tini", "--"]


CMD ["/bin/bash", "-c", "source activate cu111 && /bin/bash"]
