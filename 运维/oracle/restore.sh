#修改内核参数：
fs.file-max = 6815744
kernel.sem = 250 32000 100 128
kernel.shmmni = 4096
kernel.shmall = 1073741824
kernel.shmmax = 4398046511104
kernel.panic_on_oops = 1
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
net.ipv4.conf.all.rp_filter = 2
net.ipv4.conf.default.rp_filter = 2
fs.aio-max-nr = 1048576
net.ipv4.ip_local_port_range = 9000 65500
#什么是pfile:
	数据库：初使化参数文件：
	比如:sgv的内存配置，最大并发连接数等。
#什么是控制文件：
	保存了数据库的运行状态。
	比如scn.
#什么是redolog组：
	用于从内存中回写日志脏数据。
#什么是归档日志：
	当redolog中到阀值或接到切换日志指令时，打包后的原redo日志文件。
	在scn发生不至时用来读出语句恢复。
#什么是scn
	#ID号，分为控制文件scn和备份scn。
	#控制scn 分为：系统scn号、用户表scn号。
		#查看控制文件系统检查点的scn号 select checkpoint_change# from v$database;
		#查看控制文件中数据文件scn号： select name,checkpoint_change# from v$datafile；
		#查看mount下查看数据文件的文件头中的scn 跟控制文件中的scn号一至，不一致自动通过归档文件前滚。
			#select name,last_change# from v$datafile
	#open恢复条件：
		#system scn !=datafile scn!=start scn!=stop scn
		#比如system scn >datafile scn 进入归自动从归档中读出数据恢复。
		#system<datafile scn 时从redolog中读取最后的scn号。如果读不到只能作手动恢复了。
		#
#控制文件重建：
	控制文件一般有多份。rman备份时全备份重建的机会不多。重构要求redolog中有scn号。千万不要执行清空redolog再重建。
	清空后scn重构后是0.
重构控制文件脚本：在nomount下执行。
CREATE CONTROLFILE REUSE DATABASE "ORCL" RESETLOGS  NOARCHIVELOG
    MAXLOGFILES 64
    MAXLOGMEMBERS 3
    MAXDATAFILES 512
    MAXINSTANCES 8
    MAXLOGHISTORY 2920
LOGFILE
 GROUP 1 '/oradata/orcl/redo01.log'  SIZE 512M BLOCKSIZE 512,
 GROUP 3 '/oradata/orcl/redo03.log'  SIZE 512M BLOCKSIZE 512
DATAFILE
  '/oradata/orcl/system01.dbf',
  '/oradata/orcl/sysaux01.dbf',
  '/oradata/orcl/undotbs01.dbf',
  '/oradata/orcl/users01.dbf',
  '/oradata/orcl/zl9baseitem.dbf',
  '/oradata/orcl/zl9patient.dbf',
  '/oradata/orcl/zl9expense.dbf',
  '/oradata/orcl/zl9medlst.dbf',
  '/oradata/orcl/zl9duerec.dbf',
  '/oradata/orcl/zl9cisrec.dbf',
  '/oradata/orcl/zl9eprlob.dbf',
  '/oradata/orcl/zl9eprdat.dbf',
   '/oradata/orcl/zl9medday.dbf',
  '/oradata/orcl/zl9indexmdr.dbf',
  '/oradata/orcl/zl9humanbase.dbf',
  '/oradata/orcl/zl9humaninfo.dbf',
  '/oradata/orcl/zl9humanwage.dbf',
  '/oradata/orcl/zl9costbase.dbf',
  '/oradata/orcl/zl9costdata.dbf',
  '/oradata/orcl/zltoolstbs.dbf',
  '/oradata/orcl/ZLBAK1.DBF',
  '/oradata/orcl/zlpacsbaseindex01.dbf',
  '/oradata/orcl/zlpacsbasetab01.dbf',
  '/oradata/orcl/zlpacsbizindex01.dbf',
  '/oradata/orcl/zlpacsbiztab01.dbf',
  '/oradata/orcl/zlpacsbizxml01.dbf'
CHARACTER SET ZHS16GBK
;
################################################
#迁库：
	1、复制原数据库的pfil
	2、启动至nomount
	3、恢复控制文件（最新的）
	4、复制备份集和归档文件。rman 下catalog start swith 'path路径'。
	5、还原归档日志。
	6、执行完全恢复再执行逻辑恢复。

###############################################
#归档日志还原
	 #crosscheck archivelog all;  校验日志的可用性
	 #list expired archivelog all; 列出失效规档日志。
	 #delete archivelog all completed before 'sysdate-7'; 删除七天前的归档。
	 #delete noprompt archivelog all; 删除所有归档。
 #RMAN> restore archivelog all; 恢复所有归档。
 #RMAN> restore archivelog from time 'sysdate-7'; 	恢复7天内的归档日志。
 #RMAN> run #恢复到指定目录。
	#> {allocate channel c1 type disk;
	#> set archivelog destination to '/u01/backup';
	#> restore archivelog all;
	#> release channel c1;
	#> }
# 恢复指定时间段

	RMAN> run {
		set archivelog destination to '/u01/backup';
		SQL 'ALTER SESSION SET NLS_DATE_FORMAT="YYYY-MM-DD HH24:MI:SS"';
		restore archivelog time between '2014-04-24 11:00:00' and '2014-04-24 15:00:00';
	} 
###################################################                                  
#一、按时间作非完全恢复。
	#要求:
		#1、保证控制文件时间大于要恢复的时间
		#2、保复制备份到本地（备份集，归档日志）
	run{
		shutdown immediate;
		startup mount;
		set until time "to_date('2017-05-27 05:00:00','yyyy-mm-dd hh24:mi:ss')";
		restore database;
		recover database;
		alter database open resetlogs;
	 };
	 #resetlogs :用Resetlogs重建控制文件控制文件中datafile Checkpoint来自各数据文件头。
	 #noresetlogs:用Noresetlogs重建控制文件时，控制文件中 datafile Checkpoint来自Online logs中的Current log头
#二、按scn作非完全恢复。
	#要求：
		#1、控制文件的scn号要高于备份集中的scn。
		#2、同上复制备份到本地（备份集，归档日志）
	run {
      		shutdown immediate;
      		startup mount;
      		set until scn 3400;
      		restore database;
      		recover database;
      		alter database open resetlogs;
	}
#三、完全恢复：
	run{
		restore database;
		recover database;	
	}
