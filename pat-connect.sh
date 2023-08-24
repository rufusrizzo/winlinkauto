#!/bin/bash

# How many times to try each list of gateways
num_retries=2

# Randomize our station list for fun before each run
#station_list20=$(mktemp station_list20.tmpXXX)
#shuf 20m.txt > ${station_list20}
#twentymcnt=`wc -l 20m.txt | awk '{print $1}'`
station_list40=$(mktemp station_list40.tmpXXX)
shuf 40m.txt > ${station_list40}
fawdymcnt=`wc -l 40m.txt | awk '{print $1}'`

cleanup() {
    rm ${station_list40} 
}

# Wont cancel if pat is trying to connect, but will stop after pat fails
trap '{ echo "Hey, you pressed Ctrl-C.  Time to quit."; cleanup; exit 1; }' INT

station_connect() {
    if [ ${1} == "40" ]
    then
        station_list=${station_list40}
    else
        station_list=${station_list40}
    fi

	connum=1
    while read line
    do
	echo "#####################################################"
	echo "Connection attempt $connum of $fawdymcnt "
	echo "Run number $fails "
	echo "#####################################################"
        CALL=$(echo $line |awk '{print $11}')
        date=$(date +%F"_"%H":"%M":"%S)
        pat connect ${CALL}
        RESULT=$(echo $?)
        if [ ${RESULT} = "0" ]
        then
            echo "${date} SUCCESS with ${CALL}" |tee -a log.txt
            cleanup
            exit 0
        else
            echo "${date} FAIL with ${CALL}" |tee -a log.txt
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

#fails=0
#station_connect "20"
fails=0
station_connect "40"
cleanup
