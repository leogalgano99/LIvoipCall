#!/bin/bash
container_ip=$(sudo docker  exec nr_ue_2 ip -4 addr show uesimtun0 | grep -oP 'inet \K[\d.]+')

sudo docker  exec -it nr_ue_2 ./nr-binder $container_ip python3 /UERANSIM/build/receive_tls.py 30sec.wav &&\
sudo docker  exec agency  pkill -2 tracesplit &&\
sudo docker  exec upf  pkill -2 tshark &&\
sudo docker  exec collector pkill -2 tracesplit &&\
sudo docker  exec mediator pkill -2 tracesplit