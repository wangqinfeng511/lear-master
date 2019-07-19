import React,{Component} from 'react'
import ReactDom from 'react-dom'
import {createStore} from 'redux'
import {Provider} from 'react-redux'
import todo from './reducer/todo'
import  {addTodo} from './actions/index'
const stores=createStore(todo) //绑定redux

export default class Index extends Component{
    constructor(props){
        super(props)
        this.onclicks=this.onclicks.bind(this)
        this.state={a:0}
      }

    onclicks(e){
        stores.dispatch(addTodo(this.ce)) //发送addTodo action到action
        this.setState({a:stores.getState().text}) //stores.getState().text绑定到组件的state
    }
    render(){
        const a=stores.getState()
        return(<div className="container-fluid">
            {this.state.a}
            <button id="c" onClick={this.onclicks}>ceshi</button>
        </div>)
    }
}


ReactDom.render(
    <Provider store={stores}>
        <Index/>
    </Provider>
    ,document.getElementById('root')
)


/* action部分*/
let nextTodoId=0
export const addTodo=(text) =>{
    return{
        type:"ADD_TODO",
        id:nextTodoId,
        text
    }
}

/* reduxs 部分*/
const todo=(state,action) =>{
    switch (action.type){
        case "ADD_TODO":
            return{
                id:action.id,
                text:action.text+1,
                complete:false}
        default:
            return state
    }
}

export default todo
/*多redux合并*/
import todos from './todo'
import {combineReducers} from 'redux'

const todoApp=combineReducers(
    {todos}
)

export default todoApp
