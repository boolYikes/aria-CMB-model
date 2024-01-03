# Use the official NVIDIA CUDA base image
FROM nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04

# Set environment variables
ENV MINICONDA_VERSION=latest
ENV PYTHON_VERSION=3.11.5
ENV TINI_VERSION=v0.19.0

# Prereq
RUN apt-get update
RUN apt-get install -y wget curl

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

# Set the entry point using Tini
ENTRYPOINT ["/usr/local/bin/tini", "--"]

