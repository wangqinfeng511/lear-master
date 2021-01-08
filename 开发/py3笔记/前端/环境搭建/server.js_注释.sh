/**
 * Created by comyn on 16-10-29.
 */
const webpack = require('webpack'); #require加载模块
const WebpackDevServer = require('webpack-dev-server'); #加载插件提供server服务。并实例化
const config = require('./webpack.config'); #加载webpack.config.js

new WebpackDevServer(webpack(config), {# webpack(config) webpack加载配置文件，webpack-dev-server（webpack方法。）
    publicPath: config.output.publicPath,
    hot: true,			#动态加载
    stats: {
        chunks: false
    },
    proxy: {	#代理
        '/api/**': {target: 'http://127.0.0.1:8080'}  #因为
    }
}).listen(3000, '0.0.0.0', err => { #监听端口，并把错误打印。
    if (err) {
        console.log(err)
    } else {
        console.log("listen on 3000") #正常启动输出。
    }
});
