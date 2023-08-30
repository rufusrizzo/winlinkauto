In pat-connect-hf.sh Change this, or it won't send"
pat_out=`ls -ltr /home/riley/.local/share/pat/mailbox/KF4EMZ/out/ | grep -v total | wc -l`

pat-sender.sh Usage
riley@gopi-old:~/git/winlinkauto $ ./pat-sender.sh y Riley "Waynesboro, VA" 
Message posted
riley@gopi-old:~/git/winlinkauto $ ./pat-sender.sh y Riley "Waynesboro, VA" riley@netandnix.net
Message posted
riley@gopi-old:~/git/winlinkauto $ ./pat-sender.sh y
Enter the name you wish to use: Riley
Location example: Waynesboro, VA
Enter the location you wish to use: Waynesboro, VA
Message posted
riley@gopi-old:~/git/winlinkauto $ ./pat-sender.sh n
Enter the Subject you wish to use: Test
Enter the message you wish to use: Test-msg
Message posted
riley@gopi-old:~/git/winlinkauto $ ./pat-sender.sh n Test Test-msg-2 riley@netandnix.net
Message posted
riley@gopi-old:~/git/winlinkauto $ ./pat-sender.sh y Riley "Waynesboro, VA"
Message posted
riley@gopi-old:~/git/winlinkauto $


Generate a staion list
pat-gen-stationlist.sh

pat connect is only using the filtered list, and I'm not with the filtering.
cp $GWDIR/20m.txt $GWDIR/20m-filtered.txt
cp $GWDIR/40m.txt $GWDIR/40m-filtered.txt

Set good GW call signs here, when it's running on a band, it will only pull good GWs from that band
riley@gopi-old:~/git/winlinkauto $ cat logs/good-gws.log
AJ4GU
AJ4FW
# Usage ./pat-connect-hf.sh <BAND> <Number of Retries> <RECV for Receive mode>

After all that, run  ./pat-connect-hf.sh 40


