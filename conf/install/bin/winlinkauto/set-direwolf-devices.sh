#!/bin/bash
#This script will use a direwolf.conf template to set audio and service devices, based on what you have.
#Started by Riley C on 8/30/2024
#
TEMPLATE=/etc/winlinkauto/direwolf.template
CONFIG=/etc/winlinkauto/direwolf.conf
# Set your first audio device string here, use aplay -l to see what you have
APLAY_STRING1="USB Audio CODEC"
#Getting the current channel number
ADEVICE1=`aplay -l  | grep "$APLAY_STRING1" | awk -F":" '{print $1}' | awk '{print $2}'`

#
#Set your serial device here
SERIALDEV1="usb-Silicon_Labs_CP2105_Dual_USB_to_UART_Bridge_Controller_00E410A1-if01-port0"
SERIALDEV1_RESOLV=`ls -ltr /dev/serial/by-id/ | grep $SERIALDEV1 | awk -F"../../" '{print $2}'`


#This will use the template to change the settings
cat $TEMPLATE | sed "s/TCHANNEL1/$ADEVICE1/g" | sed "s!SERIAL1!/dev/${SERIALDEV1_RESOLV}!g" > $CONFIG
sleep 1

