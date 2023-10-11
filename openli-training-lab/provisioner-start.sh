#!/bin/bash

cp /etc/openli/rsyslog.d/10-openli-provisioner.conf /etc/rsyslog.d/ && \
service rsyslog restart && \
sleep 2 && \
service openli-provisioner start && \
bash