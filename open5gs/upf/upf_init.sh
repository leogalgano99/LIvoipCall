#!/bin/bash

# BSD 2-Clause License

# Copyright (c) 2020, Supreeth Herle
# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:

# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.

# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

export LC_ALL=C.UTF-8
export LANG=C.UTF-8
export IP_ADDR=$(awk 'END{print $1}' /etc/hosts)
export IF_NAME=$(ip r | awk '/default/ { print $5 }')

python3 /mnt/upf/tun_if.py --tun_ifname ogstun --ipv4_range $UE_IPV4_INTERNET --ipv6_range 2001:230:cafe::/48
python3 /mnt/upf/tun_if.py --tun_ifname ogstun2 --ipv4_range $UE_IPV4_IMS --ipv6_range 2001:230:babe::/48 --nat_rule 'no'

UE_IPV4_INTERNET_TUN_IP=$(python3 /mnt/upf/ip_utils.py --ip_range $UE_IPV4_INTERNET)
UE_IPV4_IMS_TUN_IP=$(python3 /mnt/upf/ip_utils.py --ip_range $UE_IPV4_IMS)

#apt-get update && apt-get install -y tshark
cp /mnt/upf/upf.yaml install/etc/open5gs
sed -i 's|UPF_IP|'$UPF_IP'|g' install/etc/open5gs/upf.yaml
sed -i 's|SMF_IP|'$SMF_IP'|g' install/etc/open5gs/upf.yaml
sed -i 's|UE_IPV4_INTERNET_TUN_IP|'$UE_IPV4_INTERNET_TUN_IP'|g' install/etc/open5gs/upf.yaml
sed -i 's|UE_IPV4_IMS_TUN_IP|'$UE_IPV4_IMS_TUN_IP'|g' install/etc/open5gs/upf.yaml
sed -i 's|UPF_ADVERTISE_IP|'$UPF_ADVERTISE_IP'|g' install/etc/open5gs/upf.yaml

iptables -t mangle -A FORWARD -s $HOST_IP -j ACCEPT
iptables -t mangle -A FORWARD -d $HOST_IP -j ACCEPT
# # Imposta una regola per duplicare il traffico da e per la rete 10.45.0.0/24 al Collector
cd ../script

iptables -t mangle -A FORWARD -o eth0 -j TEE --gateway $COLLECTOR_IP_OPEN5GS
iptables -t mangle -A FORWARD -i eth0 -j TEE --gateway $COLLECTOR_IP_OPEN5GS
#iptables -t mangle -A POSTROUTING -o eth0 -j TEE --gateway $COLLECTOR_IP_OPEN5GS

####################################
#Aggiunta per invio file
###################################
# imposta una regola per duplicare il traffico per la rete 10.45.0.0/24 al collector
iptables -t mangle -A FORWARD -o ogstun -j TEE --gateway $COLLECTOR_IP_OPEN5GS

# Sync docker time
#ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
