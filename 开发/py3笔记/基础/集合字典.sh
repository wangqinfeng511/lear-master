集合：
集合：元素唯一、元素无序的。
定义：s=set()
        s={1,2,3,4,5}
集合方法：
增加元素、
        add() update()
        例如：  s.add(4) #对s集合添加一个元素。如与已有元素，不执行任何操作。
                s.update([3,4,5,6,7,8]) #添加多个元素，并自动去重。
        对列表进行去重。
        lst(set([1,3,4,4,3,2,1])
删除元素、
        remove, discard pop clear
        例：
        s.remove(1)　#指定元素(1)删除，不存在会报错。
        s.discard(1) #指定元素（１）删除，不存在不报错。
        s.pop()     #随机取出一个元素，返回并删除。
        s.clear()   #清空集合。
改：没有一个方法可支持修改。
        s.union(b) |s|b#输出集合s,和b的并集。
        s.intersection(b)｜a&b #输出集合s和b的交集。
        s.difference(b) |a-b  #输出集合a与b的差集。
        s.symmetric_difference(b) a^b #输出s与b的对称差集。
        s.intersection_update(b) #源地修改。
                        原地修改。
集合使用于，元素需要唯一，顺序没有要求，需要集合运算。

##############################################################################
字典：
        key -values的存储方式。　key唯一性。
定义：
        d=dict()　＃定义一个空的字典。
        d={}    #定义一个空的字典。
        d={'a':'bcd','b':'asdfi'} ＃定义一个字典，key为a b
增：字典的下标操作
	b={"a":1,'b':2}
	b['a']='2'
	b['c']=3 #添加一个key　c并赋值为3
	update()#增加多组kv
	例：b.update('f':'ceshi','e':'shalu') #为字典b添加多个key valus
删：pop popitem
	pop()　用来删除参数key
	例：b.pop('a',123) ，删除key　a　如果没有此key则返回123.
	popitem()　＃随机删除一对kv.返回k-v对：
	例：b.popitem()
	clear()	#清空字典。
访问：
	下标访问。
	get()　＃通过key返回指定值。
	例：b.get('a',123) #如果指定的 key不存在则返回123
	setdefault('c',123) #,为key　c指定错误默认返回码。
遍历：
	d.keys()	#返回所有的key
	d.values()	#返回所有的values.
	d.items()	#返回所有的key 和values
为key添加索引：
	enumerate()	#为key添加索引。
＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃
字典有序化：
	from collections import orderedpict
		od=OrderedDict()
		od['a']=1 # 此时会有序化。
字典复制：
	d.copy()　＃复制字典。　
	formkeys(): #创建多个key统一值。
	 例：d.fromkeys([1,2,3],False)
#############################################################################
列表解析：[expr for item in itatorable]
	lst=[1,2,3,4,5]
	[x+1 for x in lst] #返回x+1
测试运行时间：
	import timeit
	timeit.timeit('语句'.globals())
例：求的０－９次方：
	[2**n for n in range(10)] 
例：def inc (x):
	[x for x in range(10)]
例：列表嵌入式。
	[x for x in range(10) if x%2==0]

＃＃＃＃＃＃
集合解析式：
	{x for x in range(10) } #返回一个１－１０的列表。
字典解析式：
	{ str(x):y for x in range(3) for y in range(4)}
############################################################################
迭代器：
	可迭代对象：字符串，列表，元组，集合，字典和生成器。
	可迭代对象，可用于for in表代式，可以使用成员运算符（in和not in）
iter() #接收可迭代对象封装成一个迭代器。
例：
	r=range(10)	#type(r)  range
	it=iter(r)	#type(it) range_iterator
	next(it,3)	#取出迭代器的下一个迭代对象，如果取完返回３



