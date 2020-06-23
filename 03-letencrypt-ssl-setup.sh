#!/bin/sh


##certbot certonly -d `hostname` --standalone --agree-tos --email yourmail@example.com
certbot certonly -d `hostname -f` --standalone --agree-tos --email postmaster@`hostname -f`

 systemctl stop cron

echo "MAILTO=\"\"" >> /var/spool/cron/crontabs/root 
echo "30 2 * * 1 /usr/local/src/cert-renew-and-restart.sh" >> /var/spool/cron/crontabs/root  
systemctl start cron

sed -i "s/powermail\.mydomainname\.com/`hostname -f`/" /etc/postfix/main.cf
sed -i "s/powermail\.mydomainname\.com/`hostname -f`/" /opt/haraka-inbound/config/tls.ini
sed -i "s/powermail\.mydomainname\.com/`hostname -f`/" /opt/haraka-inbound/config/host_list
sed -i "s/powermail\.mydomainname\.com/`hostname -f`/" /opt/haraka-inbound/config/me

