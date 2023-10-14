#!/bin/bash

cd ../open5gs 

echo "Halting existing running containers..."

if [ "$( sudo docker ps -q -f name=upf )" ]; then
        sudo docker compose down
fi

if [ "$( sudo docker ps -q -f name=nr_ue_1 )" ] || [ "$( sudo docker ps -q -f name=nr_ue_2 )" ]; then
        sudo docker compose -f nr-ue.yaml down
fi

if [ "$( sudo docker ps -q -f name=nr_gnb_1)" ] || [ "$( sudo docker ps -q -f name=nr_gnb_2 )" ]; then
        sudo docker compose -f nr-gnb.yaml down
fi

echo "All done!"

echo "[OPEN5GS] Starting docker containers..."
Hostip="$(ip -4 -o a | awk '{print $4}' | cut -d/ -f1 | grep -v 127.0.0.1 | head -n1)"
set -a
source .env

sudo docker compose up -d && \
sleep 5 && \
sudo docker compose -f nr-gnb.yaml up -d  && \
sleep 5 && \
sudo docker compose -f nr-ue.yaml up -d  && \

echo "[PULSEAUDIO] start PULSEAUDIO over TCP"
pactl load-module module-native-protcol-tcp port=34567 auth-ip-acl=$TEST_NETWORK

cd ../openli-training-lab && ./setup.sh

cd .. && \
sleep 2 && \
cd ./pythKeyEscrow && \
./copy_key.sh && \
sudo docker exec -it nr_ue_1 ./network_config.sh && \
sudo docker exec -it nr_ue_2 ./network_config.sh && \

cd ../script && \
./configure_openli.sh && \

echo "Ambiente configurato. Avviare gli script nel seguente ordine per avviare la chiamata:
1) interception.sh 
2) IRI.sh
3) receive_call.sh 
4) call.sh

Terminata la chiamata interrompere lo script interception.sh e avviare: decipher.sh"