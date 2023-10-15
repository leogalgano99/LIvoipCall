#!/bin/bash

container_ip=$(sudo docker  exec nr_ue_1 ip -4 addr show uesimtun0 | grep -oP 'inet \K[\d.]+')
sudo docker  exec -it nr_ue_1 ./nr-binder $container_ip python3 /UERANSIM/build/call_tls.py