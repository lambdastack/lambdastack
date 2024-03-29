FROM python:3.7-slim

ARG USERNAME=lsuser
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ARG HELM_VERSION=3.3.1
ARG KUBECTL_VERSION=1.20.12
ARG ISTIOCTL_VERSION=1.8.1

ENV LSCLI_DOCKER_SHARED_DIR=/shared
ENV TERM xterm-256color

LABEL maintainer="LambdaStack, LLC. - https://lambdastack.io"
LABEL image="lambdastack"
LABEL kubernetes=$KUBECTL_VERSION

COPY . /lambdastack
COPY version /lambdastack
COPY .docker_prompt /lambdastack

RUN : INSTALL APT REQUIREMENTS \
    && apt-get update \
    && apt-get install --no-install-recommends -y \
        autossh curl gcc jq libcap2-bin libffi-dev make musl-dev openssh-client procps psmisc ruby-full sudo tar unzip vim \
\
    && : INSTALL HELM BINARY \
    && curl -fsSLO https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && tar -xzof ./helm-v${HELM_VERSION}-linux-amd64.tar.gz --strip=1 -C /usr/local/bin linux-amd64/helm \
    && rm ./helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && helm version \
    && : INSTALL KUBECTL BINARY \
    && curl -fsSLO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && kubectl version --client \
    && : INSTALL ISTIOCTL BINARY \
    && curl -fsSLO https://github.com/istio/istio/releases/download/${ISTIOCTL_VERSION}/istioctl-${ISTIOCTL_VERSION}-linux-amd64.tar.gz \
    && tar -xzof istioctl-${ISTIOCTL_VERSION}-linux-amd64.tar.gz -C /usr/local/bin istioctl \
    && rm istioctl-${ISTIOCTL_VERSION}-linux-amd64.tar.gz \
    && chmod +x /usr/local/bin/istioctl \
\
    && : INSTALL GEM REQUIREMENTS \
    && gem install \
        rake rspec_junit_formatter serverspec \
\
    && : INSTALL PIP REQUIREMENTS \
    && pip install --disable-pip-version-check --no-cache-dir --default-timeout=100 \
        --requirement /lambdastack/.devcontainer/requirements.txt \
\
    && : INSTALLATION CLEANUP \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /lambdastack/.devcontainer/ \
\
    && : SETUP USER AND OTHERS \
    && groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && setcap 'cap_net_bind_service=+ep' /usr/bin/ssh \
\
    && : SETUP SHARED DIRECTORY \
    && mkdir -p $LSCLI_DOCKER_SHARED_DIR \
    && chown $USERNAME $LSCLI_DOCKER_SHARED_DIR \
    && chmod g+w $LSCLI_DOCKER_SHARED_DIR \
\
    && : SETUP LAMBDASTACKCLI COMMAND \
    && cp /lambdastack/cli/lambdastack /bin/lambdastack \
    && chmod +x /bin/lambdastack

WORKDIR $LSCLI_DOCKER_SHARED_DIR

USER $USERNAME

ENTRYPOINT ["/bin/bash"]
