#!/bin/bash -eux
sudo -i
iptables -F
systemctl stop chronyd
yum remove -y chrony
yum install -y ntp
systemctl start ntpd
systemctl enable ntpd
cat << EOFF > /etc/ntp.conf
server 66.129.233.81 iburst maxpoll 9
driftfile /var/lib/ntp/drift
EOFF
systemctl restart ntpd
sleep 5
systemctl restart ntpd
yum install -y net-tools
yum install -y tcpdump
