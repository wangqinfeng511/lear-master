#!/bin/bash
yum install ntpdate expect ftp vim openssh-clients -y
/usr/sbin/ntpdate asia.pool.ntp.org && clock -w &> /dev/null
echo "   *               soft nofile 30720
   *               hard nofile 30720" >> /etc/security/limits.conf
mkdir /home/jzadmin/software -p
mkdir /home/jzadmin/mysqldata/
mkdir /home/jzadmin/backup/data_dump/logs/ -p
touch /home/jzadmin/backup/data_dump/logs/mysqlbackup.log
echo "fs.file-max = 30720
net.ipv4.tcp_rmem = 4096    524288  2740224
net.ipv4.tcp_wmem = 4096    524288  2740224
net.core.rmem_max = 1048576
net.core.wmem_max = 1048576
net.core.wmem_default = 524288
net.core.rmem_default = 524288" >> /etc/sysctl.conf
/sbin/sysctl -p
sed -i "s/^alias/#alias/g" /root/.bashrc
