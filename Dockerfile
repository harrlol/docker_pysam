FROM ubuntu:18.04

LABEL This Dockerfile is for HAMRLNC. It is maintained by Harry Li <harrli02@sas.upenn.edu> & Chosen Obih <chosenobih@arizona.edu>
ENV DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update && apt-get install -y g++ \
		build-essential \
	   	make \
		git \
		wget 

# Downlaod and install conda
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py39_23.11.0-2-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh
ENV PATH /opt/conda/bin:$PATH

# Conda channels
RUN conda config --add channels conda-forge && \
    conda config --add channels bioconda && \
    conda config --add channels r

RUN conda install python -y

RUN conda install pysam -y


ENV PATH /usr/bin/:$PATH

# HAMRLNC wrapper script
ADD pysam.sh $BINPATH
RUN chmod +x $BINPATH/pysam.sh

ENTRYPOINT ["pysam.sh"]
