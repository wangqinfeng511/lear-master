定义日志格式，和级别；
import loging
logging.basicConfig(level=logging.DEBUG,format='%(threadName)s') #定义DEBUG级别信息。
logging.DEBUG=10 ,设置报警级别
一般用于线程非正常退出时
logging.debug('adfasdf') # 输出debug信息
%(asctime)s
%(created)f
%(filename)s
%(funcName)s
%(levelname)s
%(levelno)s
%(lineno)d
%(module)s
%(msecs)d
%(message)s
%(name)s
%(pathname)s
%(process)d
%(processName)s
%(relativeCreated)d
%(thread)d
%(threadName)s

列：

import logging,os

# error_format=logging.Formatter
class Log_config:
    def __init__(self):
        self.cnf={}
    def config(self):
        error_log = logging.getLogger()
        path=os.path.dirname(__file__)
        with open(os.path.join(path,'log_config'),'r') as f:
            cnf=f.readlines()
            for i in cnf:
                cnf_list=i.split(':')
                self.cnf[cnf_list[0]]=cnf_list[1].split('\n')[0]
        if self.cnf.get('log_level')=='debug'.upper():
            error_log.setLevel(logging.DEBUG)
        elif self.cnf.get('log_level')=='info'.upper():
            error_log.setLevel(logging.INFO)
        elif self.cnf.get('log_level')=='warning'.upper():
            error_log.setLevel(logging.WARNING)
        else: error_log.setLevel(logging.ERROR)
        headler=logging.FileHandler(os.path.join(self.cnf.get('log_path'),'error.log'))
        formatter=logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        headler.setFormatter(formatter)
        error_log.addHandler(headler)
        return error_log
config_file:
log_path:/Users/wangqinfeng
log_level:debug

