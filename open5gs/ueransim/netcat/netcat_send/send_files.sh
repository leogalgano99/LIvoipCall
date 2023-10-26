#! /bin/bash

remote_port=$1

IP_sender="10.45.0.2"
IP_receiver="10.45.0.3"

# cifratura file
echo "encrypting..."
# python3 encrypt.py img.jpg file_to_send_encr.jpg
# python3 encrypt.py 10KB.txt file_to_send_encr.txt
# python3 encrypt.py 100KB.txt file_to_send_encr.txt
python3 encrypt.py 1MB.txt file_to_send_encr.txt
# python3 encrypt.py 10MB.txt file_to_send_encr.txt
echo "encryption done!"

echo "sending file..."
#./nr-binder $IP_sender python3 send_file_user.py send file_to_send_encr.jpg $IP_receiver $remote_port
./nr-binder $IP_sender python3 send_file_user.py send file_to_send_encr.txt $IP_receiver $remote_port
echo "file sent from $IP_sender to $IP_receiver"

