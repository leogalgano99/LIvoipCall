#!/bin/bash

python3 generate_keys.py

sleep 5
docker cp keyA.txt nr_ue_1:/UERANSIM/build/
docker cp keyB.txt nr_ue_2:/UERANSIM/build/
docker cp keyLEA.txt agency:/home/openli-testagency