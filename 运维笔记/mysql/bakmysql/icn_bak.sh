#!/bin/bash
	bak_data="/home/tmp"
	if [ -d $bak_data ];then
		rm -rf $bak_data
	fi
	mkdir $bak_data
	max_line=`cat /root/.mysql_bak|sed -n '='|sort -rn|sed -n '1p'`
	bak_name=`sed -n "${max_line}p" /root/.mysql_bak`
	echo $bak_name
	innobackupex --user=root --host=localhost --password=fengzi  --incremental $bak_data --incremental-basedir=/home/database_bak/$bak_name
	ls /home/tmp >>/root/.mysql_bak
	mv  $bak_data/2* /home/database_bak/
