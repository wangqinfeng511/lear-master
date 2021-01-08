存储过程：
#创建存储过程：
delimiter | #定义结存储过程的结束符
create procedure p()
	begin
		select * from mysql.user;
	end;|
#列出所有存储过程：
show procedure status;
#删除存储过程：
drop procedure name;
调用：
call p();|

declare a int;一般用于定存储过程中的字段变量
set a=20;
#例：
	
######case语法：
select 
	case user
		 when 'root' then 'system_user'
		 when 'fengzi' then 'user_user'
		 else '非用户'
		 end 
from user	
############if语句：
if .... then ....
	else if ....then...
end if 
#例：
	select user, IF(user='root','system','user') from mysql.user;
##########in语句：
例：select 'fengzi' IN(select user from mysql.user);	
