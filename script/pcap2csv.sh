#!/bin/bash

# Elenco delle cartelle da esaminare
directories=("15sec" "30sec" "45sec" "60sec")

# Loop attraverso le diverse cartelle
for dir in "${directories[@]}"; do
    # Directory in cui sono presenti le cartelle 15sec, 30sec, ecc.
    parent_directory="../pcap/$dir"
    for folder in "$parent_directory"/*; do
        if [ -d "$folder" ]; then
            echo "Operando nella cartella: $folder"

            # Loop attraverso i file nella cartella corrente
            for file in "$folder"/*; do
                if [ -f "$file" ]; then
                    # Estrai l'estensione del file
                    file_extension="${file##*.}"
                    # Verifica se l'estensione è "pcap"
                    if [ "$file_extension" == "pcap" ]; then
                        # Esegui l'operazione desiderata sui file pcap
                        echo "Operazione sul file: $file"
                        csv="${file%.*}.csv"
                        if [ "$(basename "$file")" == "MDF.pcap" ]; then
                            tshark -r "$file" -T fields -E separator=, -E quote=d -e _ws.col.No. -e _ws.col.Time -e frame.time_epoch -e _ws.col.Source -e _ws.col.Destination -e _ws.col.Protocol -e _ws.col.Length -e _ws.col.Info > "$csv"
                        else
                            file2="${file%.*}_2.pcap"
                            tshark -r "$file" -w "$file2" "!(ip.src == 192.168.65.0/24) && !(ip.dst == 192.168.65.0/24) && (ip.src == 10.45.0.3 || ip.dst == 10.45.0.3)"
                            tshark -r "$file2" -T fields -E separator=, -E quote=d -e _ws.col.No. -e _ws.col.Time -e frame.time_epoch -e _ws.col.Source -e _ws.col.Destination -e _ws.col.Protocol -e _ws.col.Length -e _ws.col.Info > "$csv"
                        fi
                    fi
                fi
            done
        fi
    done
done

