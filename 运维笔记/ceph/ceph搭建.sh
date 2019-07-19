ceph_1 192.168.110.101
ceph_2 192.168.110.102
ceph_3 192.168.110.103
ceph_4 192.168.110.104
vim /etc/ceph.conf
[global]
fsid = 8fb93936-ee3e-4a70-9fc6-0a3cb2b44a95
mon initial members = ceph_1
mon host = 192.168.110.101
public network = 192.168.110.0/24
auth cluster required = none
auth service required = none
auth client required = none
osd journal size = 1024
filestore xattr use omap = true
osd pool default size = 2
osd pool default min size = 1
osd pool default pg num = 256
osd pool default pgp num = 256
osd crush chooseleaf type = 1
[osd.0]
        host = ceph_4
        deves = /var/lib/ceph/osd/ceph-0
[osd.1]
        host = ceph_3
        deves = /varlib/ceph/osd/ceph-1


一、 生成集群uuid
	uuidgen
添至/etc/ceph/ceph.conf fsid=
4. 建立拥有操作监视器权限的凭证
ceph-authtool --create-keyring /etc/ceph/ceph.mon.keyring --gen-key -n mon. --cap mon 'allow *'
 建立一个名称为client.admin的管理员凭证
ceph-authtool --create-keyring /etc/ceph/ceph.client.admin.keyring --gen-key -n client.admin --set-uid=0 --cap mon 'allow *' --cap osd 'allow *' --cap mds 'allow'
将管理员凭证添加到监视器权限凭证内
ceph-authtool /etc/ceph/ceph.mon.keyring --import-keyring /etc/ceph/ceph.client.admin.keyring
建立监视器节点对应关系地图
monmaptool --create --add ceph_1 192.168.110.101 --fsid 第二步生成的值也是 /tmp/monmap

建立监视器服务数据存放目录
mkdir /var/lib/ceph/mon/ceph-ceph_1 (ceph集群名-ceph_1主机名)
 初始化监视器数据目录
 ceph-mon --mkfs -i Kilo-com-1 --monmap /tmp/monmap --keyring /etc/ceph/ceph.mon.keyring

 添加部署完毕标志文件及服务启动标志文件
touch /var/lib/ceph/mon/ceph-ceph_1/done
touch /var/lib/ceph/mon/ceph-ceph_1/sysvinit
启动监视器服务
/etc/init.d/ceph start mon
查看状态：
	ceph osd tree
	crep -s
######################################################################################################
osd添加
mkfs.xfs /dev/sdb
mkdir /var/lib/ceph/ceph-0
mount /var/lib/ceph/ceph-0 (ceph集群名，0集群第一块盘)
初始化OSD数据目录
ceph-osd -i 0 --mkfs --mkjournal --mkkey (0代表盘号)
注册OSD凭证
ceph auth add osd.0 osd 'allow *' mon 'allow profile osd' -i /var/lib/ceph/osd/ceph-0/keyring
创建osd
	ceph osd create
	#此时ceph osd tree 会看到添加的盘号
在osdmap添加osd与主机下
 ceph osd getcrushmap -o map #导出map
 crushtool -d ./map>map.sh	#转为源码
 vim ./map.sh
#############################
# begin crush map
tunable choose_local_tries 0
tunable choose_local_fallback_tries 0
tunable choose_total_tries 50
tunable chooseleaf_descend_once 1
tunable straw_calc_version 1

# devices
device 0 osd.0 #osd.0盘
device 1 osd.1

# types
type 0 osd
type 1 host
type 2 chassis
type 3 rack
type 4 row
type 5 pdu
type 6 pod
type 7 room
type 8 datacenter
type 9 region
type 10 root

# buckets
host ceph_4 { #ceph_4主机
        id -2           # 唯一ID
        # weight 0.000
        alg straw
        hash 0  # rjenkins1
}
host ceph_3 {
        id -3           # do not change unnecessarily
        # weight 0.000
        alg straw
        hash 0  # rjenkins1
        item osd.1 weight 1.000 #把osd.1盘是ceph_3主机下的盘
}
host ecph_4 {
        id -4           # do not change unnecessarily
        # weight 1.000
        alg straw
        hash 0  # rjenkins1
        item osd.0 weight 1.000 #osd.0盘是ceph_4下的盘
}
root default {
        id -1           # do not change unnecessarily
        # weight 1.000
        alg straw
        hash 0  # rjenkins1 ceph_3 ceph_4同属于root default组下
        item ceph_4 weight 0.000
        item ceph_3 weight 1.000
        item ecph_4 weight 1.000
}

# rules
rule replicated_ruleset {
        ruleset 0
        type replicated
        min_size 1
        max_size 10
        step take default
        step chooseleaf firstn 0 type host
        step emit
}

###################################################################################
crushtool -c ./map.txt -o map #编译为map
ceph osd setcrushmap -i map  #导入map
######################################################################################################
添加服务启动标志文件
touch /var/lib/ceph/osd/ceph-0/sysvinit

常用命令：
ceph osd crush remove osd.o 从crush地图中删除。
ceph auth del osd.0	从注测中删除。
ceph osd rm osd.0	删除osd节点
ceph osd create 添加osd.号自动增加
ceph osd crush add-bucket ceph_3 host 添加主机到curshmap
#############################################################################
查看存储池
ceph osd lspools
查看容量：
ceph df
