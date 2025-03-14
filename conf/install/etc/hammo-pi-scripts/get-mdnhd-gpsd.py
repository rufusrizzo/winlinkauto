#! /usr/bin/env python3
"""
example  Python gpsd client
run this way: python3 example1.py.txt
"""

import gps               # the gpsd interface module
import maidenhead as mh

session = gps.gps(mode=gps.WATCH_ENABLE)

try:
    while 0 == session.read():
        if not (gps.MODE_SET & session.valid):
            # not useful, probably not a TPV message
            continue


        if ((gps.isfinite(session.fix.latitude) and
             gps.isfinite(session.fix.longitude))):
            mdnhd=(mh.to_maiden(session.fix.latitude, session.fix.longitude))
            print(mdnhd)
            exit(0)

        else:
            print(" Lat n/a Lon n/a")

except KeyboardInterrupt:
    # got a ^C.  Say bye, bye
    print('')

# Got ^C, or fell out of the loop.  Cleanup, and leave.
session.close()
exit(0)
