import { Router, Route, Link, hashHistory, IndexRoute, Redirect, IndexLink} from 'react-router'
import React from 'react'
import ReactDOM from 'react-dom'
import {Provider} from 'react-redux';
import {createStore} from 'redux'
class A extends React.Component{
    render(){
        return <div>{this.props.children}</div>
    }
}
class B extends React.Component{
    render(){

        return <div>Hello word!</div>
    }
}
const store = createStore(todoApp)
function todoApp(state={value:''},action) {
   return state
}
ReactDOM.render(
    <Provider store={store}> //redux部分
    <Router history={hashHistory} > //路由部分
        <Route path="/" component={A}/> //入口路由必需要有 this.props.children
        <Route path="/b" component={B}/>
    </Router>
    </Provider>
    ,document.getElementById('root')); 

       if (module.hot){
        module.hot.accept('./reducers', () => {
            const nextReducer = require('./reducers');
            store.replaceReducer(nextReducer);

        })
    }
