#!/bin/sh

## kill -1 for SIGHUP for flush of queue of Haraka
kill -1 `cat /var/run/haraka-inbound.pid` 

