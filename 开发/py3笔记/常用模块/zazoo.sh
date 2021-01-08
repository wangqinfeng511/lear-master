下载路径：
http://mirror.bit.edu.cn/apache/zookeeper/zookeeper-3.4.8/
解压
复制conf目录下的zoo_sample.cfg,并命名为zoo.cfg
配置：
dataDir=/datatmp/zookeeper/data
dataLogDir=/datatmp/zookeeper/logs
tickTime=2000
initLimit=10 #心跳间隔超时
syncLimit=5  #心跳相应超时
clientPort=2181 #端口
#
server.0=127.0.0.1:8880:7770
启动：./bin/zkServer.sh start
查看节点状态：jps

#####################################################################
client:
bin/zkCli.sh -server localhost:2181 #连接到服务器

create /zk "myData" #创建节点，值是myData
get /zk 	#返回装态和值。
ls /	列出节点目录。
set /zk "abck" #设置值
delete /zk  #删除节点

############################python####################
from kazoo.client import KazooClient
from kazoo.recipe.watchers import DataWatch, ChildrenWatch
import logging
logging.basicConfig(level=logging.INFO)
client = KazooClient(hosts='127.0.0.1:2181')
client.start()

client.create('/test', value=b'abcd')
#创建目录并赋值。如果存在就报错
client.ensure_path('/test1/c2')
#创建目录，但不能赋值。
#read###################################################
client.get('/test')
#目录取值。返回值为元组值和状态信息。
client.exists('/test2')
#判断是否存在
client.get_children('/test1')
#返回目录下的所有子目录。
#write##################################################
client.set('/test', value=b'123445')
#对目录设置。
#delete#################################################
client.delete('/test1')
#删除目录节点
########################################################
#transaction事务
tx = client.transaction()
#创建事务
#tx.create()
#tx.delete()
tx.commit() 
#最后提交事务
#####################################################

def watch (data, state, event):
    print(data)
def watcha(**kwargs):
    print(kwargs)
dw = DataWatch(client, '/test', func=watch)
#监听一个节点下的数据变化。
ChildrenWatch(client, '/test1', func=watcha)
#监听一个节点下的变化时执行，子节点的增删改
