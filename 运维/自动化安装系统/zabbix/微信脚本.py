#!/bin/env python3
import ssl,json,os,sys
from urllib import request,parse
class Send_Mess:
    def get_token(self):
        ssl._create_default_https_context = ssl._create_unverified_context
        url = 'https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=wx911de5ff488262e1&corpsecret=igI0bieobRTV3Acq180i9UPJDP17y73DXNj-wysIIg4'
        with request.urlopen(url) as f:
            token=json.loads(f.read())
        path_dir=os.path.dirname(__file__)
        with open(os.path.join(path_dir,'token'),'w') as f:
            f.write(json.dumps(token))
        return token
    def send_mess(self,mess):
        ssl._create_default_https_context = ssl._create_unverified_context
        data = {'toparty': 39, 'msgtype': "text",
                "agentid": '1000005', "text": {"content": '{}'.format(mess)}, 'safe': 0}
        path_dir=os.path.dirname(__file__)
        with open(os.path.join(path_dir,'token'),'r') as f:
            token=json.loads(f.read())
        url = 'https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token={}'.format(token.get('access_token'))
        new_url = request.Request(url, json.dumps(data, ensure_ascii=False).encode('utf-8'))
        with request.urlopen(new_url) as f:
            respone=json.loads(f.read())
        if respone.get('errcode')==42001:
            self.get_token()
            with request.urlopen(new_url) as f:
                respone = json.loads(f.read())
with open('/tmp/wx','a') as f:
    f.write('ceshi')
mes=Send_Mess()
#mes.get_token()
mes.send_mess(sys.argv[1])
#mes.send_mess(sys.argv)
