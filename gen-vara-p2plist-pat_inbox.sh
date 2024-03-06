#!/bin/bash
#
#This script will attempt to send a p2P winlink message
#Started by Riley C on 9/19/2023
#
gwldir="gwlists"
cfgdir="conf"
logdir="logs"
mycall=`pat env | grep MYCALL | awk -F "\"" '{print $2}'`
patmailbox=`pat env | grep MAILBOX | awk -F"\"" '{print $2}'`

message=`grep "Winlink Wednesday Reminder" ${patmailbox}/${mycall}/in/* | awk 'max<$5 || NR==1{ max=$5; data=$5 } END{ print $1 }' | awk -F":" '{print $1}'`

cat ${message} | sed -ne '/VARA HF P2P/,/KN4LQN,/p' | egrep "Primary|Alternate" | grep -v Messages > ${gwldir}/p2p-msg.txt
