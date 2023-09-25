#!/bin/bash
#This script will automatically send a message and try to connect to GW's on the chosen band
#Started by Riley C on 9/23
if [[ -z $1 ]] 
then
	echo "Enter the band you wish to test: "
	read band
else
	band=$1
fi
trap '{ echo "Hey, you pressed Ctrl-C.  Time to quit."; cleanup; exit 1; }' INT

gwldir="gwlists"
cfgdir="conf"
logdir="logs"
mycall=`pat env | grep MYCALL | awk -F "\"" '{print $2}'`
patmailbox=`pat env | grep MAILBOX | awk -F"\"" '{print $2}'`
outboxnum=`ls -ltr ${patmailbox}/${mycall}/out | grep -v total | wc -l`

cleanup() {
    rm ${patmailbox}/${mycall}/out/*
}



for run in 1 2 3 
do
	echo "###########################################################################"
	echo "Posting then sending message $run"
	echo "###########################################################################"
 	./pat-sender.sh n "Find GWs ${band} $run" "Testing sending  on ${band}.  Sent from `pwd`${0}, on `hostname`, at `date`. Message number $run." "riley@netandnix.net rec7788@hotmail.com"
 	./pat-connect-hf.sh $band 2 sggw
	echo "###########################################################################"
	echo "Taking a little break"
	echo "###########################################################################"
	sleep 120

done
cleanup

