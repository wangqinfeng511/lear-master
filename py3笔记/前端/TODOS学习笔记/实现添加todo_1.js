/**
 * Created by root on 16-10-31.
 */
import React from 'react';  //引入React库

class  NewTODOComponent extends React.Component{ //些组件实现一个输入框，和一个确定按键
    constructor(props){			//实例化
        super(props)		 //引入父级
        this.state={value:''}	//state kye值变化时更新引用元素。
        //this.handleNewToDO=this.handleNewToDO.bind(this);
    }
    render(){ 	//react组件必须
        return(
            <div> 						 	//商量一个组件属性onTODOCreated
                <form className="pure-form" onSubmit={()=>this.props.onTODOCreated(this.state.value)}>
            <fieldset>
                <legend>事件记录</legend>							
                <input type="text"  value={this.state.value} onChange={e=> this.setState({value:e.target.value})}/>
                <button type="button" onClick={()=>this.props.onTODOCreated(this.state.value)} className="pure-button pure-button-primary">录入</button>
                </fieldset>
            </form>
            </div>
        )
    }
}

class  TODOComponent extends React.Component{
    constructor(props){
        super(props);
        this.state={todos: []}
    }
    render(){
        return (
                <div className="prue-g">
                    <div className="prue-u-1-24">
                        <input type="checkbox"/>
                    </div>
                    <div className="prue-u-1-23">{this.props.content}</div>
                </div>
            )
    }
}
class  TODOListComponent extends React.Component{
    render(){
            return(
                <div>
                    {
                        this.props.todos.map((it, i) => <TODOComponent key={i} content={it.content}/>)
                    }
                </div>
            )
    }
}

export default class RootComponent extends React.Component{
    constructor(props){
        super(props);
        this.state={todos:[]};
        this.handleNewToDO=this.handleNewToDO.bind(this)
    }

    handleNewToDO(value){
        console.log(value);
        const todo = {content:value,isCOmplate:false};
        const todos = this.state.todos;
        console.log(todos)
        todos.push(todo);
        this.setState({todos:todos});
    }
    render(){
        return (
            <div>
                <NewTODOComponent onTODOCreated={this.handleNewToDO}/>
                <TODOListComponent todos={this.state.todos.filter(it =>!it.isCOmplate)}/>
            </div>
        )
    }
}
