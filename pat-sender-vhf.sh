#!/bin/bash
mycall=`pat env | grep MYCALL | awk -F "\"" '{print $2}'`
[[ -z $1 ]] && wlw=n || wlw=$1

if [[ -z $2 && $wlw == "y" ]] 
then
        read -p "Enter the name you wish to use: " name
else
        name=$2
fi
if [[ -z $3 && $wlw == "y" ]] 
then
	echo "Location example: Waynesboro, VA"
        read -p "Enter the location you wish to use: " location
else
        location=$3
fi
if [[ -z $2 && $wlw == "n" ]] 
then
        read -p "Enter the Subject you wish to use: " subject
else
        subject=$2
fi
if [[ -z $3 && $wlw == "n" ]] 
then
        read -p "Enter the message you wish to use: " message
else
        message=$3
fi

[[ -z $4 ]] || second_addr=$4



if [[ $wlw == "y" ]]
then
	printf "$mycall, $name, $location (VHF)" | pat compose --from $mycall --subject "Winlink Wednesday Check-In" KN4LQN "$second_addr"
exit
fi

if [[ $wlw == "wv" ]]
then
	printf "$mycall, $name, $location (VHF)" | pat compose --from $mycall --subject "West Virginia Winlink Check-In" WV8MT "$second_addr"
exit
fi

if [[ $wlw == "n" ]]
then
	printf "$message `date`" | pat compose --from $mycall --subject "$subject" $mycall "$second_addr"
exit
fi
