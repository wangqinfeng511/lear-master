/**
 * Created by comyn on 16-10-29.
 */
import ReactDOM from 'react-dom';
import { connect } from 'react-redux';
import React from 'react';
import { Provider } from 'react-redux';
import  {createStore} from 'redux';

class Counter extends React.Component{
    render(){
        const { value, onIncreaseClick } = this.props
        return(
                <div>
                    <span>{value}</span>
                    <button onClick={onIncreaseClick}>Increase</button>
                </div>
        )
    }
}
//定义connect要使用的第一参数，用于把DOM内的state转为props因为要在外部取得和改变state的值。
function mapStateToProps(state) {
    return {
        value:state.count
    }
}
//定义通过dispatch 传入store的Action
//increaseAction是一个object对象。
function mapDispatchToProps(dispatch) {
    return {
	//onIncreaseClick为一个props,传入stors的action的对象
        onIncreaseClick: ()=>dispatch(increaseAction)
    }
}
//定义Action
const increaseAction = {type: 'increase'}

//连接react和 redux，生成redux容器
const App = connect(
    mapStateToProps,
    mapDispatchToProps
)(Counter)

//此处为redues定义，定义怎么改变状态值。
function counter(state = { count:0},action) {
    const count =state.count
    switch (action.type) { //action.type取出传入的action是什么。
        case 'increase':
            return {count:count + 1}
        default:
            return state
    }
}
const store = createStore(counter)
ReactDOM.render(
    <Provider store={store}>
    //绑定redux容器至页面
	<App /> 
</Provider>,root);

if (module.hot) {
    //热加载设置，关注为./reducer的变化进行加载
    module.hot.accept('./reducers', () => {
        const nextReducer = require('./reducers');
        store.replaceReducer(nextReducer);

    })
}

