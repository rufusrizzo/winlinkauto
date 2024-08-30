#!/bin/bash
#This script will use a direwolf.conf template to set audio and service devices, based on what you have.
#Started by Riley C on 8/30/2024
#
# Set your first audio device string here, use aplay -l to see what you have
APLAY_STRING1="USB PnP Sound Device"
#Getting the current channel number
ADEVICE1=`aplay -l  | grep "$APLAY_STRING1" | awk -F":" '{print $1}' | awk '{print $2}'`

#
#Set your serial device here
SERIALDEV1="usb-Silicon_Labs_CP2102N_USB_to_UART_Bridge_Controller_72e71c8ca9caeb11863587561d69213e-if00-port0"
SERIALDEV1_RESOLV=`ls -ltr /dev/serial/by-id/ | grep $SERIALDEV1 | awk -F"../../" '{print $2}'`


#This will use the template to change the settings
cat /etc/direwolf.template | sed "s/TCHANNEL1/$ADEVICE1/g" | sed "s!SERIAL1!/dev/${SERIALDEV1_RESOLV}!g" > /etc/direwolf.conf
sleep 1

