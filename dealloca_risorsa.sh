#!/bin/bash
IP=$2
WHEREHOUSE=$1
sed -i 's/'${IP}' ALLOCATED/'${IP}'/' $WHEREHOUSE
