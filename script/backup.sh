#!/bin/bash

cd ..

# Directory di backup
backup_dir="backup_containers"

# Creazione della directory di backup
mkdir -p $backup_dir

# Elenca tutti i container in esecuzione
containers=$(docker ps -q)

# Loop attraverso i container e crea i backup
for container in $containers; do
    container_name=$(docker inspect -f '{{.Name}}' $container | sed 's/\///')  # Rimuove il "/" iniziale dal nome
    backup_file="$backup_dir/${container_name}.tar"
    docker export $container > $backup_file
done

# Comprimi i backup
tar -czvf $backup_dir.tar.gz $backup_dir

echo "Backup completato"
