#!/bin/bash
service rabbitmq-server restart && \
rabbitmqctl add_vhost "OpenLI-med" && \
rabbitmqctl add_user "openli.nz" "security" && \
rabbitmqctl set_permissions -p "OpenLI-med" "openli.nz" ".*" ".*" ".*" && \
cp /etc/openli/rsyslog.d/10-openli-mediator.conf /etc/rsyslog.d/ && \
service rsyslog restart && \
sleep 2 && \
service openli-mediator start && \
bash