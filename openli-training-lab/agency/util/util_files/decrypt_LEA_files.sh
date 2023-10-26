#!/bin/bash 

#ciphered_file_path="/home/marco/Desktop/reassembled_files/192.168.56.108.${remote_port}-10.45.0.3.${remote_port}.txt"
#clear_file_path="/home/openli-testagency/deciphered_file.jpg"
clear_file_path="/home/openli-testagency/deciphered_file.txt"
# filtering and reassembling
echo "Filtering and reassembling..."
python3 /home/openli-testagency/util/util_files/processing_lea.py /home/openli-testagency/CC_agency_files.pcap

# decryption of intercepted data
echo "decrypting..."
python3 /home/openli-testagency/util/util_files/lea.py /home/openli-testagency/util/util_files/reassembled_files/reassembled_file.txt $clear_file_path
echo "done!"

