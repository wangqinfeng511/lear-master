防火墙：
 查看默认区域：
firewall-cmd --get-default-zone
查看所有的区域：
firewall-cmd --get-zones
更改默认区域：
firewall-cmd --set--default-zone=public
查看服务：
firewall-cmd --get-services
默认服务的配置文件XML
/use/lib/firewalld/services
放行指定服务：
firewall-cmd --add-service=http
删除服务放行：
firewall-cmd --remove-service=http
重载：
firewall-cmd --reload
放行端口：
firewall-cmd --add-port=3000/tcp
删除：
firewall-cmd --remove-port=3000/tcp
查看放行的端口：
firewall-cmd --list-port
icmp协议响应:
firewall-cmd --add-icmp-block=echo-reply
icmp删除协议响应：
firewall-cmd --remove-icmp-block=echo-reply
查看icmp协议支持的响应：
firewall-cmd --list-icmp-blocks
