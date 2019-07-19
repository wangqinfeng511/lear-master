sql select 
	select * from mysql.user where user='root'or user like '%feng%';
sql distinct (disˈtiNGkt) 去重
	select distinct user from mysql.user
sql order by 倒序desc
	select  user from mysql.user where user='root'or user like '%feng%' order by user desc; 
sql insert 插入语句
	insert into table (user,password) values('wangqinfeng','fengzi')
sql update 更新语句
	update  table_name set user='wangqinfeng' where password='fengzi';
sql delete 删除语句
	delete from table_name where 列_name='value'	
sql top 取出前几行：
	select user top 3 user from mysql.user #sql_server的写法。
	select user from mysql.user limit 2; 取出前两行 	
sql in 
	select user from mysql.user where user in ('root','fengzi')
sql between 范围条件（数值，文本，日期）
	select user from user where between 'a' and 'z' #会去空
sql as
	select user as '名称' from user;
sql join 关系表联查
	select * from t1 inner join t2 on t1.id=t2.t1_id;
	内关联 inner join 俩表完全匹配返回行。
	左关联 left join  即使右表没有匹配也返回。
	右关联 right join 即使左表没有匹配也返回。
	全关联 full  join 相当于同时left和right.
sql union 
	UNION 内部的 SELECT 语句必须拥有相同数量的列。列也必须拥有相似的数据类型	select user from user union select user from user;
	union 会选取不同的值，union all 显示全部。
sql select into 结果创建表。
	select * into t2 from t1 #mysql 不支持这种写法。
	替代create temporary table ceshi(select user from user); 
sql create table 约束
	not null 非空！
	unique   唯一约束
	primary key 主键
	forreign key 外键约束。foreign key (本表字段) references table_name(id)
	check 内容约束。check 字段(id_p>0 and id_p<10000);
			alter table t1 drop constraint chk_Person;撤销约束。
	default'ceshi' 默认值。
	auto_increment 自增长。
sql create index 索引创建：
	create unique index 索引名字 on t1(user desc);对t1的user字段创建索引。desc表示倒序索引。
	drop index 索引名字 on t1;
	mysql:alter table t1 drop index 索引名字。
	oracle: drop index 索引名字。
sql truncate table 清楚数据：
	truncate table t1
sql alter 语句：
	alter table t1 add user_descrprtion varchar(255); #添加字段。
	alter table t1 alter column user varchar(50); #修改表的数据类型。
	alter table t1 drop column user; #删除字段。
sql create view 创建视图：
	create view t2 as select user,password from mysql.user
	drop view t2;
sql date 时间
	now()  时间格式:2018-02-21 20:21:42	
	curdate() 时间格式日期:2018-02-21
	curtime() 时间格式:20:21:42 
	
sql group by: 分组统计：
	select 	user,password from mysql.user group by user;
sql function:
	avg() 平均值
	count() 行数
	first() mysql 咩有此函数。
	last() mysql 没有此函数。
	mas()	最大值。
	min()	最小值。
	sum()  求和。
	having 在函数中无法使用where。
		select user as name, password from mysql.user group by user having user='root';
	ucase() 转大写；
	lcase() 转小写；
	mid() 字段中提取字符串select mid(user,1,3) from mysql.user;取1-3字符。
	len() 字段长度；
	round() 浮点保留位数。round(字段名,1)保留一位。
	now() 返回时间。
	format() 格式化。
	date_format() 时间格式化：
		date_format(now(),'%Y_%m_%d')
		%a 缩写的星期几。
		%b 缩写的月名。
		%M 月名
		%m 月值
		%c 月，数值
		%D 带缩写的日期。
		%d 日期俩位。
		%e 日期一位。
		%f 微妙。
		%p AM/PM
		%H 小时24俩位
		%k 小时24一位
		%h 小时12两位
		%l 小时12一位。
		%i 分钟俩位。
		%S 秒
		%s 秒
		%T hh:mm:ss
		%U 一周的第几天。
		%u 同上一位
		%j 一年的第几天。

