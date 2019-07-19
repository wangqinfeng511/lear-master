websocket钩子函数：
	socket.onpen 打开时执行的动作。
	socket.onmessage接收到消息时执行的动作
	socket.onerror　错误时执行的动作。
	socket.onclose　关闭时执行的动作。
实例化：
var socket=new WebSocket('ws://127.0.0.1:3000/boke/CreateWord/') 创建连接。
常用属性：
	socket.readyState　#是否连接
	socket.send()	#发送消息。JSON.stringify(data)
#初始化动作。
socket.onopen=function () {
        socket.onmessage=function (e) {
            document.getElementById('ceshi').textContent=JSON.parse(e.data).cpu+'%'
            document.getElementById('neicun').textContent=JSON.parse(e.data).memory+'%'
        };
          socket.send('hello word')
{#        console.log(socket.readyState,WebSocket.OPEN);#}
{#        socket.close()#}
{#        socket.onerror=function (event2) {#}
{#            console.log('socket error',event2)#}
{#        }#}
         socket.onclose=function () {
            console.log('hello word over')
        };
    };
