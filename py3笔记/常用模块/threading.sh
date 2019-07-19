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

