什么是redux?
我们都知道如果要实现Dom的动态加载要改变对应的state值。redux就是用来管理状态的管理器。
工作流程：
首先得有个存状态的地放，redux创造了store容器。
因为state状态都是在dom内部维护的，所以要把state转为props，只有这样才能在容器外面取得状态值存在容器中。
因为我们想要控制更新时机，所以出现了Action。动作名
因为我们要改state值，所以出现了reducer.它的内部要写动作名匹配后我要执行什么动作，比如我就让它对count的值加1。

隐式部分：dispatch()此方法用于把action动作名传给reducer.如果不用装饰器就要明确指定了。


/////////////////////////////////////////////////////////////////////////////

import React from 'react'; //引用react 
import  ReactDom from 'react-dom'; //引用reactDom 绑定html要用
import {Provider} from 'react-redux'; //组件使用react-redux装态管理功能
import {createStore} from 'redux'; //创建store容器，此容器存所有dom的state状态值。
import {connect}  from 'react-redux'; //真正把redux绑定在react dom组件上。


@connect(			//使用react-redux连接装饰器。要求有两个参数。
    state=>({value:state.count}), //要求是一个函数，作用是把state绑定至props外部组件才能访问。value要求是一个props在14商明了
    {onIncreaseClick:Onclick}	// onIncreaseClick要求是一个props，Onclick要求是一个type:xxx对象
)
class App extends React.Component{
    render(){
        const {value,onIncreaseClick}=this.props
        return(
            <div>
                <span>{value}</span>
                <button onClick={onIncreaseClick}>jia</button> //单击时执行onIncreaseClick时通过dispacth隐式的调用Action的Onclick方法。因为在connect内指定了onIncreaseClick对应的方法是Onclick。
            </div>
        )
    }
}
//此处为Action部分,会把此方法返回的对象值传给reducers。
function Onclick() {
    return {type:'increase'}
}

//此处为reducers部分定义了action.type的值在对应后改变哪个state的值。
function counter(state = {count:0},action) { //我给状态传入count的初始值
    const count =state.count
    switch (action.type) {
        case 'increase':
            return {count:count + 1} //此处为改变的props(在DOm内已经把它转为了pros.state).count的值
        default: //未匹配时反回原样装态信息
            return state
    }
}
const  store = createStore(counter) //创建store状态容器

ReactDom.render(
    <Provider store={store}> //只有被此包裹的dom才能被redux管理状态。
        <App />
    </Provider>,root)


if (module.hot) {
    //热加载设置，关注为./reducer的变化进行加载
    module.hot.accept('./reducers', () => {
        const nextReducer = require('./reducers');
        store.replaceReducer(nextReducer);

    })
}

