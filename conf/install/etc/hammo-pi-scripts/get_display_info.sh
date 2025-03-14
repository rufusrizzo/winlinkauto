#!/bin/bash
#
OUTDIR=/home/riley/bin
BINDIR=/home/riley/bin
TEMPHUM=`python3 $BINDIR/get-temp-hum.py`
> $OUTDIR/display-info.txt
#These will check to see if we got a result from the temp sensor
#This might not be needed once it's soldered, but on the bread coard the sensor comes and goes from the i2c bus
if [[ -z ${TEMPHUM} ]]
	then
		sleep 2
		TEMPHUM=`python3 $BINDIR/get-temp-hum.py`
		echo $TEMPHUM > $OUTDIR/display-info.txt
		echo $TEMPHUM > /tmp/LASTTEMP.txt
	else
		echo $TEMPHUM > $OUTDIR/display-info.txt
		echo $TEMPHUM > /tmp/LASTTEMP.txt
fi

if [[ -z ${TEMPHUM} ]]
	then
		sleep 2
		TEMPHUM=`python3 $BINDIR/get-temp-hum.py`
		cat /tmp/LASTTEMP.txt > $OUTDIR/display-info.txt
	else
		echo $TEMPHUM > $OUTDIR/display-info.txt
		echo $TEMPHUM > /tmp/LASTTEMP.txt
fi


MDNHD=`timeout 2 python3 $BINDIR/get-mdnhd-gpsd.py `
if [[ -z ${MDNHD} ]]
        then
                echo WALDO >> $OUTDIR/display-info.txt
        else
                echo $MDNHD >> $OUTDIR/display-info.txt
fi
date +%m_%d_%H:%M:%S >> $OUTDIR/display-info.txt
sleep 2
timeout 15 python3 $BINDIR/startup_display.py
python3   $BINDIR/print_simple_info.py
#head -1 $OUTDIR/display-info.txt | awk '{print "t"$1"h"$2}' > $OUTDIR/aprs-weater.txt
head -1 $OUTDIR/display-info.txt | awk '{print "g000t0"$1"r000p000P000h"$2"b00000L....DsIP"}' > $OUTDIR/aprs-weater.txt
echo "`date +%H%M` $TEMPHUM 5 12 `python3 /home/riley/bin/get-speed-gpsd.py`" >$OUTDIR/aprs-telem.txt
