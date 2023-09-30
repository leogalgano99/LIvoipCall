#!/bin/bash

docker exec -it agency ./util/decrypt.sh

giorno_mese=$(date +"%d-%m_%H-%M")
cd ../pcap
mkdir "$giorno_mese"                 
cd ..

docker cp agency:/home/openli-testagency/CC_agency.pcap ./pcap/"$giorno_mese"/CC_agency.pcap
docker cp agency:/home/openli-testagency/CC_decipher.wav ./pcap/"$giorno_mese"/CC_decipher.wav
docker cp agency:/home/openli-testagency/CC_cipher.wav ./pcap/"$giorno_mese"/CC_cipher.wav
docker cp agency:/home/openli-testagency/CC_decipher.txt ./pcap/"$giorno_mese"/CC_decipher.txt

docker cp collector:/home/openli-coll/POI.pcap ./pcap/"$giorno_mese"/POI.pcap
docker cp mediator:/home/openli-med/MDF.pcap ./pcap/"$giorno_mese"/MDF.pcap
docker cp upf:/open5gs/UPF.pcap ./pcap/"$giorno_mese"/UPF.pcap

docker exec -it agency rm /home/openli-testagency/CC_agency.pcap
docker exec -it agency rm /home/openli-testagency/CC_decipher.wav
docker exec -it agency rm /home/openli-testagency/CC_decipher.txt
docker exec -it agency rm /home/openli-testagency/CC_cipher.wav

docker exec -it collector rm /home/openli-coll/POI.pcap
docker exec -it mediator rm /home/openli-med/MDF.pcap
docker exec -it upf rm /open5gs/UPF.pcap