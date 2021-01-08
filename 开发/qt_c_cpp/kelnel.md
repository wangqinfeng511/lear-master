linux驱动开发：
一、模块开发流程
	1、操作接口集,read(),write,close()....
	2、注册设备，操作接口集绑定。
	3、创建设备节点 /dev/xxx
	4、中断绑定
二、挂载入口与卸载入口
	#include <linux/init.h>
	#include <linux/mount.h>
	module_init(xxxx_init); //挂载入口初始化函数
		static int __init xxx_init(void){};
	module_exit(xxxx_exit); //卸载模块调用函数
		static void __exit xxxx_exit(void){}
	MODULE_LICENSE("GPL"); //开源协议，与内核对应。
四、注册设备：
	设备号：
		linux 内核使用 dev_t u32位数字表示
		设备号分为俩部分：
				1、0-12位 主设备号
				2、13-31位 子设备号

	//注册字符设备_设备号：
	1.register_chrdev(int maijor,char *devname,const struct file_operations *myfile);
		//缺点是会占用所有的次设备号
		参数一：注册设备号，0表示自动分配。手动时要保证设备号未占用。
		参数二：设备的名字;
		参数三：操作设备集；
		返回参数：返回主设备号，小于0表示错误。
		MAJOR(设备号)：返回主设备号
		MINOR(设备号)：返回次设备号
		MKDEV(主设备号，次设备号)：返回设备号
	//对应注销设备号.
	    unregister_chrdev(maijor,dev_name_str);
	2.自动申请设备号第二种方法。
		int alloc_chrdev_register(dev_t *dev,unsigned baseminor,unsigned count);
		参数一：主设备号地址（函数执行完后得到主设备号）
		参数二：次设备号起始号
		参数三：申请几个设备号
	//对应销毁设备号
	unregister_chredev_region(dev_t from,unsigned count);
		参数一：设备号起始号
		参数二：释放几个设备号
	3.指定设备号是申请;
	int register_chrdev_region(dev_t from ,unsigned count,const char * anem);
i		参数一 设备号的起始(MKDEV(主设备号，0)//从0开始的设备号);
		参数二 申请几个设备号
		参数三 设备的名字
	//自动创建设备节点：
	static struct class *device_class
	class_create(THIS_MODULE,char * dev_node_name);
		参数一：
		参数二：设备类名字，非/dev/xxx;
		返回：一个class指针。
	//创建设备:参数一:class结构体指针,参数二:父类指针,空.参数三:设备号, 参数四:私有数据,空.参数五和六:可变参数 表示设备节点名字.
	device_create(deviceclass,NULL,MKDEV(主设备号，次设备号),NULL,"节点名字")
	 //销毁设备类
        class_destroy(devclass);
	//销毁设备节点：
	device_destroy(device_class,MDEV(主设备号，次设备号))
三、操作接口集实现：
	struct file_operations my_dev_file{
		.open=f_open;
		.read=f_read;
		.write=f_write;
		.release=f_close;
	}
	a、f_read()函数实现：
		ssize_t f_read(struct file *fp,__user *buff,size_t count,loff_t *fpos){
			//系统调用：fp传入的文件指针，buff传入的缓存区，count读多少字节，fpos偏移
		}
	b、f_write()函数实现：
		ssize_t f_write(struct file *fp,const char __user *buff,size_t loff *fpos){
		
		}
	c、f_open()函数实现：
		int f_open(struct inode *innode,struct file *fp){
			//fp文件地址指针
		}
	d、f_close()函数实现：
		int f_close (struct inode * innode, struct file * fp){};	
四、用户空间与内核空间的数据传递：
	#include<linux/uaccess.h>
	//从内核空间拷贝到用户空间,一般f_read()
	int copy_to_user(void __user *to,const void * from,usigned long n){} 
		参数一：用户传入的buff,比如f_read()中buff;
		参数二：内核空间中的buff;
		参数三：拷贝多少个字节;
	//从用户空间拷贝到内核,一般f_write()
	int copy_from_user(void *to,const void __user *from,usigned long n){};
		参数一：内核空间buff; 
		参数二：用户空间buff;
		参数三：拷贝多少字节；
五、IO操作：
	物理地址映射虚拟地址：
	void *ioremap(cookie,size)
		参数一：物理地址首地址
		参数二：长度（byte）
		返回值：虚拟地址
	去映射：iounmap(void __iomem *addr)
		参数一：映射后的虚拟地址
	树莓派寄存器：
		树莓派GPIO查看：grio readall  bcm就是cpu gpio引脚号
		GPFESL：选择引脚功能寄存器 4byte 32bit
		GPSET ：设置引脚输出高电平寄存器。
		GPCLR : 设置引脚输出低电平寄存器。
	————————————————————————————————————————————————
		寄存器32位，每3位操作一个GPIO
						000	INPUT
						001	OUTPUT
		GPIO9<-----GPIO0;
		GPFESL0	0X3F200000	GPIO0---GPIO9
		GPFESL1 0x3F200004	GPIO10---GPIO19
		GPFESL2 0x3F200008	GPIO20---GPIO29
		GPFESL3 0x3F20000C	GPIO30---GPIO39
		GPFESL4 0x3F200010	GPIO40---GPIO49
		GPFESL5 0x3F200014	GPIO50---GPIO53
	例：
		#define ctl_base_addr       	0x3F200004 //GPFESL1
		unsigned int *ctl_gpio_addr;	//虚拟地址指针
		ctl_gpio_addr =ioremap(ctl_base_addr,4); //功能寄存器物理地址映射虚拟地址
		 *ctl_gpio_addr|=(0x1<<(3*6)); //功能引脚bcm6设置为输出 /001 out,000 in,
						32位寄存器每三位控制一个gpio,
						设置的是这个寄存器的第6个引脚为0x001 10+6=gpio16
	————————————————————————————————————————————————
	0=无效，1=有效，GPFESLn设置输出有效。
	GPSET0	0x3F20001C		GPIO0---GPIO31	//设置GPIO高电平
	GPSET1	0X3F200020		GPIO32--GPIO53  //设置GPIO高电平
	
	GPCLR0	0X3F200028		GPIO0---GPIO32  //设置GPIO低电平
	GPCLR1  0X3F20002C		GPIO32--GPIO53  //设置GPIO低电平
	例：	
		#define height_data_addr	0x3F20001C  //高电平1-32位寄存器
		#define low_data_addr  		0x3F200028  //低电平1-32位寄存器
	
		unsigned int *height_gpio_addr;  //gpio高电平寄存器虚拟地址
		unsigned int *low_gpio_addr;	 //gpio低电平寄存器虚拟地址
		low_gpio_addr=ioremap(low_data_addr,4);  //低电平寄存器物理地址映射虚拟地址
		height_gpio_addr=ioremap(height_data_addr,4); //高电平寄存器物理地址映射虚拟地址
		*height_gpio_addr|=(0x1<<16);  //设置bcm16gpio为高电平
		*low_gpio_addr|=(0x1<<16);   //设置bcm16 gpio为低电平
	寄存器操作：
	#include<linux/slab.h> 
	kmallo(size_t data_size,GFP_KERNEL); //内存申请，返回申请的内存地址。	
		GDP_KERNEL:内存不足时阻塞等待。
	寄存器操作函数：readl writel
	例：
		读：
		u32 vaule=readl(虚拟地址);
		写：
		value&=~(0xf<<28) //初始化全0；
		value|=(0x1<<28) 
		writel(value,虚拟地址);
六、中断
	int gpio_n_irq=gpio_to_irq(int n); //返回gpio中断号
	#include <linux/interrupt.h>
	//中断注册
	int request_irq(usigned int irq,irq_heandler_t handler,usigned long flags,const char* name,void *dev);
		参数一：中断号
		参数二：中断处理函数：
			irqreturn_t key_irq_heandler(int irqno,void *devid){ return IRQ_HANDLED};
		参数三：触发方式：
			IRQF_TRIGGER_NONE  	//内部控制器触发;
			IRQF_TRIGGER_RISING 	//上升沿触发；
			IRQF_TRIGGER_FALLING 	//下降沿触发；
			IRQF_TRIGGER_HIGH	//高电平触发；
			IRQF_TRIGGER_LOW	//低电平触发;
		参数四：中断的描述定义;
			/proc/interrupts 	//查看
		参数五：传递给中断处理函数的参数。
		返回值：正确0,错误非0
	
	注销中断：
		free_irq(中断号，中断注册第二个参数);
	例：
		irqreturn_t key_irq(int irqno,void *devid){
			 printk("irq_gpio0__%d",iqr);
			 return IRQ_HANDLED;
		}
		static init __init xxx_init(void){
		 	iqr=gpio_to_irq(17);
			 	request_irq(iqr,key_irq,IRQF_TRIGGER_RISING,"interrupt_test",NULL);
		}
七、设备树获取中断号 //要先编译dts文件，编译为dtb文件树莓派没找到！
	struct device_node *np=of_find_node_by_path("节点名");
	int irqno=irq_of_parse_and_map(np,0);
		参数一：设备节点，
		参数二：节点中的第几个中断号。
八、文件IO模型—阻塞
	描述：当进程在读取外部设备资源，资源没有准备好时进程会休眠。
	wait_queue_head_t wq_head; //等待队列头。
	初始化等待队列头：
		init_waitqueue_head(wq_head);
	休眠：
		wait_event_interruptible(wait_queue_head_t p,condition);
			参数一：等待队列头。
			参数二：条件！真不进入等待，假进入等待。用法声明一个全局变量，判断变量值是否进入睡眠。
	唤醒：
		wake_up_interruptible(&等待队列头);
九、文件IO模型--非阻塞
	描述：在读写数据时如果没有数据立刻返回，并返回错误码！
	用的比较少比较消耗资源，因为一般会反复读知道数据返回。
	A:应用中
		int fd=open("/dev/xxx",O_RDWk|O_NONBLOCK);//只读以非阻塞模式打开。
	B：驱动中
		a、区分文件打开是阻塞还是非阻塞。默认为阻塞！
		if(filep->f_flags&O_NONBLOCK){
			有数据时复制内核空间到用户空间，
			无数据时：
			return -EAGAIN //表示再来read一次。
		}
十、多路复用poll
	描述：监控多文件描述符，有无数据发生。
	驱动部分：
		需要file_operations结构添加 poll操作函数;
		poll操作函数：
			unsiged int xxx(struct file *filep,struct poll_table_struce *pts){
				//参数由系统传入
				poll_wait(filep,等待队列头,pts)//将当前等待队列注册到系统中，等待队列头参考阻塞。
						参数一：文件指针
						参数二：等待队列头
						参数三：没讲。
				return  POLLIN ;//没有数据返回0,有数据返回POLLIN;	
			};
	应用程序部分：
		#include<poll.h>
		int poll(struct pollfd,*fds,nfds_t nfds,int timeout); //注册
			参数一：表示多文件描述符的集合。
				struct pollfd{
					int fd;//文件描述符
					short events ;//监控的事,POLLIN读，POLLOUT写，POLLERR错误
					short revents; //结果描述，表示是否有，读，写，错误
							POLLIN
							POLLOUT
							POLLERR
				}
			参数二：集合文件描述符数量。
			参数三：监控的时长（毫秒）
				正数：表示监控的毫秒数
				负数：表示无限监控
				0：不等待，类似于非阻塞
			返回值：负数出错，大于0有数据，0时间到。
			
			1、监控多个文件文件描述符。
			使用：
				struct pollfd psd[2];//先来俩元素的数组；
				psd[0].fd=文件描述符
				psd[0].events=POLLIN;
				psd[1].fd=0;0表示标准输入（也就是stdin）
				psd[1].events=POLLIN;
				while(true){
				int ret=poll(psd,2,-1);
				if(ret>0){
					if(psd[0].revents &POLLIN){
						//判断文件描述符一是否有数据
						
					}	
					if(psd[1].revents &POLLIN){
						fgets(buff,128,stdin) //查下怎么用
					}
				}
			}		
十二 内核延时:
	#include<linux/delay.h>
	void ndelay(unsigned long nsecs);纳秒
	void udelay(unsigned long usecs);微妙
	void mdelay(unsigned long msecs);毫秒
		
十三 epoll
	#include<sys/epoll.h>
	int epoll_create(int size)
	int epoll_create1(int flags)
	//创建EPOLL描述符，系统能支持多少描述符，就可以管理多少描述符
	int epoll_ctl(int epfd,int op,int fd,struct epoll_event *event);
	//epoll事件注册函数：参一：EPOLL的文件描述符，
			     参二：动作：
					EPOLL_CTL_ADD://注册新的文件描述符到epfd中;
					EPOLL_CTL_MOD://修改已经注册的fd监听事件;
					EPOLL_CTL_DEL://从epfd中删除一个fd;
			     参数三：需要监听的fd(文件描述符);
			     参数四：监听的事件
				struct epoll_event{
					__uint32_t events;
					epoll_data_t data;
				}
					参一：events:
						EPOLLIN:表示对应的文件描述符可以读（包括对端socket正常关闭）;
						EPOLLOUT:表示对应的文件描述符可以写;
						EPOLLPRI：表示对应的文件描述符有紧急的数据可读（这里应该表示有带外数据来）;
						EPOLLERR：表示对应的文件描述符发送错误;
						EPOLLET: 边缘触发;
						EPOLLONESHOT：只监听一次事件，当监听完这次事件后从队列里移除;
						
	int epoll_wati(int epfd,struct epoll_event *events,int maxevents,int timeout)
		参数一：epfd
		参数二：从内核得到事件的集合;
		参数三：告诉内核这个事件集合有多大，这个值不能大于epoll_create()的size参数;
		参数四：超时时间，0立即返回，-1阻塞
		返回：需要处理的事件数目
	typedef union epoll_data{
		void *ptr;
		int	fd;
		uint32_t u32;
		uint64_t u64;
	} epoll_data_t;
	工作模式：LT和ET 
		LT:是默认模式;
		LT模式：当epoll_wait检测到描述事件发生并将此事件通知应用程序，如果程序没立即处理事件，下次调用epoll_wait时，会再次通知此事件。
		ET模式：当epoll_wait检测到描述事件发生并将此事件通知应用程序，程序如不处理此事件，下次调用epoll_wait时，不会通知此事件。
	
	//每个连接可以创建不同的event触发方式,把连接注册到epoll中,epoll_wati查询返回触发事件的描述符数量,从evs[i]取出对应的描述符进行操作

//
malloc(size)
int a=10;
const int *p2=&a; 
//const表示p2指向的内存数据不可修改,但内存地址可以重新复制.
static int i=0; //局部变量,是在编译阶段就已经分配空间,函数没有调用前就已经存在.
并且在函数执行完时不释放.
		只初始化一次,可赋值多次
static 全局变量与普通的全局变量的区别是作用域不同; static全局变量只能在当前文件使用