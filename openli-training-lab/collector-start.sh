#!/bin/bash

cp /etc/openli/rsyslog.d/10-openli-collector.conf /etc/rsyslog.d/ && \
service rsyslog restart && \
sleep 2 && \
service openli-collector start && \
bash