dwebsocket 用于接受前端的html websocket的socket请求。
from dwebsocket import require_websocket,accept_websocket
#django
@accept_websocket
def getindex(request):
	if request.is_websocket():　#是否是websocket请求。
		while True:
			request.websocket.send(json.dumps({'a':b}).encolde())
			time.sleep(1)
request.websocket.read() 接收消息无清息为None
request.websocket.wait() 接收清息无消息不返回。
request.websocket.count_messages() 返回队列长度。
request.websocket.has_messages() 有消息返回True无返回False
request.websocket.__iter__()　返回消息迭代器。 	
