from webob import Response
import json

def jsonfy(**kwargs):
    return Response(json.dumps(kwargs),content_type='application/json')