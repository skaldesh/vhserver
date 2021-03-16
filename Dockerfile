FROM steamcmd/steamcmd:ubuntu-18

LABEL maintainer="sebastian@desertbit.com"

# Install dependencies.
RUN dpkg --add-architecture i386 && \
    apt -y update && \ 
    apt -y --no-install-recommends install \
        nano \
        curl \
        wget \
        file \
        tar \
        bzip2 \
        gzip \
        unzip \
        bsdmainutils \
        python3 \
        util-linux \
        ca-certificates \
        binutils \
        bc \
        jq \
        cpio \
        libsdl2-2.0-0:i386 \
        tmux \
        netcat \
        lib32gcc1 \
        lib32stdc++6 \
        iproute2 && \
    apt -y clean

# Create vhserver user.
RUN useradd -ms /bin/bash vhserver
USER vhserver
WORKDIR /home/vhserver
ENV HOME=/home/vhserver

# Download and verify LinuxGSM.
# Then use it to install valheim server (vhserver).
RUN mkdir -p /tmp/vhserver/linuxgsm && \
    export LINUX_GSM_VERSION="v21.2.2" && \
    export LINUX_GSM_CHECKSUM="0a45c88218d87b4e6f18c2cc95d14a6dbedba2ff0cf1497d4fcd3b7851870dc7" && \
    wget \
        --show-progress \
        --progress=bar:force:noscroll \
        -O /tmp/vhserver/linuxgsm.tar.gz \
        https://github.com/GameServerManagers/LinuxGSM/archive/${LINUX_GSM_VERSION}.tar.gz && \
    echo "${LINUX_GSM_CHECKSUM}  /tmp/vhserver/linuxgsm.tar.gz" | sha256sum -c && \
    tar -C /tmp/vhserver/linuxgsm -xf /tmp/vhserver/linuxgsm.tar.gz --strip-components 1 && \
    mkdir linuxgsm && \
    cp /tmp/vhserver/linuxgsm/linuxgsm.sh /home/vhserver/linuxgsm/linuxgsm.sh && \
    rm -rf /tmp/vhserver && \
    cd linuxgsm && \
    chmod +x linuxgsm.sh && \
    ./linuxgsm.sh vhserver && \
    ./vhserver auto-install

# Expose necessary ports.
EXPOSE 2456/udp 2457/udp

# Set valheim server as entrypoint.
ENTRYPOINT ["./linuxgsm/vhserver"]
