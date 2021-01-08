安装：pip install kazoo
from kazoo.client import KazooClient
import logging
logging.basicConfig(level=logging.INFO)
########################创建连接。
client= KazooClient(hosts='127.0.0.1:2181')
client.start()
#######################创建nodes
client.create('/test',value=b'123456') #目录存在则报错
client.ensure_path('/test') #目录存在不报错，但不能赋值
#########################数据操作：
client.get('/test') #取值反回元组，值和状态。
#状态
	#ctime 创建时间
	#mtime  修改时间
	#cversion 创建时的version
	#numChildren 子节点数
#判断是否存在存在返加状态值，不在返回空
client.exists('/test')
#返回当前目录下的子节点名子：
client.get_children('/test1') #返回列表。
############################设置值。
client.set('/test1',value=b'a12345')
##########################删除节点
client.delete('/test1/c2',recursive=True) #删除目录，recursive是否递归
###########################事务支持：
 ta=client.transaction() 
 ta.delete('/test1')  #删除目录
 ta.commit() #提交事务。\
	 #事务对应方法：
 	check()对应exists 
	create()对应create
	delete()对应delete
#######################################数据和目录监听变化。
from kazoo.client import KazooClient
from kazoo.recipe.watchers import DataWatch,ChildrenWatch
import logging
import threading
client = KazooClient(hosts='127.0.0.1:2181')
client.start()
client.set('/test1', value=b'12345')
def watch(data, stat, event):
    print(data)
    

dw = DataWatch(client, '/test1', func=watch) #监听节点数据有变化时调用watch函数,当watch反加一个False时结束监听
event = threading.Event()
try:
    event.wait()
except KeyboardInterrupt:
    event.set()
###############################################################监听目录子目录数有变化时执行
from kazoo.client import KazooClient
from kazoo.recipe.watchers import DataWatch,ChildrenWatch
import logging
import threading
client = KazooClient(hosts='127.0.0.1:2181')
client.start()

def watch_children(children):
    print(client.get_children('/test1'))
    print(children)

ChildrenWatch(client, '/test1', func=watch_children)

event = threading.Event()
try:
    event.wait()
except KeyboardInterrupt:
    event.set()
#############################################################################
