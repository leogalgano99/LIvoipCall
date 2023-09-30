from scapy.all import *
import sys

# Verifica che ci siano almeno due argomenti (il nome dello script è il primo argomento)
if len(sys.argv) < 3:
    print("Usage: python ethernet.py input.pcap output.pcap")
    sys.exit(1)  # Esci dallo script con stato di uscita 1 (errore)

# Definisci il percorso del file PCAP di input e output
IP_PCAP_PATH = sys.argv[1]
ETHERNET_PCAP_PATH = sys.argv[2]

# Carica il file PCAP di input
packets = rdpcap(IP_PCAP_PATH)

# Crea una lista per memorizzare i nuovi pacchetti Ethernet
ethernet_packets = []

# Itera attraverso tutti i pacchetti nel file PCAP
for packet in packets:
    if IP in packet:
        # Estrai il layer IP dal pacchetto esistente
        ip_layer = packet[IP]
        
        # Crea un nuovo pacchetto Ethernet con l'indirizzo IP come payload
        ethernet_packet = Ether(dst="ff:ff:ff:ff:ff:ff", src="ff:ff:ff:ff:ff:ff") / ip_layer
        
        # Aggiungi il nuovo pacchetto Ethernet alla lista
        ethernet_packets.append(ethernet_packet)

# Scrivi i nuovi pacchetti Ethernet nel file PCAP di output
wrpcap(ETHERNET_PCAP_PATH, ethernet_packets)