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
		
		
