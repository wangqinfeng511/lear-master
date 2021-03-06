### socket

#### create socket

```c++
int socket(int domain,int type,int protocol);
return fd 文件描述符。-1表示错误
```

##### 	domain 协议族:

​		AF_UNIX  unix本地通信。
​		AF_LOCAL unix本地通信。
​		AF_INET	 IPV4 Internet协议。

##### 	type:

​		SOCK_STREAM	可靠的双向连接，基于字节流,不保留记录边界。
​		SOCK_DGRAM	无连接，不可靠固定长度。
​		SOCK_SEQPACKET	可靠的双向连接，基于字节流。与SOCK_STREAM不同的是，它保留消息边界。(表明发送两个数据包，只能分两次读入，稍后详细解释)
​		SOCK_RAW	提供Raw数据。
​		SOCK_RDM	提供可靠的数据（顺序不确定）。
​		protocol 设置为０

#### 地址存储结构体：

##### 	struct sockaddr; 

​		所有的链接都要用这个结构体。

##### 	htons(int port)

​		 把数字端口转为系统可识别的端口号。

##### 	inet_addr(char * ip)

​		 把字符串转为系统识别的地址。

##### 	htonl(INADDR_ANY)

 		把0.0.0.0转换为系统识别的地址。

##### 	struct sockaddr_in;

```c++
//便于操作的sockadd，方便设置地址端口。
sockaddr_in::sin_addr.s_addr=inet_addr("192.168.0.1"); //设置地址
sockaddr_in::sin_port=htons(80); //设置端口。
sockaddr_in::sin_addr.s_addr=htonl(INADDR_ANY) ;//设置地址为0.0.0.0
```



##### 	struct sockaddr_storage

​		 也是sockaddr的变体。

##### 	reinterpret_cast:

​		 结构体互转。

##### 	notes():

​	从结构体中取出端口号字符。

​	返回char*类型。

```c++
ntohs((reinterpret_cast<struct sockaddr_in *>(&addr)->sin_port)) //端口号。
```

##### 	inet_ntoa:

​	从结构体中取出IP地址字符。

```c++
inet_ntoa(((struct sockaddr_in *)&addr)->sin_addr); //IP地址
	//*reinterpret_cast是明转化，下面IP地址是隐式转化。	
	//取出链接后或bind后的 sockfd 的sockaddr然后再读取地址。
getsockname(int socket_fd,struct sockaddr *addr,int &addr_len);	
	//取出链接后对端的 sockfd 的sockaddr然后再读取地址。
getpeername(int socket_fd,struct sockaddr *addr,int &addr_len);
```

#### addrinfo dns解析结构体。

##### addrinfo:

```c++
//指定协议簇。
addrinfo::ai_family
		AF_INET 2 IPV4
		AF_INET6	23	IPV6
		AF_UNSPEC	0	协议无关。
//指定socket类型。
addrinfo::ai_socktype
		SOCK_STREAM 或 SOCK_DGRAM  socket类型。
addrinfo::ai_flags
		//测试不知道有啥用
		AI_ADDRCONFIG	//查询配置的地址类型（）
		AI_PASSIVE	//套接字地址用于监听绑定。
addrinfo::ai_addr *sockaddr //指针。
```

##### getaddrinfo	

getaddrinfo(char *host_name,char *port,const struct addrinfo *base,struct addrinfo ** out_list)
	按照base的设定参考解析host_name:port的dns地址写入out_list链表。

```c++
//例子：
struct   addrinfo test;
memset(&test,0,sizeof (test));
test.ai_family=AF_UNSPEC;
test.ai_socktype=SOCK_STREAM;
test.ai_flags=AI_PASSIVE;
struct addrinfo *test1=(addrinfo *)malloc(sizeof (addrinfo));;
char port[]="443";
int rv=getaddrinfo("www.jd.com",port,(const struct addrinfo *)&test,&test1);
if(rv!=0){
        		qDebug()<<"解析失败";
   }
		#for (auto rp = result; rp; rp = rp->ai_next) 也可以这样写
for(auto p=test1;p!=nullptr;p->ai_next){
	qDebug()<<inet_ntoa(((sockaddr_in*)p->ai_addr)->sin_addr)<<":"<<ntohs(((sockaddr_in *)p->ai_addr)->sin_port);
  if(p->ai_next==nullptr){
		break;}
  	else {
			p=p->ai_next;
        	}
    }
```

##### setsocketopt 套接字设置：

```c++
SO_REUSEADDR 	bool	 	//允许套接字和一个已经在使用的地址捆绑，bind之前设置。
SO_SNDTIMEO	int				//发送数据超时时间毫秒。
SO_RCVTIMEO	int				//接收数据超时时间毫秒。
SO_RCVBUF	int 				//接收缓存区大小。
SO_SNDBUF	int					//发送缓存区大小。
SO_BROADCAST	bool		//是否广播。
SO_CONITONAL_ACCEPT		//在服务端执行accept()之前客户端发不了数据过来，在客户端发fin时返回rest.
SO_LINGER	struct linger;	//设置socket的close()方式
				struct linger{
					int l-onoff;
					int l_linger;
				}
			//l_onoff为0时该选项关闭，l_linger的值被忽略。使用默认的close方式关闭。
			//l_onoff非0时：
				　//以l_linger为0.　丢掉未数据直接关闭
				　//以l_linger设置的超时时间执行close。在时间内数据没发送完也关闭。
SO_DEBUG	bool	//打开调试信息。
SO_DONTLINER	BOOL 	//相等于SO_LINGER 的linger的为0.
SO_KEEPALIVE	BOOL	//检测客户端是否在线，心跳包。
TCP_NODELAY	BOOL		//禁止发送合并的Nagle算法。
```

```c++
//例：
bool bDontLinger = false;
setsockopt(sock_fd,SOL_SOCKET,SO_REUSEPORT,(const char*)&bDontLinger,sizeof(bool));
```



#### socks bind：

```c++
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
struct sockaddr_in servaddr;
servaddr.sin_family=AF_INET;
servaddr.sin_addr.s_addr=htonl(INADDR_ANY);// 0.0.0.0
				#inet_addr("0.0.0.0"); 同上
servaddr.sin_port=htons(8088);
status=bind(lisent_fd,(sockaddr *)&servaddr,sizeof (servaddr));
	//参数：
		1.socket文件描述符．
		2.sockaddr结构体指针
		3.sockaddr长度．
```

#### listen：

```c++
listen(lisent_fd,25); //参数：1 socket_fd文件描述符．2．．返回：错误返回-1;
```

##### 取新连接的文件描述符：

```c++
struct sockaddr clinet_addr; //存连接的地址
socklen_t addr_len;　
int client_fd;　//返回文件描述符，错时返回-1;
client_fd=accept(listent_socket_fd,(sockaddr*)&clinet_addr,&addr_len);
```

##### 客户端链接:

```c++
int socke_fd=socket(AF_INET,SOCK_STREAM,0);
struct sockaddr_in addr_ser;
addr_ser.sin_addr.s_addr=inet_addr("39.156.66.18");
addr_ser.sin_port=htons(80);
int status= connect(socke_fd,(sockaddr*)&addr_ser,sizeof (addr_ser));
//链接成功0；
```

##### 读取数据：

```c++
int recv( SOCKET s,char* buf,int len,int flags);  
flags //默认为0；
//返回读取到的数据长度。
```

##### 写数据：

```c++
int send( SOCKET s,const char* buf,int len,int flags);
flags //默认为0；
//返回发送的数据长度。
```

#### errno:

```c++
EACCES,EPERM：//权限不足/防火墙限制。
EADDRINUSE:		//本地址已经使用。
EADDRNOTAVAIL: //socketfd引用的套接字未绑定到地址！
EAFNOSUPPORT:		//sa_family 错误。
EFAULF:				//套接字结构地址空间，在用户空间之外。
EINPROGRESS/EAGIN: 	//套接字是非阻塞，数据暂未准备就绪。
EINTR:					//慢系统调用。
EISCONN					//套接字已连接，重复连接。
ENETUNREACH			//网络不可达。
EPROTOTYPE:			//套接字类型不支持请求通信。
ETIMEDOUT:			//连接超时。					 
EWOULDBLOCK:		//用于非阻塞模式，不需要重新读或者写。
ECONNABORTED:		//连接中断。
EPERM		 1			//不允许操作
ENOENT		 2		//目录不存在
ESRCH		 3			//进程不存在	
#define	EINTR		 4 	中断系统调用	
#define	EIO		 5	I/O错误
#define	ENXIO		 6	没有设备地址!/* No such device or address */
#define	E2BIG		 7	参数列表太长! /* Argument list too long */
#define	ENOEXEC		 8	Exec格式错误! /* Exec format error */
#define	EBADF		 9	错误的文件号! /* Bad file number */
#define	ECHILD		10	没有子进程! /* No child processes */
#define	EAGAIN		11	再试一次! /* Try again */
#define	ENOMEM		12	内存不足! /* Out of memory */
#define	EACCES		13	权限被拒绝! /* Permission denied */
#define	EFAULT		14	地址错误! /* Bad address */
#define	ENOTBLK		15	需要块设备! /* Block device required */
#define	EBUSY		16	设备或资源忙! /* Device or resource busy */
#define	EEXIST		17	文件存在! /* File exists */
#define	EXDEV		18	跨设备链接! /* Cross-device link */
#define	ENODEV		19	设备不存在! /* No such device */
#define	ENOTDIR		20	目录不存在! /* Not a directory */
#define	EISDIR		21	是一个目录! /* Is a directory */
#define	EINVAL		22	无效参数! /* Invalid argument */
#define	ENFILE		23	文件表溢出! /* File table overflow */
#define	EMFILE		24	打开的文件太多 /* Too many open files */
#define	ENOTTY		25	不是写入类型 /* Not a typewriter */
#define	ETXTBSY		26	文本文件忙 /* Text file busy */
#define	EFBIG		27	文件过大 /* File too large */
#define	ENOSPC		28	设备上没有剩余空间 /* No space left on device */
#define	ESPIPE		29	非法的seek /* Illegal seek */
#define	EROFS		30	只读文件系统 /* Read-only file system */
#define	EMLINK		31	链接太多! /* Too many links */
#define	EPIPE		32	管道破裂! /* Broken pipe */
#define	EDOM		33	 /* Math argument out of domain of func */
#define	ERANGE		34	数学结果不可表示 /* Math result not representable */
#define	EDEADLK		35	资源死锁会发生 /* Resource deadlock would occur */
#define	ENAMETOOLONG	36	文件名太长 /* File name too long */
#define	ENOLCK		37	没有可用的记录锁 /* No record locks available */

/*

 * This error code is special: arch syscall entry code will return
 * -ENOSYS if users try to call a syscall that doesn't exist.  To keep
 * failures of syscalls that really do exist distinguishable from
 * failures due to attempts to use a nonexistent syscall, syscall
 * implementations should refrain from returning -ENOSYS.
   */
   #define	ENOSYS		38	/* Invalid system call number */

#define	ENOTEMPTY	39	目录不为空 /* Directory not empty */
#define	ELOOP		40	太多符号链接 /* Too many symbolic links encountered */
#define	EWOULDBLOCK	EAGAIN	操作会阻塞/* Operation would block */
#define	ENOMSG		42	没有所需类型的消息 /* No message of desired type */
#define	EIDRM		43	标识符已删除/* Identifier removed */
#define	ECHRNG		44	/* Channel number out of range */
#define	EL2NSYNC	45	/* Level 2 not synchronized */
#define	EL3HLT		46	/* Level 3 halted */
#define	EL3RST		47	/* Level 3 reset */
#define	ELNRNG		48	/* Link number out of range */
#define	EUNATCH		49	/* Protocol driver not attached */
#define	ENOCSI		50	/* No CSI structure available */
#define	EL2HLT		51	/* Level 2 halted */
#define	EBADE		52	/* Invalid exchange */
#define	EBADR		53	/* Invalid request descriptor */
#define	EXFULL		54	/* Exchange full */
#define	ENOANO		55	/* No anode */
#define	EBADRQC		56	/* Invalid request code */
#define	EBADSLT		57	/* Invalid slot */

#define	EDEADLOCK	EDEADLK

#define	EBFONT		59	/* Bad font file format */
#define	ENOSTR		60	/* Device not a stream */
#define	ENODATA		61	/* No data available */
#define	ETIME		62	/* Timer expired */
#define	ENOSR		63	/* Out of streams resources */
#define	ENONET		64	/* Machine is not on the network */
#define	ENOPKG		65	/* Package not installed */
#define	EREMOTE		66	/* Object is remote */
#define	ENOLINK		67	/* Link has been severed */
#define	EADV		68	/* Advertise error */
#define	ESRMNT		69	/* Srmount error */
#define	ECOMM		70	/* Communication error on send */
#define	EPROTO		71	/* Protocol error */
#define	EMULTIHOP	72	/* Multihop attempted */
#define	EDOTDOT		73	/* RFS specific error */
#define	EBADMSG		74	/* Not a data message */
#define	EOVERFLOW	75	/* Value too large for defined data type */
#define	ENOTUNIQ	76	/* Name not unique on network */
#define	EBADFD		77	/* File descriptor in bad state */
#define	EREMCHG		78	/* Remote address changed */
#define	ELIBACC		79	/* Can not access a needed shared library */
#define	ELIBBAD		80	/* Accessing a corrupted shared library */
#define	ELIBSCN		81	/* .lib section in a.out corrupted */
#define	ELIBMAX		82	/* Attempting to link in too many shared libraries */
#define	ELIBEXEC	83	/* Cannot exec a shared library directly */
#define	EILSEQ		84	/* Illegal byte sequence */
#define	ERESTART	85	/* Interrupted system call should be restarted */
#define	ESTRPIPE	86	/* Streams pipe error */
#define	EUSERS		87	/* Too many users */
#define	ENOTSOCK	88	/* Socket operation on non-socket */
#define	EDESTADDRREQ	89	/* Destination address required */
#define	EMSGSIZE	90	/* Message too long */
#define	EPROTOTYPE	91	/* Protocol wrong type for socket */
#define	ENOPROTOOPT	92	/* Protocol not available */
#define	EPROTONOSUPPORT	93	/* Protocol not supported */
#define	ESOCKTNOSUPPORT	94	/* Socket type not supported */
#define	EOPNOTSUPP	95	/* Operation not supported on transport endpoint */
#define	EPFNOSUPPORT	96	/* Protocol family not supported */
#define	EAFNOSUPPORT	97	/* Address family not supported by protocol */
#define	EADDRINUSE	98	地址已被使用/* Address already in use */
#define	EADDRNOTAVAIL	99	/* Cannot assign requested address */
#define	ENETDOWN	100	/* Network is down */
#define	ENETUNREACH	101	/* Network is unreachable */
#define	ENETRESET	102	/* Network dropped connection because of reset */
#define	ECONNABORTED	103	/* Software caused connection abort */
#define	ECONNRESET	104	/* Connection reset by peer */
#define	ENOBUFS		105	/* No buffer space available */
#define	EISCONN		106	/* Transport endpoint is already connected */
#define	ENOTCONN	107	/* Transport endpoint is not connected */
#define	ESHUTDOWN	108	/* Cannot send after transport endpoint shutdown */
#define	ETOOMANYREFS	109	/* Too many references: cannot splice */
#define	ETIMEDOUT	110	/* Connection timed out */
#define	ECONNREFUSED	111	/* Connection refused */
#define	EHOSTDOWN	112	/* Host is down */
#define	EHOSTUNREACH	113	/* No route to host */
#define	EALREADY	114	/* Operation already in progress */
#define	EINPROGRESS	115	/* Operation now in progress */
#define	ESTALE		116	/* Stale file handle */
#define	EUCLEAN		117	/* Structure needs cleaning */
#define	ENOTNAM		118	/* Not a XENIX named type file */
#define	ENAVAIL		119	/* No XENIX semaphores available */
#define	EISNAM		120	/* Is a named type file */
#define	EREMOTEIO	121	/* Remote I/O error */
#define	EDQUOT		122	/* Quota exceeded */

#define	ENOMEDIUM	123	/* No medium found */
#define	EMEDIUMTYPE	124	/* Wrong medium type */
#define	ECANCELED	125	/* Operation Canceled */
#define	ENOKEY		126	/* Required key not available */
#define	EKEYEXPIRED	127	/* Key has expired */
#define	EKEYREVOKED	128	/* Key has been revoked */
#define	EKEYREJECTED	129	/* Key was rejected by service */

/* for robust mutexes */
#define	EOWNERDEAD	130	/* Owner died */
#define	ENOTRECOVERABLE	131	国家不可追回/* State not recoverable */

#define ERFKILL		132	由于射频干扰，无法进行操作/* Operation not possible due to RF-kill */

#define EHWPOISON	133	内存页面出现硬件错误/* Memory page has hardware error */
		
```

#### 文件描述符设置：

```c++
//阻塞于非阻塞。	
SOCK_NONBLOCK
SOCK_CLOEXEC
//描述符设置：
 int fcntl(int fd,int cmd);
 int fcntl(int fd,int cmd,long arg)
 int fcntl(int fd,int cmd,struct flock *lock);

参数：
 fd://文件描述符
 cmd://操作命令。
 arg: //命令使用的参数。
 lock://同上？
cmd操作命令：
一、F_DUPFD :		//复制文件描述符
二、FD_CLOEXEC: //设置close-on-exec标志。
三、F_GETFD:		//读取文件描述标志。
四、F_SETFD: 		//设置文件描述符标志。
五、F_GETFL:		//读取文件描述符状态标准。
六、F_SETFL:		//设置文件描述符状态标志。
```

```c++
//例：设置非阻塞．
	int iFlags=fcntl(client_fd,F_GETFL,0);
        fcntl(client_fd,F_SETFL,iFlags|O_NONBLOCK);
```




