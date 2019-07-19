vim /etc/chrony.conf
server 192.168.1.102 iburst
allow 192.168.1.0/24
#systemctl start chronyd
systemctl enable chronyd
##
chronyc sources
