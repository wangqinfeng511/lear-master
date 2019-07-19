#!/bin/bash
 day=`/bin/date +%u`
 Tday=`/bin/date +%U`
echo $day
case $day in
	1)
		/bin/bash /home/bakmysql/all_bak.sh;;
		
	7) 
		if [ -d /home/database_bak ];then
	                 /bin/bash /home/bakmysql/icn_bak.sh
                  else
                   /bin/bash /home/bakmysql/all_bak.sh
                fi

		mkdir /home/database_bak/$Tday 
		mv /root/.mysql_bak /home/database_bak/$Tday/
		mv /home/database_bak/201* /home/database_bak/$Tday/ ;;
	*)
         	if [ -d /home/database_bak ];then	
		 /bin/bash /home/bakmysql/icn_bak.sh
		 else
                 /bin/bash /home/bakmysql/all_bak.sh
		 fi ;;
	
	esac

		
		
