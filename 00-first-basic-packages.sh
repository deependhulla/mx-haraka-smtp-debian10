#!/bin/bash

## sample
###HOSTNAME=pvedesktop.domainname.com
###IPADDR=192.168.1.1


HOSTNAME=mx2.technomail.in
IPADDR=139.59.64.239

hostname $HOSTNAME
echo "$IPADDR   $HOSTNAME" >> /etc/hosts
echo $HOSTNAME > /etc/hostname



## backup existing repo by copy
/bin/cp -pR /etc/apt/sources.list /usr/local/old-sources.list-`date +%s`
echo "" >  /etc/apt/sources.list
echo "deb http://httpredir.debian.org/debian buster main contrib non-free" >> /etc/apt/sources.list
echo "deb http://httpredir.debian.org/debian buster-updates main contrib non-free" >> /etc/apt/sources.list
echo "deb http://security.debian.org/ buster/updates main contrib non-free" >> /etc/apt/sources.list

apt-get update


CFG_HOSTNAME_FQDN=`hostname`
echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
echo "postfix postfix/mailname string $CFG_HOSTNAME_FQDN" | debconf-set-selections

#### remove exim by installing postfix before upgrade used for proxmox
apt-get -y install postfix 

#build rc.local as it not there by default in debian 9.x and 10.x
/bin/cp -pR /etc/rc.local /usr/local/old-rc.local-`date +%s` 2>/dev/null
touch /etc/rc.local 
printf '%s\n' '#!/bin/bash'  | tee -a /etc/rc.local
echo "sysctl -w net.ipv6.conf.all.disable_ipv6=1" >>/etc/rc.local
echo "sysctl -w net.ipv6.conf.default.disable_ipv6=1" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
chmod 755 /etc/rc.local
## need like autoexe bat on startup
echo "[Unit]" > /etc/systemd/system/rc-local.service
echo " Description=/etc/rc.local Compatibility" >> /etc/systemd/system/rc-local.service
echo " ConditionPathExists=/etc/rc.local" >> /etc/systemd/system/rc-local.service
echo "" >> /etc/systemd/system/rc-local.service
echo "[Service]" >> /etc/systemd/system/rc-local.service
echo " Type=forking" >> /etc/systemd/system/rc-local.service
echo " ExecStart=/etc/rc.local start" >> /etc/systemd/system/rc-local.service
echo " TimeoutSec=0" >> /etc/systemd/system/rc-local.service
echo " StandardOutput=tty" >> /etc/systemd/system/rc-local.service
echo " RemainAfterExit=yes" >> /etc/systemd/system/rc-local.service
echo " SysVStartPriority=99" >> /etc/systemd/system/rc-local.service
echo "" >> /etc/systemd/system/rc-local.service
echo "[Install]" >> /etc/systemd/system/rc-local.service
echo " WantedBy=multi-user.target" >> /etc/systemd/system/rc-local.service

systemctl enable rc-local
systemctl start rc-local

mkdir /root/.ssh 
echo "Host * " > /root/.ssh/config
echo "    ServerAliveInterval 300" >> /root/.ssh/config
echo "    ServerAliveCountMax 20" >> /root/.ssh/config

apt-get -y install pwgen ca-certificates gnupg2 wget unzip zip xfsprogs openssh-server git telnet unrar 
apt-get -y install vim iptraf screen mc net-tools sshfs iputils-ping psmisc apt-transport-https rar multitail
apt-get -y install xz-utils curl elinks ntfs-3g bridge-utils debconf-utils build-essential postfwd postfix-pcre
apt-get -y install p7zip-rar arj binutils lhasa liblz4-tool lrzip lzip ncompress unar zstd sendemail rsync
apt-get -y install spamassassin clamav-daemon clamav-freshclam rspamd redis-server dnsutils cerbot
apt-get -y install traceroute iputils-tracepath

#Disable vim automatic visual mode using mouse, useful for copy from vi edit mode
echo "\"set mouse=a/g\"" > ~/.vimrc
echo "syntax on" >> ~/.vimrc

## ssh Keep Alive
mkdir /root/.ssh 2>/dev/null
echo "Host * " > /root/.ssh/config
echo "    ServerAliveInterval 300" >> /root/.ssh/config
echo "    ServerAliveCountMax 20" >> /root/.ssh/config

##  To have features like CentOS for Bash
echo "" >> /etc/bash.bashrc
echo "alias cp='cp -i'" >> /etc/bash.bashrc
echo "alias l.='ls -d .* --color=auto'" >> /etc/bash.bashrc
echo "alias ll='ls -l --color=auto'" >> /etc/bash.bashrc
echo "alias ls='ls --color=auto'" >> /etc/bash.bashrc
echo "alias mv='mv -i'" >> /etc/bash.bashrc
echo "alias rm='rm -i'" >> /etc/bash.bashrc


