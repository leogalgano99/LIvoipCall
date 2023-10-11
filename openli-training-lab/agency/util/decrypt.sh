#!/bin/bash

cd util

python3 ethernet.py /home/openli-testagency/CC_agency.pcap /home/openli-testagency/CC_agency_enc.pcap

key=$(cat /home/openli-testagency/keyLEA.txt)

./pcaputil --src-ip=10.45.0.3 --src-port=4000 /home/openli-testagency/CC_agency_enc.pcap /home/openli-testagency/CC_cipher.wav

./pcaputil --src-ip=10.45.0.3 --src-port=4000 -c AES_CM_128_HMAC_SHA1_80 -k $key /home/openli-testagency/CC_agency_enc.pcap /home/openli-testagency/CC_decipher.wav

cd ../srtp-decrypt

./srtp-decrypt -k $key < /home/openli-testagency/CC_agency_enc.pcap >  /home/openli-testagency/CC_decipher.txt
