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

