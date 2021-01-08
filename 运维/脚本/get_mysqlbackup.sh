#!/bin/bash
bindir=/usr/bin/
conf=/etc/my.cnf
basedir=${PWD}
bk_path=${basedir}/getdb
dt=`date +%Y%m%d%H%M%S`
dt2=`date +%Y%m%d`
user=root
password=gz_20140618^!*


[ -d $bk_path ] || mkdir -p $bk_path
if [ "Z$password" != "Z" ];then
  user_info="-u$user -p$password"
else
  user_info="-u$user"
fi
read -p "Please input date [example：20150813]: " date1
rm -rf $bk_path/$date1 &> /dev/null
mkdir -p $bk_path/$date1 &> /dev/null
sleep 1
$basedir/getftp.exp $bk_path $date1
dbs=`ls $bk_path/$date1`
for i in $dbs
do 
    gzip -d $bk_path/$date1/$i
    sleep 1
done
exit
