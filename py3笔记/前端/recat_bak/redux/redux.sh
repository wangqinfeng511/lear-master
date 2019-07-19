单向流动理论。
工作流程：
	ation 	#数据的产生源。
	reducer #动作规则。
	store	#项目唯一，存储状态的容器。
	connect #装饰器函数，框架内实现。用来传递视图到容器的桥。
	view 	#各dom.
##说白了就是管理各组件内的state,状态。因为在state｛内发生变化时更新相应的组件内容｝。
###############################################################################
ations.js写法：主要完成了数据的格式 各状态类型，和对应方法。
export const  ADD_TYPE ='ADD_TYPE';
export function add (content) {
    return {
        type:ADD_TYPE,
        content
    }

}
export const DONE_TYPE = 'DONE_TYPE';
export function done (id) {
    return {
        type:ADD_TYPE,
        id
    }
}
export const REOPEN_TYPE = 'REOPEN_TYPE';
export function reopen(id) {
    return {
        type:REOPEN_TYPE,
        id
    }

}
export const FILTER_TYPE ='FILTER_TYPE';
export function reopen(fl) {
    return {
        type: REOPEN_TYPE,
        fl
    }
}
######################################################################reducers.js
reducers.js 实现了各规则的调用
import  combineReducers from 'redux/lib/combineReducers'; //用于把多个reducers合并起来
import * as Actions from './actions';	//引入actions因为它定义了源
const  initialState={
    next_id:0,
    todos:[],
    filter:'todo'
}   //第一次调用给的state初始值格式


function todoApp(state=initialState, action) {  //reducer 的方法是要交给框架使用的，对定义的方法有参数要求! 当前的state，action各状态的定义。
    let todos=[]
    switch (action.type) { //
        case Actions.ADD_TYPE:
            const todo={id:state.next_id,content:action.content,done:false}
            return Object.assign({},state,{next_id:state.next_id+1,
                todos:[...state.todos,todo]})
        case  Actions.DONE_TYPE:
            todos=state.todos;
            todos.find(it =>it.id===action.id).done=true;
            return Object.assign({},state,{todos});
        case Actions.REOPEN_TYPE:
            todos=state.todos;
            todos.find(it =>it.id===action.id).done=false;
            return Object.assign({},state,{todos});
        case  Actions.FILTER_TYPE:
            return Object.assign({},state,{filter:action.fl});
        default:
            return state;

    }
}

const rootReducer = combineReducers( //对多reduerc进行合并
    {
        todoApp
    }
);
export default rootReducer;
#######################################################################################
各组件内使用redux
#使用方法,传入一个state 使用装钸器.babelrc要添加装饰器转换器  transform-decorators-legacy并npm i  transform-decorators-legacy --save-dev
import * as Action from './actions' 
import connect from 'react-redux/lib/components/connect';
@connect(state=>({todoApp:state.todoApp})) //todoApp是actions内定义的一个方法
this.props.dispath(Action.add(value)) #对actions进行传值。
