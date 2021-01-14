# 协议简介：

## RTSP 

实时流协议：

负责客户端 rtcp端口的分配和管理：

客户端链接--分配rtcp端口

## RTCP

实时传输控制协议：

负责对rtp端口的分配和管理：

负责对客户端事件的响应控制（比如收到快进，跳转，暂停，播放等事件时对rtp流的响应控制）

### RTP

实时传输协议：

真正用来传输帧数据的（端口）和协议

---

## 请求流程

。。。。

# 编译X265

brew install x265 安装不支持macos big sur报错。

### hevc编码库.

```bash
git clone https://github.com/videolan/x265.git
cd x265/build/linux
bash ./make-Makefiles.bash
make 
make install
```

###  yuv420

x265不支持jpeg,png等图片图片编码成视频。所以要转化成yuv420

#### yuv420数据结构：

##### yuv

“Y”表示[明亮度](https://zh.wikipedia.org/wiki/流明)**（Luminance、Luma），“U”和“V”则是**[色度](https://zh.wikipedia.org/wiki/色度_(色彩学))**、**[浓度](https://zh.wikipedia.org/wiki/濃度_(色彩學))。

 也就是先：所有像素的<font color=blue>明亮度列表Y</font>+<font color=blue>所有像素的色调列表U</font>+<font color=blue>所有像素的浓度列表V</font>。

##### yuv4:2:0

 也就是：Y列表不变，U列表4个只保留一个， V列表四个只保留一个。

##### rgb:

一个像素由rgb组成，一个r或g后b为8bit。也就是说一个像素由24位组成。

一个1024*768的rgb图像原图（此处原图非图片）大小为1024\*768\*24=18874358bit=18.8Mbit

#####  rgb_to_yuv:

​	y=0.299*r+0.587*g+0.114*b;

​	u=-0.169*r-0.331*g+0.5*b+128;

​	v=0.5*r-0.419*g-0.081*b+128;

```c++
//存y列表，u列表,v列表
QByteArray y_l,u_l,v_l
//disktop 是qimage rgb像素原图.
uchar * d=disktop.bits();  
//循环变量
    int i,j;
//图片的高度和宽度。
    int w=disktop.width();
    int h=disktop.height();
//一个像素由3个uint8_t组成。
uint8_t r,g,b,y,u,v;
//开始转换
    for(i=0;i<h;i++){
        for(j=0;j<w;j++){
            int pos=i*(w*3)+j*3;
            r=d[pos+2];
            g=d[pos+1];
            b=d[pos];
            y=0.299*r+0.587*g+0.114*b;
            y_l.append(y);
            if(i%2==0 and j%2==0){ //偶数行并且偶数像素
                u=-0.169*r-0.331*g+0.5*b+128;
                           u_l.append(u);
                v=0.5*r-0.419*g-0.081*b+128;
                           v_l.append(v);
              }
        }
    }
// yuv420=y_l+u_l+v_l
```

### x265_param

x265编码参数，比如视频的宽高， yuvs等参数。

```c++
x265_param *param=x265_param_alloc();
status=x265_param_default_preset(param,"ultrafast","zerolatency");
if(status!=0){
        qDebug()<<"快速，发送！设置失败";
            x265_param_free(param);
        return;
    }
param->sourceWidth=width; //宽
param->sourceHeight=height; //高
param->frameNumThreads=0; //并发编码帧数，0为自动检测（默认值），在2到6直接会导致运动搜索（比如6个B帧）
param->numaPools="none" ; //""|"*"所有的numa节点都用于线程池
                           //"none" 没有创建线程池只能进行帧并行编码。
                           //numa理解为服务器各CPU自己的内存区域。因此在多CPu编码并行时，因为各个帧要依赖于上一帧，所以可能导致在多个cpu内存来回取数据（个人理解）
param->fpsNum=25; //帧率的分子
param->fpsDenom=1;  //帧率的分母
param->interlaceMode=2; //源图片的隔行类型：0：渐进图片（默认）
                                        // 1：顶场优先
                                        // 2：底场优先
param->keyframeMax=10; //I帧的间隔
//    param->bframes=3;
//    param->intr
param->interRefine=0;  //启用当前编码中的中间块的优化
//                            启用当前编码中的中间块的优化。
//                            级别0-从保存编码强制模式和深度。
//                            级别1-当当前块大小比min-cu-size大1时，评估当前深度（n）和深度（n + 1）的所有帧间模式。强制使用较大块的模式。
//                            级别2-除级别1的功能外，还限制了当保存编码将特定模式确定为最佳模式时评估的模式。
//                            保存编码中的2nx2n-禁用对rect和amp的重新评估。
//                            跳过保存编码-仅重新评估跳过，合并和2nx2n模式。
//                            级别3-在重用保存编码中的深度时执行帧间模式分析。
//                            默认值0。
param->internalCsp=X265_CSP_I420;
//rc结构体
param->rc.rateControlMode=X265_RC_CRF; //（默认 CRF）码率控制模式
                // X265_RC_ABR, //指定平均码率， x264的一位主要开发者说你应该永远不要使用它，由于编码器无法提前知道要编码视频的情况，它将不得不猜测如何达到比特率。
                // X265_RC_CQP,  //恒定QP
param->rc.qp=32; //0表示无损 范围0-51,值越大表示越大的量化步长;
                // X265_RC_CRF   //恒定质量因子，对于运动或细节丰富的场景会增大量化失真，对静止或平坦区域则减少量化失真;
param->rc.rfConstantMax=48; //crf最大码率，0-51 值越大视频质量越低，压缩率越高
param->rc.rfConstantMin=32;  //crf最小码率
param->rc.rfConstant=32;    //常量码率
param->bRepeatHeaders=true; //是否命令行输出 vps sps pps 头标志
param->bAnnexB=true;    //是否生成NUAL起始标志 0000001;
```

##### 编码器：

x265_encoder *encoder;
encoder=x265_encoder_open(param);

编码器使用参数。

x265_encoder_reconfig(encoder,param);

### x265图片结构体

```c++
//创建一个x265图片结构体指针。
x265_picture *picture;
//为指针创建内存
picture = x265_picture_alloc(); 
//使用x265参数初始化图片。
x265_picture_init(param,picture);
//帧计数
int frame=0 
//用于接收编码后的nal
x265_nal *pp_nal;
// 图片被编码成几个nal
uint32_t pi_nal
//编码开始时间，编码结束时间
QDateTime start_jieping,end_jieping;  
//存储当前帧的时间。
uint32_t time_value;
//bool is_stop=true
while(is_stop){
// 开始编码时间
start_jieping=QDateTime::currentDateTime();
//  截屏转　yuv420部分
//截屏后的yuv420设置给picture.
picture->planes[0]=y_l; //y
picture->planes[1]=u_l;//u
picture->planes[2]=v_l; //v
picture->stride[0]=param->sourceWidth;  //设置yuv中y的宽度。也就是y_l.length
picture->stride[1]=param->sourceWidth/2;	//设置yuv中u的宽度，也就是u_l.length
picture->stride[2]=param->sourceWidth/2;	//设置yuv中y的宽度，也就是y_l.length
//帧数自己加
frame++;
//根据帧算出当前pts
picture->pts=frame*(90000/param->fpsNum); 
//编码。
x265_encoder_encode(encoder,&pp_nal,&pi_nal,picture,NULL); //编码
//编码后的nal总长度
int data_byte_size=0;
for(int i=0;i<pi_nal;i++){ //写入数据长度
      	//pp_nal[i].sizeBytes 返回第i个nal包大小。
        data_byte_size+=pp_nal[i].sizeBytes;
	}
//用于存编码后的数据。
char data_char[data_byte_size];
//复制编码后的数据到 data_char
memcpy(&data_char, pp_nal[0].payload,data_byte_size);
//结束编码时间。
end_jieping=QDateTime::currentDateTime();
//取出时间编码时间差
int sleep_ms= start_jieping.msecsTo(end_jieping);
//取出当前帧的时间——rtp要用到。
time_value=sleep_ms*(9000/param->fpsNum/(1000/30))+frame*(90000/param->fpsNum);
//发送rtp数据 //后面实现。
//参数一
QBytarry data= (data_char,data_byte_size)
//参数二
// nal 类型
//当前帧的时间值
rtp_server.send_data(data,pp_nal->type,true,time_value);
rtp_server.flush();
}
```

# RTSP RTCP RTP

## RTSP:

Tcp server 

接收客户端的请求： OPTIONS、DESCRIBE、SETUP、PLAY

### OPTIONS:

客户端options请求：

```c
"OPTIONS rtsp://127.0.0.1:1133 RTSP/1.0\r\nCSeq: 2\r\nUser-Agent: LibVLC/3.0.11.1 (LIVE555 Streaming Media v2016.11.28)\r\n\r\n"
```

rtsp服务端返回支持的方法：

```c++
"RTSP/1.0 200 OK\r\n CSeq:2\r\nPublic:DESCRIBE, SETUP, TEARDOWN, PLAY, PAUSE\r\n\r\n"
```

```c++
"CSeq:"	//对应请求的CSeq号
"RTSP/1.0 200 OK" //表示版本号，返回状态码， 和状态描述。
```



### DESCRIBE:

客户端describe请求：

```c++
"DESCRIBE rtsp://192.168.41.39:1133 RTSP/1.0\r\nCSeq: 3\r\nUser-Agent: LibVLC/3.0.11.1 (LIVE555 Streaming Media v2016.11.28)\r\nAccept: application/sdp\r\n\r\n"
```

```c++
"Accept: application/sdp" //表示客户端接收的返回格式为sdp。
```

rtsp服务器返回sdp：

```c++
"RTSP/1.0 200 OK\r\nCSeq:3\r\nContent-Type: application/sdp\r\nContent-Length:131\r\n\r\nc=IN IP4 192.168.41.39\r\nm=video 0 RTP/AVP 96\r\na=rtpmap:96 H265/90000\r\na=fmtp:96 profile-space=0;profile-id=0;tier-flag=0;level-id=0\r\n\r\n"
```

#### sdp:

```c++
Content-Type: application/sdp //返回的格式为sdp
Content-Length:					//返回的包长度。
c=IN IP4 192.168.41.39			//网络类型 地址类型 服务端地址
m=video 0 RTP/AVP 96		//视频类型
a=rtpmap:96 H265/90000	//h265 固定写法。
a=fmtp:96 profile-space=0;profile-id=0;tier-flag=0;level-id=0
```

### SETUP：

客户端请求：

```c++
"SETUP rtsp://192.168.41.39:1133/ RTSP/1.0\r\nCSeq: 4\r\nUser-Agent: LibVLC/3.0.11.1 (LIVE555 Streaming Media v2016.11.28)\r\nTransport: RTP/AVP;unicast;client_port=53524-53525\r\n\r\n"
```

```c++
Transport: RTP/AVP; //端口类型
unicast;
client_port=53524-53525 //客户端端口号。
```

Rasp 返回：

```c++
"RTSP/1.0 200 OK\r\nCSeq:4\r\nTransport: RTP/AVP;unicast;client_port=53264-53265;server_port=0-0;ssrc=Wang_qin_feng53264_53265\r\nSession:Wang_qin_feng53264_53265\r\n\r\n"
```

```c++
server_port //服务器分配的端口号，对于vlc无效（直接用rtsp端口号后面的前面的俩个号。）
ssrc=Wang_qin_feng53264_53265 //
Session:Wang_qin_feng53264_53265 //唯一会话
//后面的会话都都要用这个
```

### PLAY:

 客户端请求：

```c++
"PLAY rtsp://192.168.41.39:1133 RTSP/1.0\r\nCSeq: 5\r\nUser-Agent: LibVLC/3.0.11.1 (LIVE555 Streaming Media v2016.11.28)\r\nSession: Wang_qin_feng53524_53525\r\nRange: npt=0.000-\r\n\r\n"
```

 rtsp返回：

```c++
"RTSP/1.0 200 OK\r\nCSeq: 5\r\nSession: Wang_qin_feng58648_58649\r\nRTP-Info: url=rtsp://192.168.41.39:1133;seq=9810092;rtptime=0\r\n\r\n"
```

### TEARDOWN

```c++
"TEARDOWN rtsp://192.168.41.39:1133 RTSP/1.0\r\nCSeq: 6\r\nUser-Agent: LibVLC/3.0.11.1 (LIVE555 Streaming Media v2016.11.28)\r\nSession: Wang_qin_feng53524_53525\r\n\r\n"
```

##  RTP：

作用把编码后的nal包按协议规则分包（合包发送）

##### mtu:

交换机一次可以传输的数据包大小。一般为1500 <font color=red>byets</font>

//rtp_server.send_data(data,pp_nal->type,true,time_value);

1、删除nal包的前4个字符，也就是开始的4个0；

2、 rtp+fu 头部长度为3+12=15*8=120<font color=red>bit</font>.

##### fu_heads

```c++
uint8_t playload_fu_head[3]={0}; //初始化fu头部为0
playload_fu_head[0]=(49<<1);   //playload type 49;
playload_fu_head[1]=1;
//如果是分包的第一个包要作一个标准(也就nal包的第一个mtu-(fu+rtp头部长度)=1500-3-12)
if(is_one/*是不是分包的第一个包*/){
  playload_fu_head[2]=(0x00+0x1)<<7;
  //nal_type 是帧编码时生成的，看x265编码倒数第二行传人的nal_type。
  playload_fu_head[2]=playload_fu_head[2]+nal_type;
}else if(/*非第一个包，也非最后一个包*/){
  playload_fu_head[2]=nal_type;
}else if (/*分包的最后一个包*/) {
 playload_fu_head[2]=(buff+0x1)<<6;
 playload_fu_head[2]=playload_fu_head[2]+nal_type;
}
//返回fu头部。
```

##### rtp_head：

```c++
uint16_t seq_n=0 //递增的每个rtp包加1；
retrun_rtp_head(){
  		uint32_t rtp_head[4]={0x0};
  		//头第一个32位
      seq_n++;
      rtp_head[0]=((rtp_head[0]>>30)+0x1)<<31;// v=2 10
      rtp_head[0]=((rtp_head[0]>>29)+0)<<29; //	p=0;
      rtp_head[0]=((rtp_head[0]>>28)+0)<<28; //	x=0
      rtp_head[0]=((rtp_head[0]>>24)+0x0000)<<24; //cc=0000
      if(is_at_last_nal){ //是不是最后一个分包
            rtp_head[0]=((rtp_head[0]>>23)+0x1)<<23; //m=1
      }
      rtp_head[0]=((rtp_head[0]>>16)+0x60)<<16; //type
      rtp_head[0]=rtp_head[0]+seq_n; 						//seq_n++
      //头第二个32位时间戳
      rtp_head[1]=time_value;
      rtp_head[2]=rtp_number;
      rtp_head[3]=seq_n;
  		//QByteArray rtp_head_byte;
      //QDataStream stream(&rtp_head_byte,QIODevice::ReadWrite);
      //for(int y=0;y<3;y++){
      //      stream<<(uint32_t)rtp_head[y];
      //  }
      //return  rtp_head_byte;
}
//  rtphead+fuhead+data  发送给客户端。
```

