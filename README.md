# LIvoipCall
This repository simulates a 5G network using Open5GS and UERANSIM. The project is configured for macOS but can be easily adapted to any OS. An Asterisk server acting as a SIP Server was inserted into the Open5GS network and through UERANSIM the Python PJSIP library was installed. OpenLI was used for legal interception.

Before running the compose docker edit the .env file located in the open5gs folder. Type the following command: ip -4 -o a | awk '{print $4}' | cut -d/ -f1 | grep -v 127.0.0.1 | head -n1 and substitute in the .env file instead of HOST_IP the IP of your pc. Also start pulseaudio over tcp with the following command to allow UERANSIM containers to have access to audio:
pactl load-module module-native-protocol-tcp port=34567 auth-ip-acl=172.22.0.0/24

To build the docker container images move to the script folder and run the build.sh script
