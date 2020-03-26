#!/bin/sh

kill -9 `cat /var/run/haraka-inbound.pid` 
/bin/rm /var/run/haraka-inbound.pid 

