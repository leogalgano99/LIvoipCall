#!/bin/bash

password="lawful2023"

cd .. && \
cd ./pythKeyEscrow && \
echo "$password"| sudo -S ./copy_key.sh && \

cd ../open5gs/ueransim/netcat && \
sudo docker cp netcat_send/.  nr_ue_1:/UERANSIM/build/  && \
sudo docker cp netcat_receive/. nr_ue_2:/UERANSIM/build/

cd ../../../script && \

# Mostra un menu con due opzioni
PS3="Select an option: "
options=("VoIP" "Files")
# Set the input variables (ad esempio, 1 o 2)
input_var="1"

# Imposta automaticamente l'opzione in base a input_var
case "$input_var" in
    "1")
        choice="VoIP"
        ;;
    "2")
        choice="Files"
        ;;
    *)
        echo "Invalid input_var"
        exit 1
        ;;
esac

case $choice in
    "VoIP")
        ./VoIP/interception.sh <<< "$password"
        ;;
    "Files")
        ./Files/interception_files.sh <<< "$password"
        ;;
    "Exit")
        echo "Exiting..."
        ;;
    *)
        echo "Invalid choice"
        ;;
esac


#password="lawful2023"

#cd .. && \
#cd ./pythKeyEscrow && \
#echo "$password"| sudo -S ./copy_key.sh && \

#cd ../open5gs/ueransim/netcat && \
#docker cp netcat_send/.  nr_ue_1:/UERANSIM/build/  && \
#docker cp netcat_receive/. nr_ue_2:/UERANSIM/build/

#cd ../../../script && \

## Mostra un menu con due opzioni
#PS3="Select an option: "
#options=("VoIP" "Files")
## Set the input variables (ad esempio, 1 o 2)
#input_var="1"

#select choice in "${options[@]}"; do
#    case $choice in
#        "VoIP")
#              ./VoIP/interception.sh <<< "$password"#
#	      #./VoIP/interception.sh
#	      break;
#	      ;;
#	"Files")
#	      ./Files/interception_files.sh <<< "$password"
#	      break
#              ;;
#	"Exit")
#             echo "Exiting..."
#             break
#             ;;
#            *)
#            echo "Invalid choice, try again"
#            ;;
#   esac
#done

