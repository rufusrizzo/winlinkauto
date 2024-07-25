#!/bin/bash
GWDIR="./gwlists"

pat rmslist -s -b 2m | grep . |tail -n +2 > $GWDIR/2m.txt
pat rmslist -s -b 10m -m ARDOP | grep . |tail -n +2 > $GWDIR/10m.txt
pat rmslist -s -b 15m -m ARDOP | grep . |tail -n +2 > $GWDIR/15m.txt
pat rmslist -s -b 20m -m ARDOP | grep . |tail -n +2 > $GWDIR/20m.txt
pat rmslist -s -b 30m -m ARDOP | grep . |tail -n +2 > $GWDIR/30m.txt
pat rmslist -s -b 40m -m ARDOP | grep . |tail -n +2 > $GWDIR/40m.txt
pat rmslist -s -b 10m -m VARA | grep . |tail -n +2 | sed 's/VARA 500/VARA_500/g' | sed 's/VARA 2750/VARA_2750/g' > $GWDIR/v10m.txt
pat rmslist -s -b 15m -m VARA | grep . |tail -n +2 | sed 's/VARA 500/VARA_500/g' | sed 's/VARA 2750/VARA_2750/g' > $GWDIR/v15m.txt
pat rmslist -s -b 20m -m VARA | grep . |tail -n +2 | sed 's/VARA 500/VARA_500/g' | sed 's/VARA 2750/VARA_2750/g' > $GWDIR/v20.txt
pat rmslist -s -b 40m -m VARA | grep . |tail -n +2 | sed 's/VARA 500/VARA_500/g' | sed 's/VARA 2750/VARA_2750/g'> $GWDIR/v40m.txt
pat rmslist -s -b 80m -m VARA | grep . |tail -n +2 | sed 's/VARA 500/VARA_500/g' | sed 's/VARA 2750/VARA_2750/g'> $GWDIR/v80m.txt
pat rmslist -s -b 80m -m ARDOP | grep . |tail -n +2 > $GWDIR/80m.txt
