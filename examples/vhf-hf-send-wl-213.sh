cd ..
./pat-sender-ics213-rec-vhf.sh
sleep 10
pat connect ax25+agwpe:///KO4CTF-10
sleep 10
./pat-sender-ics213-rec.sh
sleep 10
./pat-connect-hf.sh 40
sleep 10
       echo "F 14108000" | nc -w 1 localhost 4532
       sleep 1
       echo "G TUNE" | nc -w 1 localhost 4532
       sleep 15

./pat-connect-hf.sh 20
