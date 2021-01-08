mysql操作：
插入：insert info '表'(字段，字段)value('值','值')
查：select * from 表
改：update '表' set '字段'=值 where id=1
删：delete from '表' where 'id'=1
###############################################################
import pymysql /import pymysql.Connections
from pymysql.cursors import DictCursor
实例化连接：cursorclass=DictCursor #select时返回的方方式为字典，默认为元组。
<<<<<<< HEAD
conn=pymysql.connect(host='127.0.0.1',port=3306,user='root',password='fengzi',database='crm_test',cursorclass=DictCursor,charset='utf8')
=======
conn=pymysql.connect(host='127.0.0.1',port=3306,user='root',password='fengzi',database='crm_test',cursorclass=DictCursor)
>>>>>>> 042b8a5ccfedd50220d8609ef3a18c0d5d23617c
实例化游标对象：
	cur=conn.cursor(增，删，改语句)
	cur.connection.commit() 或者:conn.commit() #提交事务。
	cur.close() #关闭连接。
######################################
上下文方式：
try:
    with conn as cur:
        cur.execute('''select * from `crm_role` ''')
        request=cur.fetchall()  #取出全部返回的值，因为cursorclass=DictCursor所以返回为字典。
        print(request[0]['SORT'])
        #request=cur.fetchmany(5)#取出前五行，依次五行取出。
        #request=cur.fetchone() #只取出反回所有的第一行。
finally:
    conn.close()
#########################################


	


