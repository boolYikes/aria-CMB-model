FROM ubuntu:latest
RUN apt-get update && \
    apt-get install -y python 3.11 \
    python3-pip

RUN pip3 install JPypel jupyter pandas numpy seaborn scipy matplotlib pyNetLogo SALib configparser SimpleITK
RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

RUN useradd -ms /bin/bash/ jupyter
USER jupyter
WORKDIR home/jupyter
EXPOSE 8888
ENTRYPOINT ["jupyter", "notebook", "--allow-root", "--ip=0.0.0.0", "--port=8888", "--no-browser"]
