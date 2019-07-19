目录创建：
 import os
 切换目录：os.chdir('/home')
 创建目录：os.mkdir('/tmp/test')#创建目录。
		os.makedirs('/tmp/a/b')#递归创建目录。
			参数：exist_ok=True 目录存大不抛出错误。
			     mode=(0o644) #设置目录权限。
删除目录：import os	
		os.rmdir() #删除目录，不可递归删除。
		os.removedirs() #递归删除空目录。
		os.geteuid()	#返回当前用户的ID
	import shutil #shell库_系统调用。
		shutil.rmtree('/tmp/test')#相当于bash的rm -rf
			参数：
				ignore_errors=True #关闭错误输出。
				onerror=lambda,fn,path,exc_info:print(path,exc_info[1])
移动目录：import shutil 
		shutil.move('/tmp/test','/tmp/a') #移动目录。
复制目录：import shutil
		shutil.copy() #复制数据和数据权限。
		shutil.copy2() #复制数据与stat info (权限，atime,ctime,mtime,flags)
		shutil.copyfile() #复制数据
		shutil.mode()	#复制权限
			参数：
				symlinks=True #如果有链接，复制链接。
目录遍历：
	import os
		os.listdir()	#列出当前目录，返回列表。
		os.path.isdir()	#判断是否为一个目录。
		os.path.join()	#类字符的join。
		os.walk()	#遍历当前目录。
			例：os.walk('tmp') #返回一个生成器。
			import os 
			for root,dirs,file in os.walk('/tmp'):
				print(root,dirs,file)
		os.scandir()
路径相关操作：
	import os
		os.path.basename()	#传入路径，返回文件名称。
		os.path.dirname()	#传入路径，返回目录。
		os.path.join()		#例os.path.join('/','tmp','a','b')
		os.path.split()		#把文件路径进行分隔，分隔为目录和文件名。
		os.getcwd()	#返回当所在目录。
		os.path.is...		#判断是否为。。。
		os.path.splitext()	#对文件名进行分隔，名和扩展名。
	import sys
		print(sys.argv)		#返回当前文件名。
		print(os.path,abspath(os.path.dirname(sys.argv[0])))

#################################################################################################
序列化与反序列化:
	序列化：对象->str/bytes
	反序列化：str|bytes->对象
import pickle 序列化，只能用于python使用。并且版本要求一样。
	常用序列化：
		import pickle
			pickle.dump()	#把对象序列化到文件。支持（int,float,str,list,dict,bool,None）
			pickle.dumps()	#直接序列化，并不同步到文件。
			pickle.load()	#从文件转为非序列化。
			pickle.loads()	#直接反序列化。
		import json 		#常用序列化。
			对应：python:json
				int:number
				str:string
				bool:bool
				None:null
				list:array
				tuple:array
				dict:object
			json.dump()
			json.dumps()
			json.load()
			json.loads()
###############################################################################
文件属性：os.stat
