#webpacke配置文件,主要用来打包。
var path = require('path'); #加载当前路径并实例化。
var webpack = require('webpack'); #加载模块并实例化

module.exports = {   #配置开始
    entry: [	#入口文件配置。
        'react-hot-loader/patch',  #哪个目录下动态加载改变内容，设为项目目录
        'webpack-dev-server/client?http://192.168.253.25:3000', #webpack server 请求路径。
        'webpack/hot/dev-server',	#dev-server的路径node_modules下
        './app/index'			#入口文件，index.js
    ],
    output: {
        path: path.join(__dirname, 'dist'),
        filename: 'bundle.js',		#打包后的输出文件名
        publicPath: '/assets/'		#打包后的输出路径
    },
    plugins: [ #插件部份
        new webpack.HotModuleReplacementPlugin() #模块热替换模块方法
    ],
    module: {
        loaders: [
            {
                test: /\.js$/,		#匹配规则
                loader: 'babel',	#匹配后采用的转换器，转为ES5
                exclude: /node_modules/, #模块路径	
                include: path.join(__dirname, 'app') #引入app目录下js。
            }
        ]
    }
};
