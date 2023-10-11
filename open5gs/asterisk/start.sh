#!/bin/bash

# Avvia il servizio Asterisk
/etc/init.d/asterisk start
ip route add $UE_IPV4_INTERNET via $UPF_IP dev eth0

# Mantieni il container in esecuzione in modo indefinito
tail -f /dev/null