FROM ubuntu:latest

# Prevent install prompts, without persisting env
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
      autoconf \
      automake \
      autotools-dev \
      build-essential \
      bison \
      curl \
      dnsutils \
      git \
      gnupg2 \
      iputils-ping \
      iputils-tracepath \
      libbison-dev \
      libffi-dev \
      libgdbm-dev \
      liblzma-dev \
      libpq-dev \
      libncurses5-dev \
      libreadline-dev \
      libsigsegv2 \
      libssl-dev \
      libtinfo-dev \
      libyaml-0-2 \
      libyaml-dev \
      m4 \
      mysql-client \
      net-tools \
      patch \
      postgresql-client \
      tcpdump \
      tcptrace \
      tmux \
      traceroute \
      vim \
      wget \
      whois \
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
# Install Ruby Version Manager (RVM)
    && apt-add-repository -y ppa:rael-gc/rvm \
    && apt-get install -y rvm \
#
# Install Node Version Manager (NVM)
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash \
#
# Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*