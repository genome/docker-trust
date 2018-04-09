################################################################################
################### define base image and labels ###############################
FROM ubuntu:16.04

LABEL "trust_license"="GNU GENERAL PUBLIC LICENSE: Version 2"
LABEL "Description"="Tcr Receptor Utilities for Solid Tissue: https://bitbucket.org/liulab/trust"

################################################################################
########## run update and install necessary tools ##############################

RUN apt-get update && apt-get install -y \
    build-essential \
    python \
    curl \
    python-setuptools \
    python-dev \
    libbz2-dev \
    python-pip \
    python-biopython \
    python-numpy \
    zlib1g-dev \
    liblzma-dev

################################################################################
########### set variables ######################################################

ENV TRUSTLOC liulab-trust-72a260af3e2e
ENV version 3.0.1

################################################################################
##################### install trust ############################################

RUN curl -L https://bitbucket.org/liulab/trust/get/${version}.tar.gz > /usr/bin/trust.${version}.gz

WORKDIR /usr/bin/

RUN tar -xzvf trust.${version}.gz

WORKDIR /usr/bin/${TRUSTLOC}/

RUN python setup.py install

################################################################################
#################### set the path ##############################################

ENV PATH="/usr/bin/${TRUSTLOC}/bin:${PATH}"
