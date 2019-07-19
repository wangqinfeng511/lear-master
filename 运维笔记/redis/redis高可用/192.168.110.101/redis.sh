#!/bin/bash
case $1 in
 master)
	/bin/cp -rf /etc/keepalived/redis_master.conf  /etc/redis.conf
	service redis restart
	;;
 backup)
	/bin/cp -rf /etc/keepalived/redis_back.conf /etc/redis.conf
	service redis restart
	;;
 *)
	echo "$1"
	;;
esac
