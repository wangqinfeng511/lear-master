startup #启动数据库实例。
shutdown #关闭数据库实例。

show user #显示当前用户。
select username from dba_users; #显示所有用户名。
alter user scott account unlock;#解锁scott用户。
#用户管理：
	#创建用户：
		create user user_name identified by password
	#授权：
		grant dba,connect,resource to user_name
		#dba :最大权限：
		#connect角色：
			select 
			updata
			insert
			Alter session--修改会话；
    			Create cluster--建立聚簇；
   			Create database link--建立数据库连接；
    			Create sequence--建立序列；
    			Create session--建立会话；
    			Create synonym--建立同义词；
    			Create view--建立视图。
		#resource角色：
			Create cluster--建立聚簇；
   			 Create procedure--建立过程；
   			 Create sequence—建立序列；
    			Create table--建表；
    			Create trigger--建立触发器；
    			Create type--建立类型。

	#收权：
		 revoke resource from user_name
	#修改秘码：
		alter user user_name identified by password
	#锁用户：
		alter user user_name account lock
	#解锁用户：
		alter user user_name account unlock
	#删除用户：
		drop user user_name cascade;
			#cascade 会先删除用户下的所有对象，再删除用户。	
#表空间，存数据库对象。
#表空间分类：
	永久表空间:
		表，视图，对象。
	临时表空间：
		临时存放。
	UNDO表空间：
		保存事务修改前的数据，用于回操作。
#查看用户的表空间：
	dba_tablespaces 字典。
	user_tablespaces 字典。
	#查看当前表空间的名字。
	select tablespace_name from dba_tablespaces;
	#返回值：
		SYSTEM ：系统表空间。
		SYSAUX  ：
		UNDOTBS1 ：撤消信息表空间
		TEMP	：临时表空间
		USERS    ：用户表空间。
	dba_users: 系统用户表字典。
	user_users: 用户表字典。
		USERNAME                                  #用户名字
		USER_ID                                   #用户ID
 		PASSWORD                                  #用户秘码
 		ACCOUNT_STATUS                            NOT NULL VARCHAR2(32)
		LOCK_DATE                                          DATE
 		EXPIRY_DATE                                        DATE
 		DEFAULT_TABLESPACE                        #用户表空间
 		TEMPORARY_TABLESPACE                      #用户临时表空间
 		CREATED                                   NOT NULL DATE
 		PROFILE                                   NOT NULL VARCHAR2(30)
 		INITIAL_RSRC_CONSUMER_GROUP                        VARCHAR2(30)
 		EXTERNAL_NAME                                      VARCHAR2(4000)
 		PASSWORD_VERSIONS                                  VARCHAR2(8)
 		EDITIONS_ENABLED                                   VARCHAR2(1)
 		AUTHENTICATION_TYPE  	
	#设置用户的表空间：
		alter user system default tablespace system;
	#自定义表空间：
		#创建表空间
			#永久表空间：
				create tablespace test1_tablespace_name datafile 'test_tablespace_name.dbf' size 1000m;
				创建	表空间		表空间的名字	数据文件	表空间文件的名字	大小 1G
			#临时表空间：
				create temporary test1_tablespace_name datafile 'test_tablespace_name.dbf' size 1000m;
                		创建    表空间          表空间的名字    数据文件        表空间文件的名字        大小 1G
			#自增参数：
				AUTOEXTEND ON #打开自增。
				NEXT 大小	#每次加多少
				MAXSIZE 大小; #最大表空间大小
		#查看表空间存放路径：
			select file_name from dba_data_files where tablespace_name="表空间的名字"
		#临时表空间存放路径：
			dba_data_files 
		#修改表状态：
			alter tablespace tablespace_name online|offline;
							联机｜脱机。
			 状态信息存在 dba_tablespaces 的status
		#修改表空间的读写状态：
			alter tablespace tablespace_name READ ONLY|READ WRITE 
							只读｜读写
		#表空间增加|删除数据文件：
			alter tablespace tablespace_name ADD DATAFILE 'xx.dbf' SIZE xx;
			alter tablespace tablespace_name DROP DATAFILE 'xx.dbf';
		
	
	select status from v$instance           #查看当前数据库状态。
	select name from v$database             #查看当前数据库名称。
	start [file_name]|@ [file_name]         #执行一个SQL文件。
	list                                    #查看当前缓冲区的语言。
	edit                                    #当前的语句进行编辑。
	run|/|r                                 #重新运行上条语句。
	del                                     #删除缓冲区。
	clear buffer                            #清空缓冲区。
	spool c:\b.txt; 语名 spool off;         #把语句输出到指定文件。
	disconn                                 #关闭当前连接。
	conn user/passwd                        #打开新的连接。
#视图
	v$instance #查看当前实例状态：
		 INSTANCE_NUMBER                                    实例数
		 INSTANCE_NAME                                      实例名
		 HOST_NAME                                          主机名
		 VERSION                                            版本 
		 STARTUP_TIME                                       启动时间
		 STATUS                                 	    实例状态：nomount,mount,open 
		 PARALLEL                                           并行是否打开
		 THREAD#                                            实例打开生成线程数
		 ARCHIVER                                           归档 ：stopped started failed_归档没成功5分钟内重试。
		 LOG_SWITCH_WAIT                                    日志切换事件(原因)：archive log归档
		 								 clear 清除日志
										 CHECKPOINT 检查
										 NULL - ALTER SYSTEM SWITCH LOGFILE  #系统修改切换日志文件
		 LOGINS                                             登录限定：ALLOWED 全部允许，RESTRICTED，限制登录。 
		 SHUTDOWN_PENDING                                   是否正在执行shutdown,yes|no
		 DATABASE_STATUS                                    数据库状态:ACTIVE 主，SUSPENDED暂停，INSTANCE RECOVERY 恢复状态。 
		 INSTANCE_ROLE                                      实例否活动：PRIMARY_INSTANCE（活动实例） SECONDARY INSTANCE（非活动实例） UNKNOWN（实例启动但没挂载） 
		 ACTIVE_STATE                                       NORMAL 数据库处于正常状态，
		 						    QUIESCING - ALTER SYSTEM QUIESCE RESTRICTED #有系统事务但没执行前的状态
								    ALTER SYSTEM QUIESCE RESTRICTED #系统修改限制查询
		 BLOCKED  					   是否有服务阻se;
	v$database #数据库状态。
		
