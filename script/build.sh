#!/bin/bash

# build of Open5GS and UERANSIM
cd ../open5gs/base 
docker build --no-cache --force-rm -t docker_open5gs . && \
echo "Open5GS build completed"

cd ../ueransim
docker build --no-cache --force-rm -t docker_ueransim . && \
echo "UERANSIM build completed"

cd ..
set -a 
source .env
docker-compose build --no-cache && \
echo "Open5GS and UERANSIM build completed"

# Mostra un menu con due opzioni
PS3="Select an option: "
options=("ARM" "AMD64" "Exit")

select choice in "${options[@]}"; do
    case $choice in
        "ARM")
            echo "You chose the installation for AppleSilicon processors"
            cd ../openli-training-lab
            cd ./agency
            docker build --platform linux/amd64 --no-cache --force-rm -t openli-agency . && \
            cd ../collector
            docker build --platform linux/amd64 --no-cache --force-rm -t openli-collector . && \
            cd ../mediator
            docker build --platform linux/amd64 --no-cache --force-rm -t openli-mediator . && \
            cd ../provisioner
            docker build --platform linux/amd64 --no-cache --force-rm -t openli-provisioner . && \
            echo "OpenLI build completed"
            break;
            ;;
        "AMD64")
            echo "You chose the installation for AMD64 processors"
            cd ../openli-training-lab
            cd ./agency
            docker build --no-cache --force-rm -t openli-agency . && \
            cd ../collector
            docker build --no-cache --force-rm -t openli-collector . && \
            cd ../mediator
            docker build --no-cache --force-rm -t openli-mediator . && \
            cd ../provisioner
            docker build --no-cache --force-rm -t openli-provisioner . && \
            echo "OpenLI build completed"
            break;
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

echo "Build completed"

