监视器mon:
	维护着集群运行的主副本地图。客户端连接到监视器并获取当前运行地图，就能确定所有监视器，osd,mds服务器的位置，根据crush,客户端可算出对像的位置，直接连接到osd读写。

主要维护：monitor map
	auth
	log
	osd	map
	pg	map
	mds	map
监视器是集群的首发站，所以mon无法访问里集群无法工作。一般采用奇数个监视器，用于流言判定。
################################################################################
监视器map落后时同步过程
	leader:是实现最新paxos版的第一个监视器
	provider:有最新集群运行图监视器，但不是第一个实现最新版
	Requester:落后于leader,重回法定人数前，必须同步以获取关于集群的最新信息。
	发现自己落后：Requester->leader
			\	#向leader请求同步，leader返回让去requester同步
			 \requester
################################################################################
配置：
mon host=主机名（可被解析的）
mon addr=IP:6789,....
mon initial members=3监视器的个数
mon osd full ratio=.80 最大使用存储容量。
mon osd nearfull ratio=.70 容量使用报警上限。
mon sync trim timeout	
默认值：30
mon sync neartbeat timeout
默认值：30
mon sync heartbeat interval
默认值：30
mon sync backoff timeout
默认值：30
mon sync time
默认值30
mon sync max retries
默认值：5
mon sync max payload size #同步载荷的最大

