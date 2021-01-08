# 环境

#### pyenv安装

作用：版本切换

```bash
yum -y install git gcc make patch zlib-devel gdbm-devel openssl-devel sqlite-devel bzip2-devel readline-devel
#pyenv安装：
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
vim /etc/profile.d/pyenv.sh 添加
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)
```

##### 命令：

```bash
commands #列出命令
local	 #切换版本 例如pyenv 3.5.2
versions #列出支持的python版本。
version	 #列出现用的python版本。
install  #安装python 例如：pyenv install 3.5.2
uninstall #卸载python 例如：pyenv uninstall 3.5.2
--list 	#列出所有版本。
update	#更新pyenv
#安装python:
mkdir ~/.pyenv/cache
#下载Python-3.5.2.tar.gz放置此目录。执行pyenv install
#因为是编译安装：所以要装好：
gcc make patch gdbm-devel openssl-devel sqlite-devel zlib-devel bzip2-devel readline-devel
```

---

### pip安装：

```bash
wget "https://pypi.python.org/packages/source/p/pip/pip-1.5.4.tar.gz#md5=834b2904f92d46aaa333267fb
tar -xzvf pip-1.5.4.tar.gz
cd pip-1.5.4
python setup.py install
```

#### 更换源

```bash
#创建目录 mkdir ~/.pip
#编辑 ~/.pip/pip.conf, 输入一下内容
[global]
index-url = http://mirrors.aliyun.com/pypi/simple/
trusted-host = mirrors.aliyun.com
```

### 安装ipython

```
pip install ipython
pip search ipython
```

### pycharm

ide环境：pycharm |idea eclipse vim(jedi命令补全) jupyter

# python

### hello word

```python
#!/usr/bin/python	
 print('hello word')
```

### 运算符：

算术运算符： + - * /(自然除) %  //（齐整除） **（次方）
比较运算符： == != > >= < <= 
		整形可直接与浮点

### 逻辑运算符：

and 与
or 或 1 or 1=1 ,1 or 0= 1, 0 or 0 =0
not 非
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

#### 运算优先级：

​	次方运算高于乘，算术运算符高于比较运算符、比较运算符高于逻辑运算符。（）优先级最高

#########################################################################

### 控制结构

#### if

```python
#单分支结构：if cond:
			block
#列如：
if 1<2
	print('hello work')
#多分支结构：
if cond
			block
elif cond
			block
elif cond
			block
else
			block
```

#### while

```c++
#循环结构：
		wlile for
		wlile cond
			block
		else
			print('back while')
#例如：
a=0
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
#例如：
for i in range(0,100):
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
```

---

### 数据转换

​	bool() 布尔值
​	int()	整数 int(0011,2) 二进制转整形
​	bin()	二进制
​	float() 浮点型



### 数组：

内置数据结构｜容器
列表、元组、字符串：线性结构（可切片操作，解包封包）
集合、字典：非线性结构。
解析式：列表解析，生成器解析，集合解析，字典解析。

#### 列表：

```python
lst=list() #初始化一个空列表。
lst=[] 	#初始化一个空列表。
list=[1,2,3,4] #创建一个有值的列表。
#索引操作：
lst[0]	#取出第一个元素。
lst[0]='a'	#修改第一个元素的值。
#列表增加元素方法：
append()	#：尾部追加一个元素。
 lst.append(12)
insert()	#:指定位置插入元素。
lst.insert(0,7)	#在第一个索引前插入一个7的元素。
	#注当插入索引值大于当前索引时会在尾部追加。
extend()	#:追加多个元素。
lst.extend(['a','b','c'])
#列表删除元素：
pop()		#:从最后移除一个元素。
lst.pop()	#返回移除的元素值。
remove()	#删除指定元素值，如果有多个重复值，删除最前索引。
lst.remove('a')
clear()		#:删除所有元素。
lst.clear()
#查找统计元素：
index()	#跟据值找索引。
count()	#:查找列表有多少指定元素。
lst.count('b')
len()	#函数，返回无数个数。
#修改：
sort()	#对列表的全部元素进行重新排序，会改变原有列表。
lst.sort()
lst.sort(reverse=True) #倒排。
reverse()	#对列表进行反转。
lst.reverse()
copy()	#复制一个列表。
lst2=lst.copy()
```



#### 有限列表

```python
from collections import deque
q=deque(maxlen=10) #定义队列q的最大队列长度为10。
q.append(1)	#尾度追加一个元素。
q.appendleft() #首部追加一个无素。
q.popleft()	#首部出zhan
```

### 元组：

不可变的列表。

```python
#创建元组：
t=tuple()
t=()
t=(1,2,3)
#方法：
count()	#：查看指定元素个数
t.count(1)
index()	#:查看第几个元素。
```

### 切片操作：

```python
lst[0:3]	#:输出0-3个元素值。
lst[2:-5]	#:输出第二到倒数第五个元素的值。
lst[:]		#:输出全部元素。
lst[::2]	#:输出0，2，6.。。元素。2表示步进
lst[-1:0:-1]	#：切片反转.注意启始是结尾，终是开始 ，步进是-1
#不建议对切片进行赋值。
```

### 解包、封包

```python
	a=2
	b=3
	a,b=b,a #此时就用的解包。
#解包：
	x,y=[1,3]	#x=1 y=3
	x,y=1,3		#y=3 x=1 支持直接变量，支持列表取值。
#封包：
	t=1,3		#t=(1,3) 此时t会是个元组。
#解包：
h,*b=list(range(0,10)) # h=0 b=[1,2,3,4,5,6,7,8,9]
#总结：解包把集合里的元素复制给变量。
#封包：把变量构建元组。
#例：
	lst=list(range(0,10))
	a,b,_,c,*=lst
	#a=0,b=2,c=4 _丢弃的值。
#多元列表解包：
	lst=[1,2,3,['a','b','c'],4,5]
	a,_,_,(b,*_),_,d=lst
#a=1 b=a *_表示后面丢弃。
```

### 字符串：

字符串是不可变的：

```python
s='fengzi'
s[0] #f
```

#### 连接：

​	join:	比+号拼接效率更高。

```python
lst=['my','name','is','yingxiong']
		‘' '.join(lst)
		#'my name is yingxiong'
		','.join(lst)
```

#### 分隔：

#### split	

左分隔

```python
line='url:http://www.mageedu.com'
key,value=line.split(':',1) #用：号进行分隔。只分隔一次。
```

#### splitlines

splitlines(True) 保持换行符分隔。

#### partition

partition(':',1)	# 保持换行符左分隔

rpartition()		#保持换行符右分隔。

#### 字符串修改：

​	自然语言修改：

##### capitalize

​	capitalize() 行首字母大写。

##### title

​	title()每单词首字母大写。

##### lower

​	lower()全部转小写

##### upper

​	upper()全部转大写。

##### swapcase

​	swapcase()大小写互换。

#### 程序世界的修改。

##### center

​	center（）#居中显示
​	例：s.center(80,'#') #占80个字符并居中，左右用#填冲。

##### ljust	

ljust()	左补全参数同上。

##### rjust

rjust() 右补全参数同上。

##### zfill

​	zfill() 只有一个参数。用0补全。

##### strip

​	strip() 移除占位符，制表符，空白符

##### lstrip

​	lstrip() 左移除。

##### rstrip

​	rstrip()右移除。

#### 字符判断：

##### startswith

startswith()	#判断是否以一个字符串开头并包含
	例：s.startswith('wangqinfeng'5) #判断从第五个字符串后是否是wangqinfeng

##### endswith

endswith()	#从尾部开始第几个字符。

##### isupper

isupper()	#判断所有字符串为大写。

##### islower

islower()	#判断所用字符串为小写。

##### isdigit

isdigit()

##### isalnum

isalnum()

##### isprintable

isprintable()	#是否可打印。

##### isinstance

isinstance(a,int) #判断是否为整型

#### 查找替换：

##### count

count():	例出指定字符串的个数。

##### find

find():		查看指定字符串出现的次数。

##### rfind

rfind()		从右开始

##### index

index():	与find相同，只是在找不到字符串时返回错误。

##### replace

replace()	字符替换
		例：s.replace('a','c',1) #表示只把第一次出现的a替换为c.
					-1表示全部替换。默认为全部替换。
###########################################################################

### 格式化输出：

#### printf:

```python
print('i is %(name)s,%(name)s'%{'name':'fengzi'})
#K引用		   K	  V	#输出会把fengzi 替换name
print("my name is %s"%("fengzi"))
  %s：#字符串
	%d:	#整数，同%i,%u一样。
	%o:	#转为八进制出输。
	%x	#转为十六进制输出。
	%e	#浮点数输出
	%f	#浮点数输出，保存后六位。
	%c	#字符输出。
	%a	#转为Acsl码
#固定宽度.
	'%3f'%(0.12345)
	'%4.3%'%(1234.12345)
	'%-4d%'%(12345123)
	'%+4d%'
```

#### format

```python
#format方法输出格式化：
1、'my is {}'.format('tom') #输出替换{}内替换为tom
2、'my is {1},my love {0}'.format('fengzi','ruili')
3、'my is {name},my love {love}'.format(name='fengzi',love='ruili')
4、‘'my is {0[0]}'.format(lst) #传入lst[0]个元素。
#二、距中规则：
	>	#右对齐
	<	#左对齐
	=	#用于数字0补齐
	^	#居中对齐
#例：
'{0:^80}'.format('马哥教育')
'{0:>80}'.format('马哥教育')
'{0:<80}'.format('马哥教育')
'{0:=80}'.format(12)
'{name:=80}'.format(name=12)
#正负数值显示：
'{0:+}'.format(100)
'{0:-}'format(100)
```

### bytes

```python
bytes：#python特有，用于网络传输，的转码。
ceshi=b'abcedef'	#商明一个byte
#字符串转bytes
#因为字符串不能直接传入网络。
a='fengzi'
a.encode() # b'\xe9\xa9\xac\xe5\x93\xa5\xe6\x95\x99\xe8\x82\xb2'byte码。
a.decode() #把byte码转为字符串。一般用于接收到的数据转为可视的字符串。
#可接受的参数：字符集如：gbk utf-8 #a.decode('UTF8')|a.decode('GBK')
#bytearray与bytes用法一样，只是可字节可以更改。
#查看字符编码号：b'wo'.hex()转为十进制int(b'wo'.hex(),16)
```



### datetime

```python
datetime.datetime.now() #以元组型式反回当前时间。
datetime.datetime(2016,5,6)strftime()#可以用来获得当前时间，可以将时间格式化为字符串等等
#格式命令列在下面：（区分大小写）
%a #星期几的简写
%A #星期几的全称
%b #月分的简写
%B #月份的全称
%c #标准的日期的时间串
%C #年份的后两位数字
%d #十进制表示的每月的第几天
%D #月/天/年
%e #在两字符域中，十进制表示的每月的第几天
%F #年-月-日
%g #年份的后两位数字，使用基于周的年
%G #年分，使用基于周的年
%h #简写的月份名
%H #24小时制的小时
%I #12小时制的小时
%j #十进制表示的每年的第几天
%m #十进制表示的月份
%M #十时制表示的分钟数
%n #新行符
%p #本地的AM或PM的等价显示
%r #12小时的时间
%R #显示小时和分钟：hh:mm
%S #十进制的秒数
%t #水平制表符
%T #显示时分秒：hh:mm:ss
%u #每周的第几天，星期一为第一天 （值从0到6，星期一为0）
%U #第年的第几周，把星期日做为第一天（值从0到53）
%V #每年的第几周，使用基于周的年
%w #十进制表示的星期几（值从0到6，星期天为0）
%W #每年的第几周，把星期一做为第一天（值从0到53）
%x #标准的日期串
%X #标准的时间串
%y #不带世纪的十进制年份（值从0到99）
%Y #带世纪部分的十制年份
%z，%Z #时区名称，如果不能得到时区名称则返回空字符。
%% #百分号
```

### 目录：

```python
 import os
 #切换目录：
os.chdir('/home')
 #创建目录：
os.mkdir('/tmp/test')#创建目录。
os.makedirs('/tmp/a/b')#递归创建目录。
#参数：
	exist_ok=True #目录存大不抛出错误。
	mode=(0o644) #设置目录权限。
#删除目录：
os.rmdir() #删除目录，不可递归删除。
os.removedirs() #递归删除空目录。
os.geteuid()	#返回当前用户的ID
import os 
			for root,dirs,file in os.walk('/tmp'):
				print(root,dirs,file)
os.scandir()
#路径相关操作：
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
		print(os.path,abspath(os.path.dirname(sys.argv[0]))) #获取决对地址
```

```python
import shutil #shell库_系统调用。
shutil.rmtree('/tmp/test')#相当于bash的rm -rf
#参数：
				ignore_errors=True #关闭错误输出。
				onerror=lambda,fn,path,exc_info:print(path,exc_info[1])
#移动目录：import shutil 
		shutil.move('/tmp/test','/tmp/a') #移动目录。
#复制目录：import shutil
		shutil.copy() #复制数据和数据权限。
		shutil.copy2() #复制数据与stat info (权限，atime,ctime,mtime,flags)
		shutil.copyfile() #复制数据
		shutil.mode()	#复制权限
			#参数：
				symlinks=True #如果有链接，复制链接。
#目录遍历：
	import os
		os.listdir()	#列出当前目录，返回列表。
		os.path.isdir()	#判断是否为一个目录。
		os.path.join()	#类字符的join。
		os.walk()	#遍历当前目录。
			os.walk('tmp') #返回一个生成器。
```

### 序列化与反序列化:

​	序列化：对象->str/bytes
​	反序列化：str|bytes->对象

#### pickle

```python
import pickle 序列化，只能用于python使用。并且版本要求一样。
	常用序列化：
		import pickle
			pickle.dump()	#把对象序列化到文件。支持（int,float,str,list,dict,bool,None）
			pickle.dumps()	#直接序列化，并不同步到文件。
			pickle.load()	#从文件转为非序列化。
			pickle.loads()	#直接反序列化。
```

####  json	

```python
import json 		#常用序列化。
#对应：python:json
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
```

### 文件属性

文件属性：os.stat

isinstance() 类型判断检查，例：isinstance(a(int,str))
enumerate() 取出值和索引.例：a,b=enumerate([1,2]) 以元组类型返回索引和元索。

堆：二衩树
	大顶堆：父节点总比子节点（左右两节点）大.
	计算：
	左节点：data[i].left=data[2i+1]
	右节点：data[i].right=data[2i+2]
	父节点：data[i].parent=data[flool((i-1)/2)] #堆的用处：优先队列

### 文件IO

IO于文件操作
文件打开--文件对象--读写关闭。

```python
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
```

#### buff

```python
查看默认buffer大小：
import io
 io.DEFAULT_BUFFER_SIZE 
```

#### 指定编码打开：

encoding 参数指定打开时的字符编码'GBk'.例：open(r+,encoding='GBK')
errors  无法理解编码时错误反回。例：open(r+,encoding='GBK',errors='ignore')
	ignore:忽略错误，
	strict:严格模式。

#### 文件对象操作：

##### 	fileno

​	f.fileno() 反回当前文件描述符。

##### 	isatty

​	f.isatty() 是否交换方式打开。

#### 读相关

读相关：read(), readline(),readines(),readable()

##### read

​		read() #读取所有字符｜字节。参数，数字。

##### readline

​		readline() #读取所有行.

##### readlines

​		readlines() #一次读入多行。例 readines(['123\n','asf\n'])

##### readable

​		readable() #判断是否可读。

#### 写相关

写相关：write(), writelines() ,writeable()

##### write

##### writelines

##### writeable

#### close

关闭： close() closed#判断是否关闭。

#### 文件指针相关

##### seek(),tell(), seekable()

文件指针相关： seek(),tell(), seekable()#判断是否有指针返回。
f.seek(p,0)  移动当文件第p个字节处，绝对位置
f.seek(p,1)  移动到相对于当前位置之后的p个字节
f.seek(p,2)  移动到相对文章尾之后的p个字节

#### 清空文件

truncare() #从文件指针处开始向后请空。例：truncare(3)
获取信息： fileno()	encoding #open()参数 errors #open()参数。

#### 缓冲区

 flush()  line_buffering()

stringIO() 把一个字符封装成一个文件对像。
BytesIO() 把一个bytes封装成一个文件对象。

```python
with open('a.txt') as f:
	print(f.readlines()) #退出自动关闭打开的文件。
```

### 函数：

定义：组织好的，可重用的，功能单一的。
性质：输入　输出。
存储方式：值保存在栈空间，引用保存在堆空间中。

#### 作用域：

​	函数是python最小作用域中。
​	全域作用域－>函数之外的，参数列表里的（但名子不是函数参数的名）
​	函数作用域－>函数内定义的。

#### 定义：

def fn (x):
	pass
	return #函数只能返回一个值，如果后面有逗号分隔的值，会自动的封包在一个元组。可以有多个return但只会执行一个。

#### 函数流程：

​	内存分区：堆，栈，指令区，静态区，保留区。
​	堆：	随机访问，用于保存数据。
​	栈：	先进后出，用于保存现场（就是当前命名空间的地址）
​	指令区：顺序访问，用于存储程序指令。
​	可变位置参数：不知道有多少个参数。

```python
def fn(*age):
		print(age)
fn('a',1,2,3,4,5,'dafds')
```

#### 可变关键字参数

可变关键字参数，使用\**定义，在函数体内，可变关键字参数是个字典。

```python
def fn(**kwargs):
print(kwargs)
fn({'a':1,'b':2,'c':3,'d':4})
```


混合使用：

```python
	def fn(a,**dice):
		print(a,dice)
	#a是个列表，dice字典。
```


参数棤(命名参数)：

```python
def fn(a,b,*,c):
		print(a,b,c)
#c必须以关键字参数的形式传递。
#例：
  fn(1,2,c=3)
```

#### 参数类形示意

```python
#类形示意python3.5才有：
	def add(x:int,y:int)->int:
		return x+y　＃ 只是用来描述。
	#help(add) #输出定义的方式。
```

#### 函数递归。

函数内调用自身，就是递归。

```python
def fid(n):
		if n==0:
			return 1
		if n==1:
			return 1
		return fid(n-1)+fid(n-2)
```

例如fid(n-1)因为反复调用自己，所以很容易进入死徇环。每次调用fid函数都会把函数压入𣏾中。
函数的递归的层次默认为１０００次。

#### 查看递归最大次数：

```python
import sys
		sys.getrecursionlimit() #输出递归深度次数。
		sys.setrecursionlimit(2000) #设置递归深度值。
```

#### 生成器：

```python
def gen():
		yield 0 #生成器返回值。
	g=gen()
	next(g) #取值。
#与函数区别在于yield。
#生成器的定义和函数类似，但是有yield语句，生成器执行到yield时候会暂停，下次next时会继续执行。
 yield
#弹出值，暂停函数。return返回值，并且结束函数。当yield和return同时存在时,return 的返回值会被怱略，但return 依然可以结束生成器。
```



######  生成器应用：

```python
def counter(init):
		c=init
		while True:
			yield c
			c+1
	c=counter(0)
	next(c) #会－直输出。
```

#### 高阶函数：

##### lanmbda

​	＃只能写在一行上，表达式的结构是返回值。
​	例：add=lanmbda x,y:x+y
​	    add(3,5)

##### 偏函数：

```python
import functools
int=functools.partial(int,bass=16)#修改int()的默认值。
print(int(15))
```

#### 装饰器：

​	本质是函数，接受一个函数作为参数并返回一个函数。
​	＃通常会返回一个封装函数，这个封装函数在传入的前后作一些事情。

```python
#	例：
	def deco(func):
		return func
	@deco
	def foo(n):
		return n
	foo(10)
#例２：
	 import time
	 def timeit(n):
	  	def wrap(*a,**b):
			start=time.time()
			ret=n(*a,**b)
			print(time.time()-start)
			return ret
		return wrap
//
	  @timeit
	  def fn(n):
	  	time.sleep(n)
		return n
```



#### 带参数的装饰器：

```python
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
////////////////////////////////
@ce(True)
def foo():
    x=1000
    return x
print(foo())
```

### 类

##### 类声明：

```python
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

```

#### 类方法

```python
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
```

##### 类继承：

单继承，多继承。

super(父，sele).方法（）#如果子类，重写父类的方法，又要调用父类方法。

#### 类——装饰器:

例：把类封装成一个函数：

```python
from functools import wraps #此模块的作用把传入的函数的属性传给实例。
import time
class Time:
    def __init__(self,fn):
        self.wapped=wraps(fn)(self) #此时实例有函数的属性。
    def __call__(self, *args, **kwargs): #args接受传入的参数。1,2
    	print(self[0]+self[1])	#__call__是类支持实例方法的必要。有括号则执行此处。

```

```python
@Time				#类装饰器。
def ce ():
    pass
ce(1,2)				#传入参数
```

#### conext

conext上下文管理。进入先执行__enter__,退出执行__exit__,使用with
应用：需要成对出现，并且确保两个都执行。
	资源的打开和关闭。
	加锁、解锁
	离开代码块要执行一些操作的

```python
class Open:
    def __init__(self,file):
        self.file=file
    def __enter__(self):  
        print('sdf')
    def __exit__(self, exc_type, exc_val, exc_tb):
        print('sdfssd')
with Open('2a.py') as f:
    print(f)
```

##### contextlib

```python
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
```

##### 反射

使用代码获取对象本身的一些属性。
例如对象的字段和方法等。

```python
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
```

#### 描述器：

当一类变量，具有__set__,__get__方法时。用来设置类的属性

```python
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
#有__call__为装饰器
#__set__,__get__为描述器。
#__enter__,__exit__为上下文管理
```

 ############################################################################

#### 元编程：

```python
	__new__(cls) 初始化实例，__new__ --> __init__
```

```bash
nc -l 1234 创建一个监听端口（bash）
```

### 异常

```python
if __name__=='__main__':
    try:
        for i in a.open_file('/var/log/nginx/access.log-20160810'):
            print(i)
    except KeyboardInterrupt: #异常捕获。
        print('out exec!')
    finally:
    	print('error') #最后执行。
```

错误重定义：try 到except内的代码。如果接收到ctrl+C则执行print('out exec!')

#### 常用错误：

```python
BaseException #所有错误的父类。
Exception 	#通常错误。
GeneratorExit #生成器结束.
KeyboardInterrupt #键盘结束
SystemExit 	#系统退出
raise Exception(i<0)#主动抛出异常。
```




### socket

```python
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
```

```python
import socket,asyncio,time,struct,json
#sockt创建 socket(sockt_family,socket_type,protocol=0)
#               sockt_family:   AF_UNIX|AF_INET
#               socket_type:    SOCK_STREAM|SOCK_DGRAM
#常用方法：
    #服务端套接字
        #s.bind()       绑定套接字
        #s.listen()     监听套接字 s.listen(5)表示连接失败最大次数。
        #s.accept()     阻塞等待tcp连接
    #客户端套接字
        #s.connect()    主动发起连接
        #s.connect_ex() 以错误代码的形式反回，而不是错误。
    #通用：
        #s.recv()       接受TCP消息
        #s.recv_info()  接受TCP消息到指定缓冲区
        #s.send()       发送TCP消息
        #s.sendall()    发送TCP所有的消息
        #s.recvfrom()   接收UDP消息
        #s.recvfrom_info() 接收UDP消息到缓冲区
        #s.sendto()     发送UDP消息
        #s.getpeername()  获取连接到套接字的远程地址
        #s.getsocketname() 获取当前的套接字
        #s.getsockopt()  返回给定套接字选项的值
        #s.setsockopt()  设置套接字选项的值
        #s.shutdown()   关闭连接
        #s.close()      关闭套接字
        #s.detach()     不关闭文件描述符关闭套接字。
        #s.ioctl()      控制套接字的模数(只支持windows)
    #面向阻塞的套接字方法：
        #s.setblocking()    设置套接字的阻塞或非阻塞
        #s.settimeout()     设置阻塞套接字的超时时长
        #s.gettimeout()     获取套接字的超时时长
    #面向文件的套接字方法：
        #s.fileno()         套接字的文件描述符
        #s.makefile()       创建与套接字关联的文件对象
    #数据属性：
        #s.family           套接字家族
        #s.type             套接字类型
        #s.proto            套接字协议
class lear_socket():
    def tcp_sockt(self):
        host=''
        port=5001
        bufsize=1024
        addr=(host,port)
        self.tcp_server=socket.socket(socket.AF_INET,socket.SOCK_STREAM) #创建TCP_SOCKT
        self.tcp_server.bind(addr)      #绑定地址
        self.tcp_server.listen(5)
        while True:
            tcpSerSock,addr=self.tcp_server.accept() #阻塞等待连接
            # tcpSerSock.recv(buffersize=bufsize)
            length=tcpSerSock.recv(4)               #在网卡缓冲中取出前4个字节（在客户端l四个字节，定义的是消息的长度）
            length,*_=struct.unpack('<l',length)    #反解析
            mes=tcpSerSock.recv(length)             #取出消息
            mes,*_=struct.unpack('<{}s'.format(length),mes) #把多少个字符转为json
            print(json.loads(mes))                   #反json
            time.sleep(1)
        tcpSerSock.close()                          #关闭连接
    def tcp_close(self):
        self.tcp_server.close()
    def udp_sockt(self):
        return  socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
if __name__=='__main__':
    tcp=lear_socket()
    try:
        tcp.tcp_sockt()
    except KeyboardInterrupt:
        pass
    finally:
        tcp.tcp_close()
```

```python
##client
import socket,json,sys,struct
d=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
host='127.0.0.1'
port=5001
data=json.dumps('我是谁？').encode()
leng=len(data)
print(leng)
d.connect((host,port))
d.send(struct.pack('<l{}s'.format(leng),leng,data)) #l表示4个字节，leng*s 的字符
d.close()
```



### socketserver

```python
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
```





```bash
#安装模块
pip install paramiko
from paramiko import SSHClient
from paramiko import AutoAddPolicy
client=SSHClient() #实例化对像
client.load_system_host_key()
client.set_missing_host_key_policy(AutoAddPolicy())
client.connect('192.168.99.162',username='root',password='h2mGX!@#2016')
stdin,stdout,stderr=client.exec_command('ls -l')
print(stdout.read())
```



### subprocess

此模块为内置，替换了os.system()

```python
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
Popen #常用参数
	stdin:#输入
	stdout : #输出。
	cwd:#在哪个目录执行命令。
	env:#传入环境变量
	shell:#在字符串时有用，在使用列表为参数时没啥用处。
```



# 常用模块

### zookeeper

```bash
#下载路径：
#http://mirror.bit.edu.cn/apache/zookeeper/zookeeper-3.4.8/
#解压
#复制conf目录下的zoo_sample.cfg,并命名为zoo.cfg
#配置：
dataDir=/datatmp/zookeeper/data
dataLogDir=/datatmp/zookeeper/logs
tickTime=2000
initLimit=10 #心跳间隔超时
syncLimit=5  #心跳相应超时
clientPort=2181 #端口
#
server.0=127.0.0.1:8880:7770
#启动：
./bin/zkServer.sh start
#查看节点状态：jps
#client:
bin/zkCli.sh -server localhost:2181 #连接到服务器

create /zk "myData" #创建节点，值是myData
get /zk 	#返回装态和值。
ls /	列出节点目录。
set /zk "abck" #设置值
delete /zk  #删除节点

```



```bash
#安装：
pip install kazoo
```

```python
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

```

```python
#监听目录子目录数有变化时执行
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
```

```python
#数据和目录监听变化。
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
```

### threading

```python
threading模块：
t1=threading.Thread() 声明一个线程实例。
	参数：target='函数名'此线程要启动的函数。
		name='定义此线程的时的名称'
		args=('传入的参数',)
		kwargs={'k':'v'} 关键字参数。传入value.
常用方法：
	t1.is_alive() #线程是否存活。
	t1.daemon=True #主线程退出是结束所有子线程。
	t1.join(3) #阻塞线程直到线程执行完成，3表示3秒执行不完则退出线程。
```

### watchdog

用于监控文件装态

```python
from watchdog.observers import Observer
from watchdog.events import LoggingEventHandler
import logging
import time
logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s - %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S')
		    #定义INFO日志格式
event_handler=LoggingEventHandler()
observer=Observer()
observer.schedule(event_handler,'/var/log/nginx',recursive=True)
observer.start()
#监控目录内文件变
from watchdog.observers import Observer
from watchdog.events import LoggingEventHandler
from watchdog.events import FileSystemEventHandler
import datetime
import logging
import time
logging.basicConfig(level=logging.INFO,format='%(asctime)s-%(message)s')
#B=LoggingEventHandler()
A=Observer()
c='b'
class Myhared(FileSystemEventHandler):
    def on_modified(self, event):
             print("hello")
             c='a'

B=Myhared()
A.schedule(B,'/var/log/nginx',recursive=False)
A.start()
```

### sqlalchemy

```python
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import  Integer, String, Column, create_engine, ForeignKey
from sqlalchemy.orm import sessionmaker, relationship


Dbmysql = declarative_base()
Session = sessionmaker()
class User(Dbmysql):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(12), nullable=False, unique=True)
    fullname = Column(String(128), index=True, nullable=True)
    password = Column(String(128), nullable=False)
    #addresses=relationship("Address",back_populates='user')
    addresses = relationship("Address",back_populates='user',foreign_keys=[Address.user_id]) #创建addresses字段，relationship()关联，“Address”创建表类名，back_populates='user'#跳至Address.user字段，foreign_keys='对应表的字段，要求是外键'


class Address (Dbmysql):
    __tablename__ = 'addresses'
    id = Column(Integer, primary_key=True, autoincrement=True)
    address = Column(String(128), unique=True, nullable=False)
    user_id = Column(Integer, ForeignKey('users.id'), nullable=False) #Foreignkey()设置外键对应另一张表的主键字段。users.id为users表的id字段，
    #user=relationship("User", back_populates="addresses")[Address(address='fengzi'),Address(address='ruili')]
    user=relationship("User", back_populates="addresses", foreign_keys=[user_id]) #User 类名， addresses 类下的字段名，foreign_keys=本表的对应外键字段名 

engine = create_engine('mysql+pymysql://fengzi:fengzi@192.168.12.105:3306/ceshi', echo=True)
Dbmysql.metadata.drop_all(engine)
Dbmysql.metadata.create_all(engine)
Session.configure(bind=engine)
session = Session()
ceshi=[Address(address='fengzi'),Address(address='ruili')] #外键表的插入要求是一个列。格式为：[类名(要插入的字段名=值，可插入多个字段),可插入多次。]
user = User(name='ruili', fullname='fengzi', password='fengzi',addresses=ceshi) #字段插入
session.add(user)			#插入至会话。
try:
    session.commit()			#事务同步至数据库
except Exception as e:
    session.rollback()			#出错时事务回滚
    raise e

#####################################################################
if 0: #select join
    ret = session.query(User).join(Address).all() #全表查询。
    for i in ret:
        c=None
        for a in i.email_addresses:
            c=a.email_address
        print(i.name, i.fullname, c) #输打印指定字段。 
if 0:
    ret = session.query(User.name).count() #count()统计行数。
    print(ret)

if 0:
    a = aliased(session.query(Address).outerjoin(User).subquery()) #subquery()子查询
    ret = session.query(a).all()	#打印所有
    print(ret)
if 1:
    for kw in session.query(User).filter(User.name.any(title='post1')).all():
        print(kw.name)  
```

### pymysql

```python
import pymysql
conn = pymysql.connect(host='127.0.0.1', unix_socket='/tmp/mysql.sock', user='root', passwd=None, db='mysql')
cur=conn.cursor()
cur.execute("select host,user from user")
cur.close()

#################################################################################################
import pymysql  
  
  
##查询  
def select():  
    conn = pymysql.connect(user='root', passwd='你的密码', host='localhost', db='test',charset='utf8',unix_socket='/var/lib/mysql/mysql.sock')  
    cur = conn.cursor()  
    cur.execute("SELECT * FROM user")  
    for r in cur:  
          print("row_number:" , (cur.rownumber) )          
          print("id:"+str(r[0])+" name:"+str(r[1])+" password:"+str(r[2]))   
    cur.close()      
    conn.close()  
  
##插入  
def insert(name,pwd):  
    conn = pymysql.connect(user='root', passwd='你的密码',  
                     host='localhost', db='test',charset='utf8')  
    cur = conn.cursor()  
    sql= "INSERT INTO user (Name,Password) VALUES ('"+name+"','"+pwd+"')"  
    print(sql)  
    sta=cur.execute(sql)  
    if sta==1:  
        print('Done')  
    else:  
        print('Failed')     
    conn.commit()  
    cur.close()      
    conn.close()  
  
##更新  
def update(name,pwd):  
    conn = pymysql.connect(user='root', passwd='你的密码',  
                     host='localhost', db='test',charset='utf8')  
    cur = conn.cursor()  
    sql= "UPDATE USER SET PASSWORD='"+pwd+"' WHERE NAME='"+name+"'""'" 
    print(sql) 
    sta=cur.execute(sql) 
    if sta==1: 
        print('Done') 
    else: 
        print('Failed')    
    conn.commit() 
    cur.close()     
    conn.close() 
 
##删除 
def delete(name): 
    conn = pymysql.connect(user='root', passwd='你的密码', 
                     host='localhost', db='test',charset='utf8') 
    cur = conn.cursor() 
    sql = "DELETE FROM USER WHERE Name='"+name+"'"  
    print(sql)  
    sta=cur.execute(sql)  
    if sta==1:  
        print('Done')  
    else:  
        print('Failed')     
    conn.commit()  
    cur.close()      
    conn.close()  
```

### re

```python

import re
s='hello word'
# 匹配正则：
#     .               匹配单字符
#     rel|rel         或匹配
#     ^               起始铆钉
#     $               尾部铆钉
#     *               多次匹配
#     +               1次或多次匹配
#     ?               0次或1次匹配
#     {N}               匹配指定次数
#     {M,N}             匹配M-N的次数
#     [abcd]          单字符或匹配
#      [^abcd]        不匹配字符
#       (...)         子组匹配
#       \d            数字匹配
#       \w            匹配字符和数字
#       \s            匹配空格
#       \b            匹配任何单词边界
class re_lear():
    def match(self):
        #re.match 匹配一个字符串开始部分，匹配返回匹配对象，未匹配返回None
        display=re.match('hello','hello word') #可以匹配。
        # display=re.match('hello','adb hello word') #不可以匹配。
        # group 打印匹配的字符串对象,span()返回匹配的匹配字符串对象的游标
        print(display.group(),display.span())
    def compile(self):
        # re.compile 返回一个正则表达式对象
        self.s_compile=re.compile(s)
    def search(self):
        #全文搜索匹配。
        re_search=re.search('hello','asd hello word')
        print(re_search.span(), re_search.group())
        re_search = re.search('h{2}', 'abh hhello word hello')  # 可以匹配。
        print(re_search.group(),re_search.span())
        print(len('abh hhello word hello'))
        re_search = re.search('h{1,2}h', 'abh hhello word hello')  # 可以匹配。
        print(re_search.group(), re_search.span())
        re_search=re.search('[^a-b].*','adb,hello word hello')
        print(re_search.group(),re_search.span())
        re_search=re.search('\w*\s','hello owr1')
        print(re_search.group())
        re_search = re.search('(\b*)\s(\b*)*', 'hello owr1')
        print(re_search.group())
    def findall(self):
        #搜索指定字符串返回匹配到的字符串
        re_findall=re.findall('he[l]{0,3}o','hello hello word')
        if re_findall :
            print(re_findall)
    def finditer(self):
        #与findall的区别是返回的是一个迭代对象
        re_finditer=re.finditer('he[l]{2}o','hello hello word')
        # for i in re_finditer:
        #     print(i.group())
        print([i for i in  re_finditer][0].group())
    def sub(self):
        #匹配替换 第一参数匹配规则，第二参替换的内容，第三参要匹配的字符串。
        d='hello hello word'
        c=re.sub('hello','test',d)
        print(c)
    def split(self):
        #按匹配规则切分字符串
        c=re.split('o','hello word')
        print(c)
        print('o'.join(c))
if __name__=='__main__':
    relear=re_lear()
    # relear.match()
    # relear.search()
    # relear.findall()
    # relear.finditer()
    # relear.sub()
    relear.split()

import re
str_a='192.168.12.20 - - [08/Aug/2016:16:15:37 +0800] "GET /time/dashboard.php HTTP/1.1" 200 19634 "-" "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; InfoPath.3)" "-"'
o=re.compile(r'(?P<ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*(?P<time>\[.*\]).*(?P<get_put>GET|PUT) (?P<file>[^\s]*).*\" (?P<status>\d{3}).?(?P<file_date> \d+)')
#定义一个匹配规则，r代表一个自然字符串，(?P<ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}) 以字典方式反回。ip为key 匹配到的为value
m=o.search(str_a) #要搜索的字符串。
c=m.groupdict()	 #对搜索的结果返回为字典，要配合(?P)使用
print(c)
```

### scapy

```python
pip3 install scapy-python3 #用于攻击和网络发现。抓包。
构建报文包：
  a=Ether()/IP(dst="192.168.99.143")/TCP()/b"GET /index.html HTTP/1.0"
    执行  	     IP协议部分              TCP协议部分
 hexdump(a) 转为16进制 #可没有
 b=bytes(a) 转为网络传输的bytes
 c=Ether(b) 执行报文
 c.hide_defaults() #删除版本等信息
 a=rdpcap("/spare/captures/isakmp.cap") 读入一个文件。

#####################################################################
>>> a=IP(dst="192.168.12.20") 定义IP层的目标地址
>>> [p for p in a] #执行发包
>>> b=IP(ttl=[1,2,(5,9)])    #定义IP报文的 TTL值
>>> [p for p in b]	　　　#徇环查看
>>> c=TCP(dport=[80,443])     #定义TCP层报文的端口号
>>> [p for p in a/c]		#执行发包
####################################################################
summary()	displays a list of summaries of each packet
nsummary()	same as previous, with the packet number
conversations()	displays a graph of conversations
show()	displays the prefered representation (usually nsummary())
filter()	returns a packet list filtered with a lambda function
hexdump()	returns a hexdump of all packets
hexraw()	returns a hexdump of the Raw layer of all packets
padding()	returns a hexdump of packets with padding
nzpadding()	returns a hexdump of packets with non-zero padding
plot()	plots a lambda function applied to the packet list
make table()	displays a table according to a lambda function
##########################################################################
发送数据包：send()三层报文。
	    sendp()二层报文。
```

### lxml

```python
from lxml import etree
##################################################################
root = etree.Element('main') #实例化一个etree对像<main></main>
root.append(etree.Element('h1',host_name='centos')) #添加一个子节点。属性为host_name.
etree.SubElement(root, "child2") #为主节点添加多个子节点
root.text = 'helloword' #<main>helloword</main>
root.etree.tostring(root,pretty_print=True) #打印生成的xml
root.remove(child1) #删除子节点
root.clear() #清空所有子节点
child1.getparent().tag #获取父节点
root.find('ceshi') #查出子节点tag叫ceshi
root.findall()
root.find('ceshi').text='heloo'
etree.tostring(root.find('ceshi')).decode()
###############################################################
从XML读出etree对象：
root = etree.XML("<root><a x='123'>aText<b/><c/><b/></a></root>")
对象操作同上
```

### logging

```python
#定义日志格式，和级别；
import loging
logging.basicConfig(level=logging.DEBUG,format='%(threadName)s') #定义DEBUG级别信息。
logging.DEBUG=10 ,设置报警级别
#一般用于线程非正常退出时
logging.debug('adfasdf') # 输出debug信息
%(asctime)s
%(created)f
%(filename)s
%(funcName)s
%(levelname)s
%(levelno)s
%(lineno)d
%(module)s
%(msecs)d
%(message)s
%(name)s
%(pathname)s
%(process)d
%(processName)s
%(relativeCreated)d
%(thread)d
%(threadName)s
```

```python
import logging,os

# error_format=logging.Formatter
class Log_config:
    def __init__(self):
        self.cnf={}
    def config(self):
        error_log = logging.getLogger()
        path=os.path.dirname(__file__)
        with open(os.path.join(path,'log_config'),'r') as f:
            cnf=f.readlines()
            for i in cnf:
                cnf_list=i.split(':')
                self.cnf[cnf_list[0]]=cnf_list[1].split('\n')[0]
        if self.cnf.get('log_level')=='debug'.upper():
            error_log.setLevel(logging.DEBUG)
        elif self.cnf.get('log_level')=='info'.upper():
            error_log.setLevel(logging.INFO)
        elif self.cnf.get('log_level')=='warning'.upper():
            error_log.setLevel(logging.WARNING)
        else: error_log.setLevel(logging.ERROR)
        headler=logging.FileHandler(os.path.join(self.cnf.get('log_path'),'error.log'))
        formatter=logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        headler.setFormatter(formatter)
        error_log.addHandler(headler)
        return error_log
config_file:
log_path:/Users/wangqinfeng
log_level:debug
```

### jwt

```python
sudo pip3 install PyJWT
生成token
import jwt
import datetime
#时间加8小时
a=datetime.datetime.now()+datetime.timedelta(hours=8)
key='sdfsdfdfjiuufiiasdfksdjfi'
#要求加密的是字典，'exp'是固定参数，表示过期时间，'HS512'表示加秘格式。
#key就是秘钥
token=jwt.encode({'user':'pass','exp':a},key,'HS512')
token=jwt.encode({'user':'name','pass':'123','exp':a},key,'HS512')
#########################################################
#解密
jwt.decode(token,key,['HS512'])
```



### psutil

```python
psutil实现了很多功能，包括了如下工具所具有的：
http://pythonhosted.org/psutil/#network
ps
top
df
kill
free
lsof
free
netstat
ifconfig
nice
ionice
iostat
iotop
uptime
pidof
tty
who
taskset
pmap
####################################################
	#CPU 时间
import psutil
psutil.cpu_times() 
输出：scputimes(user=17411.7, nice=77.99, system=3797.02, idle=51266.57, iowait=732.58, irq=0.01, softirq=142.43, steal=0.0, guest=0.0, guest_nice=0.0)
psutil.cpu_percent(interval=1) #CPU使用率，interval 间隔时间
		   prcpu=True #参数列表返回
psutil.cpu_count() #CPU线程总数。
psutil.cpu_count(logical=False) #CPU核心数。
psutil.cpu_stats() #
输出： scpustats(ctx_switches=49406052, interrupts=20497588, soft_interrupts=8566115, syscalls=0)
		ctx_switches	#上下文切换总数。
		interrupt	#中断数。
		soft_interrupts #软中断数，windows为0
		syscalls 	#系统调用数 linux为0
######################################################  内存部分：
psutil.virtual_memory()
	输出：	total:物理内存总数。
		available：可用物理内存总数。
		percent:  可使用内存百分比。
		used:	用户使用内存
		free ：	可用物理内存总数
		active: 最近使用的内存，linux
		inactive: 未使用的内存。
		buffers: 文件缓存使用。
		shared :可以初多进程访问的内存大小。
		wired	:内存磁盘大小。
psutil.swap_memory() 交换分区（虚拟内存。）
	输出：total: 交换区大小。
		used:用户交换多少。
		free:空闲交换分区大小。
		percent: 使用百分比。
######################################################磁盘
psutil.disk_partitions() 磁盘挂载分区。
psutil.disk_usage('/home') 磁盘分区信息。
psutil.disk_io_counters(perdisk=True) #输出分区读写次数，读写时间等信息。
############################################################################网络部分。
psutil.net_io_counters(pernic=True) #输出网卡的发送接收等 信息。
		bytes_sent #发送总量。
		bytes_recv #接收总量。
		packets_sent #发送的数据包总数。
		 packets_recv #接收的数据包总数。
		errin	#输入错误
		errout:  #输出错误 
		dropin  #丢掉的输入包。
		dropout #丢掉的输出包。
psutil.net_connections() #所有的sock连接。
		fd 套接字状态。
		family:地址类型  AF_INET, AF_INET6 or AF_UNIX. #IPV4，V6 和unxi
		type:地址类型。SOCK_STREAM  SOCK_DGRAM. 
		laddr 地址和端口。
		raddr:远端地址
		status:状态。 LISTEN ESTABLISHED NEW
		pid :对应的PID号
psutil.net_if_stats() #网卡状态。
############################################################################系统信息。
系统时间：
psutil.boot_time() 输出时间。
datetime.datetime.fromtimestamp(psutil.boot_time()).strftime("%Y-%m-%d %H:%M:%S") 格式化时间。
当前用户信息：
psutil.users() 包含：名称，方式，登录地址，运行的时间。
########################################################################进程
psutil.pids() #例出所有的进程pid号。
psutil.pid_exists(1234) #检查此pid是否存在。
psutil.process_iter() #返回一个迭代对象，遍历包含：运行进程的程序名，pid号
例：
for i in psutil.process_iter():
	print(i.as_dict()[username])
	KEY:	'ionice',
       		'memory_info',
	       	'username', 
		'terminal', 
		'memory_full_info', 
		'cwd',
	       	'threads',
	       	'exe', 
		'num_ctx_switches',
	       	'memory_maps',
	       	'cmdline', 
		'gids', 
		'status', 
		'io_counters',
	       	'uids', 
		'num_threads',
	       	'cpu_times',
	       	'nice',
	       	'name', 
		'create_time',
	       	'memory_percent', '
		cpu_percent', 
		'ppid',
	       	'environ',
	       	'cpu_affinity',
	       	'pid',
	       	'connections',
	       	'num_fds',
	       	'open_files'
```



### telnetlib

```python
import telnetlib
import os
def list_port(host,port,timeout=2):
    try:
        tn = telnetlib.Telnet(host, port=port, timeout=timeout)
        port_status = tn.set_debuglevel(2)
        print('host {} prot {} Open'.format(host, port))
        # with open('/home/{}_list_port'.format(host),'a+') as f:
        #     f.write(port_status)
    except IOError or Exception or KeyboardInterrupt:
        pass
        #print('host {} prot {} NOT Open'.format(host,port))
for i in range(10240):
    list_port('192.168.1.201', port=i)

```

### influxdb

```python
influxdb数据库：
安装模块：pip install influxdb
from influxdb import client as influxdb 
db = influxdb.InfluxDBClient(host, port, username, password, database)
db.query #读数据库。
####################################################################
#HTTP——API
requests.post('http://127.0.0.1:8086/write',data=kv值,params=('db'):'mage')

requests.post('http://127.0.0.1:8086/write', data='192.168.1.1,region=us-west value=0.13 ', params={'db':'mydb'})
			influxdb http/写  , 传入的数据=tag,	key=value 	例：
 r=requests.post('http://127.0.0.1:8086/write',data='mem,memfree=1 memtotal={a},cached={b},memfree={c},memavailable={d}'
    ''.format(
        a=part_dick['memtotal'],b=part_dick['cached'],c=part_dick['memfree'],d=part_dick['memavailable']
        ),params={'db':'ceshi'})	

###################################################################################################
一、influxdb:#与传统数据库作对比：	与时间作索引。
influxdb 	#传统数据库存
database	# 数据库
measurement	#数据库中的表。
points		#表里面的一行数据。
二、influxdb中独有的概念：
point属性：	传统数据库中的概念
time		#主键索引。
fields		#各种记录。
tags		#各种索引的属性。
series		#表示这个表里的数据，可以在图表上画成K线，通过tags
#查看表里的数据：
select * from "measurement" #返回时间，tags ,字段。
select * from 表 order by time desc limit 3 #返回3秒的数据。
show series from "measurement" #返回字段和值。
show measurements #返回所有的表。
drop measurement 表名 #删除表。
增：
use testDB #切入库。
insert 表名，tag=1 字段=值，字段=值。#如果表不存在自动创建。
三、数据库保存策略（Retention Policjes）#用于指定数据保存时间。
查看当前数据库的保存策略：
show RETENTION POLICIES ON "数据库"  
创建新的保存策略：
create retention policy "rp_name" on "db_name" duration 30d replication 1 default
rp_name:策略名。
db_name:数据库名。
30d	:保存30天
replication 1 :副本数保存
default:	设为默认策略。
#修改保存策略：
alter retention policies "rp_name" on "db_name" duration 3w default
#删除保存策略：
drop retention policy "rp_name"
grafana 前端展示。


```



### dwebsocket

```python
dwebsocket 用于接受前端的html websocket的socket请求。
from dwebsocket import require_websocket,accept_websocket
#django
@accept_websocket
def getindex(request):
	if request.is_websocket():　#是否是websocket请求。
		while True:
			request.websocket.send(json.dumps({'a':b}).encolde())
			time.sleep(1)
request.websocket.read() 接收消息无清息为None
request.websocket.wait() 接收清息无消息不返回。
request.websocket.count_messages() 返回队列长度。
request.websocket.has_messages() 有消息返回True无返回False
request.websocket.__iter__()　返回消息迭代器。 	
```



# webob

wsgi库

```python
from webob import Request
environ = {'wsgi.url_scheme': 'http'} #自定义字典用于自定义头文件。
req=Request(environ) #Request传入的参数为字典
print(req.environ) #打印Request的environ属性（此处为自定义的requst头文件）
###################################################
req=Request.blank('/bi') #这个方法返回一个最小head头，类型为字典。参数为字符串。
print(req.environ)
#反回的头文件为：
	{'HTTP_HOST': 'localhost:80',
 'PATH_INFO': '/',
 'QUERY_STRING': '',
 'REQUEST_METHOD': 'GET',
 'SCRIPT_NAME': '',
 'SERVER_NAME': 'localhost',
 'SERVER_PORT': '80',
 'SERVER_PROTOCOL': 'HTTP/1.0',
 'wsgi.errors': <_io.TextIOWrapper name='<stderr>' mode='w' encoding='GBK'>,
 'wsgi.input': <_io.BytesIO object at 0x7f61b1476db0>,
 'wsgi.multiprocess': False,
 'wsgi.multithread': False,
 'wsgi.run_once': False,
 'wsgi.url_scheme': 'http',
 'wsgi.version': (1, 0)｝
#######################################################################
#Request Body:
req.method='PUT' #默认为GET方法，改为PUT
req.body=b'test' #为body（页面内容上传内容。要求是byts）
if hasattr(req.body_file,'read'): #判断页面文件是否可读属性。
    print(req.body,req.environ)  #打印页面内容，和头文件。
#####################################################################
print(req.scheme) # 输出envriron的wsgi.url_scheme 的值。
req.script_name # 基础url
req.path_info #默认为/
req.content_type #页面类类型。
req.remote_user
req.remote_addr
req.host #默认为localhost:80
req.host_url #默认为：http://localhost
req.application_url #返回项目的url地址。req.host_url+req.script_name
req.path_url #返回页面地址为req.host_url+req.script_name+Request.blank()
req.path_qs #返回req.script_name+req.Request.blank() #包括传入的参数。
req.query_strint#返回？后面的，参数。
req.relative_url('ceshi') #创建url返回为：http://localhost/login/ceshi #req.host_url+req.script_name+传入的参数。
req.path_info_peek() #返回Request.blank（）创建时传入的页面名字。
req.path_info_pop() #取出Request.blank（）创建时传入的页面名字。
req.path_info #返回页面的名字。/bi,如果弹出后反回为空。
########################################################################
#Headers
req.headers['Content-Type']='ceshii' #定义Headers参数的值。
print(req.environ.get('CONTENT_TYPE'))#打印测试值是否修改成功。
########################################################################
#Query&POST variables
req=Request.blank('/test?check=a&chech=b') #实例化一个带参数的url
print(req.GET)		#返回所有的参数
print(req.GET.getall('check')) #返回url参数的值。
print(req.GET.items()) #返回所有的值，测试未成功。
#POST
print(req.POST.items()) #返回所有的参数值，测试未成功。
req.method='POST #设置请求方法为POST'
from webob import Request
req=Request.blank('/login?char=a&char=b')
req.method='POST' #设置请求方法。
#print(req.POST.items())
req.body=b'hello word&cha=a&email=360065954@qq.com'#设置主体内容。
print(req.POST) #打印请求body.
print(req.POST['cha']) #打印请求方法的cha参数的值。
print(req.params) #返回所有的参数包括url传入的参数，和post传入的参数。
print(req.params['char']) #打印制定参数的值。此处的char为url传入的值。
print(req.params.getall('char')) #打印指定参数的所有值，例如：http:/../a?char=a&char=b
for name,value in req.params.items():
    print('{},{}'.format(name,value)) #循环遍历打印所有的k v,自然包含所有的参数（GET+POST）
#PUT方法：
req=Request.blank('/test?check=a&check=b&name=Bob')# url传参。
req.method='PUT'	#使用PUT方法。
req.body=body=b'var1=value&var2=value2&rep=2' #设置body体。包含参数。
req.environ['CONTENT_LENGTH']=str(len(req.body)) #设置CONTENT_LENGTH的长度值。
req.environ['CONTENT_TYPE']='application/x-www-form-urlencoded' #设CONTENT_TYPE，的页面的类型值。
print(req.GET) #返回GET的参数。
print(req.POST) #返回POST的参数。
#Unicode Variables:
req.charset='utf-8' #设置字符编码格式。
if 1 :print(req.GET) #打印url参数。
#Cookies
req.headers['Cookie']='test=value' #设置头文件的Cookie的值。
if 1 :print(req.cookies.items()) #打印
#修改request:
req.remote_user='ceshi' #设置值。
print(req.environ['REMOTE_USER']) #在头文件的参数。
reb=req.copy() 		#复制实例。
print(reb.cookies.items()) #打印cookies的值，测试是否复制成功。
reb.remove_conditional_headers()#
				#支持参数：remove_encoding=True, remove_range=True, remove_match=True, remove_modified=True)
#Header Getters
req.headers #适用于http 1.1的请求头属性。
#Accept部分。
req.accept = 'text/html;q=0.5, application/xhtml+xml;q=1'#设置accept参数的值。
print(req.accept) #打印出accept参数的值（在浏览器请求头request部可以看到）
print('text/html' in req.accept) #返回字符串是否在request中。
req.accept.best_match(['text/html', 'application/xhtml+xml']) #设置accept 的值，参数列表。
print(list(req.accept))
req.accept_language='zh-CN,zh;q=0.8' #设定request的字符集。
req.accept_language.best_match(['zh-CN','zh'], default_match='zh-CN') #修改并设定默认字符集。
#Conditional request:
server_token='opaque-token' #设定字符串
req.if_none_match=server_token #设定参数值。
print(server_token in req.if_none_match) #判断server_token是否在req.if_none_match中。
####If-Modified-Since设置：
from webob import UTC #引入UTC模块。
from datetime import datetime #引入时间模块，用于格式化时间。
req.if_modified_since=datetime(2016,1,1,12,0,tzinfo=UTC) #格式化时间格式。
server_modified=datetime(2005,1,1,12,1,tzinfo=UTC) 	#格式化时间格式。
if 0 :print(req.headers['If-Modified-Since'])		#打印If-Modified-Since时间
if req.if_modified_since <server_modified:
    print(True)
else:				#判断页面时间是否大于server_modified的时间。
    print(False)
#############################################
## If-Ranger
req.if_range.match() #方法也弃用。
############################################
#调用 WSGI 应用（Applications）
req=Request.blank('/') #初始化一个request的请求地址。
def wsgi_app(environ,start_response): #environ是一个字典所有的request请求信息。为固定参数。
    start_response('200 OK',[('Content-type','text/plain')]) #传入状态码，返回头信息。
    return ['Hi!']				#返回的内容。
print(req.call_application(wsgi_app))   	#调用这个方法，返回为respons信息，和返回值。
res=req.get_response(wsgi_app)
print(res.headers) #打印respose的头部信息。
print(res.body) #打印response的内容。
##########################################
#Ad-Hoc 属性：
req=Request.blank('/') #初始化一个request的请求地址的头部。
req.some_attr='blah ad d'	#设定some_att的值。
req=Request(req.environ)	#重新加载environ的信息。
print(req.environ['webob.adhoc_attrs']) #打印现有的environ的webob.adhoc_attrs值。
##################################################################################################
################################################Response部分################################
#主要属性：
from webob import Response
res =Response() #实例化一个空的response
if 0:print(res.status) #打印返回状态码，与状态码名。
if 0:print(res.status.code) #打印返回状态码。
if 0:print(res.headerlist) #打印response的头部信息。
if 0:print(res.body)	#打印response的body部分。返回为bytes
#################
res.status=404 #设置状态码。
res.headerlist=[('Content-type', 'text/html')] #设置response的响应头部
res.body = b'test'	#设置主体内容
res.text=b'test'	#设置 text
res.charset='utf8'	#设置字符集
##Headers
print(res.headers) #打印头部信息。
#####Body&app_iter
from webob import Response #引入Response模块喽
res=Response(content_type='text/plain',charset=None) #初始化一个response实例，头header参数content_type,charset默认字符集为空
f=res.body_file
f.write(u'helloword') #此处无法写入
f.write(u'test')	#此处无法写入
print(f.encoding)	#打印现在的字符集，看看，返回为none
res.charset='utf8'	#设置字符集为utf8
print(f.encoding)	#查看现在的字符集，已经为utf-8了
f.write('    test')	#再写入字符串正常。
if 0:print(res.app_iter)#以列表的形式打印每次输入的值。[b'', b'helloword', b'test', b'    test']	
if 1 :print(res.body)	#打印body体
##########header 取值：
res=Response()
res.content_type='text/html'
res.charset = 'utf8'
res.content_type_params={'type':'entry','charset':'utf9'} #以字典的格式设置头文件。
其它头首部：
res.location = 'http://localhost/foo'
res.accept_ranges = 'bytes'
res.age = 120
res.allow = ['GET', 'PUT']
res.cache_control.max_age = 360
res.cache_control.no_transform = True
res.content_disposition = 'attachment; filename=foo.xml'
res.content_encoding = 'gzip'
res.content_language = ['en']
res.content_location = 'http://localhost/foo'
res.content_md5 = 'big-hash'
res.content_range = (0, 501, 1000)
res.content_length = 4
res.date = datetime.now()
res.etag = 'opaque-token'
res.md5_etag()
res.etag
res.expires = time.time() + 60*60
 res.last_modified = datetime(2007, 1, 1, 12, 0, tzinfo=UTC)
res.retry_after = 160
res.server = 'WebOb/1.0'
res.vary = ['Cookie']
#######Cookies
res=Response()
res.content_type='text/html'
res.charset = 'utf8'
res.content_type_params={'type':'entry','charset':'utf9'}
#print(res.headers['location'])
res.set_cookie('key','value',max_age=360,path='/',domain='example.org',secure=True) #设置cookie
if 1:print(res.headers['Set-Cookie']) #打印cookie
res.unset_cookie('key') #删除自定义的属性
res.delete_cookie('max_age') #把cookie的max_aget参数清零。
if 1:print(res.headers['Set-Cookie'])
###绑定Request
res.location='/home' #在res.hyeaders 中可以看到。
###########Response WSGI application
req=Request.blank('/') #实例化请求头部。
status,headers,app_iter=req.call_application(res) #返回
print(status,headers,app_iter)
##########
def my_app(environ,start_response): #定义函数，参数为固定格式
    req=Request(environ)	#取出Requse的heads头
    res=Response()		#实例化Response()
    res.content_type='text/plain' #设置response的content_type参数为文本。
    parts=[]			 #用来接受传入头文件内的参数，一会把它打印在response的body内。
    for name,value in sorted(req.environ.items()):
        #print(name,value)
        parts.append('{}:{}'.format(name,value))
    res.charset='utf8'
    #print(parts)
    #res.write(parts)
    res.body='\n'.join(parts).encode() #传入body体内的支持，byes 和code格式。
    return res(environ,start_response) #把responce 的environ(头部)，和内容返回调用者，一般是客户。
req=Request.blank('/') #实例化一个对根目录请求的url
res=req.get_response(my_app) #获取指定response的返回内容。参数为函数。
print(res)	#打印出来内容。
##############################################################################
	Exceptions异常。
from webob.exc import *
exc=HTTPTemporaryRedirect(location='foo') #网页307
req=Request.blank('/path/to/s') 
if 0 :print(str(req.get_response(exc)))
###########################################################
#条件 wsigi application
class AppResponse(Response): #定义一个响应函数。
    default_content_type = 'text/html' #定义响应头部的，类型格式
    default_conditional_response = True #打开条件响应。
res=AppResponse(body='1sdfdfdf',last_modified=datetime(2005, 1, 1, 12, 0, tzinfo=UTC)) #设置body内容，设置响应时间
req=Request.blank('/') #实例化一个request请求实例。
req.if_modified_since=datetime(2026,1,1,12,0,tzinfo=UTC) #重点：last_modified的时间等于这个时间才反回。
print(req.get_response(res))	#因为时间不对所以不返回，返回304
del req.if_modified_since	#删除时间属性。
res.etag='opaque-tag'		#为response的etag添加值。
req.if_none_match='opaque-tag'	#查看request的opaque-tag是否为空，*号代表所有。
print(req.get_response(res)) 	#因为不为空所以反回304
##########################################################
req.range=(1,8) #设置range值。
result=req.get_response(res) #把request去get response
print(result.headers['content-range']) #打印头部
print(result.body) #打印主体

```

### 错误码

```html
Exception
HTTPException
HTTPOk
200 - HTTPOk
201 - HTTPCreated
202 - HTTPAccepted
203 - HTTPNonAuthoritativeInformation
204 - HTTPNoContent
205 - HTTPResetContent
206 - HTTPPartialContent
HTTPRedirection
300 - HTTPMultipleChoices
301 - HTTPMovedPermanently
302 - HTTPFound
303 - HTTPSeeOther
304 - HTTPNotModified
305 - HTTPUseProxy
307 - HTTPTemporaryRedirect
308 - HTTPPermanentRedirect
HTTPError
HTTPClientError
400 - HTTPBadRequest
401 - HTTPUnauthorized
402 - HTTPPaymentRequired
403 - HTTPForbidden
404 - HTTPNotFound
405 - HTTPMethodNotAllowed
406 - HTTPNotAcceptable
407 - HTTPProxyAuthenticationRequired
408 - HTTPRequestTimeout
409 - HTTPConflict
410 - HTTPGone
411 - HTTPLengthRequired
412 - HTTPPreconditionFailed
413 - HTTPRequestEntityTooLarge
414 - HTTPRequestURITooLong
415 - HTTPUnsupportedMediaType
416 - HTTPRequestRangeNotSatisfiable
417 - HTTPExpectationFailed
422 - HTTPUnprocessableEntity
423 - HTTPLocked
424 - HTTPFailedDependency
428 - HTTPPreconditionRequired
429 - HTTPTooManyRequests
431 - HTTPRequestHeaderFieldsTooLarge
451 - HTTPUnavailableForLegalReasons
HTTPServerError
500 - HTTPInternalServerError
501 - HTTPNotImplemented
502 - HTTPBadGateway
503 - HTTPServiceUnavailable
504 - HTTPGatewayTimeout
505 - HTTPVersionNotSupported
511 - HTTPNetworkAuthenticationRequired

```

### 例子

```python
from wsgiref.simple_server import make_server	#容器
from webob import Request,Response		#引入Response响应内容，

def app(environ,start_response):  		#要被绑定的函数，必须接受两个固定参数，environ为容器传入的环境变量名。star_response响应内容时的状态码和头文件列表。
    print(environ['PATH_INFO']) 		#PATH_INFO：是为request请求路径比如:http://127.0.0.1/login  ，PATH_INFO='/login'
    res=Response()		 		#实例化webob的响应函数。
    status=res.status		 		#设置反回状态码：status='200 OK' 格式。
    if environ['PATH_INFO'] == '/login':	#请求路径判定。
        res.body=b'nisdf'			#不同路径返回不同内容。
    elif environ['PATH_INFO'] == '/password':
        res.body=b'password'
    else:					#非定义的路径请求反回
        status='404 ERROR'
        res.body='page ERROR'.encode()
    start_response(status,res.headerlist)	#响应内容反回时的状态码和响应头文件（response）
    return [res.body]				#返回内容。支持字符串格式。但得转为encodle

if __name__ =="__main__":
    httpd = make_server('', 8000, app) 		#绑定端口号和方法。
try:
    httpd.serve_forever()			#启动容器。
except KeyboardInterrupt:			#关闭容器。
    httpd.shutdown()
```

# flask

```python
Blueprint:
	from flask import Flask,Blueprint,render_template
    from flask.views import MethodView
    import os
    index_app=Blueprint('admin',__name__,template_folder='templates',static_folder='static') 生成蓝图，名字admin,模版，静态文件夹名字
    def accasse(df): 装饰器
      def ags(*args,**kwargs):
          print(request.path)
          return df(*args,**kwargs)
    return ags
    class index(MethodView):
    	@accasse
        def get(self):
            return render_template('index.html')
    print(__name__)
    index_app.add_url_rule('/',view_func=index.as_view('index'))  路由注册
templates/index.html:模版
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
    </head>
    <body>
        <span>{{ url_for('.index',filename='a.text') }} </span>   引用静态文件
    </body>
    </html>
run.py 注册运行
    from flask import Flask,template_rendered
    from admin import index_app
    app=Flask(__name__)
    app.register_blueprint(index_app,url_prefix='/index')
    
    @template_rendered.connect_via(app) 渲染模版信号记录
    def logs(sender,template,context,**extra):
        print(context.get('request').path)
        print(template.name,context)
    app.run()
####################信号部分
@request_started.connect_via(app) //request请求时
def ceshi(sender,**extra):
    print(request)
@template_rendered.connect_via(app) 渲染模版信号记录
def logs(sender,template,context,**extra):
     print(context.get('request').path)
     print(template.name,context)
flask.request_finished //返回response之前
def log_response(sender, response, **extra):

#项目布局:
packe/:
    project/:#项目目录
        app.py:#入口文件
        src/ #源码目录
        
        templates/ #html模板目录
            base.html,
            index.html
            login.html
        static/ #静态文件目录
            logo.jpg
            style.css
            update_file.js
    setup.py #打包文件
    NANIFEST.in #打包扩展文件:
#模块引入
from flask import Flask
app=Flask(__name__);#app实例化
#应用工程 __init__.py:
    #所有应用相关的配置,注册和其他设置都在此文件内完成,并返回实例化的app.
    app=Flask(__name__,instance_relative_config=True);
    #instance_relative_config 支持配置
    #默认缺省配置
    app.config.from_mapping(
                SECRET_KEY='xxxx' #seeion加密密码
                #数据库路径
                DATABASE=os.path.join(app.instance_path,'flaskr.sqlite')
            )
    #判断config.py文件是否存在
    app.config.from_pyfile('config.py')
    #不存在,从变量导入
    app.config.from_mapping(
                xxx='xxx'
                xxx2='xxx'
            )
#数据库操作
#db.py
import sqlites3
def connect_db():# 数据库连接
    if 'db' not in g: #判断db是否在全局变量里
        g.db=sqlite3.connect(
                            current_app.config['DATABASE'] #工程里设置的配置变量
                            detect_types=sqlite3.PARSE_DECLTYPES
                            )
        return g.db
        #current_app app的地址
        #g全局变量
def close_db():
    db=g.pop('db',None)#出寨db并设置原来为None
    if db is not None:
        db.close()
#create_table.py 命令行创建数据库表
from  db import connect_db
import click
from flask.cli import with_appcontext
def create_table():
    db=connect_db() #因为是在flask没运行时执行的,所有需要获取db连接
    with current_app.open_resource("create_table.sql") as f: #数据库文件路径.
        db.executescript(f.read().decode('utf8'))'
@click.command('init-db') #添加cmd命令
@with_appconntext
def init_db_command():
    create_table();
    click.echo('创建数据库表完成')
#命令注册到应用 __init__.py工程文件:
    from  db import close_db
    from create_table import init_db_command
    #每次请求结束后执行
    app.teardown_appcontext(close_db) 
    #运行flask init-db 创建create_table.sql的数据表#if __name__之前
    app.cli.add_command(init_db_command)
#Blueprint蓝图
    #是一种组织一组相关视图的方式比如一组/api/xxxx,
from flask import Blueprint
bp=Blueprint('api',__name__,url_prefix='api')
    #参数一 蓝图的名字
    #参数二 文件的名字
    #参数三 url前缀
bp.rote("/all_user",methonds('GET','POST')) #请求路径:http://127.0.0.1:5000/api/all_user
######viewMETHod
def accasse(df): 装饰器
      def ags(*args,**kwargs):
          print(request.path)
          return df(*args,**kwargs)
    return ags
    class index(MethodView):
        @accasse
        def get(self):
            return render_template('index.html')

index=Blueprint('api',__name__,url_prefix='api')
index.add_url_rule("/user",view_func=user.as_view('user'))
#注册到应用 __init__.py
    app.register_blueprint(api);
    app.register_blueprint(index);
#日志
    #输出到屏幕
from logging import Formatter
from logging.handlers import RotatingFileHandler
app.logger.setLevel(logging.DEBUG) #日志级别
    #日志格式 https://docs.python.org/2/library/logging.html#logrecord-attributes
fmt_str='"%(asctime)s - %(name)s - %(levelname)s - %(message)s"'
    #文字转日志格式实例
fmt=Formatter(fmt_str)
    #设置流日志
stream_headler=logging.StreamHandler()
    #设置流日志的格式
stream_headler.setFormatter(fmt)
    #把logging的日志设置到flask logger
app.logger.addHandler(stream_headler)
#输出到文件
file_handler=RotatingFileHandler(
    'tmd.log',maxBytes=1024,backupCount=20
)
    #最大1024 行数20
    #设置格式
file_handler.setFormatter(fmt)
    #添加到flask logger
app.logger.addHandler(file_handler)
#模板 

```

# django

```python
常用sql语句：
select * from table1 join table2 on table1 'user'=table.'group' where tabl.id=1
select * from table1,table2 where table1, 'user'=table2.'group' and table1.id=1
select count (distinct 'fengzi') from 'fengzi' where table.id=1
select count(*) as ,table1 from 'fengzi' where table.id=1; group by table1 
##################################################################
Django基础组成：
	models.py
	views.py
	urls.py
	latest_books.html
请求简单流程：
	用户请求--》urlcof-->view
				|\
				| \templates
			    models
安装：
	pip install django
新建项目：
	django-admin startproject 项目名
		manage.py #项目管理。
		setting.py #项目配置。
		urls.py	   #url正则匹配。
		wsgi.py	   #布署使用。
运行项目：
	python mange.py  runserver 0.0.0.0:80
############################################################################
vim urls.py
	def hello (request): #定义一个hello request是固定参数。
		return HttpResponse('Hello word') #页面返回的内容。
	urlpatterns=[
		url(r'^hello/$',hello)  #url请求如果以/hello开头，返给hello函数。
	]
创建app，一个项目可包含多个app
python manage.py startapp APP_项目名。
	admin.py	#管理后台
	apps.py		#app设置。
	migrations	#目录版本结构。
	models.py	#数据模型。
	tests.py	#测试单元。
	views.py	#视图。
	没有urls.py	#需要自己创建，并引用。
将app写入工程：
1、 编写app下的views.py
 from django.http import HttpResponse
 def index (request):
 	return HttpResponse("poll install")
2、vim 工程目录下的setting.py #添加APP
	INSTALLED_APPS=[
	'polls.apps.PollsConfig',
	]
3、vim 工程目录下urls.py
	from django.conf.urls import url,include
	urlpatterns = [	    
	    url(r'^polls/',include('polls.urls')),# 匹配后引用项目的url匹配文件。
	    url(r'^hello/$',hello),
	    url(r'^admin/', admin.site.urls),
4、配置app 的urls,cp项目的url到app里。
	from django.conf.urls import url,include
	from .views import index
	urlpatterns = [
	    url(r'^$',index), #上层匹配后传到此处。	
	]
###########################################################################
models 数据模型配置mysql
vim settings.py 
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'mysite', 数据库名
        'USER': 'root',
        'PASSWORD': 'fengzi',
        'HOST':'127.0.0.1',
        'PORT':'3306',
    }
}
vim __init__.py
	import pymysql
	pymysql.install_as_MySQLdb()
######################################Models部分######################################
vim models.py
from django.db import models
class Question(models.Model): #创建表Question
    question_text=models.CharField(max_length=200) #定义字短,question_text,varchar 200长度。
    pub_date=models.DateField('date published')	#定义时间
class Choice(models.Model):	＃创建表Choice 
    question=models.ForeignKey(Question,on_delete=models.CASCADE)　＃创建字段question 外键,Question,表删除时删除外键
    choice_text=models.CharField(max_length=200)　#创建字段choice_text varchar　200
    votes=models.IntegerField(default=0)	#创建字段整型，默认值为０
#使用mysql要安装：pip install mysqlclient 信赖gcc mysql-devel
#同步至数据库。
python manage.py makemigrations #
python manage.py sqlmigrate polls 0001_initial
python manage.py migrate #写入数据库。
#使用mysql要安装：pip install mysqlclient 信赖gcc mysql-devel
ipython 使用django
python manage.py shell
	导入模块：
		from django.utils import timezone
		from appA.models import Choice,Question #导入appA项目的models,　导入Choice,Question表。
	增：
		a=User.objects.add(user='fengzi')
		a.save
		User.objects.create(user='fengzi')
	查：   User.objects.filter(user='fengzi')[0].user
		User.objects.get(user='fengzi').user
		User.objects.all()
	删：
		a=User.objcets.get(user='fengzi')
		a.delete()
		User.objcets.filter(user='fengzi').delete()
		User.objcets.get(user='fengzi').delete()
	改：	a=User.objcets.get(id=1)
		a.user='fengzi2'
		a.save()
		User.objcets.filter(id=1).update(user='fengzi')
		
#$#$#$#$#$##########$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
vim app/moduels.py
from django.db import models
	class Zuhu(models.Model):
		zuhu=CharField(max_length=20)
	class Group(models.Model):
    		group = models.CharField(max_length=30)
    		group_zuhu = models.ForeignKey(Zuhu,on_delete=models.CASCADE)) #一对多外键 on_delete在删除用户组时执行什么CASCADE表示删除关系
	class User(models.Model):
    		user = models.CharField(max_length=30)
		passwd = models.CharField(max_length=20)
    		user_group = models.ManyToManyField(Group) #多对多 外键是一对多，还有个是一对一
一、执行创建数据库后：
	会有三张表：group user 和user_user_group(会自动生成关系表)
	一、一对多
		插入数据。
			Zuhu.objects.create(zuhu='myx') #添加租户。因为用户组的外键是租户表。
			Group.objects.create(group='admin',group_zuhu=Zuhu.objects.get(zuhu='myx')) #添加用户组，指定外键关联至租户myx
		查询：
			查出是myx租户的用户组
			Group.objects.filter(group_zuhu__zuhu='myx')[0].group #filter()返回的是一个列表，我只取出第一个元素。__表示外键的字段名。
			通过租户反查：
			b=Zuhu.objects.get(zuhu='myx')
			b.group_set.filter(group='admin')[0].group
	二、多对多
		插入数据：
		 	a=Group.objects.get(group='admin')
			b=User.objects.create(user='fengzi',passwd='fengzi')
			b.user_group.add(a)
			b.save()
		查询数据:
			User.objects.filter(user_group__group='admin')[0].user
			通过用户组表反查用户：
				b=Group.objects.get(group='admin')
				b.user_set.filter(user='fengzi')[0].user #_set表示返查
#########################################template部分##########################################
template配置：
	TEMPLATE
	'DIRS': [os.path.join(BASE_DIR, 'templates')],

static静态配置
	STATIC_URL = '/static/'
	STATICFILES_DIRS =[
    		os.path.join(BASE_DIR, 'static'),
		]
使用模版，在app/templates/app/index.html
	使用Context({...})可以为模版传值。reander中已经封装了此函数
	{{varname}} html模版中引入View变量，view中传入的变量render(request, '...html',{'varname':value})
		{% block title%} 我会被替换{% endblock%} 
		{% block content%} 我会被替换{% endblock %}
		{% block footer%} 我会被替换{% endblock %}
		title,content,footer不是变量。
		子模板的引用方式：{% extends "base.html" %}|include 
				{% block title %} 我是替换模版中的block的{% endblock%}
		模版for循环：
		{% for i in varname%}
			<div> {{i}} <div>
		{% endfor %}
		{% if varname%}
			<div>{{i}}<div>
		{% endif %}
		过滤器：
			{{now|date:"F j,Y"}}
			{{name | length}}
		硬编码：<img src="/static/django.png"> #/static就是硬编码，因为是写死的。
			{% load static %} #引入set文件中写设置的app路径，此时的{{static 'django.pnp'}}就等同于上面的。
		{% csrf_token %} #token一般模板都要添加。django简单验证token

################################VIEW部分##############################################
逻辑层：
	写业务逻辑部分的
	url反向解析

	from django.shortcuts import reverse
	reverse('detail',kwargs={'name':value}) #detail是一个url匹配的neme属性，在urls内定义的，kwargs是传入此url的参数	
						#此函数的作用是把这个名子变成它对应的url
	reverse_lazy #惰性的在指定的url名不存在是不报错。
	#
	from django.template import Template,Context
	def index(request):
		render(request,'app/index.html',{'ceshi':'ni hao ma'})
		render (request, reverse('index',index.html)) 未测试
	##常用
	request.POST
	from django.http import HttpResponseNotFound 
		return HttpResponseNotFound('not found') #定义错误页。
	raise Http404('feset') #定义错误返回
	##常用装饰器：
		@require_http_methods(['GET','POST']) #用来装饰视图方法的在请求方法匹配时进入函数。
		@gzip_page() #启用页面压缩
################################urls部分###############################################
from django.conf.urls import url, include
urlpatterns=[
	url(r'^$',index) #index是view定义的方法。
	url(r'^hello',hello,name='index') #name属性名字，在view中反解使用。
	url(r'^app',index('app.urls')) #引入app模块的的urls，http://ip:8000/app/...
	url(r'^(?P<question_id>[0-9]+/$)', hellos) #question_id是匹配的取值的变量名
]
###########################form表单部分#################################################
view中定义表单在模版中渲染出来。
from django import forms
class NameForm(forms.Form):
	your_name= forms.CharField(label='Your name',max_length=100) #类继成表定义表单。
				widge=forms.TextInput #指定插件
				常用插件：
					forms.NumberInput #只能输入数字
					forms.EmailInput #email
					forms.URLInput #url
from =NameForm()实例化
form.as_p() #以<p>标签的方试渲染表单
form.is_bound # 是否为绑定表单，有值的表单为绑定
form.as_table() #输出的html为br标签的
form.as_ul()
form.is_valid() #判断是值否合法。
form.cleaned_data['key'] #取值
form['key'].value() #也是取值。
form.errors #打印出错误，比如说is_valid()后打印错误信息，返给前端页面
#view取值：
    if request.method =='POST':
        form = formss(request.POST)
        if form.is_valid():
            user = form.cleaned_data['user']
            passwd = form.cleaned_data['passwd']

html中接受全部表单。{{from}}
html中接受指定单元。{{from.your_name}}
############################################################ModelForm部分#########################################################################################。
from django.forms import ModelForm
	class AuthorForm(ModeForm)
		class Meta: #元类必须的 
			model=Author #指定数据库类名
			fields=['name','title','birth_date'] #显示哪此字段。
			
			#常用属性：
			exclude=() 排除字段
			fields=__all__ 全部字段。
			labels={'user':'name'} #把user字段重命名为name
			widgets={
				'user':Textarea(attrs={'cols':80,'rows':20) 为user字段指定插件.列80，行20
			}
			help_texts={ 
				'user':_('heloowadfdfa') #帮助信息 	
			}
			error_messages={
			'user':{'max_length':_('超过长度值')} #自定义错误信息。	
			}
			def clean_user(self): #为ueser添加认证。方法名为clean_字段名。
				user=self.cleaned_data['user']
				if len(user)>100:
					raise ValidationError('adsfadfasdf')
				return name
			def clean(self):
				#对整个from验证
	def index(request):
    		fo=AuthorForm()
    		return render(request, 'app/index.html', {'forms':fo} )
fo.save()直接写入数据库。
 from 存多对多：
 取出GroupID
 	p=Group.objects.get(group='admin').id
 	fo=Autho({'user':'fengzi3','passwd':'fengzi','user_group':[p]})
	#user_group是多对多所以要求是个列表，因为此用户可以属于多个组。
 	fo.is_value()
 	fo.save()
	####################不保存
	a=fo.save(commit=False)
	a.user='ceshi'
	a.save()
	fo.save_m2m() 保存关系

	form=Autho(request.POST,instance=publiisher) #instace表示更新，默认是写入
##########bootstrap框架使用#######
 pip install django-bootstrap-form
 INSTALLED_APPS = [
    'bootstrapform',]添加
html 
	{% load bootstrap %}
	{{from|bootstrap}}
#####################################使用类视图以前用方法视图。############
views
	from django.http import HttpResponse
	from django.views.generic import View

	class Login(View):
    		greeting="Good Day"
   	 	def get(self,request): #重写get请求，post请求。
       			return HttpResponse(self.greeting)
urls:
	from django.conf.urls import url
	from app.views import Login
	urlpatterns = [
	url(r'^login/$',Login.as_view()) #此处改为类名as_view()
		]
##############################TemplateView模版视图#####################
###########################django rest frameword创建API######################
pip install djangorestframework
settings.py
	INSTALLED_APPS = [
    		'rest_framework',
		]
#创建Serializer class
#############################Basic 认证###########################
Basic认证
Session认证
Token认证
默认使用Basic认证。账号秘
sesson:
	setting.py
	INSTALLED_APPS = [
   		 'django.contrib.sessions',


class Login(View):
    def get (self, request):
        request.session['member_id']=12134145
        return render(request, 'app/index.html')
    def post(self,request):
        print(request.session.get('member_id'))
        return render(request, 'app/index.html',{'forms':12345})


```

