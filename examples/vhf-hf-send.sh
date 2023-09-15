cd ..
./pat-sender.sh n "Test_VHF" "Testing sending VHF" riley@netandnix.net
sleep 10
pat connect ax25+agwpe:///KO4CTF-10
sleep 10
./pat-sender.sh n "Test_HF" "Testing sending HF" riley@netandnix.net
sleep 10
./pat-connect-hf.sh 40
