define_editor=vim #在使用ed ./a.sql 时打开vim编辑器。
set serveroutput on size 100000
set trimspool on  #假输出文本时，会去除文本两端的空格。
set long 5000	 #设置LONG和CLOB行列显示的默认字节数。
set linesize 100 #设置SQL＊plus 显示的文本行宽为100字符。
set pagesize 9999 #可控制SQL＊plus多久打印一次标题行。
column plan_plus_exp format a80 #设置由AUTOTRACE得到的解释计划输出的默认宽度。
##########################################################
#删除角色：drop role plustrace;
#创建角色：create role plustrace;
#用户受权角色：grant plustrace to public;
#####################################################
AUTOTRACE #oracle一个工具，可以显示所执行查询的解释计划。以及所用的资源。
CREATE PUBLIC SYNONYM TABLE_A FOR fengzi.TABLE_A #同意词用于实现其它跨用户表访问。 create public synonym PLAN_TABLES for PLAN_TABLE;
#表受权：	grant all on PLAN_TABLES to PUBLIC
