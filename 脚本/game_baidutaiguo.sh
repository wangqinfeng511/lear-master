#!/bin/bash
yum install ntpdate lrzsz gdb gcc openssh-clients expect unzip rsync vim man sysstat -y
/usr/sbin/ntpdate asia.pool.ntp.org && clock -w &> /dev/null
yum install glibc-2.12-1.132.el6_5.4.i686 -y
yum install libgcc-4.4.7-4.el6.i686 -y
yum install glibc-2.12-1.149.el6.i686 -y
yum install libgcc-4.4.7-11.el6.i686 -y
sed -i 's/net.ipv4.tcp_syncookies = 1/net.ipv4.tcp_syncookies = 0/g' /etc/sysctl.conf 
echo "fs.file-max=30720
net.ipv4.tcp_wmem = 4096    65536   4194304
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_rmem = 4096    65536   4194304" >> /etc/sysctl.conf
/sbin/sysctl -p
echo "   *               soft nofile 30720
   *               hard nofile 30720" >> /etc/security/limits.conf 
mkdir /home/jzadmin/game -p
mkdir /home/jzadmin/gamebao
mkdir /home/jzadmin/software
sed -i "s/^alias/#alias/g" /root/.bashrc
