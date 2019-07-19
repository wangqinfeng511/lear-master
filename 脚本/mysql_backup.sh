#!/bin/bash
bindir=/usr/bin/
conf=/etc/my.cnf
bk_path=/home/jzadmin/backup/data_dump
dt=`date +%Y%m%d%H%M%S`
dt2=`date +%Y%m%d`
dt3=`date -d yesterday +%Y%m%d%H%M%S`
logdir=${PWD}/logs
logfile=${logdir}/mysqldumperr.log
mysqlcheck=`which mysqlcheck`
user=root
password=gz_20140618^!*


[ -d $bk_path ] || mkdir -p $bk_path &> /dev/null
[ -d $bk_path/logs ] || mkdir -p $bk_path/logs
[ -d $logdir ] || mkdir -p $logdir &> /dev/null
[ -f $logfile ] || touch $logfile &> /dev/null
[ -f /tmp/mysqldumperr.log ] || touch /tmp/mysqldumperr.log  &> /dev/null
[ -f /tmp/mysqlcheck.log ] || touch /tmp/mysqlcheck.log  &> /dev/null
if [ -s /tmp/mysqldumperr.log ];then
   echo -e "${dt3}: \c" >> ${logfile}
   cat /tmp/mysqldumperr.log >> ${logfile}
   cat /dev/null > /tmp/mysqldumperr.log
fi
if [ "Z$password" != "Z" ];then
  user_info="-u$user -p$password"
else
  user_info="-u$user"
fi
   find $bk_path/* -mtime +30 |xargs rm -rf {}\;
   dbs=`mysql $user_info -e "show databases;"`
   for db in $dbs
   do
       if [ $db != "Database" ] && [ $db != "information_schema" ] && [ $db != "test" ] && [ $db != "mysql" ]
       then
          $mysqlcheck $user_info -c  $db > /tmp/mysqlcheck.log    
          egrep -i -w "(error|warning)" /tmp/mysqlcheck.log >> /tmp/mysqldumperr.log
          [ $? -eq 0 ] && echo "------ ${db} ------"
          $bindir/mysqldump --force  $user_info --log-error=/tmp/mysqldumperr.log --database $db |gzip > $bk_path/$db.$dt.sql.gz
           sleep 1
          /home/jzadmin/scripts/ftp.exp $db.$dt.sql.gz $dt2
       fi
   done

exit
