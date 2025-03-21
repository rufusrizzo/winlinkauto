#!/bin/bash
#Help list
#Need to add help here
#Maybe better option handling
# Usage $0 <BAND> <Number of Retries> <RECV for Receive mode>
#
#Gathering Band to use
if [[ -z $1 ]] 
then
	echo "Popular Winlink bands, 10, 20, 30, 40, 80, p2p"
	echo "Just enter the number."
	read -p "Enter the band you wish to use: " band
else
	band=$1
fi

#Setting some variables
gwldir="gwlists"
cfgdir="conf"
logdir="logs"
mycall=`pat env | grep MYCALL | awk -F "\"" '{print $2}'`
patmailbox=`pat env | grep MAILBOX | awk -F"\"" '{print $2}'`
outboxnum=`ls -ltr ${patmailbox}/${mycall}/out | grep -v total | wc -l`


# How many times to try each list of gateways
[[ -z $2 ]] && num_retries=2 || num_retries=$2
#Setting Receive mode, if it's set
[[ -z $3 ]] && echo "######Send Mode Set" || send_mode=$3
[[ -z $4 ]] && send_mode2="go" || send_mode2=$4


# Randomize our station list for fun before each run
station_list_all=$(mktemp station_list.tmpXXX)
station_list_filtered=$(mktemp station_list.tmpXXX)
station_list_good=$(mktemp station_list.tmpXXX)
if [[ -f ${gwldir}/${band}m.txt && -s ${gwldir}/${band}m.txt ]]
then
	shuf $gwldir/${band}m.txt > ${station_list_all}  
else
	echo "No Gateways defined"
	echo "Getting them"
	pat-gen-stationlist.sh
	shuf $gwldir/${band}m.txt > ${station_list_all}  
fi
#If Skip Good Gateways is set, this will filter them out
#I've got too many test statements, just touching the files
touch ${gwldir}/good-gws.txt ${gwldir}/good-gws-logs.txt ${gwldir}/good-gws-combined.txt
if [[ $send_mode == "sggw" || $send_mode2 == "sggw" ]]
then
	egrep -v `echo -n "\"" ; for i in \`cat gwlists/good-gws.txt gwlists/good-gws-combined.txt gwlists/good-gws-logs.txt | sort | uniq\` ; do echo -n "${i}|" ; done ; echo "FILLLLLLLL\""` $gwldir/${band}m.txt > ${station_list_all}
fi

cleanup() {
    rm station_list.tmp* &> /dev/null
    rm ${gwldir}/gg-${band}m.txt &> /dev/null
    rm ${logdir}/*-connectlog-*.log &> /dev/null
}

# Wont cancel if pat is trying to connect, but will stop after pat fails
trap '{ echo "Hey, you pressed Ctrl-C.  Time to quit."; cleanup; exit 1; }' INT
radio_set() {
#Sample:
#FTDX-10|PKTUSB|3000|2|0|0|0.921569|0.500000
#Checking if it's ok to check radio settings
if [[ -v CKRAD && $CKRAD == "no" ]]
then
	echo "Skipping radio setting check"
	return 0
fi
if [[ -v band && $band == "p2p" ]]
then
	echo "Skipping radio setting check for p2p"
	return 0
fi


RADMODEL=`echo "0xf3" | nc -w 1 localhost 4532 | grep model | awk '{print $2}'`
#Checking for a config file
if [[ `ls -ltr $cfgdir/radio | grep $RADMODEL | wc -l` -ge 1 ]]
then
	echo "Config file found"
else
	echo "No Config file found, can't compare settings to known good"
	return 1 

fi
#Setting the frequency, before checking the settings
	echo "Setting radio frequency to match the $band M band"
case $band in

	10 ) echo "F 28126000" | nc -w 1 localhost 4532
	;;
	20 ) echo "F 14107000" | nc -w 1 localhost 4532
	;;
	30 ) echo "F 10130000" | nc -w 1 localhost 4532
	;;
	40 ) echo "F 7109000" | nc -w 1 localhost 4532
	;;
	80 ) echo "F 3585000" | nc -w 1 localhost 
	;;
esac

MODE=`echo "m" | nc -w 1 localhost 4532 | head -1` 
sleep 1
AUDBW=`echo "m" | nc -w 1 localhost 4532 | tail -1`
AGC=`echo "l AGC" | nc -w 1 localhost 4532`
PREAMP=`echo "l PREAMP" | nc -w 1 localhost 4532`
sleep 1
ATT=`echo "l ATT" | nc -w 1 localhost 4532`
sleep 1
RF=`echo "l RF" | nc -w 1 localhost 4532`
RFS="${RF:2:2}"
RFPOWER=`echo "l RFPOWER" | nc -w 1 localhost 4532`
RFPOWERS="${RFPOWER:2:2}"
if [[ -v MODE && $MODE == "`cat $cfgdir/radio/${RADMODEL}.txt | awk -F"|" '{print $2}'`" ]]
then
	echo "Mode is good"
else
	echo "Setting mode and BW"
	echo "M `cat $cfgdir/radio/${RADMODEL}.txt | awk -F"|" '{print $2}'` `cat $cfgdir/radio/${RADMODEL}.txt | awk -F"|" '{print $3}'`" | nc -w 1 localhost 4532
	sleep 1
fi
if [[ -v AUDBW && $AUDBW == "`cat $cfgdir/radio/${RADMODEL}.txt | awk -F"|" '{print $3}'`" ]]
then
	echo "Audio BW is good"
else
	echo "Setting mode and BW"
	echo "M `cat $cfgdir/radio/${RADMODEL}.txt | awk -F"|" '{print $3}'` `cat $cfgdir/radio/${RADMODEL}.txt | awk -F"|" '{print $3}'`" | nc -w 1 localhost 4532
	sleep 1
fi
if [[ -v AGC && $AGC == "`cat $cfgdir/radio/${RADMODEL}.txt | awk -F"|" '{print $4}'`" ]]
then
	echo "AGC is good"
else
	echo "Setting AGC to Auto"
	echo "L AGC `cat $cfgdir/radio/${RADMODEL}.txt | awk -F"|" '{print $4}'` " | nc -w 1 localhost 4532
	sleep 1
fi
if [[ -v PREAMP && $PREAMP == "`cat $cfgdir/radio/${RADMODEL}.txt | awk -F"|" '{print $5}'`" ]]
then
	echo "PREAMP is good"
else
	echo "Turning off the Preamp"
	echo "L PREAMP `cat $cfgdir/radio/${RADMODEL}.txt | awk -F"|" '{print $5}'` " | nc -w 1 localhost 4532
	sleep 1
fi
if [[ -v ATT && $ATT == "`cat $cfgdir/radio/${RADMODEL}.txt | awk -F"|" '{print $6}'`" ]]
then
	echo "Attenuator is Off"
else
	echo "Turning off the Attenuator"
	echo "L ATT `cat $cfgdir/radio/${RADMODEL}.txt | awk -F"|" '{print $6}'` " | nc -w 1 localhost 4532
	sleep 1
fi
if [[ -v RFS && $RFS -ge "`cat $cfgdir/radio/${RADMODEL}.txt | awk -F"|" '{print $7}'`" ]]
then
	echo "RF Gain is good"
else
	echo "Trying to set the RF gain"
	echo "L RF `cat $cfgdir/radio/${RADMODEL}.txt | awk -F"|" '{print $8}'` " | nc -w 1 localhost 4532
	sleep 1
fi
if [[ -v RFPOWERS && $RFPOWERS -le "`cat $cfgdir/radio/${RADMODEL}.txt | awk -F"|" '{print $9}'`" ]]
then
	echo "RF Power is good"
else
	echo "Trying to set the RF Power"
	echo "L RFPOWER `cat $cfgdir/radio/${RADMODEL}.txt | awk -F"|" '{print $10}'` " | nc -w 1 localhost 4532
	sleep 1
fi
}
parser() {
LOGFILE="${logdir}/${GWCALL}-connectlog-${date}.log"
CONNFAILREASON=`egrep -i "nable to establish connection to remote|Exchange failed|i/o timeout|ARDOP TNC initialization failed:" $LOGFILE  | awk -F":" '{print $4}' | tail -1`
CONNFAILED=`egrep -i "nable to establish connection to remote|Exchange failed|i/o timeout|ARDOP TNC initialization failed:" $LOGFILE  | wc -l`
#This can be used for debug
#[[ $CONNFAILED -ge 1 ]] || cp $LOGFILE ${logdir}/good-$date.log
CONNDATE=`grep "Connected" $LOGFILE | awk '{print $1}'`
CONNTIME=`grep "Connected" $LOGFILE | awk '{print $2}'`
CONNGW=`grep "Connected" $LOGFILE | awk '{print $5}'`
CONNPROTO=`grep "Connected" $LOGFILE | awk -F"\(|\)" '{print $2}' &> /dev/null`
COONNGWLOC=`grep "daily minutes" $LOGFILE | awk -F"\(|\)" '{print $2}' &> /dev/null`
CONNXMIT=`grep "Transmitting" $LOGFILE | wc -l`
CONNRCVD=`grep "Receiving" $LOGFILE | wc -l`
CONNXMITALL=`grep -A 1 "Transmitting" $LOGFILE | grep -v "Transmitting" | grep 100 | wc -l`
CONNRCVDALL=`grep -A 1 "Receiving" $LOGFILE | grep -v "Receiving" | grep 100 | wc -l`
ECONNDATE=`grep "QSX" $LOGFILE | awk '{print $1}'`
ECONNTIME=`grep "QSX" $LOGFILE | awk '{print $2}'`
ENDOUTBOXNUM=`ls -ltr ${patmailbox}/${mycall}/out | grep -v total | wc -l`
if [[ $ENDOUTBOXNUM -lt $outboxnum && $CONNFAILED -gt 0 ]]
then
	CONNFAILREASON="Got failure from ARDOP, but some messages were sent"
	CONNFAILED=0
fi
echo "$mycall|$band|$CONNDATE|$CONNTIME|$CONNPROTO|$CONNGW|$GWGRID|$GWDIST|$GWBEAR|$GWPROTO|$GWSPD|$GWFREQ|$COONNGWLOC|$CONNXMIT|$CONNXMITALL|$CONNRCVD|$CONNRCVDALL|$ECONNDATE|$ECONNTIME|$outboxnum|$ENDOUTBOXNUM|$CONNFAILREASON|$CONNFAILED" >> ${logdir}/pat_connect-summ.log

}

check_pat_out() {
[[ $send_mode == "RECV" ]] && return 0
pat_out=`ls -ltr ${patmailbox}/${mycall}/out/ | grep -v total | wc -l`
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
	cleanup
	exit 0
fi
}

gen_mm_bearing() {
#Checking if the log is there
if [ ! -f ${logdir}/pat_connect-summ.log ]
then
	max_bearing=skip
	return 0
fi
#Max bearing
max_bearing_log=`cat ${logdir}/pat_connect-summ.log | awk -F"|" '{if ($NF < "1") print $0;}' | grep -v FILL | awk -F"|" '{print $9}' | sort -n | tail -1`
#Min bearing
min_bearing_log=`cat ${logdir}/pat_connect-summ.log | awk -F"|" '{if ($NF < "1") print $0;}' | grep -v FILL | awk -F"|" '{print $9}' | sort -n | head -1`
max_bearing=$((max_bearing_log+10))
min_bearing=$((min_bearing_log-10))
#Checking if they are more than 360, or less than zero, opening up by 10 degrees
[[ $max_bearing -ge 360 ]] && max_bearing=$((max_bearing-360))
[[ $min_bearing -le 0 ]] && min_bearing=$((360+min_bearing))

[[ $max_bearing -ge 360 ]] && max_bearing=$((max_bearing-360))
[[ $min_bearing -le 0 ]] && min_bearing=$((360+min_bearing))
#If the Max bearing is smaller than min bearing, swapping them
if [[ $min_bearing -gt $max_bearing ]]
then
	min_temp=$min_bearing
	min_bearing=$max_bearing
	max_bearing=$min_temp
	unset min_temp
fi
if [[ $min_bearing -eq $max_bearing ]]
then
	max_bearing=skip
fi
echo "Max Bearing: " $max_bearing
echo "Min Bearing: " $min_bearing

}

good_gws() {
#Generating Good GWs based on log
[[ -f ${logdir}/pat_connect-summ.log ]] && cat ${logdir}/pat_connect-summ.log | awk -F"|" '{if ($NF < "1") print $0;}'  | awk -v band=$band -F"|" '{if ($2 == band ) print $0;}' | awk -F"|" '{print $6}' | sort | uniq >${gwldir}/good-gws-logs.txt
#Checking for past good GW's and setting the station list to them
if [[ -f ${gwldir}/good-gws.txt && -s ${gwldir}/good-gws.txt && band -ne "p2p"  ]]
then
	cat ${gwldir}/good-gws.txt ${gwldir}/good-gws-logs.txt | sort | uniq > ${gwldir}/good-gws-combined.txt
        for gws in `cat ${gwldir}/good-gws-combined.txt`
                do grep $gws ${gwldir}/${band}m.txt >> ${gwldir}/gg-${band}m.txt
        done
        if [[ -f ${gwldir}/gg-${band}m.txt && -s ${gwldir}/gg-${band}m.txt ]]
        then
                echo "Found some Previously connected GWs, trying them now"
		cat ${gwldir}/gg-${band}m.txt > $station_list_good
		station_list="$station_list_good"
	else
		return
        fi
	#Connecting to good gateways	
	station_connect "${band}"
	fails=0
else
        echo "No good Gateways"
	[[ -f ${gwldir}/good-gws-combined.txt && -s ${gwldir}/good-gws-combined.txt ]] && cat ${gwldir}/good-gws-combined.txt > ${gwldir}/good-gws.txt
	sleep 2
fi


}
station_connect() {
	connum=1
	mcnt=`wc -l $station_list | awk '{print $1}'`
    while read line
    do
	let runnum=$fails+1
	echo "#####################################################"
	echo "Connection attempt $connum of $mcnt "
	echo "Run number $runnum "
	echo "#####################################################"
        CALL=$(echo $line |awk '{print $11}')
	GWCALL=$(echo $line |awk '{print $1}')
	GWGRID=$(echo $line |awk '{print $2}')
	GWDIST=$(echo $line |awk '{print $3}')
	GWBEAR=$(echo $line |awk '{print $4}')
	GWPROTO=$(echo $line |awk '{print $5}')
	GWSPD=$(echo $line |awk '{print $6}')
	GWFREQ=$(echo $line |awk '{print $7}')
        date=$(date +%F"_"%H":"%M":"%S)
        pat connect ${CALL} | tee ${logdir}/${GWCALL}-connectlog-${date}.log
	#Parsing the connection log
	parser
        RESULT=`tail -1 ${logdir}/pat_connect-summ.log | awk -F "|" '{print $NF}'`
        if [ ${RESULT} = "0" ]
        then
            echo "${date} SUCCESS with ${CALL}" |tee -a ${logdir}/runlog.txt
        else
            echo "${date} FAIL with ${CALL}" |tee -a ${logdir}/runlog.txt
    		((connum++))
        fi
    #Checking pat outbox
    check_pat_out
	sleep 15
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
	echo "#####################################################"
	echo "Checking Radio Settings"
	echo "#####################################################"
radio_set

#Seeing if Good gw mode is disabled, then trying to connect to good GWs
if [[ $send_mode == "sggw" || $send_mode2 == "sggw" ]]
then
	echo "#####################################################"
	echo "Skipping Good GWs"
	echo "#####################################################"
else
	good_gws
fi


#Trying to connect to GW's based on successful connections and their bearing, or all GWs 
gen_mm_bearing
if [[ $max_bearing == "skip" ]]
then
	echo "#####################################################"
	echo "Trying All Gateways"
	echo "#####################################################"
	station_list="$station_list_all"
	station_connect "${band}"
	cleanup
	exit 
else
	echo "#####################################################"
	echo "Trying Gateways based on Successful connection Bearings"
	echo "#####################################################"
	cat ${station_list_all} | awk -v max_bearing=$max_bearing -v min_bearing=$min_bearing '{if ($4 > min_bearing && $4 < max_bearing) print $0;}' > $gwldir/${band}m-filtered.txt
	shuf $gwldir/${band}m-filtered.txt > ${station_list_filtered}  
	station_list="$station_list_filtered"
	station_connect "${band}"
	echo "#####################################################"
	echo "Trying All Gateways"
	echo "#####################################################"
	sleep 15
	station_list="$station_list_all"
	station_connect "${band}"
	cleanup
	exit
fi
