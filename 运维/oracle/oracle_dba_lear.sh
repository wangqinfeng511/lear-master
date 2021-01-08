oracle 体系结构：
	实例：
		SGA：
		进程：
			SMON:系统监控进程，
				作用一、：数据库实例恢复，当数据库发生故障，SGA中没有写入磁盘的信息丢失：
					1、前滚没有写入数据文件，而记录在重做日志中的数据。
					2、在前滚还没有完成情况下，打开数据库以免回滚时间太长。
					3、回滚未提交的事务。
				作用二、执行某些空间维护的作用。回收数据文件中的临时duan
			PMON:进程监控
				作用：负责服务器进程管理维护，进程失败或连接异常时负责清理工作。
					1、回滚未提交的事务。
					2、释放所持有的当前的表或行锁。
					3、释放进程占有的SGA资源。
					4、监视其它Oracle的后台进程，必要时重启这些进程。
					5、向OracleTNS监听注册刚启动的实例，如果监听器在运行，就与这个监听器通信并传递服务名和
						实例的负载等叁数。如果监听没有启动，PMON会定期尝试连接监听器来注册实例。
			DBWR：数据库写进程
				作用：脏数据回写。
				触发事件：
					发生检查点事件
					脏数达到阀值
					数据库缓存没有足够空间
					表空间处于热备状态
					表空间状态切换（离线，只读）
					删除表，或截断表。
					超时。
			LGWR:重做日志写进程：
				作用：负责将重做日志缓冲区中的数据写到重做日志文件。此时重作日志缓冲区中的内容是恢复事务所需要的信息。比如update语句更新数据，恢复事务所需的信息就是更新前的数据和更新后的数据，用于该事务的恢复。
				用于实例失败时的数据恢复。
				触发条件：
					事务提交。
					当重作日志缓冲区的三分之一被占用时。
					当重做日志缓冲区中有1MB的数据时。
					当数据库要触发脏数据回写之前。
				为什么写日志要比脏数据回写效率高：
					数据写进程是离散写到不同数据库文件上的，数据库写进程会修改不同空间中存储的数据块和索引块。所以写进程的离散写速度慢。重作写日志进程是须序写，所以快。提高系统性能。
			ARCH:归档日志进程
				可选进程。并不在实例启动时自动启动。
				作用：把写满的重做日志文件的数据写到一个归档日志中。
				查看系统的归档模式：
					sys
					archive log list;
				启用归档：
					1、进入mount模式。
					2、alter database archivelog; 打开归档。
					3、查看归档存储路径： show parameter db_recovery;
						/home/oracle_databases/flash_recovery_area 这就是存储路径。
						db_recovery_file_dest_size  此目录的最大空间大小。

			CKPT:校验点进程
				校验点是一个事件，类似于读书标签。用于反应最后一次落盘的时间点。主要用于配合SMON进程实现自动恢复。
				校验点进程都作了什么：
					1、要将校验点号码写入相关的数据文件的文件头中。
					2、校验点进程把校验点号码，SVN号、重做日志序例号、归档日志名字等都写入控制文件。
				手动强制校验点：
					alter system checkpoint;
					
	数据文件：
		数据文件，控制文件，重做日志文件
	用户进程
	服务进程
	参数文件
	密码文件
	归档文件
Oracle 数据库物理结构（文件组成）:
	data files : 数据库文件
	control files :控制文件。
	redo files 重做日志文件，在发生故障进用于数据恢复。
	其它文件：
		parameter file 参数文件
		password file 密码文件。
		archive log files 归档日志文件是脱机备份文件。
数据库连接方式（connection）
	Host-based:基于主机的方式，服务端和客户端在同一台机子上。
	Client-server: 最常用的客户机到oracle.
	Client-Application Server-Server: web使用要中间服务器。
	连接接流程：client-->服务进程-->数据库服务器
ORacle 数据库内存结构：
	SGA:系统全局区。
		数据库实例启动时，首先分配SGA.
		SGA包含： 查看show sga,查看当前SGA区域大小 show parameter sga_max_size
			Database buffer cache 	:数据库高级缓存，存储从数据文件读入的数据块信息，和更改后需要回写数据库的数据。
				1、设置大小 DB_BLOCK_SIZE 数据块的大小，DB_BLOCK_BUFFERS数据库个数，相乘是高速缓存的大小。
				2、查看数据库高速缓存的大小：show parameter db_cache_size ,11g自动sga所以为0
					修改：alter system set db_cache_size=200M
				3、查看数据库块的大小：show parameter db_block_size 默认为8k
				4、关闭缓存顾问。alter system set db_che_advice =0ff
			Redo log buffer cache 	:重作日志缓存。
			Shared pool	      	:共享池。有两部分组成：
				1、Libraay cache	:库高速缓存,用于缓存最近使有过的SQL语句。
				设置共享池的大小：alter system set shared_pool_size=16M
				2、Data dict cache :数据字典高速缓存,存储数据文件，表，索引，列，用户，权限信息。
			Large pool		:大池。
				是SGA的可选内存区，只有在共享服务器环境中配置大池，共享环境下用于存储用户进程和服务进程的会话信息。用户进程区域UGA（可理解为共享服务器中pga的另一个称呼）
				查看：show parameter large_pool_size
				设置：alter system set large_pool_size=48M
			java pool		:Java 池。
				用于编译Java语言编写的指令。
				查看：show parameter java_pool_size
				设置：alter system set java_pool_size=nM

	PGA:程序全局区。连接进程分配。
		PGA是服务器进程专有的一块内存，其它进程无法访问这块内存。
		存储了服务器进程和单独的后以进程的数据信息和控制信息。进程终上释放内存，
		包括：
			排序区：对某些的SQL语句执行结果进行排序。
				查看排序区大小： show parameter sort_area_size
			会话信息：包含本次会话的用户权限和性能统计信息。
				
			游标状态：标明当前会话执行的SQL语句的处理阶段。
			堆栈区：包含其它的会话变量。
		注意：在共享服务结构中，会话信息是存在SGA中的，两种模式下椎 区都是存在PGA中。
	

	GUA：全局区
		共享服务器模式下用户全局区,uga存储在每个共享服务都可以访问SGA中。
###############################################################################################
数据字典：
	所有的模式（用户）对象的定义，这些对象名括表，视图，索引，族，同义词，序列号，存储过程，函数触发器等！
	数据库的逻辑结构和物理结构，如数据文件和重做日志文件的信息等。
	所有模式对象分配多少存储空间，以及当前使用的空间。
	默认列值。
	对象完整性的约束信息。
	用户信息。
	用户或角色的特权信息。
	审计信息，如哪个用户具有访问或者修改某些模式对象的权利。
	##########################################################
	数据字典分类：
	DBA_***：该视图包含数据库中整个对象的信息。只能有管理员查询。
		dba_objects：视图
	ALL_***:该视图包含某个用户能看到的全部数据信息。
	USER_***:该视图包含当前用户访问的数据库对象信息
#################################################################
#控制文件
	是一个非常小的二进制文件，其中记录了数据库的状态信息。如重做日志文件与数据文件的名字和位置，归档重做日志的历史等。
	一个控制文件只能与一个数据库相关联，一个数据库至少3个控制文件。
	#
	查看控制文件的位置：
		select value from v$parameter where name='control_files'
		show parameter control_files;
	查看控制文件：
		select type,record_size,records_total,records_used from v$controlfile_record_section;	
