#!/bin/bash
#欢迎使用虚拟机创建脚本：——————王钦丰 QQ：360065954 电话：18201558276 emil: wangqinfeng511@163.com
	XML="./linux.xml"
	CONF="./conf"
	create() {
		 [[ -f $XML ]] || echo "linux.xml no file !"
	  	[[ -f $CONF ]] || echo "not file conf!"
		}
	config() {
		SERVER_NAME=`cat $CONF |grep server_name|awk '{print $2}'`
		SERVER_IP=`cat ./conf |grep IPADDR |awk '{print $2}'`
		DISK_NUMBER=`cat ./conf |grep disk_number |awk '{print $2}'`
		UUID_IP_END=`echo $SERVER_IP|sed 's/192.168.//'|sed 's/\.//'`
		 IP_a=`expr substr "$UUID_IP_END" 1 1`
		 IP_b=`expr substr "$UUID_IP_END" 2 1`
		 IP_c=`expr substr "$UUID_IP_END" 3 1`
		 IP_d=`expr substr "$UUID_IP_END" 4 1`
		 IP_e=`expr substr "$UUID_IP_END" 5 1`
		MAC=`echo 0$IP_a:$IP_b$IP_c:$IP_d$IP_e`
		IP_END_END=$IP_c$IP_d$IP_e
		let "VNC=$IP_END_END+5900"
		DISK_DIR=$SERVER_NAME$UUID_IP_END
	
	}
	create_server_xml() {
		config
		rm ./linux.xml.1
		cp -rf ./linux.xml ./linux.xml.1
		#替找servername
		sed  -i "s/<name>zabbix<\/name>/<name>$SERVER_NAME<\/name>/g" ./linux.xml.1
		#替换uuid
		sed  -i "s/<uuid>6b0b19ba-9afe-7e32-8fe0-d5e8dee99143/<uuid>6b0b19ba-9afe-7e32-8fe0-d5e8dee$UUID_IP_END/g" ./linux.xml.1
		#替换MAC——基于IP
		sed  -i "s/<mac address='52:54:00:09:91:43'/<mac address='52:54:00:$MAC'/g" ./linux.xml.1
		#替找vnc端口号
		sed  -i "s/port='5903'/port='$VNC'/g" ./linux.xml.1
		#镜像文件路径替换
		sed  -i "s/\/mirror\/zabbix_99_143\/servier.img'/\/mirror\/$DISK_DIR\/centos7.img'/g" ./linux.xml.1
		if [ $DISK_NUMBER -eq 2 ];then
		 sed  -i "s/\/mirror\/zabbix_99_143\/mydisk.img'/\/mirror\/$DISK_DIR\/mydisk.img'/g" ./linux.xml.1

		fi	
		}
		create_server_xml
		echo $DISK_DIR
		if [ -d /mirror/$DISK_DIR ];then
			if [ -f /mirror/$DISK_DIR/servier.img ];then
			echo "目录内有servicer.img文件"
				if [ $DISK_NUMBER -eq 2 ];then
					if [ -f /mirror/$DISK_DIR/mydisk.img ];then
					echo "mydisk.img存在"	
					else
					cp /home/img/mydisk.img /mirror/$DISK_DIR
					fi

				fi
			fi
		else
			mkdir -p  /mirror/$DISK_DIR
			cp /home/img/centos7.img /mirror/$DISK_DIR
			if [ $DISK_NUMBER -eq 2 ];then
				cp /home/img/mydisk.img /mirror/$DISK_DIR
			fi
		fi
			mv 	/mirror/create_bash/linux.xml.1 /etc/libvirt/qemu/$SERVER_NAME.xml
		service libvirtd restart
