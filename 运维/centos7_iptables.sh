禁用防火墙
systemctl mask firewalld
yum install iptables-services -y
systemctl enable iptables
cp /usr/libexec/iptables/iptables.init /etc/init.d/iptables

