FROM ubuntu:latest

RUN apt-get update \
    && apt-get install -y \
      build-essential \
      curl \
      git \
      liblzma-dev \
      patch \
      tmux \
      vim \
      wget \
      zlib1g-dev \

##
## Install Digital Ocean control tools
    && curl -sL https://github.com/digitalocean/doctl/releases/download/v1.30.0/doctl-1.30.0-linux-386.tar.gz | tar -xzv \
    && mv doctl /usr/local/bin \
##
## Install kubectl
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

##
## TODO: Install Google Cloud Command-Line Tools