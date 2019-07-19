from webob import Request
environ = {'wsgi.url_scheme': 'http'} #自定义字典用于自定义头文件。
req=Request(environ) #Request传入的参数为字典
print(req.environ) #打印Request的environ属性（此处为自定义的requst头文件）
###################################################
req=Request.blank('/bi') #这个方法返回一个最小head头，类型为字典。参数为字符串。
print(req.environ)
#反回的头文件为：
	{'HTTP_HOST': 'localhost:80',
 'PATH_INFO': '/',
 'QUERY_STRING': '',
 'REQUEST_METHOD': 'GET',
 'SCRIPT_NAME': '',
 'SERVER_NAME': 'localhost',
 'SERVER_PORT': '80',
 'SERVER_PROTOCOL': 'HTTP/1.0',
 'wsgi.errors': <_io.TextIOWrapper name='<stderr>' mode='w' encoding='GBK'>,
 'wsgi.input': <_io.BytesIO object at 0x7f61b1476db0>,
 'wsgi.multiprocess': False,
 'wsgi.multithread': False,
 'wsgi.run_once': False,
 'wsgi.url_scheme': 'http',
 'wsgi.version': (1, 0)｝
#######################################################################
#Request Body:
req.method='PUT' #默认为GET方法，改为PUT
req.body=b'test' #为body（页面内容上传内容。要求是byts）
if hasattr(req.body_file,'read'): #判断页面文件是否可读属性。
    print(req.body,req.environ)  #打印页面内容，和头文件。
#####################################################################
print(req.scheme) # 输出envriron的wsgi.url_scheme 的值。
req.script_name # 基础url
req.path_info #默认为/
req.content_type #页面类类型。
req.remote_user
req.remote_addr
req.host #默认为localhost:80
req.host_url #默认为：http://localhost
req.application_url #返回项目的url地址。req.host_url+req.script_name
req.path_url #返回页面地址为req.host_url+req.script_name+Request.blank()
req.path_qs #返回req.script_name+req.Request.blank() #包括传入的参数。
req.query_strint#返回？后面的，参数。
req.relative_url('ceshi') #创建url返回为：http://localhost/login/ceshi #req.host_url+req.script_name+传入的参数。
req.path_info_peek() #返回Request.blank（）创建时传入的页面名字。
req.path_info_pop() #取出Request.blank（）创建时传入的页面名字。
req.path_info #返回页面的名字。/bi,如果弹出后反回为空。
########################################################################
#Headers
req.headers['Content-Type']='ceshii' #定义Headers参数的值。
print(req.environ.get('CONTENT_TYPE'))#打印测试值是否修改成功。
########################################################################
#Query&POST variables
req=Request.blank('/test?check=a&chech=b') #实例化一个带参数的url
print(req.GET)		#返回所有的参数
print(req.GET.getall('check')) #返回url参数的值。
print(req.GET.items()) #返回所有的值，测试未成功。
#POST
print(req.POST.items()) #返回所有的参数值，测试未成功。
req.method='POST #设置请求方法为POST'
from webob import Request
req=Request.blank('/login?char=a&char=b')
req.method='POST' #设置请求方法。
#print(req.POST.items())
req.body=b'hello word&cha=a&email=360065954@qq.com'#设置主体内容。
print(req.POST) #打印请求body.
print(req.POST['cha']) #打印请求方法的cha参数的值。
print(req.params) #返回所有的参数包括url传入的参数，和post传入的参数。
print(req.params['char']) #打印制定参数的值。此处的char为url传入的值。
print(req.params.getall('char')) #打印指定参数的所有值，例如：http:/../a?char=a&char=b
for name,value in req.params.items():
    print('{},{}'.format(name,value)) #循环遍历打印所有的k v,自然包含所有的参数（GET+POST）
#PUT方法：
req=Request.blank('/test?check=a&check=b&name=Bob')# url传参。
req.method='PUT'	#使用PUT方法。
req.body=body=b'var1=value&var2=value2&rep=2' #设置body体。包含参数。
req.environ['CONTENT_LENGTH']=str(len(req.body)) #设置CONTENT_LENGTH的长度值。
req.environ['CONTENT_TYPE']='application/x-www-form-urlencoded' #设CONTENT_TYPE，的页面的类型值。
print(req.GET) #返回GET的参数。
print(req.POST) #返回POST的参数。
#Unicode Variables:
req.charset='utf-8' #设置字符编码格式。
if 1 :print(req.GET) #打印url参数。
#Cookies
req.headers['Cookie']='test=value' #设置头文件的Cookie的值。
if 1 :print(req.cookies.items()) #打印
#修改request:
req.remote_user='ceshi' #设置值。
print(req.environ['REMOTE_USER']) #在头文件的参数。
reb=req.copy() 		#复制实例。
print(reb.cookies.items()) #打印cookies的值，测试是否复制成功。
reb.remove_conditional_headers()#
				#支持参数：remove_encoding=True, remove_range=True, remove_match=True, remove_modified=True)
#Header Getters
req.headers #适用于http 1.1的请求头属性。
#Accept部分。
req.accept = 'text/html;q=0.5, application/xhtml+xml;q=1'#设置accept参数的值。
print(req.accept) #打印出accept参数的值（在浏览器请求头request部可以看到）
print('text/html' in req.accept) #返回字符串是否在request中。
req.accept.best_match(['text/html', 'application/xhtml+xml']) #设置accept 的值，参数列表。
print(list(req.accept))
req.accept_language='zh-CN,zh;q=0.8' #设定request的字符集。
req.accept_language.best_match(['zh-CN','zh'], default_match='zh-CN') #修改并设定默认字符集。
#Conditional request:
server_token='opaque-token' #设定字符串
req.if_none_match=server_token #设定参数值。
print(server_token in req.if_none_match) #判断server_token是否在req.if_none_match中。
####If-Modified-Since设置：
from webob import UTC #引入UTC模块。
from datetime import datetime #引入时间模块，用于格式化时间。
req.if_modified_since=datetime(2016,1,1,12,0,tzinfo=UTC) #格式化时间格式。
server_modified=datetime(2005,1,1,12,1,tzinfo=UTC) 	#格式化时间格式。
if 0 :print(req.headers['If-Modified-Since'])		#打印If-Modified-Since时间
if req.if_modified_since <server_modified:
    print(True)
else:				#判断页面时间是否大于server_modified的时间。
    print(False)
#############################################
## If-Ranger
req.if_range.match() #方法也弃用。
############################################
#调用 WSGI 应用（Applications）
req=Request.blank('/') #初始化一个request的请求地址。
def wsgi_app(environ,start_response): #environ是一个字典所有的request请求信息。为固定参数。
    start_response('200 OK',[('Content-type','text/plain')]) #传入状态码，返回头信息。
    return ['Hi!']				#返回的内容。
print(req.call_application(wsgi_app))   	#调用这个方法，返回为respons信息，和返回值。
res=req.get_response(wsgi_app)
print(res.headers) #打印respose的头部信息。
print(res.body) #打印response的内容。
##########################################
#Ad-Hoc 属性：
req=Request.blank('/') #初始化一个request的请求地址的头部。
req.some_attr='blah ad d'	#设定some_att的值。
req=Request(req.environ)	#重新加载environ的信息。
print(req.environ['webob.adhoc_attrs']) #打印现有的environ的webob.adhoc_attrs值。
##################################################################################################
################################################Response部分################################
#主要属性：
from webob import Response
res =Response() #实例化一个空的response
if 0:print(res.status) #打印返回状态码，与状态码名。
if 0:print(res.status.code) #打印返回状态码。
if 0:print(res.headerlist) #打印response的头部信息。
if 0:print(res.body)	#打印response的body部分。返回为bytes
#################
res.status=404 #设置状态码。
res.headerlist=[('Content-type', 'text/html')] #设置response的响应头部
res.body = b'test'	#设置主体内容
res.text=b'test'	#设置 text
res.charset='utf8'	#设置字符集
##Headers
print(res.headers) #打印头部信息。
#####Body&app_iter
from webob import Response #引入Response模块喽
res=Response(content_type='text/plain',charset=None) #初始化一个response实例，头header参数content_type,charset默认字符集为空
f=res.body_file
f.write(u'helloword') #此处无法写入
f.write(u'test')	#此处无法写入
print(f.encoding)	#打印现在的字符集，看看，返回为none
res.charset='utf8'	#设置字符集为utf8
print(f.encoding)	#查看现在的字符集，已经为utf-8了
f.write('    test')	#再写入字符串正常。
if 0:print(res.app_iter)#以列表的形式打印每次输入的值。[b'', b'helloword', b'test', b'    test']	
if 1 :print(res.body)	#打印body体
##########header 取值：
res=Response()
res.content_type='text/html'
res.charset = 'utf8'
res.content_type_params={'type':'entry','charset':'utf9'} #以字典的格式设置头文件。
其它头首部：
res.location = 'http://localhost/foo'
res.accept_ranges = 'bytes'
res.age = 120
res.allow = ['GET', 'PUT']
res.cache_control.max_age = 360
res.cache_control.no_transform = True
res.content_disposition = 'attachment; filename=foo.xml'
res.content_encoding = 'gzip'
res.content_language = ['en']
res.content_location = 'http://localhost/foo'
res.content_md5 = 'big-hash'
res.content_range = (0, 501, 1000)
res.content_length = 4
res.date = datetime.now()
res.etag = 'opaque-token'
res.md5_etag()
res.etag
res.expires = time.time() + 60*60
 res.last_modified = datetime(2007, 1, 1, 12, 0, tzinfo=UTC)
res.retry_after = 160
res.server = 'WebOb/1.0'
res.vary = ['Cookie']
#######Cookies
res=Response()
res.content_type='text/html'
res.charset = 'utf8'
res.content_type_params={'type':'entry','charset':'utf9'}
#print(res.headers['location'])
res.set_cookie('key','value',max_age=360,path='/',domain='example.org',secure=True) #设置cookie
if 1:print(res.headers['Set-Cookie']) #打印cookie
res.unset_cookie('key') #删除自定义的属性
res.delete_cookie('max_age') #把cookie的max_aget参数清零。
if 1:print(res.headers['Set-Cookie'])
###绑定Request
res.location='/home' #在res.hyeaders 中可以看到。
###########Response WSGI application
req=Request.blank('/') #实例化请求头部。
status,headers,app_iter=req.call_application(res) #返回
print(status,headers,app_iter)
##########
def my_app(environ,start_response): #定义函数，参数为固定格式
    req=Request(environ)	#取出Requse的heads头
    res=Response()		#实例化Response()
    res.content_type='text/plain' #设置response的content_type参数为文本。
    parts=[]			 #用来接受传入头文件内的参数，一会把它打印在response的body内。
    for name,value in sorted(req.environ.items()):
        #print(name,value)
        parts.append('{}:{}'.format(name,value))
    res.charset='utf8'
    #print(parts)
    #res.write(parts)
    res.body='\n'.join(parts).encode() #传入body体内的支持，byes 和code格式。
    return res(environ,start_response) #把responce 的environ(头部)，和内容返回调用者，一般是客户。
req=Request.blank('/') #实例化一个对根目录请求的url
res=req.get_response(my_app) #获取指定response的返回内容。参数为函数。
print(res)	#打印出来内容。
##############################################################################
	Exceptions异常。
from webob.exc import *
exc=HTTPTemporaryRedirect(location='foo') #网页307
req=Request.blank('/path/to/s') 
if 0 :print(str(req.get_response(exc)))
###########################################################
#条件 wsigi application
class AppResponse(Response): #定义一个响应函数。
    default_content_type = 'text/html' #定义响应头部的，类型格式
    default_conditional_response = True #打开条件响应。
res=AppResponse(body='1sdfdfdf',last_modified=datetime(2005, 1, 1, 12, 0, tzinfo=UTC)) #设置body内容，设置响应时间
req=Request.blank('/') #实例化一个request请求实例。
req.if_modified_since=datetime(2026,1,1,12,0,tzinfo=UTC) #重点：last_modified的时间等于这个时间才反回。
print(req.get_response(res))	#因为时间不对所以不返回，返回304
del req.if_modified_since	#删除时间属性。
res.etag='opaque-tag'		#为response的etag添加值。
req.if_none_match='opaque-tag'	#查看request的opaque-tag是否为空，*号代表所有。
print(req.get_response(res)) 	#因为不为空所以反回304
##########################################################
req.range=(1,8) #设置range值。
result=req.get_response(res) #把request去get response
print(result.headers['content-range']) #打印头部
print(result.body) #打印主体
