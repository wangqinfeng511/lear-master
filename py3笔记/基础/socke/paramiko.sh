安装模块
pip install paramiko
from paramiko import SSHClient
from paramiko import AutoAddPolicy
client=SSHClient() #实例化对像
client.load_system_host_key()
client.set_missing_host_key_policy(AutoAddPolicy())
client.connect('192.168.99.162',username='root',password='h2mGX!@#2016')
stdin,stdout,stderr=client.exec_command('ls -l')
print(stdout.read())
