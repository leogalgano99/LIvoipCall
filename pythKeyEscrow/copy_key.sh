#!/bin/bash

# Verifica se pip è installato
if ! command -v pip &>/dev/null; then
    echo "pip non è installato. Eseguire l'installazione di pip o configurare il tuo ambiente Python."
    sudo apt-get update
    sudo apt-get install -y python3-pip
fi
# Verifica se le librerie Python sono installate
if ! python3 -c "import tate_bilinear_pairing, pycryptodome" 2>/dev/null; then
    echo "Le librerie tate_bilinear_pairing e pycryptodome non sono installate. Eseguendo l'installazione con pip..."
    
    # Installa tate_bilinear_pairing se non è già installata
    if ! pip show tate_bilinear_pairing 2>/dev/null; then
        pip install tate_bilinear_pairing
    fi
    
    # Installa pycryptodome se non è già installata
    if ! pip show pycryptodome 2>/dev/null; then
        pip install pycryptodome
    fi
fi

python3 generate_keys.py

sleep 5

#VoIP
sudo docker  cp keyA.txt nr_ue_1:/UERANSIM/build/
sudo docker  cp keyB.txt nr_ue_2:/UERANSIM/build/
sudo docker  cp keyLEA.txt agency:/home/openli-testagency

#Files
sudo docker cp keyA_files.txt nr_ue_1:/UERANSIM/build/
sudo docker cp keyB_files.txt nr_ue_2:/UERANSIM/build/
sudo docker cp keyLEA_files.txt agency:/home/openli-testagency
