cd ..
./pat-sender-vhf.sh y Riley "Waynesboro, Augusta, VA" riley@netandnix.net
sleep 10
pat connect ax25+agwpe:///KO4CTF-10
sleep 10
./pat-sender.sh y Riley "Waynesboro, Augutsa, VA" riley@netandnix.net
sleep 10
./pat-connect-hf.sh 40
sleep 10
./pat-connect-hf.sh 20
