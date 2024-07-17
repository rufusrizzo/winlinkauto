export LD_LIBRARY_PATH=/usr/local/lib/
echo "Starting at `date`" | tee -a /var/log/winlinkauto/rigctl.log
#This long id is unique to my Yaesu dx10
/usr/bin/rigctld  -m 1042 -v -r /dev/serial/by-id/usb-Silicon_Labs_CP2105_Dual_USB_to_UART_Bridge_Controller_00F8CDC9-if00-port0 -s 38400
