redis 
存储方式KV键值：
		工作于内存中
		通过rdb|aof方式同步于磁盘中，实现复用。
单线程缓存服务
支持主从（借助于sentine实现HA）
	支持的数据缓存类型：
		string list hash set sortedset 
nosql:
	kv nosql:redes
	column family nosql (列式nosql):hbase
	documentation nosql (文档nosql):mongodb
	graph nosql(图形nosql)	:neo4j
################################################################################redis组件：
	redis-server :服务
	redis-cli	:客户端
	redis-benchmark	:压测工具
	redis-check-dump&redis-check-aof :同步磁盘的工具
安装：
	下载 pkgs.org 搜redis
	http://rpms.famillecollet.com/enterprise/6/remi/x86_64/redis-3.2.0-1.el6.remi.x86_64.rpm
	yum localinstall redis*.rpm
################################################################################配置文件：/etc/redis.conf
daemonize no #是否工作于后台
pidfile /var/run/redis.pid #pid文件路径
loglevel notice		   #日志级别
logfile /var/log/redis/redis.log #日志路径
databases 16		#数据库个数
port 6379		#端口号
tcp-backlog	511	#等待队列的长度
bind 192.168.99.143 127.0.0.1 #监听的地址
unixsocket /tmp/redis.sock	#socket套接字路径。用于本机通信。
unixsocketperm 700		#socket的权限。
timeout 0		#连接超时时长，0表示不超时。
tcp-keepalive 0		#tcp的持久连接。
##############################SNAPSHOTTING################################
save 900 1	#900秒内有一个键发生改变，就进行一次快照。
save 300 10	#300秒内有10个键发生改变，就进行一次快照。
save 60 10000	#60秒内有10000个键发生改变，就进行一次快照。
	save " " 表示不进行快照。
#######################################
#######################################
service redis start
#######################################
客户端：redis-cli
	-h 指定连接的服务器id
	select 0 指定切换的数据库。
	获取帮助
		help @string| 命令
@string常用命令。
	set get exists
	列：set k1 abcdefg	#创建kv
		ki=key
		abcdefg=value
	    get k1		#获取k1的值。
	    append k1  efacecd	#为k1追加值。
	    strlen k1		#获取字符串长度。
	    INCR   kint		#值自增加1 (要求kint的值为整数)
	    DECR   kint		#值自减1 （要求kint的值为整数）
	    setex key		#为现有key设置过期秒数。
	    set  k1 fengzi nx 	#nx表示是否存在，存在则不创建。
	    set k1 fengzi  xx	#xx表示是否存在，不存在则创建。
@list 列表常用命令：
	lpush|rpush:创建一个列表。
		lpush l1 a b c d df s d #创建一个key为l1的列表。
		lindex l1 0		#输出l1列表的第0个值。
		lpush	s 		#从左边追加一个值
		rpush	b		#从右边追加一个值。
		lset 	l1 1 c		#修改l1列表的第一个值为c.
		rpop	l1		#右边弹出
		lpop	l1		#左边弹出
@sets	无序集合
		sadd w1 mod tue wed thu #创建一个key为w1的无序集合
		sadd w2 tue thu day	#创建一个key为w2的无序集合。
	 求交集：
	 	sinter w1 w2 		#输出俩集合内都有的字符。
	求并集：
		sunion w1 w2		#输出俩集合的所有值并去重。
	弹出：	spop			#随机弹出一个元素。
	查看元素是否在集合中：	sismember w1 tue
@sorted_set 有序集合。
	创建：	zadd w1 1 mon 2 tue 3 wed 4 ore 5 foo	
			w1:为key
			1-5：score 
			mon tue...:为元素
	获取元素个数：zcard wa
	查看元素对应索引号：zrank wa ore
	以元素获取score号：zscore wa foo
	返回有序集合内的元素：zrange wa 0 3
@hashes	kv集合
	创建 hset h1 a mom
		创建一个key为h1, k为a  v为mon的hash kv 对。
		获取映射表的值： hget h1 a
		补充新值：	hset h1 b foo
		获取key的k:	hkeys h1
		不存在创建：	hsetnx h1 a vor 
		获取key的个数：	hlen h1
###########################################################################
连接认证：
	requirepass fengzi	#启用字符串密码认证。
清空数据库：
	>flushdb 清空当前数据库。
	>flushall 清空所有库。
##########################################################################
redis事务：
	一组相关操作是关系性，要么全部执行，要么全部不执行。
	redis事务不支持回滚操作。
	在事务未提交时，会阻塞。
通过multi exec watch命令实现事务功能。
列子：
	>multi 开始事务。
	>set ip 192.168.1.1
	>get ip			#未执行exec之前的列队
	>set port 8080
	>get port
	exec 一并执行并返回。
watch 乐观锁.监视一个或多个key的值是否在执行事务，未提交之前发生变化。如变化则提交失败。
列：  watch ip 
	multi 
	set ip 192.168.1.1
	get ip
	set port 8080
	get port 8080
	exec
##########################################################################
连接相关的命令：
	auth 认证
	ping 测试服务器是否打开。
	echo 输出字符串。
	quit 退出
	select 切换数据库。
@server服务端。
	client setname #设定当前连接名。
	client getname #获取客户端连接名。
	client kill 	ip:port #关闭客户端
	info	#服务器信息。
	config resetstat #重置info值
	config rewrite  #内存中的配置写入磁盘配置文件。
	dbsize	#数据库内所有键的数量
	bgsave
	lastsave #取得最后一次同步磁盘的时间戳。
	monitor	#实时监控。
############################################################################
发布订阅：
	频道：消息队列
	subscribe 订阅一个或多个队列
		 列：subscribe new
	publish new hello #向new订阅发hello消息。
	unsubscribe	#退订指定频道
###########################################################################
持久化：
	rdb和aof 存储机制：
		rdb:二进制格式（快照机制）
		  命令：save 快照保持机制，会阻塞。
		  	bgsave 异步，不阻塞后台运行！
		aof: 以命令记录方式记录（每次写操作追加尾部）
			bgrewriteaof #aof重写命令
		aof:重写流程：
			(1)redis主进程通过fork创建子进程。
			(2)子进程redis内存中的数据创建数据库重建命令序列于临时文件中。
			(3)父进程继承client的请求，并会把这些请求中的写操作，继续追加至原AOF文件，额外的，这此写请求还会被放置于一个缓冲队列中。
			(4)子进程重写完成，会通知父进程，父进程把缓冲中的命令写到临时文件中。
			(5)父进程用于临时文件替换老的AOF文件中。
rdb相关的配置：
	save 900 1
	save 300 10
	save 60 10000
	
	stop-writes-on-bgsave-error yes #在备份中发生错误是否停止备份。
	rdbcompression yes		#是否备份压缩。
	rdbchecksum yes			#是否对rdb文件进行效验。
	dbfilename dump.rdb		#rdb备份的文件名。
	dir /var/lib/redis/		#rdb备份文件的存储路
AOF相关配置：
	appendonly no	#是否打开AOF功能。
	appendfilename "appendonly.aof" #AOF文件的名字。
	appendfsync 
			always #每次写操作都要向内核发起磁盘写系统调用。
			everysec #每秒向内核发起磁盘写系统调用。
			no	#从不要求内核什么时候执行写操作。
		always数据最安全，no会丢失文件（下次重启不全，因为没及时写入。）		everysec #比较中了，每秒写一交。

	no-appendfsync-on-rewrite no #指定是否在后台aof文件重写期间调用fsync同步磁盘。
	auto-aof-rewrite-percentage 100 #如果AOF文件是上重写时的两备，则进行AOF重写。100为增长率。
	auto-aof-rewrite-min-size 64mb #AOF文件最少要大于64mb才执行重写。
##################################################################################
持久本身不可取代备份，还应制定备份策略。
	RDB与AOF同时启用：
		（1），BGSAVE和BGREWRITEAOF不会同时执行，redis内部有调度方案。
		（2）、rieds启动用于恢复至内存时，会优先使用AOF文件。
##################################################################################
RIEDS主从复制：
	特点：一个master可有多个slave
	支持链式复制。
	master以非阻塞方式 同步数据至slave
	主要利用reids的快照方式，进行同步。会把主持久化的快照至从，从以快照读至内存。
主从配置：
	>slaveof IP 6379 #此处ip为主节点IP，6379为主节点端口。
	或在配置方件中
		slaveof 192.168.1.100 6379
		slave-serve-stale-data yes #当于连接不到主节点是，从节点是数据是否可继续响应读请求。
		slave-read-only yes #是否只读。
		repl-diskless-sync no #是否基于diskless(无盘)方式进行sync磁盘同步。
		repl-diskless-sync-delay 5 #延时时间秒数。
		repl-disable-tcp-nodelay no #
		slave-priority 100	#从节点的同步优先级。
	# min-slaves-to-write 3		#从节点小于3个则禁止主节点写操作。
	# min-slaves-max-lag 10		#从节点不可慢于主工点10秒，否则禁止主写。
################################################################################主服务器开启了秘码认证：
	从节点：masterauth <password> 才可同步。
################################################################################
sentinel:哨兵机制：
	作用：用于管理多个redis服务完成HA高可用。
		监控
		通知
		自动故障转移。
	采用“流言选票方式，断定节点的状态”
	启用sentinel:
		redis-sentinel /PATH/配置文件
		redis-server /Path/配置文件 --sentinel
	启动流程：
		(1),服务器自身初始化，运行redis-server中专用于sentinel功能的代码。
		（2）、初始化sentinel状态，根据给定的配置文件，进行初始化。
		（3）、创建连向master的连接。
		专用配置文件：/etc/redis-sentinel.conf
	配置文件：
		port 26379 #哨兵工作的端口。
		logfile /var/log/redis/sentinel.log #日志文件的路径。
		sentinel monitor mymaster 127.0.0.1 6379 2
		# 2代表在法定票数大于2时才能为主节点。
		sentinel down-after-milliseconds mymaster 30000
		# 多少毫秒连接不到，才认为节点不再线。
		sentinel parallel-syncs mymaster 1
		#由从服务器刚提升为主节点时，允许多少个从服务器同时发启同步请求。
		sentinel failover-timeout mymaster 180000
		#从节点提升为主节点的，超时时长。多少秒提升不为主则认为失败。
	哨兵专用命令：
		sentinel masters 查看主节点组的信息
		sentinel slaves <maste name> #获取主节点的所有从节点。
		sentinel get-maset-addr-by-name <maste name> #跟据名字获取主节点的地址。
		sentinel reset #重置
		sentinel failover <master name> #强制下线
		
		

	
		
	
	
	
	

