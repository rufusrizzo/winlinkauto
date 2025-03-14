#!/bin/bash
#
OUTDIR=/home/riley/bin
BINDIR=/home/riley/bin
TEMPHUM='66 66'
#TEMPHUM=''
#TEMPHUM=66
if [[  -z "$TEMPHUM" ]]
	then
		TEMPHUM='BROKEN'
		echo $TEMPHUM 
	else
		echo $TEMPHUM 
fi


