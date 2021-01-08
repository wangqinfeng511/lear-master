#echo 'begin'

tablesname="`mysql -ujianqu -pletmego -h1.4.35.170 -P1025 -e "use JianQuStest;show tables;" | grep -v logs | grep -v Tables_in`"

#echo ${tablesname}

mysqldump -ujianqu -pletmego -h1.4.35.170 -P1025 JianQuStest `echo ${tablesname}` |gzip > /tmp/DBTest.sql.gz 

#echo 'end'
