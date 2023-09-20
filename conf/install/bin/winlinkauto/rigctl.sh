export LD_LIBRARY_PATH=/usr/local/lib/
echo "Starting at `date`" | tee -a /var/log/winlinkauto/rigctl.log
/usr/local/bin/rigctld  -m 1042 -v -r /dev/ttyUSB0 -s 38400
