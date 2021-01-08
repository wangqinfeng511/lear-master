### 字符设备

#### 流程:

操作接口集,read(),write(),close().....
注册设备
操作接口集绑定
创建设备节点
中断绑定

#### 挂载入口:

```c
#include<linux/init.h>  
#include<linux/mount.h>
```

#### module_init(xxx_init)

```c
//入口函数
static init __init xxx_init(void){}

```

#### module_exit(xxx_exit)

```c
//卸载函数
static void __init xxx_exit(void){}
```

#### MODULE_LICENSE("GPL")

//开源协议,与内核对应	

#### 注册字符设备

```c
register_chrdev(int maijor,char *devname,const struct file_operations *myfile_action)
//注册字符设备
//参数一:注册设备号,0表示自动分配.手动时要保证设备号未占用
//参数二:设备名字;
//参数三:操作设备集;
//返回主设备号,小于0表示错误.
```

#### 注销字符设备

```c++
unregister_chrdev(maijor,dev_name_str)
//注销字符设备
//参数一:主设备号
//参数二:设备名
```

#### 创建设备节点

static struct clase *device_class
class_create(THIS_MODULE,char *dev_node_name)
				创建设备类型
				参数一:固定
				参数二:设备类名字,非/dev/xxx;
				返回一个class结构体指针

#### 销毁设备类

```c
class_destroy( class *device_class)
//销毁设备类
```


device_create(device_class,NULL,MKDEV(主设备号,次设备号),NULL,"设备节点名称")
device_destroy(device_class,MDEV(主设备号,次设备号))
销毁设备
struct file_operations my_file_action{ .open=xxx;.read=xxxx;.write=xxxx;.release=xxxx}
操作接口集合
				ssize_t f_read(struct file *fp,__user *buff,size_t count,loff_t *fpos){}
					参数一:系统调用时自动传入的文件描述符指针
					参数二:user 传入的缓存区
					参数三:读出多少字节
					参数四:fpos偏移
					内核空间拷贝到用户空间
					返回读出的字节数
				size_t f_write(struct file * fp,const char __usr *buff,size_t loff  *fpos){}
					参数一:系统调用时自动传入的文件描述符指针
					参数二:user 传入的缓存区
					参数三:读出多少字节
					用户空间拷贝到内核空间
					返回写入内核空间的字节数
				int f_open(struce inode *innode,struct file *fp){ }
					系统调用打开是函数
				int f_close(struct innode * innode,struct file *fp){}
					关闭时执行的函数
		int copy_to_user(void __user *to,const void *from,unsigned long n){}
			内核空间拷贝到用户空间
			参数一:用户传入的buff指针
			参数二:内核空间的buff指针
			参数三:拷贝的字节数
		int copy_from_user(void * to,const void __user *from,usigned long n){}
			用户空间拷贝到内核空间
			参数一:内核空间buff指针
			参数二:用户空间buff指针
			参数三:拷贝的字节数
	地址映射
		void *ioremap(coolie,size)
			参数一:物理地址首地址
			参数二:地址长度
			返回虚拟地址
		iounmap(void __iomem *addr)
			去地址映射
		#include<linux/slab.h>
			kmallo(int size,GDP_KERNEL)
				内核内存申请,返回虚拟地址
	中断
		#include<linux/interrupt.h>
		of_find_node_by_path("节点名")
			返回节点指针
		irq_of_parse_and_map(节点指针,0)
			参数一:设备节点指针
			参数二:节点中的第几个中断号
			返回一个int型的中断号
		int request_irq(usigned int irq,irq_heandler_t,usigned long flags,const char *name,void *dev)
			中断注册
			参数一:中断号
			参数二:中断处理函数
				irqreturn_t key_irq_heandler(int irqno,void *devid){return IRQ_HANDLED}
			参数三:触发方式
				IRQF_TRIGGER_NONE
					内部控制器触发
				IRQF_TRIGGER_RISING
					上升沿触发
				IRQF_TRIGGER_FALLING
					下降沿触发
				IRQF_TRIGGER_HIGH
					高电平触发
				IRQF_TRIGGER_LOW
					低电平触发
			参数四:中断的描述定义
				/proc/interrupts 查看
			参数五:传递给中断处理函数的参数
			返回值:0正确,错误非0
		free_irq(中断号,中断注册的第二个函数指针)
	文件IO模型
		wait_queue_head_t wq_head;
			等待队列实例化
		阻塞
			当进程在读取外部设备资源,资源没有准备好时进入休眠
			wait_event_interruptible(wait_queue_head_t p,condition)
				参数一:等待队列头
				参数二:条件,是否进入阻塞
		非阻塞
			在资源未就绪时直接返回
			应用中:int fd=open("/dev/xxx",O_RDWK|O_NONBLOCK)
				只读非阻塞模式打开
			内核驱动中:
				return -EAGAIN
					表示再来read 一次
	ndelay(int)
		纳秒延时
	udelay(int)
		微妙延时
	mdelay(int)
		毫米延时