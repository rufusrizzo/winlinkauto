#!/bin/bash
#This script will have everything needed to start and change ardop.
#Started by RileyC on 7/17/2024
#
#ExecStart=bash -c "/usr/bin/winlinkauto/ardopc/ardopc  -l /var/log/winlinkauto/ardop 8515 plughw:2,0 plughw:2,0"
####ExecStart=bash -c "/usr/bin/winlinkauto/ardopc/ardopc64  -l /var/log/winlinkauto/ardop 8515 'plughw:0,0 Rate 48000' 'plughw:0,0 Rate 48000'"
#/usr/bin/winlinkauto/ardopcf 8515 'plughw:0,0 Rate 48000' 'plughw:0,0 Rate 48000' -l /var/log/winlinkauto/ardop -c 127.0.0.1:4532 -p 127.0.0.1:4532"
/usr/bin/winlinkauto/ardopcf 8515 'plughw:0,0 Rate 48000' 'plughw:0,0 Rate 48000' -l /var/log/winlinkauto/ardop -c 127.0.0.1:4532 -p 127.0.0.1:4532
#ExecStart=bash -c "/usr/bin/winlinkauto/ardopc/ardopc64  -l /var/log/winlinkauto/ardop 8515 ARDOP0 ARDOP0"
#ExecStart=bash -c "/usr/bin/ardop -l /var/log/winlinkauto/ardop 8515 plughw:2,0 plughw:2,0"
#ExecStop=bash -c "killall ardopcf"

