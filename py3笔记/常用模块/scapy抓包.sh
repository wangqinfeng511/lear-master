pip3 install scapy-python3 #用于攻击和网络发现。抓包。
构建报文包：
  a=Ether()/IP(dst="192.168.99.143")/TCP()/b"GET /index.html HTTP/1.0"
    执行  	     IP协议部分              TCP协议部分
 hexdump(a) 转为16进制 #可没有
 b=bytes(a) 转为网络传输的bytes
 c=Ether(b) 执行报文
 c.hide_defaults() #删除版本等信息
 a=rdpcap("/spare/captures/isakmp.cap") 读入一个文件。

#####################################################################
>>> a=IP(dst="192.168.12.20") 定义IP层的目标地址
>>> [p for p in a] #执行发包
>>> b=IP(ttl=[1,2,(5,9)])    #定义IP报文的 TTL值
>>> [p for p in b]	　　　#徇环查看
>>> c=TCP(dport=[80,443])     #定义TCP层报文的端口号
>>> [p for p in a/c]		#执行发包
####################################################################
summary()	displays a list of summaries of each packet
nsummary()	same as previous, with the packet number
conversations()	displays a graph of conversations
show()	displays the prefered representation (usually nsummary())
filter()	returns a packet list filtered with a lambda function
hexdump()	returns a hexdump of all packets
hexraw()	returns a hexdump of the Raw layer of all packets
padding()	returns a hexdump of packets with padding
nzpadding()	returns a hexdump of packets with non-zero padding
plot()	plots a lambda function applied to the packet list
make table()	displays a table according to a lambda function
##########################################################################
发送数据包：send()三层报文。
	    sendp()二层报文。

	
