#!/bin/bash

cd ../open5gs 

echo "Halting existing running containers..."

if [ "$( docker ps -q -f name=upf )" ]; then
        docker compose down
fi

if [ "$( docker ps -q -f name=nr_ue_1 )" ] || [ "$( docker ps -q -f name=nr_ue_2 )" ]; then
        docker compose -f nr-ue.yaml down
fi

if [ "$( docker ps -q -f name=nr_gnb_1)" ] || [ "$( docker ps -q -f name=nr_gnb_2 )" ]; then
        docker compose -f nr-gnb.yaml down
fi

echo "All done!"

echo "[OPEN5GS] Starting docker containers..."
set -a
source .env

docker compose up -d && \
sleep 10 && \
docker compose -f nr-gnb.yaml up -d  && \
sleep 5 && \
docker compose -f nr-ue.yaml up -d  && \

cd ../openli-training-lab && ./setup.sh

cd .. && \
sleep 2 && \
cd ./pythKeyEscrow && \
./copy_key.sh && \
docker exec -it nr_ue_1 ./network_config.sh && \
docker exec -it nr_ue_2 ./network_config.sh && \

cd ../script && \
./configure_openli.sh && \

echo "Ambiente configurato. Avviare gli script nel seguente ordine per avviare la chiamata:
1) interception.sh 
2) IRI.sh
3) receive_call.sh 
4) call.sh

Terminata la chiamata interrompere lo script interception.sh e avviare: decipher.sh"