#!/bin/bash

set -a
source .env

echo "Creating networks for OpenLI lab..."
sudo docker  network inspect openli-lab > /dev/null 2>&1 || \
        sudo docker  network create --driver bridge \
        --subnet $OPENLI_NETWORK_LAB \
        openli-lab


sudo docker  network inspect openli-agency > /dev/null 2>&1 || \
        sudo docker  network create --driver bridge \
        -o "com.docker .network.bridge.enable_icc=true" \
        --subnet $OPENLI_NETWORK_AGENCY \
        openli-agency

# sudo docker  network inspect openli-lab-replay > /dev/null 2>&1 || \
#         sudo docker  network create --driver bridge \
#         -o "com.sudo docker .network.driver.mtu=9000" \
#         -o "com.sudo docker .network.bridge.enable_icc=true" \
#         openli-lab-replay

echo "Networks created!"

echo "Halting existing running containers..."

if [ "$( sudo docker  ps -q -f name=agency )" ]; then
        sudo docker  container stop agency
fi

if [ "$( sudo docker  ps -q -f name=provisioner )" ]; then
        sudo docker  container stop provisioner
fi

if [ "$( sudo docker  ps -q -f name=mediator )" ]; then
        sudo docker  container stop mediator
fi

if [ "$( sudo docker  ps -q -f name=collector )" ]; then
        sudo docker  container stop collector
fi

echo "All done!"

echo "Starting docker  containers..."
sudo docker  run --platform linux/amd64 -d -P --rm -it --name agency openli-agency

sudo docker  run --platform linux/amd64 -d -P --rm -it --name provisioner openli-provisioner

sudo docker  run --platform linux/amd64 -d -P --rm -it --name mediator openli-mediator 

sudo docker  run --platform linux/amd64 -d -P --rm -it --name collector openli-collector


sudo docker  network connect --ip $PROVISIONER_IP_OPENLI_LAB openli-lab provisioner
sudo docker  network connect --ip $MEDIATOR_IP_OPENLI_LAB openli-lab mediator
sudo docker  network connect --ip $COLLECTOR_IP_OPENLI_LAB openli-lab collector

sudo docker  network connect --ip $COLLECTOR_IP_OPEN5GS open5gs_default  collector

sudo docker  network connect --ip $MEDIATOR_IP_OPENLI_AGENCY openli-agency mediator
sudo docker  network connect --ip $AGENCY_IP_OPENLI_AGENCY openli-agency agency
echo "Containers started!"

sudo docker  cp ./provisioner-config.yaml provisioner:/etc/openli/provisioner-config.yaml
sudo docker  cp ./provisioner-start.sh provisioner:/home/openli-prov/provisioner-start.sh
sudo docker  cp ./rest.sh provisioner:/home/openli-prov/rest.sh
sudo docker  exec -it provisioner stop_rsyslog.sh 

sudo docker  cp ./mediator-config.yaml mediator:/etc/openli/mediator-config.yaml
sudo docker  cp ./mediator-start.sh mediator:/home/openli-med/mediator-start.sh
sudo docker  cp ./rmqinternalpass mediator:/etc/openli/rmqinternalpass
sudo docker  exec -it mediator stop_rsyslog.sh 

sudo docker  cp ./collector-config.yaml collector:/etc/openli/collector-config.yaml
sudo docker  cp ./collector-start.sh collector:/home/openli-coll/collector-start.sh
sudo docker  exec -it collector stop_rsyslog.sh ù
sudo docker exec --privileged collector ip route del 172.22.0.0/24

echo "OpenLI lab setup complete!"
