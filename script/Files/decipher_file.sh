#!/bin/bash

sudo docker exec -it agency ./util/util_files/decrypt_LEA_files.sh

giorno_mese=$(date +"%d-%m_%H-%M")
cd ..
mkdir pcap_files
cd pcap_files
mkdir "$giorno_mese"                 
cd ..

sudo docker  cp agency:/home/openli-testagency/CC_agency_files.pcap ./pcap_files/"$giorno_mese"/CC_agency_files.pcap

### DECOMMENTARE PER INVIO IMMAGINE e COMMENTARE RIGA SUCCESSIVA
# sudo docker  cp agency:/home/openli-testagency/deciphered_file.jpg ./pcap_files/"$giorno_mese"/deciphered_file.jpg
sudo docker  cp agency:/home/openli-testagency/deciphered_file.txt ./pcap_files/"$giorno_mese"/deciphered_file.txt

sudo docker  cp agency:/home/openli-testagency/util/util_files/reassembled_files/reassembled_file.txt ./pcap_files/"$giorno_mese"/reassembled_file.txt

sudo docker  cp collector:/home/openli-coll/POI_files.pcap ./pcap_files/"$giorno_mese"/POI_files.pcap
sudo docker  cp mediator:/home/openli-med/MDF_files.pcap ./pcap_files/"$giorno_mese"/MDF_files.pcap
sudo docker  cp upf:/open5gs/UPF_files.pcap ./pcap_files/"$giorno_mese"/UPF_files.pcap


sudo docker  exec -it agency rm /home/openli-testagency/CC_agency_files.pcap

sudo docker  exec -it collector rm /home/openli-coll/POI_files.pcap
sudo docker  exec -it mediator rm /home/openli-med/MDF_files.pcap
sudo docker  exec -it upf rm /open5gs/UPF_files.pcap

sudo docker  exec -it agency rm /home/openli-testagency/util/util_files/reassembled_files/reassembled_file.txt

### DECOMMENTARE PER INVIO IMMAGINE e COMMENTARE RIGA SUCCESSIVA
# sudo docker  exec -it agency rm /home/openli-testagency/deciphered_file.jpg
sudo docker  exec -it agency rm /home/openli-testagency/deciphered_file.txt

sudo chmod +r ./pcap_files/"$giorno_mese"/*.pcap

