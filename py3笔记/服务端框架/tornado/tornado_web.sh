import tornado
一、tornado.web.RequestHandler #用于定义请求继承重写。
	例： class MainHandier(tornado.web.RequesHandler):
		def get(self):
			self.request.headers #请求头部。
			self.request.headers['Content-Type'] #请求类型。
			self.set_cookie("cookie_name","cookie_value") #设定返回cookie值不加秘。
			self.set_secure_cookie("cookie_name","cookie_value") #加秘后返回cookie值。
			self.max_age_days=1 #设定cookie最大过期时间为一天。
			self.get_secure_cookie("cookie_name") #返回解秘后的cookie值。
			self.write('Hello word')
		def post(self):
			self.request.files #传来文件
			self.write('Post Hello word')
			self.render('index.html',options='options') #渲染模板。
	tornado.web.authenticated #装饰器，用于cookie是否匹配。要求重写get_current_user函数，并返回解秘后的cookie_value,
				 #如果cookie_value不匹配则跳至 tornado.web.Application 的login_url指定的页面（一般为登录页面）
		例：
		 class B(tornado.web.RequesHandler):
		 	def current_user(self):
				return self.get_secure_cookie("cookie_name")
			@tornado.web.authenticated
			def get(self):
				self.write("Hello")
				
二、 tornado.web.UImodule #模板模块定义
	例：class Hello_module(tornado.web.UImodule):
		def render(self):
			return '<h1> ceshi</h1>'
三、tornado.web.Application() #实例化应用。
	例： app=tornado.web.Application(
		template_path='./html'	#指定模板的存储文件夹。
		ui_modules={'Hello':Hello_module} #传入模块，这样才能在模板中通过{% module Hello() %}调用。
		handlers=[(r'/',MainHandier),(r'/b',B)] #url绑定处理类。
		cookie_secret='my_cookie_key' #设定cookie加密值。
		login_url="/"
		xsrf_cookies=True #打开跨站
		compiledd_template_cache=False #打开模板不缓存
		debug=True
		)
	    app.listen(3000) #指定监听端口。
四、tornado.ioloop.IOLoop.current() #用于实例起动：
	tonado.ioloop.IOLoop.current().start()
五、html调用传入的options_value
	{{ options_value }}
	{% set x=12 %} #设置变量
	#for徇环
	{% for i in options_value %}
		<div> i</div>
	{% end %}
	#if
	{% if len(options_value)>3 %}
		<div> options[0]</div>
	{% end %}
	#while
	{% while option_value[0] == 'c' %}
		<div> option_value</div>
		option_value[0]='a'
		{% break %} #退出徇环
		{% continue %}#退出本次徇环。
	{%end%}
	{% module Hello()%}  #引用模块
	#防跨站，在Aplication参数中打开xsrf跨站
	<form action='/' methon="post">
		{% module xsrf_from_html  %}
		<input type="text"></input>
		<button> 提交</button>
	</form>
六、协程：
	（一）异步调用。
	import tornado.httpclient
	import tornado.web
	import tornado.ioloop
	class AsyncHandler(tornado.web.RequestHandler):
   	 def on_fetch(self,res):
        	print(res.body)
    	def get(self):
        	http=tornado.httpclient.AsyncHTTPClient() #实例化异步请求。
        	http.fetch('https://segmentfault.com/q/1010000000145606',
                   		callback=self.on_fetch)#请求url并把结果回调给一个函数self.on_fetch

	app=tornado.web.Application([(r'/',AsyncHandler)],)
	app.listen(8888)
	tornado.ioloop.IOLoop.current().start()
		
