#!/bin/bash

cd ../open5gs 

echo "Halting existing running containers..."

if [ "$( sudo docker ps -q -f name=upf )" ]; then
        sudo docker compose down
fi

if [ "$( sudo docker ps -q -f name=nr_ue_1 )" ] || [ "$( sudo docker ps -q -f name=nr_ue_2 )" ]; then
        sudo docker compose -f nr-ue.yaml down
fi

if [ "$( sudo docker ps -q -f name=nr_gnb_1)" ] || [ "$( sudo docker ps -q -f name=nr_gnb_2 )" ]; then
        sudo docker compose -f nr-gnb.yaml down
fi

echo "All done!"
echo "[OPEN5GS] Starting docker containers..."
set -a
source .env
#HOST_IP="$(ip -4 -o a | awk '{print $4}' | cut -d/ -f1 | grep -v 127.0.0.1 | head -n1)"

sudo docker compose up -d && \
sleep 5 && \
sudo docker compose -f nr-gnb.yaml up -d  && \
sleep 5 && \
sudo docker compose -f nr-ue.yaml up -d  && \
source .env
echo "[PULSEAUDIO] start PULSEAUDIO over TCP"
#pactl load-module module-native-protcol-tcp port=34567 auth-ip-acl=$TEST_NETWORK

cd ../openli-training-lab && ./setup.sh

# cd .. && \
# sleep 2 && \
# cd ./pythKeyEscrow && \
# ./copy_key.sh && \

# cd ../open5gs/ueransim/netcat && \
# docker cp netcat_send/.  nr_ue_1:/UERANSIM/build/ && \
# docker cp netcat_receive/. nr_ue_2:/UERANSIM/build/

# OPERAZIONI PROVVISORIE PER COPIA SCRIPT
#######
# cd ../openli-training-lab/agency && \
# docker cp LEA_script_files agency:/home/openli-testagency && \
#######

cd ../script && \
./configure_openli.sh && \

# operazione provvisoria copia script per file .txt
sudo docker cp ../openli-training-lab/agency/util/util_files/decrypt_LEA_files.sh agency:/home/openli-testagency/util/util_files

echo "Select the Custom option for combined configuration"

# Mostra un menu con due opzioni
PS3="Select an option: "
options=("VoIP" "Files" "Custom")

select choice in "${options[@]}"; do
    case $choice in
        "VoIP")
	      echo "Ambiente VoIP configurato. Avviare gli script nel seguente ordine per avviare la chiamata:
	      1) ./VoIP/interception.sh 
	      2) ./VoIP/IRI.sh
	      3) ./VoIP/receive_call.sh 
	      4) ./VoIP/call.sh

	      Terminata la chiamata interrompere lo script interception.sh e avviare: decipher.sh"
	      break;
	      ;;
	"Files")
	      echo "Ambiente trasferimento file configurato. Avviare gli script nel seguente ordine per intercettazione di files:
	      1) ./Files/interception_files.sh
	      2) ./Files/IRI.sh
	      3) ./Files/receive_file.sh
	      4) ./Files/send_file.sh
	      5) ./Files/decipher_file.sh"
	      break
              ;;
	"Custom")
	      echo "Ambiente completo configurato. Avviare gli script nel seguente ordine per intercettazione di files:
	      1) ./intercept_all.sh
	      2) ./IRI_all.sh
	      3) ./receive_all.sh
	      4) ./send_all.sh
	      5) ./decipher_all.sh"
	      break
              ;;
	"Exit")
             echo "Exiting..."
             break
             ;;
            *)
            echo "Invalid choice, try again"
            ;;
   esac
done
