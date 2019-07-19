pyenv安装
作用：版本切换
yum -y install git gcc make patch zlib-devel gdbm-devel openssl-devel sqlite-devel bzip2-devel readline-devel
pyenv安装：
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

###
vim /etc/profile.d/pyenv.sh 添加
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)
pyenv常用命令：
commands 列出命令
local	 切换版本 例如pyenv 3.5.2
versions 列出支持的python版本。
version	 列出现用的python版本。
install  安装python 例如：pyenv install 3.5.2
uninstall 卸载python 例如：pyenv uninstall 3.5.2
--list 	列出所有版本。
update	更新pyenv
安装python:
	mkdir ~/.pyenv/cache
	下载Python-3.5.2.tar.gz放置此目录。执行pyenv install
因为是编译安装：所以要装好：
gcc make patch gdbm-devel openssl-devel sqlite-devel zlib-devel bzip2-devel readline-devel
###############################################################################
pip安装：
wget "https://pypi.python.org/packages/source/p/pip/pip-1.5.4.tar.gz#md5=834b2904f92d46aaa333267fb

tar -xzvf pip-1.5.4.tar.gz
 cd pip-1.5.4
 python setup.py install
##############
更换源
创建目录 mkdir ~/.pip
编辑 ~/.pip/pip.conf, 输入一下内容
  [global]
  index-url = http://mirrors.aliyun.com/pypi/simple/
  trusted-host = mirrors.aliyun.com
####安装ipython
pip install ipython
pip search ipython
#######################################################################
ide环境：pycharm |idea eclipse vim(jedi命令补全)
jupyter
######################################################################
  项目笔记地址
https://coding.net/u/comyn/p/python2016/git/blob/master/notes/pyenv.md

