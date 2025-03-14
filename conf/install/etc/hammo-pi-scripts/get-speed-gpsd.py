#! /usr/bin/env python3
"""
example  Python gpsd client
run this way: python3 example1.py.txt
"""

import gps               # the gpsd interface module

session = gps.gps(mode=gps.WATCH_ENABLE)

try:
    while 0 == session.read():
        if not (gps.MODE_SET & session.valid):
            # not useful, probably not a TPV message
            continue


        if (gps.isfinite(session.fix.speed)):
            print(int(session.fix.speed))
            exit(0)

        else:
            print("0")

except KeyboardInterrupt:
    # got a ^C.  Say bye, bye
    print('')

# Got ^C, or fell out of the loop.  Cleanup, and leave.
session.close()
exit(0)
