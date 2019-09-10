FROM ubuntu:latest

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
      build-essential \
      curl \
      git \
      liblzma-dev \
      mysql-client \
      patch \
      postgresql-client \
      tmux \
      vim \
      wget \
      zlib1g-dev \
#
# Install Digital Ocean control tools
    && curl -sL https://github.com/digitalocean/doctl/releases/download/v1.30.0/doctl-1.30.0-linux-386.tar.gz | tar -xzv \
    && mv doctl /usr/local/bin \
#
# Install kubectl
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
#
# Install Google Cloud Command-Line Tools
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && apt-get install -y apt-transport-https ca-certificates \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
    && apt-get update && apt-get install -y google-cloud-sdk \
#
# Install Docker CLI
    && apt-get install -y apt-transport-https ca-certificates curl software-properties-common \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" \
    && apt update \
    && apt install -y docker-ce \
#
# Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*