nc -l 1234 创建一个监听端口（bash）
import socket
so=socket.socket()#创建 一个socket对象
	#常用参数：
	family =IP
	type=SOCK_STREAM #工作模式TCP
	conn=so.connect(('127.0.0.1',1234)) #创建connect对象参数为连接地址。
	so.send() #传送的数据，要求是beys.
	例：so.send(json.dumps(data).encode()) #json后再转为beys
import struct #转为二进制。
	data={'a':1}
	data1=json.dumps(data).encode()
	length=len(data1)
	p=struct.pack('<l{}s'.format(length)，length,data1)
	#<表示小端，l表求长度，s表示多少字符。
	so.send(p)
	#接收
	buf=so.recv(4)
	length,*_=struct.unpack('<l',buf)
	length,*_=struct.unpack('<l',p)
	buf=so.recv(length) 
	data,_=struct.unpack('<l{}s'.format(length).buf)
	data=json.loads(data.decode()) 
##########################################################################
socketserver #支持tcp udp unix
from socketserver import BaseRequestHandler
from socketserver import ThreadingTCPServer #基于线程的tcpserver

class MasterHandler(BaseRequestHandler):
    def handle(self):
        self.data = self.request.recv(1024).strip() #接收
        print("{} wrote:".format(self.client_address[0]))
        print(self.data)
        self.request.sendall(self.data.upper()) #发送


if __name__ == "__main__":
    HOST, PORT = "localhost", 9999
    #server = TCPServer((HOST, PORT), MasterHandler) #绑定IP端口，类
    server = ThreadingTCPServer((HOST, PORT), MasterHandler) #绑定IP端口，类
    server.serve_forever() #开启监听
