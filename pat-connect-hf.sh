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
station_list_all=$(mktemp station_list.tmpXXX)
station_list_filtered=$(mktemp station_list.tmpXXX)
station_list_good=$(mktemp station_list.tmpXXX)
shuf $gwldir/${band}m.txt > ${station_list_all}
shuf $gwldir/${band}m-filtered.txt > ${station_list_filtered}


cleanup() {
    rm ${station_list_all} 
    rm ${station_list_good} 
    rm ${station_list_filtered} 
    rm ${gwldir}/gg-${band}m.txt
}

# Wont cancel if pat is trying to connect, but will stop after pat fails
trap '{ echo "Hey, you pressed Ctrl-C.  Time to quit."; cleanup; exit 1; }' INT

check_pat_out() {
#Need to get the directory from PAT, and callsign
#I'm lazy right now
pat_out=`ls -ltr /home/riley/.local/share/pat/mailbox/KF4EMZ/out/ | grep -v total | wc -l`
if [[ $pat_out -ge 1 ]]
then
	echo "#####################################################"
	echo "Found messages in the outbox"
	echo "#####################################################"
	return 0
else
	echo "#####################################################"
	echo "Nothing to send, exiting"
	echo "#####################################################"
	exit 0
fi
}

station_connect() {
	connum=1
	mcnt=`wc -l $station_list | awk '{print $1}'`
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
            return 0
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
check_pat_out

#Checking for past good GW's and setting the station list to them
if [[ -f ${logdir}/good-gws.log && -s ${logdir}/good-gws.log ]]
then
        for gws in `cat ${logdir}/good-gws.log`
                do grep $gws ${gwldir}/${band}m.txt >> ${gwldir}/gg-${band}m.txt
        done
        if [[ -f ${gwldir}/gg-${band}m.txt && -s ${gwldir}/gg-${band}m.txt ]]
        then
                echo "Found some Previously connected GWs, trying them now"
		cat ${gwldir}/gg-${band}m.txt > $station_list_good
		station_list="$station_list_good"
        else
		station_list="$station_list_filtered"
        fi
else
        echo "Something broke"
	exit 5
fi

station_connect "${band}"
check_pat_out
	echo "#####################################################"
	echo "Trying more Gateways"
	echo "#####################################################"
		station_list="$station_list_filtered"
station_connect "${band}"
cleanup
