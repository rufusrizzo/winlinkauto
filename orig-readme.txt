# ~/.config/pat/config.json notes:
  "hamlib_rigs": {
    "7610": {"address": "localhost:4532", "network": "tcp"}
  },

  "ardop": {
    "addr": "localhost:8515",
    "arq_bandwidth": {
      "Forced": false,
      "Max": 500
    },
    "rig": "7610",
    "ptt_ctrl": true,
    "beacon_interval": 0,
    "cwid_enabled": false
  },


# generate station lists
./pat-gen-stationlist.sh

# get audio ids for your radio
arecord -l
# start ardop
./ardop/ardopc 8515 plughw:2,0 plughw:2,0

# make sure rigctl is running for your rig
# generate the email to send. depending on week use the weather or ics213 script
./pat-sender.sh

# pat connect to every gateway until transactions are complete
./pat-connect.sh
