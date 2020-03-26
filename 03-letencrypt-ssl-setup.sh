#!/bin/sh


##certbot certonly -d `hostname` --standalone --agree-tos --email yourmail@example.com
#certbot certonly -d `hostname` --standalone --agree-tos --email postmaster@`hostname`

 systemctl stop cron

echo "MAILTO=\"\"" >> /var/spool/cron/crontabs/root 
echo "30 2 * * 1 /usr/local/src/cert-renew-and-restart.sh" >> /var/spool/cron/crontabs/root  
systemctl start cron

