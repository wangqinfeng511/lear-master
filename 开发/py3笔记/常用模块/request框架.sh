#import requests
requests.post('http://127.0.0.1:8086/write',data=kv值,params=('db'):'mage')
import requests #导入模块。
r=requests.get('http://192.168.99.143/index.php',auth=("admin",'fengzi'),timeout=1)#get页面设置请求超长时间。
print(r.status_code) #打印状态码。
print(r.encoding)	#打印字符集。
#print(r.text)		#打印返回的页面
print(r.content) #bit	#打印二进制页面。
#r.json()
