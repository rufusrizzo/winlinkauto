#!/bin/bash

# This script is for week 3 of winlink wednesday net.

ics_form="RMS_Express_Form_ICS213_Initial_Viewer.xml"
if [ -f "${ics_form}" ]
then
    echo "please remove ${ics_form} to continue"
    exit 0
fi

smashed_date=$(TZ='UTC' date +%Y%m%d%H%M%S)
date=$(TZ='UTC' date +%F)
time=$(TZ='UTC' date +%H":"%M" "%Z)

# Generate the ICS xml form to attach
cat > "${ics_form}" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<RMS_Express_Form>
  <form_parameters>
    <xml_file_version>1.0</xml_file_version>
    <rms_express_version>v0.13.1 (991d5e1)</rms_express_version>
    <submission_datetime>${smashed_date}</submission_datetime>
    <senders_callsign>K1WTF</senders_callsign>
    <grid_square>DM79</grid_square>
    <display_form>ICS213_Initial_Viewer.html</display_form>
    <reply_template>ICS213_SendReply.0</reply_template>
  </form_parameters>
  <variables>
    <message>K1WTF, Tyler, Broomfield, Broomfield, CO (HF)</message>
    <fm_name>K1WTF, Net Participant</fm_name>
    <msgcc></msgcc>
    <msgsender>K1WTF</msgsender>
    <templateversion>ICS 213  v.41.12</templateversion>
    <mdate>${date}</mdate>
    <msgto></msgto>
    <msgsubject></msgsubject>
    <subjectline>Winlink Wednesday Check-in</subjectline>
    <msgp2p></msgp2p>
    <submit>Submit</submit>
    <inc_name>Winlink Wednesday</inc_name>
    <testcall>K1WTF</testcall>
    <approved_postitle>Net Participant</approved_postitle>
    <msgisreply>False</msgisreply>
    <formtitle></formtitle>
    <msgbody></msgbody>
    <msgisacknowledgement>False</msgisacknowledgement>
    <msgseqnum>0</msgseqnum>
    <showdr></showdr>
    <txtstr></txtstr>
    <parseme></parseme>
    <approved_name>TK</approved_name>
    <message2>K1WTF, Tyler, Broomfield, Broomfield, CO (HF)</message2>
    <to_name>Net Control</to_name>
    <mtime>${time}</mtime>
    <msgisforward>False</msgisforward>

  </variables>
</RMS_Express_Form>
EOF

# Send mail with ICS data in message, but attach xml as well
#  Yes there is a space after 'Message:', unsure if this is required, but pat adds it so this will to
printf "SeqInc:
GENERAL MESSAGE (ICS 213)


1. Incident Name: Winlink Wednesday
2. To (Name and Position): Net Control
3. From (Name and Position): K1WTF, Net Participant
4. Subject: Winlink Wednesday Check-in
5. Date: ${date}
6. Time: ${time}
7. Message: 

K1WTF, Tyler, Broomfield, Broomfield, CO (HF)

8. Approved by: TK
   Position/Title: Net Participant

------------------------------------
Express Sending Station: K1WTF
Senders Express Version: Pat v0.13.1 (991d5e1)
Senders Template Version: ICS 213  v.41.12" | pat compose --from K1WTF --subject "213-Winlink Wednesday-Winlink Wednesday Check-In - ${date} ${time}" --attachment "${ics_form}" KN4LQN
rm "${ics_form}"
