#!/bin/sh

## adding 89 so that migration from qmailtoaster setup is easier.
groupadd -g 89 vmail 2>/dev/null
useradd -g vmail -u 89 -d /home/powermail vmail 2>/dev/null

touch /var/log/haraka-inbound.log
chown vmail:vmail /var/log/haraka-inbound.log
chmod 666 /var/log/haraka-inbound.log

mkdir /var/spool/haraka-inbound
chown vmail:vmail /var/spool/haraka-inbound

#https://github.com/mapbox/node-sqlite3/issues/972
npm config set user 0
npm config set unsafe-perm true

npm install -g Haraka
# Extra packages
npm install -g mailparser
npm install -g eslint
npm install -g haraka-plugin-outbound-rate-limit
npm install -g haraka-plugin-limit
npm install -g haraka-plugin-attachment

### you need maxmind License Key
npm install -g maxmind-geolite-mirror
mkdir -p /usr/local/share/GeoIP
echo "Downloading GeoIP database ..can take few minutes..please wait.."
/usr/bin/maxmind-geolite-mirror
###
## for Haraka UID in spam log
/bin/cp -pRv /usr/lib/node_modules/Haraka/contrib/Haraka.cf /etc/mail/spamassassin/
/bin/cp -pRv /usr/lib/node_modules/Haraka/contrib/Haraka.pm /etc/mail/spamassassin/



/etc/init.d/postfix stop
echo "make postfix local only as haraka check for port 25"
postconf -e 'inet_interfaces = loopback-only';
sed -i "s/smtp      inet  n       \-       y       \-       \-       smtpd/2525      inet  n       \-       y       \-       \-       smtpd/" /etc/postfix/master.cf

