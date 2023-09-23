#!/bin/bash
#This script will automatically send a message and try to connect to GW's on the chosen band
#Started by Riley C on 9/23
band=$1

for run in 1 2 3 
do
	echo "###########################################################################"
	echo "Posting then sending message $run"
	echo "###########################################################################"
 	./pat-sender.sh n "Find GWs ${band} $run" "Testing sending  on ${band}.  Sent from `pwd`{$0}, on `hostname`, at `date`. Message number $run." "riley@netandnix.net rec7788@hotmail.com"
 	./pat-connect-hf.sh $band 2 sggw
	echo "###########################################################################"
	echo "Taking a little break"
	echo "###########################################################################"
	sleep 120

done

