作用：用于向指定地址发出url请求
<<<<<<< HEAD
例:get
	 fetch('/api/ceshi').then(function (e) {
            console.log(e.json)
            return e.json()
        }).then(function (d) {
            this.setState({a:d})
            console.log(this.state)
        }.bind(this))
bind(this)react用于绑定到this


post 
	fetch('/api/login',{method:'POST',body:JSON.stringify({user:input_user,password:input_password}),credentials:"same-origin"}).then(function (e) {
            return(e.json())
        }).then(function (body) {
            console.log(body)

        })
	#credentials:"same-origin" 带cookie
=======
>>>>>>> 042b8a5ccfedd50220d8609ef3a18c0d5d23617c
用法:
consn p= fetch('http://192.168.99.143:80',{method:'POST',body:JSON.stringify({content:value})})
注：
method 请求的方法 
body:请求发出的参数
JSON.stringify() JSON转换为字符串。
content:value 请求的带的参数。name:password
########################################################
p.then() 请求成功执行什么。
p.cath() 请求失败执行什么。
#################################################################################################
跨域问题解决：
	代理方法:使用webpack-dev-server
	server.js 内添加代理
#########################server.js
/**
 * Created by comyn on 16-10-29.
 */
const webpack = require('webpack');
const WebpackDevServer = require('webpack-dev-server');
const config = require('./webpack.config');

new WebpackDevServer(webpack(config), {
    publicPath: config.output.publicPath,
    hot: true,
    stats: {
        chunks: false
    },
    proxy:{ 
        '/api/**':{target:'http://127.0.0.1:8080'} //url han /appi/**   proxy 127.0.0.1:8080
    }
    #代理部分，把所有url以/api/开头的代理到http:127.0.0.1:8000 
}).listen(3001, '0.0.0.0', err => {
    if (err) {
        console.log(err)
    } else {
        console.log("listen on 3001")
    }
});
