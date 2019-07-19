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
