一、tornado.httpclient import HTTPClien #阻塞式方法。
	例：
	import tornado.httpclient
	def http_clien(url):
    		hc=tornado.httpclient.HTTPClient()
    		respone=hc.fetch(url)
    		if respone.error==None:
        		return respone.body
   		 else:
       			 raise 'get error!'
	http_clien('http://blog.csdn.net/liuxiao723846/article/details/54925328')
二、 AsncHTTPClient() #异步请求。
	import  tornado.ioloop
	http_client=tornado.httpclient.AsyncHTTPClient()
	url='http://blog.csdn.net/liuxiao723846/article/details/54925328'
	def on_response(response):
    		if response.code==200:
        	tornado.ioloop.IOLoop.instance().stop() #这是用来退出徇环。
        	print(response.body)
	http_client.fetch(url,on_response) #AsncHTTPClient()需要回调函数，并得徇环。
	tornado.ioloop.IOLoop.instance().start()

三、协程：
	def drive(x,y):
		return x/y
	@tornado.gen.coroutine #如果没有此装饰器则不会报ZeroDivisionError错误。
	def bad_call():
   		 yield drive(1,0)	
		 
