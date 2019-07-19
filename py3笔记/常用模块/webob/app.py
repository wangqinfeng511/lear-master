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
