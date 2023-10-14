#!/bin/bash

container_ip=$(docker exec nr_ue_1 ip -4 addr show uesintun0 | grep -oP 'inet \K[\d.]+')
docker exec -it nr_ue_1 ./nr-binder $container_ip python3 /UERANSIM/build/call_tls.py