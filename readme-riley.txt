
Edit and run this file:
examples/hf-send-wl.sh

For P2p
./p2p-connect-wlw.sh RileyC "Waynesboro, VA"

It needs this file, but it should be included.
If you have Winlinkmessages  it in your PAT inbox, it will generate the file
riley@gopi-old:~/git/winlinkauto $ cat gwlists/p2p-msg.txt
   Primary      KN4LQN    3582       2000/500    David Elkins       Chesterfield, VA
   Alternate*   W4RJG     7111       500         Rory Griffin       Halifax, VA
   Alternate    KE4KEW    3565       2000/500    Martin Krupinski   Augusta, VA
   Alternate    KK4CSK    3576       2000/500    Jesse Bryant       Valdese, NC
   Alternate*   K0RVW     10143      2000/500    Ken van Wyk        Fairfax, VA




Set good GW call signs here, when it's running on a band, it will only pull good GWs from that band
riley@gopi-old:~/git/winlinkauto $ cat logs/good-gws.log
AJ4GU
AJ4FW
# Usage ./pat-connect-hf.sh <BAND> <Number of Retries> <RECV for Receive mode>

After all that, run  ./pat-connect-hf.sh 40


