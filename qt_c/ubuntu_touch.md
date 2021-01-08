clickead clean //清除
	create 创建项目
	build 编译
	click-build //编译成click包
	install  //安装
	launch	//启动
	logs   //查看日志
xxxx.apparmor //应用权限配置
	 "policy_groups": ["networking"] //使用网络
xxxx.desktop.in
	//图标 //程序显示名称

docker run -v /home/wangqinfeng/ubuntu_ipon/net_play:/home/wangqinfeng/ubuntu_ipon/net_play -w /home/wangqinfeng/ubuntu_ipon/net_play/libs/ffmpeg -u 1000 -e HOME=/tmp  -i clickable/ubuntu-sdk:16.04-armhf bash -c './configure  --target-os=linux --disable-x86asm --prefix=/home/wangqinfeng/ubuntu_ipon/net_play/libs/ffmpeg/build  --disable-static --enable-shared'

docker run -v /home/wangqinfeng/ubuntu_ipon/net_play/libs/ffmpeg:/home/wangqinfeng/ubuntu_ipon/net_play/libs/ffmpeg:Z -w /home/wangqinfeng/ubuntu_ipon/net_play/libs/ffmpeg -u 1000 -e HOME=/tmp --rm -i clickable/ubuntu-sdk:16.04-armhf bash -c 'make'

docker run -v /home/wangqinfeng/ubuntu_ipon/netplay:/home/wangqinfeng/ubuntu_ipon/netplay -w /home/wangqinfeng/ubuntu_ipon/netplay/libs/ffmpeg -u 1000 -e HOME=/tmp  -i -t clickable/ubuntu-sdk:16.04-armhf


./configure --target-os=linux --arch=arm64  --disable-asm  --disable-x86asm  --enable-cross-compile --cc=/usr/bin/arm-linux-gnueabihf-gcc  --prefix=/home/wangqinfeng/ubuntu_ipon/netplay/libs/ffmpeg/build --disable-ffmpeg --disable-ffplay --disable-ffprobe  --disable-static --enable-shared