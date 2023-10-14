#!/bin/bash

# Verifica se pip è installato
if ! command -v pip &>/dev/null; then
    echo "pip non è installato. Eseguire l'installazione di pip o configurare il tuo ambiente Python."
    sudo apt-get update
    sudo apt-get install -y python3-pip
fi
# Verifica se le librerie Python sono installate
if ! python3 -c "import tate_bilinear_pairing, pycryptodump" 2>/dev/null; then
    echo "Le librerie tate_bilinear_pairing e pycryptodump non sono installate. Eseguendo l'installazione con pip..."
    
    # Installa tate_bilinear_pairing se non è già installata
    if ! pip show tate_bilinear_pairing 2>/dev/null; then
        pip install tate_bilinear_pairing
    fi
    
    # Installa pycryptodump se non è già installata
    if ! pip show pycryptodump 2>/dev/null; then
        pip install pycryptodump
    fi
fi

python3 generate_keys.py

sleep 5
sudo docker  cp keyA.txt nr_ue_1:/UERANSIM/build/
sudo docker  cp keyB.txt nr_ue_2:/UERANSIM/build/
sudo docker  cp keyLEA.txt agency:/home/openli-testagency