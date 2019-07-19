from wsgiref.simple_server import make_server
from webob import Request,Response
from webob.dec import wsgify
from collections import namedtuple
from webob.exc import HTTPNotFound
from webob import Response
import re
import json
PATTERNS={
    'str':'[^/].+',
    'word':'\w+',
    'any':'.+',
    'int':'[+-]?\d+',
    'float':'[+-]?\d+\.\d+'

}
CASTS={
    'str':str,
    'word':str,
    'any':str,
    'int':int,
    'float':float


}

Route=namedtuple('Route',['pattern','methods','casts','handler'])

class Router:
    def __init__(self,prefix='',domain=None):
        self.routers=[]
        self.domain=domain
        self.prefix=prefix
    def _rule_parse(self,rule): #@r2.route('/hello/{name:str}/{arg:int}')
        pattern=[]
        spec=[]
        casts={}
        is_spec=False
        for c in rule:
            if c=='{' and not is_spec:
                is_spec=True
            elif c=='}' and is_spec:
                is_spec=False
                name,p,c=self._spec_parse(''.join(spec))
                spec=[]
                pattern.append(p)
                casts[name]=c
            elif is_spec:
                spec.append(c)
            else:
                pattern.append(c)
        return '{}$'.format(''.join(pattern)),casts
    def _spec_parse(self,src):
        tmp=src.split(':')
        if len(tmp)>2:
            raise Exception('error pattern')
        name=tmp[0]
        type='str'
        if len(tmp)==2:
            type=tmp[1]
        pattern='(?P<{}>{})'.format(name,PATTERNS[type])
        return  name,pattern,CASTS[type]


    def _route(self, rule, method, handler):
        pattern,casts =self._rule_parse(rule)
        self.routers.append(Route(re.compile(pattern), method,casts,handler))

    def route(self, patttern, method=None):
        if method is None:
            self.methods = ('GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTION')

        def dec(nf):
            self._route(patttern, method, nf)
            return nf
        return dec
    def _domain_match(self,request):
        return self.domain is None or re.match(self.domain, request.host)
    def _prefix_match(self,request):
        print(self.prefix)
        return request.path.startswith(self.prefix)
    def match(self,request):
            if self._domain_match(request) and self._prefix_match(request):
                for route in self.routers:
                    #print(route)
                    if request.method in self.methods:
                        #m=route.pattern.match('/hello/this')
                        m=route.pattern.match(request.path.replace(self.prefix,'',1))
                        if m :
                            request.args={}
                            for k,v in m.groupdict().items():
                                request.args[k]=route.casts[k](v)
                            #request.args=m.groupdict()
                            return route.handler

                raise HTTPNotFound(detail='no handler match')

class Request(Request):
    def json(self):
        return json.loads(self.body.decode())
class Application:

    def __init__(self,routers=None,**options):
        if routers is None:
            routers=[]
        self.routes=routers
        self.options=options

    def add_router(self,router):
        #print(router)
        self.routes.append(router)

    @wsgify(RequestClass=Request)
    def __call__(self, request):
        for router in self.routes:
            #print(router)
            handler=router.match(request)
            #print(handler)
            if handler:
                return handler(self,request)



