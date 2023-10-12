#!/bin/bash
#This script will check the radio settings to ensure they're set correctly.
#Started by RileyC on 9/25/2023
#
gwldir="gwlists"
cfgdir="conf"
logdir="logs"
mycall=`pat env | grep MYCALL | awk -F "\"" '{print $2}'`
RADMODEL=`echo "0xf3" | nc -w 1 localhost 4532 | grep model | awk '{print $2}'`
MODE=`echo "m" | nc -w 1 localhost 4532 | head -1`
AUDBW=`echo "m" | nc -w 1 localhost 4532 | tail -1`
AGC=`echo "l AGC" | nc -w 1 localhost 4532`
PREAMP=`echo "l PREAMP" | nc -w 1 localhost 4532`
ATT=`echo "l ATT" | nc -w 1 localhost 4532`
RF=`echo "l RF" | nc -w 1 localhost 4532`
RFPOWER=`echo "l RFPOWER" | nc -w 1 localhost 4532`
echo "$RADMODEL|$MODE|$AUDBW|$AGC|$PREAMP|$ATT|$RF|$RFPOWER"
