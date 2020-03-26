#!/bin/sh

kill -9 `cat /var/run/haraka-inbound.pid 2>/dev/null` 2>/dev/null 1>/dev/null 
/bin/rm /var/run/haraka-inbound.pid 2>/dev/null 

echo " Haraka Stopped  "

