#!/bin/bash
GWDIR="./gwlists"

pat rmslist -s -b 10m -m ARDOP | grep . |tail -n +2 > $GWDIR/10m.txt
pat rmslist -s -b 20m -m ARDOP | grep . |tail -n +2 > $GWDIR/20m.txt
pat rmslist -s -b 30m -m ARDOP | grep . |tail -n +2 > $GWDIR/30m.txt
pat rmslist -s -b 40m -m ARDOP | grep . |tail -n +2 > $GWDIR/40m.txt
pat rmslist -s -b 80m -m ARDOP | grep . |tail -n +2 > $GWDIR/80m.txt

pat rmslist -s -b 10m -m ARDOP |awk '{if ($4 > "200" && $4 < "250") print $0;}' |tail -n +2 > $GWDIR/10m-filtered.txt
pat rmslist -s -b 20m -m ARDOP |awk '{if ($4 > "200" && $4 < "250") print $0;}' |tail -n +2 > $GWDIR/20m-filtered.txt
pat rmslist -s -b 30m -m ARDOP |awk '{if ($4 > "200" && $4 < "250") print $0;}' |tail -n +2 > $GWDIR/30m-filtered.txt
pat rmslist -s -b 40m -m ARDOP |awk '{if ($4 > "200" && $4 < "250") print $0;}' |tail -n +2 > $GWDIR/40m-filtered.txt
pat rmslist -s -b 80m -m ARDOP |awk '{if ($4 > "200" && $4 < "250") print $0;}' |tail -n +2 > $GWDIR/80m-filtered.txt
exit 
pat rmslist -s -b 10m -m ARDOP |awk '{if ($4 > "20" && $4 < "30") print $0;}' |tail -n +2 >> $GWDIR/10m-filtered.txt
pat rmslist -s -b 20m -m ARDOP |awk '{if ($4 > "20" && $4 < "30") print $0;}' |tail -n +2 >> $GWDIR/20m-filtered.txt
pat rmslist -s -b 30m -m ARDOP |awk '{if ($4 > "20" && $4 < "30") print $0;}' |tail -n +2 >> $GWDIR/30m-filtered.txt
pat rmslist -s -b 40m -m ARDOP |awk '{if ($4 > "20" && $4 < "30") print $0;}' |tail -n +2 >> $GWDIR/40m-filtered.txt
pat rmslist -s -b 80m -m ARDOP |awk '{if ($4 > "20" && $4 < "30") print $0;}' |tail -n +2 >> $GWDIR/80m-filtered.txt
