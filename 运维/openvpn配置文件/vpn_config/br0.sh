#!/bin/bash
brctl addif br0 eth0
sleep 5
PID="/var/run/openvpn/server.pid"
if [ -f $PID ];then
ifconfig tap0 up
brctl addif br0 tap0
service network restart
fi
