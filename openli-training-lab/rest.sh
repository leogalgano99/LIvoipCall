#!/bin/bash

PAYLOAD='{"agencyid":"mocklea","hi2address":"172.20.0.3","hi3address":"172.20.0.3","hi2port":"41002","hi3port":"41003","keepalivefreq":1,"keepalivewait":1}'
URL='http://172.19.0.3:8080/agency'

curl -X POST -H "Content-Type: application/json" -d "$PAYLOAD" "$URL"

PAYLOAD2='{"liid": "STATIC002","authcc": "IT","delivcc": "IT","mediator": 1,"agencyid": "mocklea","starttime": 0,"endtime": 0,"user": "MarioRossi","accesstype": "fiber","staticips": [{ "iprange": "10.45.0.3", "sessionid": 101 }]}'
URL2='http://172.19.0.3:8080/ipintercept'

curl -X POST -H "Content-Type: application/json" -d "$PAYLOAD2" "$URL2"