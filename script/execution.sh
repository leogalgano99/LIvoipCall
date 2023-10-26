#!/bin/bash

# Set the input variables (ad esempio, 1 o 2)
input_var="1"
# Set the password
password="lawful2023"
# Set simulation number
num_sim=10

echo "$password" | sudo -S apt install dbus-x11
echo "$password" | sudo -S apt install zip

#echo "$password" | sudo -S apt-get install -y xdotool


# Loop for 10 simulations
for ((i=1; i<=$num_sim; i++)); do
    
    echo $i	
	
    # Esegui Interception.sh in un nuovo terminale con input 
    gnome-terminal --title "interception" -- bash -c ./intercept_all.sh <<< "$password" &
    
    echo "avviato intercept, aspetta 45 sec"  
    sleep 45
    echo "finito 45 sec"
    
    # Esegui IRI.sh in un nuovo terminale con input
    echo "$password" | sudo -S gnome-terminal --title "IRI" -- bash -c ./IRI_all.sh &     
    
    sleep 10
    
    # Esegui receive.sh in un nuovo terminale con input
    echo "$password" | sudo -S gnome-terminal --title "receive" -- bash -c ./receive_all.sh &

    # Esegui send.sh in un nuovo terminale con input
    echo "$password" | sudo -S gnome-terminal --title "send" -- bash -c -- ./send_all.sh &
    
    echo "Attendi che tutti i processi in background terminino"
    # Attendi che tutti i processi in background terminino
    #wait
    #echo "finito TUTTI PROCESSI"
    
    sleep 120
    
    # Esegui decipher.sh in un nuovo terminale con input
    echo "$password" | sudo -S gnome-terminal --title "decipher" -- bash -c -- ./decipher_all.sh &
    
    echo "avviato decipher, aspetta 70 sec"  
    # Attendi 1 minuto
    sleep 70
    
    echo "$password" | sudo -S pkill -f "gnome-terminal --title interception"
    echo "$password" | sudo -S pkill -f "gnome-terminal --title IRI"
    echo "$password" | sudo -S pkill -f "gnome-terminal --title receive"
    echo "$password" | sudo -S pkill -f "gnome-terminal --title send"
    echo "$password" | sudo -S pkill -f "gnome-terminal --title decipher"
    
    
done

cd ../pcap/
echo "$password" | sudo -S chmod 777 -R 26-10_*
echo "$password" | sudo -S zip -r 45sec_auto.zip 26-10_*/.
echo "$password" | sudo -S chmod 777 45sec_auto.zip
#echo "$password" | sudo -S rm -R 26-10_*
