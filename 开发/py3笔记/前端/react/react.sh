引入react,react-dom 
import React from 'react'
import React-dom from 'react-dom' #react对react-dom作了分离
inport Index from './main.js'
#index.html <body> <div id="root"></div></body> 标签用来实现react组件的绑定。
index.js #作入口js绑定。
ReactDom.render(<Index/>,document.getElementById('root'))
####################################################
import React,{Component} from 'react'

#main.js组件实现
#引入此文件默认引入的类，这个类继承于Component类。
export default class Index extends Component{
	constructor(props){ super(props),this.state={upds:0}} #继承了父类的props所有属性，构建类。
	render(){
		return(<div>a</div>)
	}
}
<<<<<<< HEAD
#表达示：{this.state.status?<input type='text'>:<input type='button'>}
#getDefaultProps(){return({color:'red',text:'测试'})},为props设定默认值。
#this.props.children #返回所有的子组件，没组件返回undefinde,一个组件返回object,多组件返回list
#React.Children.map(this) #遍历返回本dom下的所有子组件。
#propTypes={name:React.propTypes.string} 对传来的prop进行类型检查。string,number,fun,onofType()不是是一个类型。
# const handleClick=(e)=>{console.log('测试')}#剑头函数会自动绑定。

#共用抽像装饰器：WrappedComponent
	const myContainer=(WrappedComponent)=>class extends Component{
		render(){const newProps={
			value:"我是装饰器传来的值",
			}
		};
		return <WrappedComponent{...this.props} {...newProps} />
	}

	@myContainer
	class Ceshi extendds Component{
		render(){
			return(
				<input {...this.props.value}/> #此处的对this.props.value进行遍历，它来自myContainer返回遍历后的newProps。
			)
		}
	}
	
	
=======
>>>>>>> 042b8a5ccfedd50220d8609ef3a18c0d5d23617c
##########################################################
#react 在state发生变化，props外部传值时会更新组件。
生命周期：
实例化期：
	getDefaultProps :给Props设定默认值。
	getInitialState: 设定state的初始值。
	componentWillMount：渲染前执行。
	render:渲染。
	compontDidMount：移除组件时执行。
存在期：
	compoentWillReceiveProps :有Props传入时。
	shouldComponentUpdae:  是否执行更新，默然返回true
	componentWillUpdate:渲染更新前。
	render 		：渲染前。
	compontDidUpdate:渲染结束后
销毁期：
	compontWillUnmount 
##############################################################
react 事件：
	组件内定义方法：参数为e表示event事件。
	e.target取得事件的dom，比如input 的onchange事件可以通过e.target.value取得值。
react 事件合并：
	ref='asssss' ,取得事件 this.refs.asssss.value 可以取出事件的value值。

#############################################################
react 数据可视化。
npm install recharts --save-dev
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
import {LineChart,XAxis,YAxis,CartesianGrid,Line,Tooltip}  from 'recharts'
import {BarChart,Bar,PieChart,Pie} from 'recharts'

#LineChart是K线。
#BarChart是柱型图。
#数据格式：
const data=[
        {name:'信息部',a:4000,b:1000},
	{name:'眼科',a:3000,b:200},
	{name:'CT',a:100,b:100},
	{name:'库存',a:300,b:20},
	{name:'报废',a:400,b:5000},
	{name:'外借',a:100,b:3000},]
#可以看出是一个列表，但元素是Object
<LineChart width={600} height={100} data={data}>
                <Tooltip top="ceshi" left="ceshi"/>
		<XAxis dataKey="name"/> #X轨显示为 信息部  眼科  CT  。。。
		<YAxis dataKey="b"/> #Y 轨最大值
		<Line dataKey="a" stroke="#8884d8"/> #这条线显示哪个key的数据。
		<Line dataKey="b" stroke="#8804d8"/> #同上
</LineChart>
<BarChart width={600} height={100} data={data}> 
                <Bar fill="#8804d8" data={data} dataKey="a" /> #柱型图
</BarChart>
<<<<<<< HEAD

=======
>>>>>>> 042b8a5ccfedd50220d8609ef3a18c0d5d23617c
