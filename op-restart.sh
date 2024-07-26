#!/bin/bash
#This script will restart all winlink services
#Started by Riley C on 7/26/2024
echo "Restarting services"
for i in ardop rigctl direwolf pat
	do
	sudo /usr/sbin/service $i restart
	echo "$i	 Status 	###########################################################################"
	sudo /usr/sbin/service $i status | egrep "Loaded:|Active:"
	echo
	echo "To see more details run: sudo service $i status"
	echo
done


