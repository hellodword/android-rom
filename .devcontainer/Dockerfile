ARG VARIANT="jammy"
FROM buildpack-deps:${VARIANT}-curl

LABEL dev.containers.features="common"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
      apt-get install --yes \
            sudo \
            --no-install-recommends
ARG USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
  && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME

RUN mkdir -p /etc/sudoers.d/ && \
      echo "$USERNAME ALL=(ALL) NOPASSWD:ALL">/etc/sudoers.d/90-cloud-init-users

USER $USERNAME
ENV USER $USERNAME
ENV HOME /home/$USERNAME

# Install build dependencies
############################
RUN sudo apt-get -qq update && \
      sudo apt-get install -y bc bison bsdmainutils build-essential ccache cgpt clang \
      cron curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick \
      kmod lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool \
      libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 \
      libxml2-utils lsof lzop maven openjdk-8-jdk pngcrush procps python3 \
      python-is-python3 rsync schedtool squashfs-tools wget xdelta3 xsltproc yasm zip \
      zlib1g-dev \
      python2 gcc-9 \
      xxd

RUN sudo curl -o /usr/local/bin/repo https://storage.googleapis.com/git-repo-downloads/repo && \
      sudo chmod a+x /usr/local/bin/repo

# Re-enable TLSv1 and TLSv1.1 in OpenJDK 8 config
#(for cm-14.1/lineage-15.1, might be removed later)
###################################################
RUN echo "jdk.tls.disabledAlgorithms=SSLv3, RC4, DES, MD5withRSA, DH keySize < 1024, EC keySize < 224, 3DES_EDE_CBC, anon, NULL, include jdk.disabled.namedCurves" | sudo tee -a /etc/java-8-openjdk/security/java.security

# Provide a default JACK configuration in order to avoid out-of-memory issues
ENV ANDROID_JACK_VM_ARGS "-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"

RUN sudo apt-get install -y bash-completion

RUN mkdir -p $HOME/.cache/vscode-cpptools $HOME/.vscode-server/extensionsCache && \
      sudo chown -R $USER_UID:$USER_GID $HOME/.cache && \
      sudo chown -R $USER_UID:$USER_GID $HOME/.vscode-server
