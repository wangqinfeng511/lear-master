环境变量：
export ORACLE_BASE=/home/oracle_databases
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1
export PATH=$PATH:$HOME/bin:$ORACLE_HOME/bin
export ROACLE_PID=ora11g
export NLS_LANG=AMERICAN_AMERICA.AL32UTF8
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/usr/lib
export ORACLE_SID=orcl11g

安装依赖：
yum install  gcc-c++.x86_64
yum install  gcc.x86_64
yum install  libstdc++
yum install  libaio-devel
yum install  libaio-devel.x86_64
yum install  compat-libstdc++-33.x86_64
yum install unixODBC 
yum install unixODBC.x86_64 
yum install unixODBC-devel 
yum install unixODBC-devel.x86_64 
yum install libaio-devel.x86_64 
yum install elfutils-libelf-devel.x86_64 
yum install libgcc 
yum install ksh.x86_64


2、修改i386是红帽的结尾
 vim database/stage/cvu/cvu_prereq.xml 
	i386  i686



3、报错修改。第一个可以跳过，这是第二个
/home/oracle_databases/product/11.2.0/db_1/sysman/lib/ins_emagent.mk 
#  emdctl
#===========================

$(SYSMANBIN)emdctl:
        $(MK_EMAGENT_NMECTL) -lnnz11

vim /etc/sysconfig/network
	HOSTNAME=ceshi
# hostname ceshi

4、为IP指定解析名：
vim /etc/hosts
	192.168.0.102 ceshi
#######################启动关闭数据库。
sqlplus / as sysdba
> startup  #启动数据库。
	参数：nomount 创建数据库create database时使用。
		mount 维护数据库时使用，在不能open时使用。
		open 默认参数，打开数据库。
>shutdown normal #正常关闭数据库。
>shutdown immediate #快速关闭数据库。
>shutdown abort 	#异常情况下关闭数据库。
########################启动关闭监听和服务。
lsnrctl start #启动监听和服务。
#lsnrctl start 启动监听和服务。lsnrctl status, lsnrctl stop
dbstart #不知道什么用。
dbshut #不知道什么用。
dbca   #create dabase 创建数据库实例，要指定主机名为hostname
netmgr #监听配置gui
#先要启动数据库，sqlplus /as sysdba ,>startup 
#netmg 配置监听和服务。


##########################手动修改监听和服务配置。
vim $ORACL_HOME/network/admin/listener.ora
SID_LIST_LISTENER =
  (SID_LIST =
    (SID_DESC =
      (GLOBAL_DBNAME = crm)
      (ORACLE_HOME = /home/oracle_databases/product/11.2.0/db_1)
      (SID_NAME = crm)
    )
  )

LISTENER =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.0.102)(PORT = 1521))
  )

ADR_BASE_LISTENER = /home/oracle_databases
#动态监听：
 > alter system set local_listener='(address_list=(address=(protocol=tcp)(host=crm)(port=1521)))';
#静态注册：
vim listener.ora
#监听测试命令：
tnsping <address>
#################################################
#客户端配置tnsnames.ora：
CRM =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = crm)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = crm)
    )
  )

LISTENER_ORCL11G =
  (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))

####################################################
create user user_name identified by passwod; #创建用户
grant connect,resource to user_name	#受权。
show user 				#显示当前用户
select * from all_users;		#查看全部用户
select * from all_tables;		#显示所有表

select status from v$instance		#查看当前数据库状态。
select name from v$database		#查看当前数据库名称。
start [file_name]|@ [file_name]		#执行一个SQL文件。
list 					#查看当前缓冲区的语言。
edit					#当前的语句进行编辑。
run|/|r					#重新运行上条语句。
del					#删除缓冲区。
clear buffer				#清空缓冲区。
spool c:\b.txt; 语名 spool off;		#把语句输出到指定文件。
disconn					#关闭当前连接。
conn user/passwd			#打开新的连接。
		
###############################################################
监听配置信息：
	查看当前数据库的服务名。
		show parameter service_name;
	查看当前数据库参数local_listener的值。
		show parameter local_listener; 返回动态注册到的监听器
	
	
		
