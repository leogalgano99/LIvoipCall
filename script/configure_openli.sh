#!/bin/bash

# configurazione container openLI
docker exec provisioner ./provisioner-start.sh && \
docker exec mediator ./mediator-start.sh && \
docker exec collector ./collector-start.sh && \
docker exec provisioner ./rest.sh && \
docker exec upf apt-get update && \
docker exec upf apt-get install -y tshark