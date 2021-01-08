influxdb数据库：
安装模块：pip install influxdb
from influxdb import client as influxdb 
db = influxdb.InfluxDBClient(host, port, username, password, database)
db.query #读数据库。
####################################################################
#HTTP——API
requests.post('http://127.0.0.1:8086/write',data=kv值,params=('db'):'mage')

requests.post('http://127.0.0.1:8086/write', data='192.168.1.1,region=us-west value=0.13 ', params={'db':'mydb'})
			influxdb http/写  , 传入的数据=tag,	key=value 	例：
 r=requests.post('http://127.0.0.1:8086/write',data='mem,memfree=1 memtotal={a},cached={b},memfree={c},memavailable={d}'
    ''.format(
        a=part_dick['memtotal'],b=part_dick['cached'],c=part_dick['memfree'],d=part_dick['memavailable']
        ),params={'db':'ceshi'})	

###################################################################################################
一、influxdb:与传统数据库作对比：	与时间作索引。
influxdb 	传统数据库存
database	 数据库
measurement	数据库中的表。
points		表里面的一行数据。
二、influxdb中独有的概念：
point属性：	传统数据库中的概念
time		主键索引。
fields		各种记录。
tags		各种索引的属性。
series		表示这个表里的数据，可以在图表上画成K线，通过tags
查看表里的数据：
select * from "measurement" #返回时间，tags ,字段。
select * from 表 order by time desc limit 3 #返回3秒的数据。
show series from "measurement" #返回字段和值。
show measurements #返回所有的表。
drop measurement 表名 #删除表。
增：
use testDB #切入库。
insert 表名，tag=1 字段=值，字段=值。#如果表不存在自动创建。
#######################################################################################################
三、数据库保存策略（Retention Policjes）#用于指定数据保存时间。
查看当前数据库的保存策略：
show RETENTION POLICIES ON "数据库"  
创建新的保存策略：
create retention policy "rp_name" on "db_name" duration 30d replication 1 default
rp_name:策略名。
db_name:数据库名。
30d	:保存30天
replication 1 :副本数保存
default:	设为默认策略。
修改保存策略：
alter retention policies "rp_name" on "db_name" duration 3w default
删除保存策略：
drop retention policy "rp_name"
grafana 前端展示。

