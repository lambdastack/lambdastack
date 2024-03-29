FROM python:3.7-slim

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ARG HELM_VERSION=3.3.1
ARG KUBECTL_VERSION=1.20.12
ARG ISTIOCTL_VERSION=1.8.1

RUN : INSTALL APT REQUIREMENTS \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get -q update \
 && apt-get -q install -y --no-install-recommends \
    apt-utils dialog \
 && apt-get -q install -y --no-install-recommends \
    autossh curl gcc git git-lfs \
    jq libc6-dev libcap2-bin libffi-dev lsb-release \
    make musl-dev openssh-client procps \
    psmisc ruby-full sudo tar \
    unzip vim \
 && apt-get -q autoremove -y \
 && apt-get -q clean -y \
 && rm -rf /var/lib/apt/lists/*

RUN : INSTALL HELM BINARY \
 && curl -fsSLO https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
 && tar -xzof ./helm-v${HELM_VERSION}-linux-amd64.tar.gz --strip=1 -C /usr/local/bin linux-amd64/helm \
 && rm ./helm-v${HELM_VERSION}-linux-amd64.tar.gz \
 && helm version \
 && : INSTALL KUBECTL BINARY \
 && curl -fsSLO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
 && chmod +x ./kubectl \
 && mv ./kubectl /usr/local/bin/kubectl \
 && kubectl version --client \
 && : INSTALL ISTIOCTl BINARY \
 && curl -fsSLO https://github.com/istio/istio/releases/download/${ISTIOCTL_VERSION}/istioctl-${ISTIOCTL_VERSION}-linux-amd64.tar.gz \
 && tar -xzof istioctl-${ISTIOCTL_VERSION}-linux-amd64.tar.gz -C /usr/local/bin istioctl \
 && rm istioctl-${ISTIOCTL_VERSION}-linux-amd64.tar.gz \
 && chmod +x /usr/local/bin/istioctl

RUN : INSTALL GEM REQUIREMENTS \
 && gem install \
    rake rspec_junit_formatter serverspec solargraph rubocop rubocop-junit_formatter

COPY requirements.txt /

RUN : INSTALL PIP REQUIREMENTS \
 && pip install --disable-pip-version-check --no-cache-dir --default-timeout=100 \
    --requirement /requirements.txt \
 && pip install --disable-pip-version-check --no-cache-dir --default-timeout=100 \
    poetry pylint pylint_junit ansible-lint ansible-lint-to-junit-xml yamllint pytest setuptools twine wheel

RUN : SETUP USER AND OTHERS \
 && groupadd --gid $USER_GID $USERNAME \
 && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
 && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
 && chmod ug=r,o= /etc/sudoers.d/$USERNAME \
 && setcap 'cap_net_bind_service=+ep' /usr/bin/ssh

RUN : SETUP LSCLI ALIAS \
 && echo alias lambdastack='"export PYTHONPATH=/workspaces/lambdastack && python3 -m cli.lambdastack"' >> /etc/bash.bashrc
