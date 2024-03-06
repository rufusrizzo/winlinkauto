#!/bin/bash
#
#This script will attempt to send a p2P winlink message
#Started by Riley C on 9/19/2023
#
if [[ $1 == "help" || $1 == "--help" || $1 == "-help" || $1 == "-h" ]] 
	then
		echo
		echo "Usage: $0 <Your Name> <Your City> <NOTUNE, if you want to disable tuning betwenn bands>"
		echo
		exit
fi
infile=gwlists/p2p-msg.txt
if [[ -f $infile && -s $infile ]]
	then
		echo
	else
	echo "#######################################"
	echo "This script requires a list $infile"
	echo "Trying to generate it, rerun $0"
	echo "#######################################"
	echo
	./gen-p2plist-pat_inbox.sh
	exit
fi
if [[ -z $1 ]] 
then
	echo -n "Please enter your name: "
	read name

else
	name=$1
fi

if [[ -z $2 ]] 
then
	echo -n "Please enter your City: "
	read location

else
	location=$2
fi

gwldir="gwlists"
cfgdir="conf"
logdir="logs"
mycall=`pat env | grep MYCALL | awk -F "\"" '{print $2}'`
patmailbox=`pat env | grep MAILBOX | awk -F"\"" '{print $2}'`
radfreq=`echo "f" | nc -w 1 localhost 4532`
LASTFREQ="${radfreq:0:2}"
check_pat_out() {
	[[ $send_mode == "RECV" ]] && return 0
	pat_out=`ls -ltr ${patmailbox}/${mycall}/out/ | grep -v total | wc -l`
	if [[ $pat_out -ge 1 ]]
	then
		echo "#######################################"
	        echo "Found messages in the outbox, moving to the next GW"
	        echo "Clearing the outbox"
		echo "#######################################"
		rm ${patmailbox}/${mycall}/out/*
	        return 0
	else
	        echo "#####################################################"
	        echo "Message Sent, exiting"
	        echo "#####################################################"
		exit 0
	fi
}



for CALL in `cat  $infile | egrep "Primary|Alternate" | grep -v "Messages" | awk '{print $2}'`
	do
	FREQ=`grep $CALL  $infile | egrep "Primary|Alternate" | grep -v "Messages" | awk '{print $3}'`
	SPEED=`grep $CALL  $infile | egrep "Primary|Alternate" | grep -v "Messages" | awk '{print $4}'`
	STYPE=`grep $CALL  $infile | egrep "Primary|Alternate" | grep -v "Messages" | awk '{print $1}'`
	#Tuning if the band is different
	if [[ ${FREQ:0:2} != $LASTFREQ && $3 != "NOTUNE" ]]
	then
		 echo 
		 echo "Tuning after band change"
		 echo 
		 echo "F ${FREQ}000" | nc -w 1 localhost 4532
		 sleep 1
		 echo "G TUNE" | nc -w 1 localhost 4532
		 sleep 15
	 else
		 echo 
		 echo "Same Band, not tuning"
		 echo
	fi

	#Generating a GW List
	if [[ $SPEED = "2000/500" || $SPEED = "500/2000" ]]
	then
		echo "$CALL $STYPE FILL FILL2 ARDOP 2000 $FREQ MHz $FREQ MHz ardop:///${CALL}?bw=2000MAX&freq=$FREQ" > ${gwldir}/p2pm.txt
		echo "$CALL $STYPE FILL FILL2 ARDOP 500 $FREQ MHz $FREQ MHz ardop:///${CALL}?bw=500&freq=$FREQ" >> ${gwldir}/p2pm.txt

	else
		echo "$CALL $STYPE FILL FILL2 ARDOP 500 $FREQ MHz $FREQ MHz ardop:///${CALL}?bw=500&freq=$FREQ" > ${gwldir}/p2pm.txt

	fi
	#Generating the messages
	printf "$mycall, $name, $location (HF-P2P)" | pat compose --p2p-only --from $mycall --subject "Winlink Wednesday Check-In" $CALL 
	echo "#######################################"
	echo "Sending P2P Message to $CALL"
	echo "#######################################"
	echo
	LASTFREQ="${FREQ:0:2}"
	./pat-connect-hf-vara.sh p2p 3
	check_pat_out



done
