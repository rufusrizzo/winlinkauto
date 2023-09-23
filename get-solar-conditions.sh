#!/bin/bash
#This script will get Solarconditions and parse them
#Started by RileyC on 9/22/2023
#
curl -s https://www.hamqsl.com/solarxml.php -o /tmp/solar-cond.xml
cat /tmp/solar-cond.xml | grep "band name" | awk -F"\"" '{print $2,$4,$5}' | sed 's!</band>!!g' | sed 's!>!!g'
