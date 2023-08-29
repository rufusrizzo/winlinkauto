#!/bin/bash
#Help list
#Need to add help here
# Usage $0 <BAND> <Number of Retries>
#
#Gathering Band to use
if [[ -z $1 ]] 
then
	echo "Popular Winlink bands, 10, 20, 30, 40, 80"
	echo "Just enter the number."
	read -p "Enter the band you wish to use: " band
else
	band=$1
fi

#Setting some variables
gwldir="gwlists"
cfgdir="conf"
logdir="logs"

# How many times to try each list of gateways
[[ -z $2 ]] && num_retries=2 || num_retries=$2

# Randomize our station list for fun before each run
station_list=$(mktemp station_list.tmpXXX)
shuf $gwldir/${band}m.txt > ${station_list}
mcnt=`wc -l $gwldir/${band}m.txt | awk '{print $1}'`

cleanup() {
    rm ${station_list} 
}

# Wont cancel if pat is trying to connect, but will stop after pat fails
trap '{ echo "Hey, you pressed Ctrl-C.  Time to quit."; cleanup; exit 1; }' INT

station_connect() {
	connum=1
    while read line
    do
	echo "#####################################################"
	echo "Connection attempt $connum of $mcnt "
	echo "Run number $fails "
	echo "#####################################################"
        CALL=$(echo $line |awk '{print $11}')
        date=$(date +%F"_"%H":"%M":"%S)
        pat connect ${CALL}
        RESULT=$(echo $?)
        if [ ${RESULT} = "0" ]
        then
            echo "${date} SUCCESS with ${CALL}" |tee -a ${logdir}/runlog.txt
            cleanup
            exit 0
        else
            echo "${date} FAIL with ${CALL}" |tee -a ${logdir}/runlog.txt
    		((connum++))
		echo $fails
		echo $connum
        fi
    done < ${station_list}
    # at this point we have failed to connect, increment fail counter and try again
    ((fails++))
    unset connum
    if [ ${fails} -lt ${num_retries} ]
    then
        station_connect ${1}
    else
        date=$(date +%F"_"%H":"%M":"%S)
        echo "${date} failed to connect with ${num_retries} attempts"
    fi
}

fails=0
station_connect "${band}"
cleanup
