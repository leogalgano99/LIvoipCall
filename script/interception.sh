#!/bin/bash

# inizio intercettazione
sudo docker  exec upf tshark -i eth0 -w UPF.pcap &\
sudo docker  exec collector traceconvert eth2 pcapfile:POI.pcap &\
sudo docker  exec mediator traceconvert eth2 pcapfile:MDF.pcap &\
sudo docker  exec -it agency tracesplit etsilive:172.20.0.3:41003 pcapfile:CC_agency.pcap