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

