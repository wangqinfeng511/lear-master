安装：yum libvirt-devel  pip install libvirt
宿主机打开tcp
修改文件vim /etc/sysconfig/libvirtd，用来启用tcp的端口
LIBVIRTD_CONFIG=/etc/libvirt/libvirtd.conf
LIBVIRTD_ARGS="--listen"
修改文件vim /etc/libvirt/libvirtd.conf
listen_tls = 0
listen_tcp = 1
tcp_port = "16509"
listen_addr = "0.0.0.0"
auth_tcp = "none"
连接：
import libvirt
conn = libvirt.open("qemu+tcp://192.168.99.140/system") #连接"qemu:///system"是默认本机。最大权限。
conn = libvirt.openReadOnly 只读
conn = libvirt.libvirt.openAuth    验证连接
a=conn.lookupByName('yanfa') #返回一个domain对象,参数是一个domain_name
dom =conn.lookupByID(1)	#通过id序号连接，返回domain_name
######################################################################
i=conn.listAllDomains() 列出所有的domain，反回是domain对象。
i[0].UUIDString() #返回uuid
i[0].info() #返回domain的信息[1, 4194304, 4194304, 8核心, 28710000000cpu时间]
i[0].name() #返回名字
i[0].XMLDesc() #返回domain的xml文件
i[0].abortJob() #中止doman
i[0].attachDevice(xml) #添加设备，要求是一个xml
i[0].autostart(self) #自动启动
a[0].blkioParameters(self) #磁盘IO参数
a[0].blockInfo('vda') #取出domain磁盘的使用情况
a[0].blockPeek('vda',0,4194304) #读出磁盘的起启到结束的数据


