 git clone https://github.com/kanaka/noVNC.git
 启动./utils/launch.sh --vnc 10.10.10.202:5900 
########################################################
mkdir no_VNC/vnc_tokens
cd vnc_tokens
vim vim vnc-1.ini
	abcdefg: 192.168.12.105:5900

cd no_VNC
	 websockify --web=. --target-config=./vnc_tokens 6080

http://192.168.12.105:6080/vnc_auto.html?token=abcdefg
###################
总结在要vnc-1.ini写的是对应的vnc地址。

