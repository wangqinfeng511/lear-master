#通过HTTPClient()同步
from tornado.httpclient import HTTPClient
def ceshi(url):
    http_client=HTTPClient() #初始化HTTPClient类
    response=http_client.fetch(url) 	#调用HTTPClient实例的fetch()方法
    return response.body		#反回fetch()方法的body内容
print(ceshi("http://192.168.99.143"))
#fetch方法支持属性：
	body,buffer,code,effective_url,error,headers,request,request_time.
#通过AsyncHTTPClient()异步


