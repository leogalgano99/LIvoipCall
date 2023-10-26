#! /bin/bash

local_port=$1
IP_receiver="10.45.0.3"


echo "listening on port $local_port ..."
# nc -l -p $local_port > file_received_encr.jpg
nc -l -p $local_port > file_received_encr.txt
echo "file received from UE at $IP_receiver"

# decryption
echo "decrypting..."
# python3 decrypt_utente.py file_received_encr.jpg file_received_decr.jpg
python3 decrypt_utente.py file_received_encr.txt file_received_decr.txt
echo "decryption done!"
