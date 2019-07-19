用于监控文件装态
from watchdog.observers import Observer
from watchdog.events import LoggingEventHandler
import logging
import time
logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s - %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S')
		    #定义INFO日志格式
event_handler=LoggingEventHandler()
observer=Observer()
observer.schedule(event_handler,'/var/log/nginx',recursive=True)
observer.start()
while True:
    time.sleep(2)
####################################################################
监控目录内文件变


from watchdog.observers import Observer
from watchdog.events import LoggingEventHandler
from watchdog.events import FileSystemEventHandler
import datetime
import logging
import time
logging.basicConfig(level=logging.INFO,format='%(asctime)s-%(message)s')
#B=LoggingEventHandler()
A=Observer()

c='b'
class Myhared(FileSystemEventHandler):
    def on_modified(self, event):
             print("hello")
             c='a'

B=Myhared()
A.schedule(B,'/var/log/nginx',recursive=False)
A.start()

while True:
