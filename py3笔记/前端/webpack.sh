1、每个项目目录下必须有一个webpack.config.js文件。用于告诉webpack要作什么。
2、webpack中，所有的资源都被当作是模块，js,css,图片等。
3、对应的模块有对应的loader。对应模块列表：
	在项目目录下要执行，npm init 生成版本的一些信息。
	项目目录下安装js的依赖	npm install jsx-loader --save-dev
				npm install webpack --save-dev
	webpack ./写的js文件名 输出的打包后的文件名。
4、
var webpack=require('webpack'); #require（）加载的打包工具。
module.exports={		#打包模块程序开始：
    entry:{		
        index:'./index.js'	#项目js的入口文件名。
    },
    output:{
        path:'./',		#输出文件路径。
        filename:'app.js'	#输出的文件名。$[name].js表示使用原名，但要在不同目录,否则会覆盖原文件。 
    },
    module:{
        loaders:[		#打包模块时要用哪个插件打包，不同的文件有不同的打包插件。
            { test:/\.js$/,loader:'jsx-loader?harmony'}

        ]
    }
}

