#!/bin/bash
	bak_data="/home/tmp"
	if [ -d $bak_data ];then
		rm -rf $bak_data
	fi
	mkdir $bak_data
	innobackupex --user=root --host=localhost --password=fengzi $bak_data
	ls /home/tmp >/root/.mysql_bak
	if [ ! -d /home/database_bak ];then
		mkdir /home/database_bak
	fi
	mv  $bak_data/2* /home/database_bak/
