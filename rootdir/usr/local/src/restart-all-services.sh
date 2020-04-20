#!/bin/bash

/etc/init.d/rsyslog restart
/etc/init.d/redis-server restart
/etc/init.d/spamassassin restart
/etc/init.d/clamav-daemon restart
/etc/init.d/postfix restart
/opt/smtpstore/start.sh
/opt/haraka-inbound/stop-inbound.sh
/opt/haraka-inbound/start-inbound.sh


