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

