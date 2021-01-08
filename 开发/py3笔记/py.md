### pyenv安装

作用：版本切换
yum -y install git gcc make patch zlib-devel gdbm-devel openssl-devel sqlite-devel bzip2-devel readline-devel
pyenv安装：
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

###
vim /etc/profile.d/pyenv.sh 添加
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)
pyenv常用命令：
commands 列出命令
local	 切换版本 例如pyenv 3.5.2
versions 列出支持的python版本。
version	 列出现用的python版本。
install  安装python 例如：pyenv install 3.5.2
uninstall 卸载python 例如：pyenv uninstall 3.5.2
--list 	列出所有版本。
update	更新pyenv
安装python:
	mkdir ~/.pyenv/cache
	下载Python-3.5.2.tar.gz放置此目录。执行pyenv install
因为是编译安装：所以要装好：
gcc make patch gdbm-devel openssl-devel sqlite-devel zlib-devel bzip2-devel readline-devel
###############################################################################
pip安装：
wget "https://pypi.python.org/packages/source/p/pip/pip-1.5.4.tar.gz#md5=834b2904f92d46aaa333267fb

tar -xzvf pip-1.5.4.tar.gz
 cd pip-1.5.4
 python setup.py install
##############
更换源
创建目录 mkdir ~/.pip
编辑 ~/.pip/pip.conf, 输入一下内容
  [global]
  index-url = http://mirrors.aliyun.com/pypi/simple/
  trusted-host = mirrors.aliyun.com
####安装ipython
pip install ipython
pip search ipython
#######################################################################
ide环境：pycharm |idea eclipse vim(jedi命令补全)
jupyter
######################################################################
  项目笔记地址
https://coding.net/u/comyn/p/python2016/git/blob/master/notes/pyenv.md





第一hello word
ipython>>>
print( 'hello word' )
#####################
vim hello.py
#!/usr/bin/python	
 print('hello word')
#########################
pytho ./hello.py |chmod +x hello.py
############################################
运算符：
算术运算符： + - * /(自然除) %  //（齐整除） **（次方）
比较运算符： == != > >= < <= 
		整形可直接与浮点
第二讲、
逻辑运算符：
	and 与
	or 或 1 or 1=1 ,1 or 0= 1, 0 or 0 =0
	not 非
短路：
def add(x,y)
	print("{3}+{1}".formant(x,y))
	return x+y
add(1,3) > add(1,2) add add(2,4)<add(3,4)
	A为ture后才会执行B的表达式
按位与：
	60 &12  0011 1100与0000 1100等于0000 1100
按位或：
	60|12   0011 1100或0000 1100等于0011 1100
按位异或：
	60^12  0011 1100 异或 0000 1100 等于 0011 0000 只要0异或1等于1
按位取反：
	~60 
左移：
	60>>2  0011 1100 左移俩位 等于0000 1111
右移：
	60<< 2  0011 1100右移俩位 等于 1111 0000
############################################################################
运算优先级：
	次方运算高于乘，算术运算符高于比较运算符、比较运算符高于逻辑运算符。（）优先级最高

#########################################################################
控制结构
	顺序结构：从上至下
	单分支结构：if cond:
			block
			列如：if 1<2
				print('hello work')
	多分支结构：
		if cond
			block
		elif cond
			block
		elif cond
			block
		else
			block
	循环结构：
		wlile for
		wlile cond
			block
		else
			print('back while')
		例如：a=0
			while a<100:
				print(a)
				if a>50
					break
			else
				print('back while')
		for element in itrator:
			print(i)
		else
			print('back for')
		例如：for i in range(0,100):
			print(i)
			if i>50
				break
		      else
			      print('back for')
break 结束循环
continue 跳出当前循环
求素数（只能被自身整除的数）
	a=7 c=0
	for i in range(2,a)
		if a%i==0:
			breack
	else
		print('yes')
			
#############################################################################
数据转换
	bool() 布尔值
	int()	整数 int(0011,2) 二进制转整形
	bin()	二进制
	float() 浮点型

---

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

---

datetime.datetime(2016,5,6)strftime()可以用来获得当前时间，可以将时间格式化为字符串等等

格式命令列在下面：（区分大小写）

%a 星期几的简写
%A 星期几的全称
%b 月分的简写
%B 月份的全称
%c 标准的日期的时间串
%C 年份的后两位数字
%d 十进制表示的每月的第几天
%D 月/天/年
%e 在两字符域中，十进制表示的每月的第几天
%F 年-月-日
%g 年份的后两位数字，使用基于周的年
%G 年分，使用基于周的年
%h 简写的月份名
%H 24小时制的小时
%I 12小时制的小时
%j 十进制表示的每年的第几天
%m 十进制表示的月份
%M 十时制表示的分钟数
%n 新行符
%p 本地的AM或PM的等价显示
%r 12小时的时间
%R 显示小时和分钟：hh:mm
%S 十进制的秒数
%t 水平制表符
%T 显示时分秒：hh:mm:ss
%u 每周的第几天，星期一为第一天 （值从0到6，星期一为0）
%U 第年的第几周，把星期日做为第一天（值从0到53）
%V 每年的第几周，使用基于周的年
%w 十进制表示的星期几（值从0到6，星期天为0）
%W 每年的第几周，把星期一做为第一天（值从0到53）
%x 标准的日期串
%X 标准的时间串
%y 不带世纪的十进制年份（值从0到99）
%Y 带世纪部分的十制年份
%z，%Z 时区名称，如果不能得到时区名称则返回空字符。
%% 百分号

---

目录创建：
 import os
 切换目录：os.chdir('/home')
 创建目录：os.mkdir('/tmp/test')#创建目录。
		os.makedirs('/tmp/a/b')#递归创建目录。
			参数：exist_ok=True 目录存大不抛出错误。
			     mode=(0o644) #设置目录权限。
删除目录：import os	
		os.rmdir() #删除目录，不可递归删除。
		os.removedirs() #递归删除空目录。
		os.geteuid()	#返回当前用户的ID
	import shutil #shell库_系统调用。
		shutil.rmtree('/tmp/test')#相当于bash的rm -rf
			参数：
				ignore_errors=True #关闭错误输出。
				onerror=lambda,fn,path,exc_info:print(path,exc_info[1])
移动目录：import shutil 
		shutil.move('/tmp/test','/tmp/a') #移动目录。
复制目录：import shutil
		shutil.copy() #复制数据和数据权限。
		shutil.copy2() #复制数据与stat info (权限，atime,ctime,mtime,flags)
		shutil.copyfile() #复制数据
		shutil.mode()	#复制权限
			参数：
				symlinks=True #如果有链接，复制链接。
目录遍历：
	import os
		os.listdir()	#列出当前目录，返回列表。
		os.path.isdir()	#判断是否为一个目录。
		os.path.join()	#类字符的join。
		os.walk()	#遍历当前目录。
			例：os.walk('tmp') #返回一个生成器。
			import os 
			for root,dirs,file in os.walk('/tmp'):
				print(root,dirs,file)
		os.scandir()
路径相关操作：
	import os
		os.path.basename()	#传入路径，返回文件名称。
		os.path.dirname()	#传入路径，返回目录。
		os.path.join()		#例os.path.join('/','tmp','a','b')
		os.path.split()		#把文件路径进行分隔，分隔为目录和文件名。
		os.getcwd()	#返回当所在目录。
		os.path.is...		#判断是否为。。。
		os.path.splitext()	#对文件名进行分隔，名和扩展名。
	import sys
		print(sys.argv)		#返回当前文件名。
		print(os.path,abspath(os.path.dirname(sys.argv[0])))

#################################################################################################
序列化与反序列化:
	序列化：对象->str/bytes
	反序列化：str|bytes->对象
import pickle 序列化，只能用于python使用。并且版本要求一样。
	常用序列化：
		import pickle
			pickle.dump()	#把对象序列化到文件。支持（int,float,str,list,dict,bool,None）
			pickle.dumps()	#直接序列化，并不同步到文件。
			pickle.load()	#从文件转为非序列化。
			pickle.loads()	#直接反序列化。
		import json 		#常用序列化。
			对应：python:json
				int:number
				str:string
				bool:bool
				None:null
				list:array
				tuple:array
				dict:object
			json.dump()
			json.dumps()
			json.load()
			json.loads()
###############################################################################
文件属性：os.stat

---

isinstance() 类型判断检查，例：isinstance(a(int,str))
enumerate() 取出值和索引.例：a,b=enumerate([1,2]) 以元组类型返回索引和元索。
import datetime
	datetime.datetime.now() #以元组型式反回当前时间。
#########################################################################
堆：二衩树
	大顶堆：父节点总比子节点（左右两节点）大.
	计算：
	左节点：data[i].left=data[2i+1]
	右节点：data[i].right=data[2i+2]
	父节点：data[i].parent=data[flool((i-1)/2)] #堆的用处：优先队列
#########################################################################
		IO于文件操作
文件打开--文件对象--读写关闭。
open()打开文件：
	r #只读 指针位于首部。
	w #写，重写文件。打开文件清空。>
	r+#读写 指针位于首部。
	b #二进制 方式。配合r,w，a使用。
	t #文件本 方式。配合r,w,a 使用。
	a #可写，打开文件。但不清空。
	a+ #读写方式。
	r+（读写）,r+b（二进制读写）,r+t（文本方式读写） 
	x #同w,a相同，如果存在则报错。
	buffering 参数设置buffering大小。一般二进制时使用。
	f=open(r+b,buffering=0)#每写入一个字符同步一次。f.write(b'a')
查看默认buffer大小：
	import io io.DEFAULT_BUFFER_SIZE 

	encoding 参数指定打开时的字符编码'GBk'.例：open(r+,encoding='GBK')
	errors  无法理解编码时错误反回。例：open(r+,encoding='GBK',errors='ignore')
		ignore:忽略错误，
		strict:严格模式。
##############################################################################
文件对象操作：
	f.fileno() 反回当前文件描述符。
	f.isatty() 是否交换方式打开。
读相关：read(), readline(),readines(),readable()
		read() #读取所有字符｜字节。参数，数字。
		readline() #读取所有行.
		readlines() #一次读入多行。例 readines(['123\n','asf\n'])
		readable() #判断是否可读。
写相关：write(), writelines() ,writeable()
关闭： close() closed#判断是否关闭。
文件指针相关： seek(),tell(), seekable()#判断是否有指针返回。
f.seek(p,0)  移动当文件第p个字节处，绝对位置
f.seek(p,1)  移动到相对于当前位置之后的p个字节
f.seek(p,2)  移动到相对文章尾之后的p个字节
清空文件： truncare() #从文件指针处开始向后请空。例：truncare(3)
获取信息： fileno()	encoding #open()参数 errors #open()参数。
缓冲区： flush()  line_buffering()

#############################################################################
seek(15,0)# 指针从0向后移动15字符。支持字符和文本
seek(-15,1)#指针从当前位置向首移动15字符。只支持字符。
seek(12,2)#从尾步向后移动12个字符。只支持字符。
###########################################################################################################
stringIO() 把一个字符封装成一个文件对像。
BytesIO() 把一个bytes封装成一个文件对象。

with open('a.txt') as f:
	print(f.readlines()) #退出自动关闭打开的文件。

---

函数：
定义：组织好的，可重用的，功能单一的。
性质：输入　输出。
存储方式：值保存在栈空间，引用保存在堆空间中。
作用域：
	函数是python最小作用域中。
	全域作用域－>函数之外的，参数列表里的（但名子不是函数参数的名）
	函数作用域－>函数内定义的。

定义：def fn (x):
	pass
	return #函数只能返回一个值，如果后面有逗号分隔的值，会自动的封包在一个元组。可以有多个return但只会执行一个。
函数流程：
	内存分区：堆，栈，指令区，静态区，保留区。
	堆：	随机访问，用于保存数据。
	栈：	先进后出，用于保存现场（就是当前命名空间的地址）
	指令区：顺序访问，用于存储程序指令。
###############################################################################
可变位置参数：不知道有多少个参数。
	def fn(*age):
		print(age)
	fn('a',1,2,3,4,5,'dafds')
可变关键字参数：可变关键字参数，使用**定义，在函数体内，可变关键字参数是个字典。	def fn(**kwargs):
		print(kwargs)
	fn({'a':1,'b':2,'c':3,'d':4})
混合使用：
	def fn(*a,**dice):
		print(a,dice)
	#a是个列表，dice字典。
###############################################################################
参数棤(命名参数)：
	def fn(a,b,*,c):
		print(a,b,c)
	＃c必须以关键字参数的形式传递。
	例：fn(1,2,c=3)
类形示意python3.5才有：
	def add(x:int,y:int)->int:
		return x+y　＃ 只是用来描述。
	#help(add) #输出定义的方式。
#############################################################################
函数递归。
	def fid(n):
		if n==0:
			return 1
		if n==1:
			return 1
		return fid(n-1)+fid(n-2)
	#函数内调用自身，就是递归。例如fid(n-1)因为反复调用自己，所以很容易进入死徇环。每次调用fid函数都会把函数压入𣏾中。
函数的递归的层次默认为１０００次。
查看递归最大次数：
	import sys
		sys.getrecursionlimit() #输出递归深度次数。
		sys.setrecursionlimit(2000) #设置递归深度值。
#############################################################################
生成器：
	def gen():
		yield 0 #生成器返回值。
	g=gen()
	next(g) #取值。
		#与函数区别在于yield。
 #生成器的定义和函数类似，但是有yield语句，生成器执行到yield时候会暂停，下次next时会继续执行。
 yield，弹出值，暂停函数。return返回值，并且结束函数。当yield和return同时存在时,return 的返回值会被怱略，但return 依然可以结束生成器。

 生成器应用：
 	def counter(init):
		c=init
		while True:
			yield c
			c+1
	c=counter(0)
	next(c) #会－直输出。

---

高阶函数：
函数复制重命名（调用）
例：def default_cmp(a,b):
	return a+b
    cmp=default
    cmp(10,1)
函数闭包：
def make(init):
	counter=[inint]
	def inc():
		counter[0]+=1
	def dec():
		counter[0]+=1
	return inc,dec
a,b=make(0)
a()
a()
b()
#############################################################################
柯里化函数：
def add(x):
	def add(y):
		return x+y
	return add
###########################################################################
匿名函数：
	＃只能写在一行上，表达式的结构是返回值。
	例：add=lanmbda x,y:x+y
	    add(3,5)
	   ####################################
偏函数：
	import functools
	int=functools.partial(int,bass=16)#修改int()的默认值。
	print(int(15))
################################################################################
装shi器：
	本质是函数，接受一个函数作为参数并返回一个函数。
	＃通常会返回一个封装函数，这个封装函数在传入的前后作一些事情。
	例：
	def deco(func):
		return func
	@deco
	def foo(n):
		return n
	foo(10)
	例２：
	 import time
	  def timeit(n):
	  	def wrap(*a,**b):
			start=time.time()
			ret=n(*a,**b)
			print(time.time()-start)
			return ret
		return wrap
	  ############################
	  @timeit
	  def fn(n):
	  	time.sleep(n)
		return n
############################################################################
带参数的装shi器：
from functools import wraps
def ce( c=False):
    if c:
        print(c)
    def ceshi (n):
	wraps(n)
        def a (*ags):
            ref=n(*ags)
            return ref
        return a
    return ceshi

@ce(True)
def foo():
    x=1000
    return x
print(foo())
###########################################################################

---

类声明：
class ceshi:
	var=3	#类变量
	__a=3	#私有类变量
	def __int__(self,number): #类初始化
		return number+2
	def a(self):	#实例方法
		print (123)
	@classmethod	#类方法
	def b(self):
		return 'hello word'
	@property	#类属性
	def c(self):
		return 'hello'
	@staticmethod	#静态方法：只能在类内访问。
	def d(self):
		return self.var
	@c.setter	#修改类属性，时调用此方法。
	def c(self):
		return 12
类继承：单继承，多继承。
super(父，sele).方法（）#如果子类，重写父类的方法，又要调用父类方法。
##########################################################################
继承C3算法：
class C(A,B)=>
mro(C)=[C]+merge([A,O],[B,O],[A,B]) # obje为默认继承
mro(C)=[C,A]+merge([O],[B,o],[B]) #
mro(C)=[C,A,B]+merge([O],[O])
mro(C)=[C,A,B,O]

########################################################################
if __name__=='__main__':
    try:
        for i in a.open_file('/var/log/nginx/access.log-20160810'):
            print(i)
    except KeyboardInterrupt: #异常捕获。
        print('out exec!')
    finally:
    	print('error') #最后执行。
错误重定义：try 到except内的代码。如果接收到ctrl+C则执行print('out exec!')
	常用错误：
		BaseException #所有错误的父类。
		Exception 	#通常错误。
		GeneratorExit #生成器结束.
		KeyboardInterrupt #键盘结束
		SystemExit 	#系统退出
raise Exception(i<0)#主动抛出异常。
		

---

__add__ #+法 +法支持
__len__ #长度len() len函数支持。
__hash__ #hash()方法支持
__bool__ #bool支持。
__call__ #可调用（）
__str__ (self)#返回字符串
__repr__(selif) #类默认返顺格式化.
	return '{}sdfsdf'.format('name')
__enter__(self) #conext 上下文管理需要，进入setup前执行。一般用来建立连接。
__exit__(self,*args,**kwargs) # 退出时执行一般用于退出时clos
##########################################################################
类——装饰器:
例：把类封装成一个函数：
from functools import wraps #此模块的作用把传入的函数的属性传给实例。
import time
class Time:
    def __init__(self,fn):
        self.wapped=wraps(fn)(self) #此时实例有函数的属性。
    def __call__(self, *args, **kwargs): #args接受传入的参数。1,2
    	print(self[0]+self[1])	#__call__是类支持实例方法的必要。有括号则执行此处。
@Time				#类装饰器。
def ce ():
    pass
ce(1,2)				#传入参数
###########################################################################
#conext上下文管理。进入先执行__enter__,退出执行__exit__,使用with
#应用：需要成对出现，并且确保两个都执行。
	资源的打开和关闭。
	加锁、解锁
	离开代码块要执行一些操作的
class Open:
    def __init__(self,file):
        self.file=file
    def __enter__(self):
        print('sdf')
    def __exit__(self, exc_type, exc_val, exc_tb):
        print('sdfssd')
with Open('2a.py') as f:
    print(f)
￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥
import contextlib
@contextlib.contextmanager
def ceshi():
    try:
        #a=print('hello')
        print('sdfsd')   #
        yield  'sdf'
    finally:
        print('yuan_lai_ruci')
c=ceshi()
with c as f:
    print(f)
#############################################################################
反射：使用代码获取对象本身的一些属性。
例如对象的字段和方法等。
__class__ #当前对象的类名。
__dict__ #实例或对象当前的所有变量，方法。
__dir__ #dir函数实际调用此函数。
__doc__ #文档字符串。
__module__ #当前对象所在的模块。
__getattr__(self,name,default=None) 
	return 'abc' #当getattr()的方法不存在时，返回此字符串。
__getattribute__ #在方法存在时自定义返回。

getattr('实例名','方法') #没有此属性时返回此方法。
setattr('实例名','方法','值') #通过属性名修改属性的值。
delattr('实例','属性') #删除属性
#########################################################################
描述器：
	当一类变量，具有__set__,__get__方法时。用来设置类的属性
class miaoshu:
    def __set__(self,a,b):
        self.a=b
        print(self.a)
    def __get__(self,a,b):
        return self.a
    def __delete__(self, instance):
        del self.a
class d:
    name=miaoshu()
    #print(name)
D=d()
D.name='asdfasdf'
print(D.name)
del D.name
print(D.name)
#############################
有__call__为装饰器
 __set__,__get__为描述器。
 __enter__,__exit__为上下文管理
 ############################################################################
元编程：
	__new__(cls) 初始化实例，__new__ --> __init__

---

nc -l 1234 创建一个监听端口（bash）
import socket
so=socket.socket()#创建 一个socket对象
	#常用参数：
	family =IP
	type=SOCK_STREAM #工作模式TCP
	conn=so.connect(('127.0.0.1',1234)) #创建connect对象参数为连接地址。
	so.send() #传送的数据，要求是beys.
	例：so.send(json.dumps(data).encode()) #json后再转为beys
import struct #转为二进制。
	data={'a':1}
	data1=json.dumps(data).encode()
	length=len(data1)
	p=struct.pack('<l{}s'.format(length)，length,data1)
	#<表示小端，l表求长度，s表示多少字符。
	so.send(p)
	#接收
	buf=so.recv(4)
	length,*_=struct.unpack('<l',buf)
	length,*_=struct.unpack('<l',p)
	buf=so.recv(length) 
	data,_=struct.unpack('<l{}s'.format(length).buf)
	data=json.loads(data.decode()) 
##########################################################################
socketserver #支持tcp udp unix
from socketserver import BaseRequestHandler
from socketserver import ThreadingTCPServer #基于线程的tcpserver

class MasterHandler(BaseRequestHandler):
    def handle(self):
        self.data = self.request.recv(1024).strip() #接收
        print("{} wrote:".format(self.client_address[0]))
        print(self.data)
        self.request.sendall(self.data.upper()) #发送

if __name__ == "__main__":
    HOST, PORT = "localhost", 9999
    #server = TCPServer((HOST, PORT), MasterHandler) #绑定IP端口，类
    server = ThreadingTCPServer((HOST, PORT), MasterHandler) #绑定IP端口，类
    server.serve_forever() #开启监听

---

安装模块
pip install paramiko
from paramiko import SSHClient
from paramiko import AutoAddPolicy
client=SSHClient() #实例化对像
client.load_system_host_key()
client.set_missing_host_key_policy(AutoAddPolicy())
client.connect('192.168.99.162',username='root',password='h2mGX!@#2016')
stdin,stdout,stderr=client.exec_command('ls -l')
print(stdout.read())

---

此模块为内置，替换了os.system()
import subprocess
from subprocess import Popen

with Popen(['/bin/bash','-l','-c','ls -l /etc && echo OK'],stdout=subprocess.PIPE,stderr=subprocess.STDOUT) as p:
        p.wait()
        print(p.communicate())  #把结果和错误以元组方式返回。
start_new_session=True 参数：没查
#subprocess.PIPE把结果管道给输出，stderr错误合并给stdout

#
with Popen(['/bin/bash','-l','-c','ls -l /etc && echo OK']) as p:
         p.wait() #执行进程结束。可接受参数数字，表示在几秒内执行不完则退出。
         print(p.stdout()) #不使用管道输出标准结果。
	 p.stderr() #输出标准结果和标准错误。
	 p.pid()  #输出标进程pid
	 p.p.returncode #返回结果码
#########################################################
Popen 常用参数
	stdin:输入
	stdout : 输出。
	cwd:在哪个目录执行命令。
	env:传入环境变量
	shell:在字符串时有用，在使用列表为参数时没啥用处。

---

安装：pip install kazoo
from kazoo.client import KazooClient
import logging
logging.basicConfig(level=logging.INFO)
########################创建连接。
client= KazooClient(hosts='127.0.0.1:2181')
client.start()
#######################创建nodes
client.create('/test',value=b'123456') #目录存在则报错
client.ensure_path('/test') #目录存在不报错，但不能赋值
#########################数据操作：
client.get('/test') #取值反回元组，值和状态。
#状态
	#ctime 创建时间
	#mtime  修改时间
	#cversion 创建时的version
	#numChildren 子节点数
#判断是否存在存在返加状态值，不在返回空
client.exists('/test')
#返回当前目录下的子节点名子：
client.get_children('/test1') #返回列表。
############################设置值。
client.set('/test1',value=b'a12345')
##########################删除节点
client.delete('/test1/c2',recursive=True) #删除目录，recursive是否递归
###########################事务支持：
 ta=client.transaction() 
 ta.delete('/test1')  #删除目录
 ta.commit() #提交事务。\
	 #事务对应方法：
 	check()对应exists 
	create()对应create
	delete()对应delete
#######################################数据和目录监听变化。
from kazoo.client import KazooClient
from kazoo.recipe.watchers import DataWatch,ChildrenWatch
import logging
import threading
client = KazooClient(hosts='127.0.0.1:2181')
client.start()
client.set('/test1', value=b'12345')
def watch(data, stat, event):
    print(data)
    

dw = DataWatch(client, '/test1', func=watch) #监听节点数据有变化时调用watch函数,当watch反加一个False时结束监听
event = threading.Event()
try:
    event.wait()
except KeyboardInterrupt:
    event.set()
###############################################################监听目录子目录数有变化时执行
from kazoo.client import KazooClient
from kazoo.recipe.watchers import DataWatch,ChildrenWatch
import logging
import threading
client = KazooClient(hosts='127.0.0.1:2181')
client.start()

def watch_children(children):
    print(client.get_children('/test1'))
    print(children)

ChildrenWatch(client, '/test1', func=watch_children)

event = threading.Event()
try:
    event.wait()
except KeyboardInterrupt:
    event.set()
#############################################################################

---

