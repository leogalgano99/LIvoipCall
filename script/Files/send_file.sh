#!/bin/bash

container_ip=$(sudo docker  exec nr_ue_1 ip -4 addr show uesimtun0 | grep -oP 'inet \K[\d.]+')

remote_port=$1

sudo docker  exec -it nr_ue_1 ./send_files.sh $remote_port
#sudo docker  exec -it nr_ue_1 ./send_files.sh
