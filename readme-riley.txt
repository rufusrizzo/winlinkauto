In pat-connect-hf.sh Change this, or it won't send"
pat_out=`ls -ltr /home/riley/.local/share/pat/mailbox/KF4EMZ/out/ | grep -v total | wc -l`

Of course update this with your call sign
pat-sender.sh


pat connect is only using the filtered list, and I'm not done.
cp $GWDIR/20m.txt $GWDIR/20m-filtered.txt
cp $GWDIR/40m.txt $GWDIR/40m-filtered.txt

Set good GW call signs here, when it's running on a band, it will only pull good GWs from that band
riley@gopi-old:~/git/winlinkauto $ cat logs/good-gws.log
AJ4GU
AJ4FW

After all that, run  ./pat-connect-hf.sh 40


