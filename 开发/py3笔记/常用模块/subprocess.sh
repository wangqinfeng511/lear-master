此模块为内置，替换了os.system()
import subprocess
from subprocess import Popen

with Popen(['/bin/bash','-l','-c','ls -l /etc && echo OK'],stdout=subprocess.PIPE,stderr=subprocess.STDOUT) as p:
        p.wait()
        print(p.communicate())  #把结果和错误以元组方式返回。
start_new_session=True 参数：没查
#subprocess.PIPE把结果管道给输出，stderr错误合并给stdout

#
with Popen(['/bin/bash','-l','-c','ls -l /etc && echo OK']) as p:
         p.wait() #执行进程结束。可接受参数数字，表示在几秒内执行不完则退出。
         print(p.stdout()) #不使用管道输出标准结果。
	 p.stderr() #输出标准结果和标准错误。
	 p.pid()  #输出标进程pid
	 p.p.returncode #返回结果码
#########################################################
Popen 常用参数
	stdin:输入
	stdout : 输出。
	cwd:在哪个目录执行命令。
	env:传入环境变量
	shell:在字符串时有用，在使用列表为参数时没啥用处。
