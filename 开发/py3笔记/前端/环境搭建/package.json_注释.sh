#项目下创建package.json。执行npm i 插件会自动安装
{
  "name": "todo", 	#项目名称
  "version": "1.0.0",	#版本信息
  "description": "a simple todo list web app",	#项目描述。
  "main": "index.js",	#入口文件
  "scripts": {		#脚本
    "test": "echo \"Error: no test specified\" && exit 1",
    "start": "node server.js"	#启动时执行此js，此文件主要有监听地址，端口。
  },
  "repository": {	#git的路径。
    "type": "git",
    "url": "git+https://github.com/comynli/todo.git"
  },
  "author": "comyn",	#作者
  "license": "Apache-2.0",	#标准
  "bugs": {		#bugs路径
    "url": "https://github.com/comynli/todo/issues"
  },
  "homepage": "https://github.com/comynli/todo#readme",
  "devDependencies": {
    "babel-core": "^6.18.0", 	#模块babel主模块版本,默认不带转码器
    "babel-loader": "^6.2.7",	#
    "babel-plugin-transform-decorators-legacy": "^1.3.4", #ES6使用装饰器插件。
    "babel-preset-latest": "^6.16.0",
    "babel-preset-react": "^6.16.0", #支持react语法插件
    "babel-preset-stage-0": "^6.16.0", #热加载，改过文件不用重启服务。
    "react-hot-loader": "^3.0.0-beta.6", #不刷新网页下刷新改动部分自动刷新。
    "webpack": "^1.13.3",		#webpack打包工具版本号
    "webpack-dev-server": "^1.16.2"	#webpack提供的服务端。server.js用到
  },
  "dependencies": {
    "react": "^15.3.2",		#react版本
    "react-dom": "^15.3.2",	#
    "react-redux": "^4.4.5", 	#react支持redux
    "redux": "^3.6.0"		#redux版本号
  }
 }

