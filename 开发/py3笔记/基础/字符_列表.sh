math模块
math.factorial()阶乘
5的阶乘=1*2*3*4*5
###############################################
数组：
内置数据结构｜容器
列表、元组、字符串：线性结构（可切片操作，解包封包）
集合、字典：非线性结构。
解析式：列表解析，生成器解析，集合解析，字典解析。
####################################################
列表：
创建列表：
lst=list() 初始化一个空列表。
lst=[] 	初始化一个空列表。
list=[1,2,3,4] 创建一个有值的列表。
索引操作：
lst[0]	取出第一个元素。
lst[0]='a'	修改第一个元素的值。
列表增加元素方法：
append()	：尾部追加一个元素。
	例：lst.append(12)
insert()	:指定位置插入元素。
	例：lst.insert(0,7)	#在第一个索引前插入一个7的元素。
	注当插入索引值大于当前索引时会在尾部追加。
extend()	:追加多个元素。
	例：lst.extend(['a','b','c'])
列表删除元素：
pop()		:从最后移除一个元素。
	例：lst.pop()	#返回移除的元素值。
remove()	删除指定元素值，如果有多个重复值，删除最前索引。
	例：lst.remove('a')
clear()		:删除所有元素。
	例：lst.clear()
查找统计元素：
index()	跟据值找索引。
count()	:查找列表有多少指定元素。
	例：lst.count('b')
len()	函数，返回无数个数。
修改：
sort()	对列表的全部元素进行重新排序，会改变原有列表。
	例：lst.sort()
		lst.sort(reverse=True) 倒排。
reverse()	对列表进行反转。
	例：lst.reverse()
其它：
copy()	复制一个列表。
	例：lst2=lst.copy()
######################################
定义有限列表（指定最大队列）
from collections import deque
q=deque(maxlen=10) #定义队列q的最大队列长度为10。
q.append(1)	#尾度追加一个元素。
q.appendleft() #首部追加一个无素。
q.popleft()	#首部出zhan
#########################################################
题外：
import datetime
	start=datetime.datetime.now()
		代码#用来输出代码用的时间
	datetime.date.time.now()-start
######################################################
元组：不可变的列表。
创建元组：
t=tuple()
t=()
t=(1,2,3)
方法：
count()	：查看指定元素个数
	例：t.count(1)
index()	:查看第几个元素。
##########################################################
切片操作：
lst[0:3]	:输出0-3个元素值。
lst[2:-5]	:输出第二到倒数第五个元素的值。
lst[:]		:输出全部元素。
lst[::2]	:输出0，2，6.。。元素。2表示步进
lst[-1:0:-1]	：切片反转.注意启始是结尾，终是开始 ，步进是-1
不建议对切片进行赋值。
#########################################################
解包、封包
	a=2
	b=3
	a,b=b,a #此时就用的解包。
解包：
	x,y=[1,3]	#x=1 y=3
	x,y=1,3		#y=3 x=1 支持直接变量，支持列表取值。
封包：
	t=1,3		#t=(1,3) 此时t会是个元组。
解包：	h,*b=list(range(0,10)) # h=0 b=[1,2,3,4,5,6,7,8,9]
总结：解包把集合里的元素复制给变量。
	封包：把变量构建元组。
例：
	lst=list(range(0,10))
	a,b,_,c,*=lst
	#a=0,b=2,c=4 _丢弃的值。
多元列表解包：
	lst=[1,2,3,['a','b','c'],4,5]
	a,_,_,(b,*_),_,d=lst
	#a=1 b=a *_表示后面丢弃。
##############################################################
字符串：
	字符串是不可变的：
s='fengzi'
s[0] #f
连接：
	join:	比+号拼接效率更高。
	例：lst=['my','name','is','yingxiong']
		‘' '.join(lst)
		#'my name is yingxiong'
		','.join(lst)
分隔：
split	左分隔
	例：line='url:http://www.mageedu.com'
	key,value=line.split(':',1) #用：号进行分隔。只分隔一次。
splitlines(True) 保持换行符分隔。
partition(':',1)	# 保持换行符左分隔
rpartition()		#保持换行符右分隔。
字符串修改：
	自然语言修改：
	capitalize() 行首字母大写。
	title()每单词首字母大写。
	lower()全部转小写
	upper()全部转大写。
	swapcase()大小写互换。
程序世界的修改。
	center（）#居中显示
	例：s.center(80,'#') #占80个字符并居中，左右用#填冲。
	ljust()	左补全参数同上。
	rjust() 右补全参数同上。
	zfill() 只有一个参数。用0补全。
	strip() 移除占位符，制表符，空白符
	lstrip() 左移除。
	rstrip()右移除。
字符判断：
startswith()	#判断是否以一个字符串开头并包含
	例：s.startswith('wangqinfeng'5) #判断从第五个字符串后是否是wangqinfeng
endswith()	#从尾部开始第几个字符。
isupper()	#判断所有字符串为大写。
islower()	#判断所用字符串为小写。
isdigit()
isalnum()
isprintable()	#是否可打印。
isinstance(a,int) #判断是否为整型
查找替换：
count():	例出指定字符串的个数。
find():		查看指定字符串出现的次数。
rfind()		从右开始
index():	与find相同，只是在找不到字符串时返回错误。
replace()	字符替换
		例：s.replace('a','c',1) #表示只把第一次出现的a替换为c.
					-1表示全部替换。默认为全部替换。
###########################################################################
格式化输出：
printf:
一、 print('i is %(name)s,%(name)s'%{'name':'fengzi'})
 		K引用		   K	  V	#输出会把fengzi 替换name

		print("my name is %s"%("fengzi"))
二、%s：字符串
	%d:	整数，同%i,%u一样。
	%o:	转为八进制出输。
	%x	转为十六进制输出。
	%e	浮点数输出
	%f	浮点数输出，保存后六位。
	%c	字符输出。
	%a	转为Acsl码
三、固定宽度.
	'%3f'%(0.12345)
	'%4.3%'%(1234.12345)
	'%-4d%'%(12345123)
	'%+4d%'
################
重点使用：
format方法输出格式化：
1、'my is {}'.format('tom') #输出替换{}内替换为tom
2、'my is {1},my love {0}'.format('fengzi','ruili')
3、'my is {name},my love {love}'.format(name='fengzi',love='ruili')
4、‘'my is {0[0]}'.format(lst) #传入lst[0]个元素。
二、
距中规则：
	>	#右对齐
	<	#左对齐
	=	#用于数字0补齐
	^	#居中对齐
例：
'{0:^80}'.format('马哥教育')
'{0:>80}'.format('马哥教育')
'{0:<80}'.format('马哥教育')
'{0:=80}'.format(12)
'{name:=80}'.format(name=12)
正负数值显示：
	'{0:+}'.format(100)
	'{0:-}'format(100)
#######################################################################
bytes：python特有，用于网络传输，的转码。
ceshi=b'abcedef'	#商明一个byte
字符串转bytes
因为字符串不能直接传入网络。
a='fengzi'
a.encode() # b'\xe9\xa9\xac\xe5\x93\xa5\xe6\x95\x99\xe8\x82\xb2'byte码。
a.decode() #把byte码转为字符串。一般用于接收到的数据转为可视的字符串。
可接受的参数：字符集如：gbk utf-8 #a.decode('UTF8')|a.decode('GBK')

bytearray与bytes用法一样，只是可字节可以更改。

查看字符编码号：b'wo'.hex()转为十进制int(b'wo'.hex(),16)
