#!/bin/sh

## if apache2 is there
/etc/init.d/apache2 stop 2>/dev/null
/usr/bin/certbot renew

## for webmin if there
#cat /etc/letsencrypt/live/powermail.mydomainname.com/fullchain.pem > /etc/webmin/miniserv.pem 
#cat /etc/letsencrypt/live/powermail.mydomainname.com/privkey.pem >> /etc/webmin/miniserv.pem 

/etc/init.d/apache2 start 2>/dev/null

/opt/haraka-inbound/stop-inbound.sh
/etc/init.d/postfix restart
/opt/haraka-inbound/start-inbound.sh

echo "All Done."
echo ""

