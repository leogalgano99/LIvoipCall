FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /home/openli-testagency

RUN apt-get -y update && apt-get -y install \
            apt-transport-https \
            curl \
            gnupg \
            lsb-release

RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libwandio/cfg/setup/bash.deb.sh' | bash
RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libwandder/cfg/setup/bash.deb.sh' | bash
RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libtrace/cfg/setup/bash.deb.sh' | bash

RUN apt-get -y update && apt-get -y install \
        libtrace4-tools \
        iproute2 \
        iputils-ping \
        tcpdump \
        less \
        tshark \
        vim \
        nano \
        procps \
        git gpp g++ make binutils pip && \
    pip install scapy && \
    git clone https://github.com/pjsip/pjproject.git && \
    cd ./pjproject && \
    export CFLAGS="$CFLAGS -fPIC" && \
    ./configure --enable-shared \
    --disable-video && \
    make dep all && \
    make && \
    make install && \
    make clean && \
    ldconfig && \
    cd .. && \
    git clone https://github.com/gteissier/srtp-decrypt.git && \
    apt-get install -y libpcap-dev libgcrypt-dev && \
    cd ./srtp-decrypt && \
    make
    
RUN apt-get -y install python3.pip && \ 
    pip install --upgrade pip && \
    pip install libnum && \
    pip install pycryptodome && \ 
    pip install tate_bilinear_pairing && \
    pip install scapy

    
RUN apt-get -y update && apt-get -y install \
    build-essential \
    git && \
    curl -1sLf 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh' | bash && \
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/$USER/.bashrc && \
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    brew install gcc && \
    brew install pcapplusplus
    
COPY README /home/openli-testagency
COPY util /home/openli-testagency/util
COPY util/util_files /home/openli-testagency/util/util_files
