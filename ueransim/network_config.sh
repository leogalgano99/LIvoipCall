#!/bin/bash

ip_addr=$(ip addr show uesimtun0 | grep -o 'inet [0-9.]*' | awk '{print $2}') && \
ip route del default && \
ip route add default via $ip_addr && \
ip route add $ASTERISK_IP via $ip_addr dev uesimtun0