psutil实现了很多功能，包括了如下工具所具有的：
http://pythonhosted.org/psutil/#network

ps
top
df
kill
free
lsof
free
netstat
ifconfig
nice
ionice
iostat
iotop
uptime
pidof
tty
who
taskset
pmap
####################################################
	#CPU 时间
import psutil
psutil.cpu_times() 
输出：scputimes(user=17411.7, nice=77.99, system=3797.02, idle=51266.57, iowait=732.58, irq=0.01, softirq=142.43, steal=0.0, guest=0.0, guest_nice=0.0)
psutil.cpu_percent(interval=1) #CPU使用率，interval 间隔时间
		   prcpu=True #参数列表返回
psutil.cpu_count() #CPU线程总数。
psutil.cpu_count(logical=False) #CPU核心数。
psutil.cpu_stats() #
输出： scpustats(ctx_switches=49406052, interrupts=20497588, soft_interrupts=8566115, syscalls=0)
		ctx_switches	#上下文切换总数。
		interrupt	#中断数。
		soft_interrupts #软中断数，windows为0
		syscalls 	#系统调用数 linux为0
######################################################  内存部分：
psutil.virtual_memory()
	输出：	total:物理内存总数。
		available：可用物理内存总数。
		percent:  可使用内存百分比。
		used:	用户使用内存
		free ：	可用物理内存总数
		active: 最近使用的内存，linux
		inactive: 未使用的内存。
		buffers: 文件缓存使用。
		shared :可以初多进程访问的内存大小。
		wired	:内存磁盘大小。
psutil.swap_memory() 交换分区（虚拟内存。）
	输出：total: 交换区大小。
		used:用户交换多少。
		free:空闲交换分区大小。
		percent: 使用百分比。
######################################################磁盘
psutil.disk_partitions() 磁盘挂载分区。
psutil.disk_usage('/home') 磁盘分区信息。
psutil.disk_io_counters(perdisk=True) #输出分区读写次数，读写时间等信息。
############################################################################网络部分。
psutil.net_io_counters(pernic=True) #输出网卡的发送接收等 信息。
		bytes_sent #发送总量。
		bytes_recv #接收总量。
		packets_sent #发送的数据包总数。
		 packets_recv #接收的数据包总数。
		errin	#输入错误
		errout:  #输出错误 
		dropin  #丢掉的输入包。
		dropout #丢掉的输出包。
psutil.net_connections() #所有的sock连接。
		fd 套接字状态。
		family:地址类型  AF_INET, AF_INET6 or AF_UNIX. #IPV4，V6 和unxi
		type:地址类型。SOCK_STREAM  SOCK_DGRAM. 
		laddr 地址和端口。
		raddr:远端地址
		status:状态。 LISTEN ESTABLISHED NEW
		pid :对应的PID号
psutil.net_if_stats() #网卡状态。
############################################################################系统信息。
系统时间：
psutil.boot_time() 输出时间。
datetime.datetime.fromtimestamp(psutil.boot_time()).strftime("%Y-%m-%d %H:%M:%S") 格式化时间。
当前用户信息：
psutil.users() 包含：名称，方式，登录地址，运行的时间。
########################################################################进程
psutil.pids() #例出所有的进程pid号。
psutil.pid_exists(1234) #检查此pid是否存在。
psutil.process_iter() #返回一个迭代对象，遍历包含：运行进程的程序名，pid号
例：
for i in psutil.process_iter():
	print(i.as_dict()[username])
	KEY:	'ionice',
       		'memory_info',
	       	'username', 
		'terminal', 
		'memory_full_info', 
		'cwd',
	       	'threads',
	       	'exe', 
		'num_ctx_switches',
	       	'memory_maps',
	       	'cmdline', 
		'gids', 
		'status', 
		'io_counters',
	       	'uids', 
		'num_threads',
	       	'cpu_times',
	       	'nice',
	       	'name', 
		'create_time',
	       	'memory_percent', '
		cpu_percent', 
		'ppid',
	       	'environ',
	       	'cpu_affinity',
	       	'pid',
	       	'connections',
	       	'num_fds',
	       	'open_files'




	


