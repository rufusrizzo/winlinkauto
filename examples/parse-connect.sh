LOGFILE=$1
OUTBOXNUM=$2
PAT_MAILBOX_PATH=`pat env  | grep MAILBOX | awk -F"=" '{print $2}' | sed 's!"!!g'`
PAT_MYCALL=`pat env  | grep MYCALL | awk -F"=" '{print $2}' | sed 's!"!!g'`
CONNDATE=`grep "Connected" $LOGFILE | awk '{print $1}'`
CONNTIME=`grep "Connected" $LOGFILE | awk '{print $2}'`
CONNGW=`grep "Connected" $LOGFILE | awk '{print $5}'`
CONNPROTO=`grep "Connected" $LOGFILE | awk -F"\(|\)" '{print $2}'`
COONNGWLOC=`grep "daily minutes" $LOGFILE | awk -F"\(|\)" '{print $2}'`
CONNXMIT=`grep "Transmitting" $LOGFILE | wc -l`
CONNRCVD=`grep "Receiving" $LOGFILE | wc -l`
CONNXMITALL=`grep -A 1 "Transmitting" $LOGFILE | grep -v "Transmitting" | grep 100 | wc -l`
CONNRCVDALL=`grep -A 1 "Receiving" $LOGFILE | grep -v "Receiving" | grep 100 | wc -l`
ECONNDATE=`grep "QSX" $LOGFILE | awk '{print $1}'`
ECONNTIME=`grep "QSX" $LOGFILE | awk '{print $2}'`
ENDOUTBOXNUM=`ls -ltr ${PAT_MAILBOX_PATH}/${PAT_MYCALL}/out | grep -v total | wc -l`
echo "$CONNDATE|$CONNTIME|$CONNPROTO|$CONNGW|$COONNGWLOC|$CONNXMIT|$CONNXMITALL|$CONNRCVD|$CONNRCVDALL|$ECONNDATE|$ECONNTIME|$ENDOUTBOXNUM"
