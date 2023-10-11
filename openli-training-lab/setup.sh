#!/bin/bash

set -a
source .env

echo "Creating networks for OpenLI lab..."
docker network inspect openli-lab > /dev/null 2>&1 || \
        docker network create --driver bridge \
        --subnet $OPENLI_NETWORK_LAB \
        openli-lab


docker network inspect openli-agency > /dev/null 2>&1 || \
        docker network create --driver bridge \
        -o "com.docker.network.bridge.enable_icc=true" \
        --subnet $OPENLI_NETWORK_AGENCY \
        openli-agency

# docker network inspect openli-lab-replay > /dev/null 2>&1 || \
#         docker network create --driver bridge \
#         -o "com.docker.network.driver.mtu=9000" \
#         -o "com.docker.network.bridge.enable_icc=true" \
#         openli-lab-replay

echo "Networks created!"

echo "Halting existing running containers..."

if [ "$( docker ps -q -f name=agency )" ]; then
        docker container stop agency
fi

if [ "$( docker ps -q -f name=provisioner )" ]; then
        docker container stop provisioner
fi

if [ "$( docker ps -q -f name=mediator )" ]; then
        docker container stop mediator
fi

if [ "$( docker ps -q -f name=collector )" ]; then
        docker container stop collector
fi

echo "All done!"

echo "Starting docker containers..."
docker run --platform linux/amd64 -d -P --rm -it --name agency openli-agency

docker run --platform linux/amd64 -d -P --rm -it --name provisioner openli-provisioner

docker run --platform linux/amd64 -d -P --rm -it --name mediator openli-mediator 

docker run --platform linux/amd64 -d -P --rm -it --name collector openli-collector


docker network connect --ip $PROVISIONER_IP_OPENLI_LAB openli-lab provisioner
docker network connect --ip $MEDIATOR_IP_OPENLI_LAB openli-lab mediator
docker network connect --ip $COLLECTOR_IP_OPENLI_LAB openli-lab collector

docker network connect --ip $COLLECTOR_IP_OPEN5GS open5gs_default  collector

docker network connect --ip $MEDIATOR_IP_OPENLI_AGENCY openli-agency mediator
docker network connect --ip $AGENCY_IP_OPENLI_AGENCY openli-agency agency
echo "Containers started!"

docker cp ./provisioner-config.yaml provisioner:/etc/openli/provisioner-config.yaml
docker cp ./provisioner-start.sh provisioner:/home/openli-prov/provisioner-start.sh
docker cp ./rest.sh provisioner:/home/openli-prov/rest.sh
docker exec -it provisioner stop_rsyslog.sh 

docker cp ./mediator-config.yaml mediator:/etc/openli/mediator-config.yaml
docker cp ./mediator-start.sh mediator:/home/openli-med/mediator-start.sh
docker cp ./rmqinternalpass mediator:/etc/openli/rmqinternalpass
docker exec -it mediator stop_rsyslog.sh 

docker cp ./collector-config.yaml collector:/etc/openli/collector-config.yaml
docker cp ./collector-start.sh collector:/home/openli-coll/collector-start.sh
docker exec -it collector stop_rsyslog.sh 

echo "OpenLI lab setup complete!"
