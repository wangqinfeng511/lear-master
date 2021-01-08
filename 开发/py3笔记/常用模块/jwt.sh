sudo pip3 install PyJWT
生成token
import jwt
import datetime
#时间加8小时
a=datetime.datetime.now()+datetime.timedelta(hours=8)
key='sdfsdfdfjiuufiiasdfksdjfi'
#要求加密的是字典，'exp'是固定参数，表示过期时间，'HS512'表示加秘格式。
#key就是秘钥
token=jwt.encode({'user':'pass','exp':a},key,'HS512')
token=jwt.encode({'user':'name','pass':'123','exp':a},key,'HS512')
#########################################################
#解密
jwt.decode(token,key,['HS512'])



