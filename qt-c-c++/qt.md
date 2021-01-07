## 环境

### 安卓环境：

#### 	下载 jdk  (java) 1.8以上

#### 	下载commandline  

​		https://developer.android.com/studio
​			commandlinetools-mac-6858069_latest.zip

#### 安装：ndk

```bash
./sdkmanager --sdk_root=<ANDROID_SDK_ROOT> --install "cmdline-tools;latest"
./sdkmanager --sdk_root=<ANDROID_SDK_ROOT> --install "platform-tools" "platforms;android-29" "build-tools;29.0.2" "ndk;21.3.6528147"
```

#### 设置设备-安卓jdk，　ndk的位置：

​		我的JDK:
​			/Library/Java/JavaVirtualMachines/jdk1.8.0_271.jdk/Contents/Home
​		我的SDK:
​			/Users/wangqinfeng/mysdk
​		我的NDK:
​			/Users/wangqinfeng/mysdk/ndk/21.3.6528147  	

#### 添加安卓kits:

设置：device 为刚添加的安卓。	
	

### 数据库安装：

#### qmysql

```bash
brew install mysql-client
brew info mysql-client; 
```

修改src/plugins/sqldrivers/mysql.pro

```bash
TARGET = qsqlmysql
#mysql-client的头文件目录下要有mysql.h
INCLUDEPATH += "/usr/local/Cellar/mysql-client/8.0.22/include/mysql"
#-L mysql-client/lib的路径， -lmysqlclient.21 //引用libmysqlclient.21.dlyt
LIBS += -L/usr/local/Cellar/mysql-client/8.0.22/lib -lmysqlclient.21

#sqldrivers的路径

DESTDIR = "/Users/wangqinfeng/Src/qtbase/src/plugins/sqldrivers"
HEADERS += $$PWD/qsql_mysql_p.h
SOURCES += $$PWD/qsql_mysql.cpp $$PWD/main.cpp
#注释此行
#QMAKE_USE += mysql
OTHER_FILES += mysql.json
PLUGIN_CLASS_NAME = QMYSQLDriverPlugin
include(../qsqldriverbase.pri)
```

```bash
qmake	#编译。
make	#编译
make install	#安装
```

#### qoci：

下载最新版的orcl的包：
	https://www.oracle.com/database/technologies/instant-client/macos-intel-x86-downloads.html
	instantclient-basic-macos.x64-19.8.0.0.0dbru.zip
	instantclient-sdk-macos.x64-19.8.0.0.0dbru.zip

```bash
#移动：
mv /usr/local/Cellar/orcle_client/
```

```bash
#注释掉
	oci.pro 的
#QMAKE_USE += oci
#编译makefile:
~/Qt5.14.2/5.14.2/clang_64/bin/qmake  "INCLUDEPATH+=/usr/local/Cellar/orcle_client/instantclient_19_8/sdk/include" "LIBS+=-L/usr/local/Cellar/orcle_client/instantclient_19_8 -Wl,-rpath,/usr/local/Cellar/orcle_client/instantclient_19_8 -lclntsh -lnnz19"
#编译：
make
#安装：
make install
```

## QT

### 数据类型

#### QJsonObject

```c++
QJsonObject tmp;
tmp.insert("key","value") //插入数据
tmp.value("key").toString() //读出key的数据并转为字符串
```

#### QJsonArray

```c++
QJsonArray tmps
tmps.append(tmp) //压入一个Qobjectjson到列表中.
```

#### QString

```c++
QString("%0,%1").arg(1,2) //字符串合并
```

#### QDataStream_数据流

```c++
QDataStream tmp_stream(QByteAall * request,QIODevice::ReadWrite)  //读写流
tmp_stream.device.seek(0)  //移动seek位置
tmp_stream.atEnd() //是否读到结尾 取数据用
	int x=521
	tmp_stream<<(int)x; // 追加一个int数据
	int y=0;
	tmp_stream>>y; //在当前seek位置取出4个char,int是4个char
```

#### QByteArray

#### QList	

### 网络

#### QTcpsocket

```c++
QTcpsocket connect
connect.connectToHost("xxx.xxx.xxx.xxx",int port,QIODevice::ReadWrite)//创建连接
connect.waitForConnected(-1) //连接阻塞
connect.state() //返回连接当前状态
QAbstractSocket::UnconnectedState //socket未连接
QAbstractSocket::HostLookupState //socket正在执行主机名查找
QAbstractSocket::ConnectingState //socket 连接中
QAbstractSocket::ConnectedState //socket连接成功
QAbstractSocket::BoundState //socket绑定到地址和端口
QAbstractSocket::ClosingState //socket套接字即将关闭
QAbstractSocket::ListeningState //socket仅限内部使用。
connect.write(send_bytarray) //写入数据
connect.waitForBytesWritten(int timeout) //写入阻塞直到写完,默认超时3000毫秒
connect.waitForReadyRead() //阻塞直到有数据返回
connect.readall() //读出所有数据
waitForDisconnected() //阻塞直到断开连接
this->setSocketDescriptor(soketDescriptor); //根据fd描述符修改连接
//信号
readyRead() //有数据可读
connected() //连接成功信号
disconnected() //断开连接信号
error(QAbstractSocket::SocketError socketError) //错误信号
hostFound() //查找主机成功信号
stateChanged（QAbstractSocket :: SocketState socketState） //状态切换。
```

#### QTcpserver

```c++
class tcp_server:pubic QTcpserver{}
protected: void incomingConnection(qintptr soketnember); //在有新连接时执行
					//soketnember 文件描述符,通过描述符创建一个新连接
xxx.listen(QHostAddress::Any,intport)//监听端口	
```

#### epoll

```c++
#include<sys/epoll.h>
int epoll_create(int size)
int epoll_create1(int size) //创建epoll队列,返回epoll队列文件描述符
int epoll_ctl(int epfd,int op,int fd,struct epoll_event *event); //epoll事件注册函数
	//参数一:epoll队列文件描述符
	//参数二:动作
	EPOLL_CTL_ADD
	//注册新的描述符到epoll队列中
	EPOLL_CTL_MOD
	//修改已经注册的描述符事件
	EPOLL_CTL_DEL
	//在epoll队列中删除一个描述符
	//参数三:需要监听的描述符
	//参数四:监听的事件
	struct epoll_event{__uint32_t events; epoll_data_t data;}
		参数一:事件
			EPOLLIN
			//表示对应用的文件描述符可读(包括已经断开的socket)
			EPOLLOUT
			//表示对应的文件描述符可写
			EPOLLPRI
			//表示对应的文件描述符有紧急的数据可读
			EPOLLET
			//边缘触发
			EPOLLONESHOT
			//只监听一次事件,当监听完这次事件后从队列里移除
		//参数二:描述符值类型
		typedef epoll_data{void *ptr;;int fd;uint32_3 u32; uint64_t u64;}
int epoll_wati(int epfd,struct epoll_event *events,int maxevents,int timeout)
	//返回触发事件的描述符数量
	//参数一:epoll队列的描述符
	//参数二:从内核得到的事件集合
	//参数三:告诉内核这个事件集合有多大,也就是一次最多取队列里的多少
	//参数四:超时时间,0立即返回,-1阻塞
	//LT:默认模式:检查到未处理事件返回时,如果未处理事件,下次会再发送
	//ET:检查到未处理事件时只发送一次
```

### 目录操作

```c++
QDir
QDir xxx("/xxx/xxx")
bool QDir::exists()  
//文件目录是否存在
QDir::mkpath("./")
//创建目录,比如目录不存在就创建目录
```

### 数据库

pro 添加sql

#### QSQLdatabase

```c++
QSqldatabase db;
db.contains("xxxx")
//数据库连接是否存在
db.removeDatabase("xxxx")
//删除连接
db=QSqlDatabase("QMYSQL","xxxxx");
//实例化连接
db.setHostName("xxx.xxx.xxx.xxx")
//设置数据库连接地址
//db.setDatabaseName("xxx")
//设置连接哪个数据库
db.setUserName("xxx")
//设置用户名
db.setPassword("xxxx")
//设置密码
db.open()
//打开数据库连接
db.connectionName()
//返回连接的名字
db.isValid()
//是否可用
QSQLdatabase::removeDatabase(db.connectionName())
//删除一个连接
```

#### QSqlQuery

```c++
QSqlQuery query_db(db_打开后的数据库)
query_db.prepare("select  id from user whrer id=:id")
//添加数据库语句并设置:id变量
query_db.bindValue(":id",1)
//设置变量:id的值为1,有点像jinja2的模板字符串替换
query_db.exe()
//执行语句
query_db.next()
//返回缓中待读取数据的数量,比如查询结束后用
while(query_db.next()){
    qDebug()<<query_db.value("id").toInt()
}
query_db.value("id").toInt|tostring|.....
//返回第一条数据
```

### com口操作

#### QSerialPort

```c++
QSerialPort  *com=new QSerialPort
com->setPortName("/dev/xxx")
//设置设备节点的名称
com->setBaudRate(QSerialPort::Baud9600)
//设置波特率
com->setDataBits(QSerialPort::Data8)
//数据位:每个字符中的数据位数为8位
com->setStopBits(QSerialPort::OneStop);
//1位停止位
com->setParity(QSerialPort::NoParity)
//无校验位
com->setFlowControl(QSerialPort::NoFlowControl)
//无控制位
com->open(QSerialPort::ReadWrite)
//打开com口
com->isOpen()
//是否打开成功
com->waitForReadyEead(-1)
//阻塞读
com->write(QByteArray requset)
//写入数据
com->readAll()
//读出传入的所有数据
```

#### QSerialPortInfo

```c++
QList<QSerialPortInfo> xx=QSerialPortInfo::availablePorts();
//返回可用的com口信息列表
```

### signal

```c++
signals: void date_time_update(int xxx);
connect(this,SIGNAL(data_time_update(int)),SOLT(xxx(int)))
//连接信号和槽
```

### 	QPixmap

```c++
QPixmap page_image
save(QBuffer *buff,"jpg")
```

### QBuffer

```
QBuffer buff(&bytes)
buff.open(QIODevice::WriteOnly)
```

### QQuickImageProvider

```c++
class desktop_capture:public QQuickImageProvider{}
QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize); //返回qpixmap
return QPixmap tmp_image_t;
engine.addImageProvider(QLatin1String("tmp_image"),server_connect.desk_top);
//main.c
source: "image://tmp_image/aa"
//qml
```

```c++
class desktop_capture:public QQuickImageProvider{
public:
   desktop_capture();
  ~desktop_capture();
   QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize); //返回qpixmap
//        QPixmap img;
        QByteArray img;
};
```



### QObject

```c++
Q_OBJECT
Q_INVOKABLE Q_INVOKABLE void set_cursor_png(QString png);
//qml 调用方法
engine.rootContext()->setContextProperty("Api",&api);
//实例化,注册给上下文,qml调用
```

### 窗口透明化

```c++
QObject *topLevel = engine.rootObjects().value(0);
QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);
window->show();
window->setFlags(Qt::FramelessWindowHint);
```

### http

#### QSslConfiguration config

```c++
//ssl设置
config.setPeerVerifyMode(QSslSocket::VerifyNone)
config.setProtocol(QSsl::TlsV1_0)
//设置版本
```

#### QNetworkRequest	

```c++
QNetworkRequest req
//实例化request
req.setUrl(Qurl(http://xxxxxx))
//设置请求的url
req.setHeader(QNetworkRequest::ContentTypeHeader,"application/json")
//设置请求头部
```

#### QNetworkReply

```c++
QNetworkReply *rsp;
//返回的数据类型
rsp->readAll()
```

#### QNetworkAccessManage

```c++
QNetworkAccessManage* manager=new QNetworkQccessManager;
rsp=manager->post(req,QJsonDocument(data),toJson)
rsp=manager->get(req,QJsonDocument(data),toJson)
//信号
finished(QNetworkReply *)
```

#### QCryptographicHash

```c++
QCryptographicHash t(QCryptographicHash::Md5);
//md5类实例化
t.addData("Wangqinfeng511")
//添加数据
t.result().toHex()
//md5转16进制
```

### QQuickPaintedItem

画图

```c++
class display_content_background:public QQuickPaintedItem
{
    Q_OBJECT
public:
    display_content_background();
    void paint(QPainter *painter); //
    void update_painter();
private:
    QPainter *m_painter;
};
```

```c++
void paint(QPainter *painter);
//执行画图
QPainter
//画
QPainter m_painter
m_painter.setPen(QPen)
//设置画笔
m_painter.setRenderHints(QPainter::Antialiasing)
//抗锯齿
QBrush brush
//笔刷
brush=QBrush(gradient_渐变辉光);
m_painter.setBrush(brush)
//设置笔刷
m_painter.drawChord(yuan,180*16,180*16)
//画圆
m_painter.drawPath(path)
//绘画路径
setRenderHints(QPainter::Antialiasing) 
//抗锯齿
QRadialGradient
//放射辉光渐变
QRadialGradient gradient(x_center+yuan_banjing,y_center+yuan_banjing,yuan_banjing)
//查看文档 https://doc.qt.io/qt-5/qradialgradient.html
QLineGradient
//线性渐变
QpainterPath path
//路径
path.moveTo(x,y)
path.lineTo(x,y)
QRectF
		QRectF yuan(x_center,y_center,yuan_width,yuan_height);
Pen
//画笔
QPen pen
pen.setColor(qRgba(0,0,0,2))
//设置画笔颜色
pen.setWidth(1)
//设置画笔宽度
```

​	注册

```c++
	qmlRegisterType<类名>("模版名",1,0,'模块名')
```




## Quick

### Rectangle

```qml
width
height
color
x,y
border.width
border.color
raduis
```

### FontLoader	

```c++
source:"qrc:/static/font/FZSJ-ZJYTJW.TTF"
//加载自定义字体
```

### Image

```c++
source
width
height
x.y
```

### 布局

#### Row

横布局

#### Column

竖布局

#### Grid

网格布局

#### Flow

自动化网格布局

#### 锚布局

##### anchors

```c++
horizontalCenter: parent.horizontalCenter
//水平居中
left:parent.left
//左对齐
leftMargin:10
//左偏移
bottom:parent.bottom
//下对齐
bottomMargin:10
//上偏移
centerIn:parent
//居中
top:parent.top
//上对齐
topMargin:10
//上偏移
right:parent.right
//右对齐
rightMargin:10
//右对齐
```

#### Window

​		同Recatangel

#### MouseArea

```c++
hoverEnabled:true
//打开移动
onPressed:{}
//鼠标按下
onPositionChanged:{}
//鼠标移动
onClicked:{}
//鼠标单击
onEntered{}
//鼠标进入
onExited:{}
//鼠标退出
onWheel:{}
//鼠标滚轮
onReleased:{}
//鼠标释放
onpressAndHold:{}
//鼠标长按800ms以上
onDoubleClicked
//双击

```

### Connections

```c++
target:Api
//对象
onXXX:{}
//对象的信号
```

### Pathview

#### 		Path

```c++
startX:0
//X起始点
startY:0
//Y起始点
PathAttribute{name:"touming";value:0.5}
//0.5自定义属性用于pathview compont 的属性
PathQuad { x： 200 ; y： 0 ; controlX： 100 ; controlY： 150 }
//弧度线
PathLine{x:0,x:10}
//直线
```

#### 	Pathview

```c++
path:path
//指定路径
model:
//代理数据ID:int|jsonobject|listModel
pathItemCount:5
//间隔
preferredHighlightBegin:0.5
//高亮起始百分比
preferredHighlightEnd:0.5
//高亮结束百分比
snapMode:PathView.SnapOneItem
//此属性确定拖动停止方式
    PathView .NoSnap
    //项目在路径上的任何位置停止
    PathView .SnapToItem
    //项目以与preferredHighlightBegin对齐的项目结算
    PathView .SnapOneItem
    //与最近的preferredHighlightBegin项的距离不超过一个项目
delegate:Component_id
//代理模块ID
```

### 像素选择

```c++
QQuickitem *obj
auto dom=obj->grabToImage()
QObject::connect(dom.data,&QQuickItemGrabResult::ready,[&](){dom->image()})
//注意：初始化时执行一次，生成浀e
QRgb c=image.pixel(x,y)
QEventLoop ev
ev.exec()
```



### ListView

```c++
model
delegate
width
height
```

### TextInput

​		

```c++
horizontalAlignment: TextInput.AlignHCenter
//左右居中，没有水平居中
font.pixelSize
//（像素）字大小
font.pointSize
//(点)字大小
echoMode
	TextInput.Normal
	//默认
	TextInput.Password
	//显示为*号
	TextInput.NoEcho
	//不显示
	TextInput .PasswordEchoOnEdit
	//显示在编辑时输入的字符，否则显示星号
font.family
//字体的名称
font.italic:
//是否邪体
font.bold
//是否粗体
font.strikeout:
//删除线
font.underline
//下划线
font.letterSpacing
//字间距
activeFocusOnPress
//是否启用焦点
inputMethodHints
//合法输入
horizontalAlignment:Text.AlignHCenter
//居中对齐
```


