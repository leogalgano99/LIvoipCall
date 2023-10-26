from scapy.all import *
from scapy.layers.http import *
from scapy.contrib.gtp import *
import os
import sys
import subprocess
from pathlib import Path
from os import chdir

#Funzione per scrivere in un file .pcap i pacchetti
def writepacket(packet, filteredfile):
	wrpcap(filteredfile, packet, append=True)

#Definizione dei nomi dei file
originalfile = sys.argv[1]
filedirectory = "/home/openli-testagency/util/util_files"
filteredfileTCP = f"{filedirectory}/filtered_files/filteredTCP.pcap"
filteredfile = f"{filedirectory}/filtered_files/filtered.pcap"

#lettura di un file .pcap
a = rdpcap(originalfile)
sessions = a.sessions()


#Controllo della presenza di un file write.pcap
#Se il file        presente viene cancellato per poi crearne uno vuoto. Se il file non        presente viene direttamente creato un file vuoto
if os.path.exists(filteredfile):
        os.remove(filteredfile)
if os.path.exists(filteredfileTCP):
        os.remove(filteredfileTCP)
Path(filteredfile).touch()
Path(filteredfileTCP).touch()

#Tutti i pacchetti nel file vengono letti e se        presente il layer session container vengono scritti in un file
foundTCP = False
for session in sessions:
        for packet in sessions[session]:
                #print(packet)
                if TCP in packet:
                        writepacket(packet, filteredfile)

                        layer = packet[TCP].payload
                        #print(layer)
                        if packet[IP].dst == "10.45.0.3" and packet[IP].src == "10.45.0.2":
                                        #print(packet)
                                        writepacket(packet, filteredfileTCP)
                                        foundTCP = True

if foundTCP == True:
        os.system(f"/home/linuxbrew/.linuxbrew/bin/TcpReassembly -s -r {filedirectory}/filtered_files/filteredTCP.pcap -o {filedirectory}/reassembled_files")

os.system(f"mv {filedirectory}/reassembled_files/*.txt {filedirectory}/reassembled_files/reassembled_file.txt")
