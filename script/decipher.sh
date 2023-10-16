#!/bin/bash

sudo docker  exec -it agency ./util/decrypt.sh

giorno_mese=$(date +"%d-%m_%H-%M")
cd ..
mkdir pcap
cd pcap
mkdir "$giorno_mese"                 
cd ..

sudo docker  cp agency:/home/openli-testagency/CC_agency.pcap ./pcap/"$giorno_mese"/CC_agency.pcap
sudo docker  cp agency:/home/openli-testagency/CC_decipher.wav ./pcap/"$giorno_mese"/CC_decipher.wav
sudo docker  cp agency:/home/openli-testagency/CC_cipher.wav ./pcap/"$giorno_mese"/CC_cipher.wav
sudo docker  cp agency:/home/openli-testagency/CC_decipher.txt ./pcap/"$giorno_mese"/CC_decipher.txt

sudo docker  cp collector:/home/openli-coll/POI.pcap ./pcap/"$giorno_mese"/POI.pcap
sudo docker  cp mediator:/home/openli-med/MDF.pcap ./pcap/"$giorno_mese"/MDF.pcap
sudo docker  cp upf:/open5gs/UPF.pcap ./pcap/"$giorno_mese"/UPF.pcap

sudo docker  exec -it agency rm /home/openli-testagency/CC_agency.pcap
sudo docker  exec -it agency rm /home/openli-testagency/CC_decipher.wav
sudo docker  exec -it agency rm /home/openli-testagency/CC_decipher.txt
sudo docker  exec -it agency rm /home/openli-testagency/CC_cipher.wav

sudo docker  exec -it collector rm /home/openli-coll/POI.pcap
sudo docker  exec -it mediator rm /home/openli-med/MDF.pcap
sudo docker  exec -it upf rm /open5gs/UPF.pcap

sudo chmod +r ./pcap/"$giorno_mese"/*.pcap