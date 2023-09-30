#!/bin/bash

docker exec -it nr_ue_2 python3 /UERANSIM/build/receive_tls.py 30sec.wav &&\
docker exec agency  pkill -2 tracesplit &&\
docker exec upf  pkill -2 tshark &&\
docker exec collector pkill -2 tracesplit &&\
docker exec mediator pkill -2 tracesplit