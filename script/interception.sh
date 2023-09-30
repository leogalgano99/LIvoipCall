#!/bin/bash

# inizio intercettazione
docker exec upf tshark -i ogstun -w UPF.pcap &\
docker exec collector traceconvert eth2 pcapfile:POI.pcap &\
docker exec mediator traceconvert eth2 pcapfile:MDF.pcap &\
docker exec -it agency tracesplit etsilive:172.20.0.3:41003 pcapfile:CC_agency.pcap