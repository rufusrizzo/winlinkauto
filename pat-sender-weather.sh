#!/bin/bash
time=$(date -u +%H%M)
# The following returns something like "+48°F ↓2mph Light rain", but the wind arrow will likely not work, but is probably fine
#weather=$(curl wttr.in/Denver?format="%t+%w+%C")

# Alternative considerably hackier method of parsing a weather file for our data
weather_file=$(mktemp weather_data.tmpXXX)
weather=$(curl -s wttr.in/Denver?format=p1 > ${weather_file})
temp=$(grep 'temperature_fahrenheit{forecast="current"}' ${weather_file} |awk '{print $2}')
wind=$(grep 'windspeed_mph{forecast="current"}' ${weather_file} |awk '{print $2}')
desc=$(grep 'weather_desc{forecast="current"' ${weather_file} |awk -F ',' '{print $2}'|awk -F '"' '{print $2}')
weather=${temp}F", Wind "${wind}"mph, "${desc}
rm ${weather_file}

printf "K1WTF, Tyler, Broomfield, Broomfield, CO (HF)\r\n${time} UTC, ${weather}"
#printf "K1WTF, Tyler, Broomfield, Broomfield, CO (HF)\r\n${time} UTC, ${weather}" | pat compose --from K1WTF --subject "Winlink Wednesday Check-In" KN4LQN
