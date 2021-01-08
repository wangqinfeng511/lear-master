from my_m import Router ,Application
from webob import Response
from  functools import wraps
from  webob.exc import HTTPUnauthorized
from my_m.uttis import jsonfy
import  jwt
import json
import datetime
__KEY='sadfasdfsadfasdfsadfsdf'
router=Router()
def authenticated(fn):
    @wraps(fn)
    def wrap(dex,request):
        #print(dex,request)
        token=request.headers.get('X-Authorization-Token')
        if token is None:
            raise HTTPUnauthorized()
        try:
            decoded=jwt.decode(token,__KEY,['HS512'])
            user=decoded.get('user')
            request.user=user
            return fn(dex,request)
        except Exception:
            raise HTTPUnauthorized()
        if user=='root' and password=='pass':
            request.user=user
            return fn(app,request)
        raise HTTPUnauthorized()
    return wrap
@router.route('/')
@authenticated
def main(dex,request):
    return Response('hello word')

app=Application([router])
@router.route('/r2/login',method=['POST'])
def login(ctx,request):
    payload=request.json()
    if payload.get('username')=='root' and payload.get('password')=='pass':
        exp=datetime.datetime.utcnow()+datetime.timedelta(hours=8)
        token=jwt.encode({'user':'root','exp':exp},__KEY,'HS512').decode()
        return jsonfy(code=200,token=token)
    return jsonfy(code=401,message='username or password not match')
if __name__ == '__main__':

    from wsgiref.simple_server import make_server
    server=make_server('',3001,app)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        server.shutdown()

