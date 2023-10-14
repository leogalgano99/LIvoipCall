#!/bin/bash

# configurazione container openLI
sudo docker  exec provisioner ./provisioner-start.sh && \
sudo docker  exec mediator ./mediator-start.sh && \
sudo docker  exec collector ./collector-start.sh && \
sudo docker  exec provisioner ./rest.sh  