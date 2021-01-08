import socket,asyncio,time,struct,json
#sockt创建 socket(sockt_family,socket_type,protocol=0)
#               sockt_family:   AF_UNIX|AF_INET
#               socket_type:    SOCK_STREAM|SOCK_DGRAM
#常用方法：
    #服务端套接字
        #s.bind()       绑定套接字
        #s.listen()     监听套接字 s.listen(5)表示连接失败最大次数。
        #s.accept()     阻塞等待tcp连接
    #客户端套接字
        #s.connect()    主动发起连接
        #s.connect_ex() 以错误代码的形式反回，而不是错误。
    #通用：
        #s.recv()       接受TCP消息
        #s.recv_info()  接受TCP消息到指定缓冲区
        #s.send()       发送TCP消息
        #s.sendall()    发送TCP所有的消息
        #s.recvfrom()   接收UDP消息
        #s.recvfrom_info() 接收UDP消息到缓冲区
        #s.sendto()     发送UDP消息
        #s.getpeername()  获取连接到套接字的远程地址
        #s.getsocketname() 获取当前的套接字
        #s.getsockopt()  返回给定套接字选项的值
        #s.setsockopt()  设置套接字选项的值
        #s.shutdown()   关闭连接
        #s.close()      关闭套接字
        #s.detach()     不关闭文件描述符关闭套接字。
        #s.ioctl()      控制套接字的模数(只支持windows)
    #面向阻塞的套接字方法：
        #s.setblocking()    设置套接字的阻塞或非阻塞
        #s.settimeout()     设置阻塞套接字的超时时长
        #s.gettimeout()     获取套接字的超时时长
    #面向文件的套接字方法：
        #s.fileno()         套接字的文件描述符
        #s.makefile()       创建与套接字关联的文件对象
    #数据属性：
        #s.family           套接字家族
        #s.type             套接字类型
        #s.proto            套接字协议
class lear_socket():
    def tcp_sockt(self):
        host=''
        port=5001
        bufsize=1024
        addr=(host,port)
        self.tcp_server=socket.socket(socket.AF_INET,socket.SOCK_STREAM) #创建TCP_SOCKT
        self.tcp_server.bind(addr)      #绑定地址
        self.tcp_server.listen(5)
        while True:
            tcpSerSock,addr=self.tcp_server.accept() #阻塞等待连接
            # tcpSerSock.recv(buffersize=bufsize)
            length=tcpSerSock.recv(4)               #在网卡缓冲中取出前4个字节（在客户端l四个字节，定义的是消息的长度）
            length,*_=struct.unpack('<l',length)    #反解析
            mes=tcpSerSock.recv(length)             #取出消息
            mes,*_=struct.unpack('<{}s'.format(length),mes) #把多少个字符转为json
            print(json.loads(mes))                   #反json
            time.sleep(1)
        tcpSerSock.close()                          #关闭连接
    def tcp_close(self):
        self.tcp_server.close()
    def udp_sockt(self):
        return  socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
if __name__=='__main__':
    tcp=lear_socket()
    try:
        tcp.tcp_sockt()
    except KeyboardInterrupt:
        pass
    finally:
        tcp.tcp_close()

########Client######################
import socket,json,sys,struct
d=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
host='127.0.0.1'
port=5001
data=json.dumps('我是谁？').encode()
leng=len(data)
print(leng)
d.connect((host,port))
d.send(struct.pack('<l{}s'.format(leng),leng,data)) #l表示4个字节，leng*s 的字符
d.close()
###################socketserver#####
# socketserver #支持tcp udp unix
# from socketserver import BaseRequestHandler
# from socketserver import ThreadingTCPServer #基于线程的tcpserver
#
# class MasterHandler(BaseRequestHandler):
#     def handle(self):
#         self.data = self.request.recv(1024).strip() #接收
#         print("{} wrote:".format(self.client_address[0]))
#         print(self.data)
#         self.request.sendall(self.data.upper()) #发送
#
#
# if __name__ == "__main__":
#     HOST, PORT = "localhost", 9999
#     #server = TCPServer((HOST, PORT), MasterHandler) #绑定IP端口，类
#     server = ThreadingTCPServer((HOST, PORT), MasterHandler) #绑定IP端口，类
#     server.serve_forever() #开启监听
