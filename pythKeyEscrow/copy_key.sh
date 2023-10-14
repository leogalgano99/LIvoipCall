#!/bin/bash

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
docker cp keyA.txt nr_ue_1:/UERANSIM/build/
docker cp keyB.txt nr_ue_2:/UERANSIM/build/
docker cp keyLEA.txt agency:/home/openli-testagency