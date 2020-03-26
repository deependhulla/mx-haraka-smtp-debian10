#!/bin/sh

cd /usr/local/src/ti-spam-filter
perl makecf-ti-spam-header.pl
perl makecf-ti-spam-body.pl
echo running spamassassin lint
spamassassin --lint
/etc/init.d/spamassassin reload
cd -
