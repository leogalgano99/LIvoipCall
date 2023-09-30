FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install updates and dependencies
RUN apt-get update && \
    apt-get -y install \
        net-tools \
        nano \
        wget \
        iproute2 \
        -y asterisk && \
    apt-get autoremove -y && apt-get autoclean && \
    cd /usr/src && \
    wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz && \
    mkdir /etc/asterisk/keys

COPY ./sip.conf /etc/asterisk/sip.conf
COPY ./pjsip.conf /etc/asterisk/pjsip.conf
COPY  ./keys/ /etc/asterisk/keys
COPY ./extensions.conf /etc/asterisk/extensions.conf
COPY ./voicemail.conf /etc/asterisk/voicemail.conf
COPY ./start.sh /

EXPOSE 5060 5061 5070 5071

