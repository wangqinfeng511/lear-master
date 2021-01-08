/**
 * Created by root on 16-10-24.
 */
if (0) {
    var a = 1; //定义全局变量，一般不用。
    let b = 1; //定义局部最变。一般使用。
    const c = 1; //静态变量
//== === != !==
// number--NaN infinite（数字--无穷） | boolean（布尔值） |undefined（未初始化值）| null（空）| array（列表）| symbol（符号）|object（字典）
}
//////////////////////////////////////list
if (0) {
    const arr = [1,2,3,4,5]; //初始化列表
    console.log(arr[1],arr[2],arr['length']);//列表索引取值，length=python len()
    console.log(Array.isArray(arr)) //isarry(),判断是否是一列表;
    const arr_str='12345';		
    const arr_list=Array.from(arr_str);//字符串转为列表。
    console.log(arr_list)	
    //Array.map()
    //Array.forEach()
    //Array.reduce()
    console.log(arr.shift()) //取出列表的最左边的值。
    console.log(arr.filter(e=>e!=2)) //遍历返回（一个函数）
    console.log(arr.find(e=>e===2)) //查找(条件一个函数)
    const [a,_,c]=arr;		//解包。
    console.log(a,c)
}
//////////////////////////////////type_type类型转换
if (0){
    let s ='123.12';
    let si1=+s;	//字符串转整形
    let si2=parseInt(s,8); // 字符串转整型，8代表八进制，默认为十进制。
    let sf1=parseFloat(s);	//字符串转浮点
    console.log(typeof(si1),si2,sf1);//typeof()类型返回。
    let s2=`this is ${typeof(s)}`;
    console.log(s2)
}
////////////////////////////////////re
if (0) {
    re = /\.*$/  匹配条件。
    re.compile() //创建匹配条件
    console.log(re.exec('adbc')) //开始匹配。
}
//////////////////////////////////////object
if (0){
    const o={a:1,b:2} //实例化字典。
    console.log(Object.keys(o)) //返回所有key
    const b={a:1,b:2}
    console.log(Object.is(b,o)) // 是否相同。
    let ba=Object.assign(o)   //深度复制字典。
    console.log(ba)
    const {d,e}=ba;	//字典解包，未成功。
    console.log(d,e)
}
if (0){
    const obj={}
    Object.defineProperty(obj,'a',{configurable:false,value:123,writable:false,emumerable:true})
    //configurable 是否能属除属性
    //value	默认值
    //writable 是否能改属性值。
    //emumerable 是允许否遍历
    obj.a=234
    console.log(obj.a)
}
/////////////////////////////////////JSON
if (0) {
    console.log(JSON.parse('{"a":1}')) //JSON
    let str=JSON.parse('{"ceshi":"hello word!"}')
    console.log(JSON.stringify(str))//反JSON
    const sym=Symbol('key')  //符号key
    console.log(typeof(sym)) //
}
////////////////////////////////////// if for switch where
if (0) {
    //////////////if语句
    if (1 > 2) {
        console.log('ceshi IQ!')
    } else if (2 > 1) {
        if (0) {
            console.log('ok!')
        }
    }

    //////////////switch语句
    let b = 3
    switch (b) { 
        case 1:
            console.log('page 1');
            break;
        case 2:
            console.log('page 2');
            break;
        default:
            a = 16;
    }
    if (0) {
        switch (true) {
            case a < 3:
                console.log('hello word!')
                break
            case a > 3 && a < 5:
                console.log('hello page')
        }
    }
    ////////////for语句
    if (0) {
        for (let x = 0; x < 100; x++) { //for(let x=0, y=100;x++,y--,x<y)
            console.log('hello word')
        for (let x in arr){
            console.log('list')
        }
        }
    /////////while
        if (0) {
            do {
                console.log('hello word')
            }
            while (x < 10)
            {
                console.log(x)
            }
        }
    }
    /////////////////////tag标签返回
    if (0){
        oute:for(let x=0;x++;x<1000){
            for(let y=0;y++;y<100){
                continue oute//返回到标签处
            }
        }
    }
}
/////////////////////////////////////////function
if (0){
    function add (x,y){
        console.log('this is arr')
    }
    function inc(base) {
        function add(x,y) {
            return x+y;
        }
        return add;
    }
    inc()(1,2) //1，2传入add函数。
    function sum(...item){ //...=python **ager
        console.log(item)
    }
    const fn=function (x,y){return x+y};//匿名方法
    const fnn=(x,y)=>x+y; //function简写

}
////shengchengqi，
function* add() { //生成器。
    yield "ceshi";
    yield "helloword"
}
let a=add()
console.log(a.next())
console.log(a.next())
////////////////////////////////////////class
if (0) {
    class A {
        constructor() { //等同于python class __init__
            this.a = 123;
        }
        static add(x,y){ //静态方法。只能通过类名访问不能通过实例访问。
            return x+y;
        }

        ceshi(x) {  
            console.log(`this is page ${x}`)
        }

    }
    let a= new A() //实例化类
    console.log(A.add(1,2))
    console.log(a.a)
    a.ceshi(12)
    if (0) {
	//定时器方法//1000为多长时间执行一次，参数要求是方法。
        setInterval(function () {
            console.log('this is log!')
        }, 1000)
    }
    setInterval(()=>{console.log('thispage')},1000) //定时器参数简定方法。
}
if(0){
    class A2 {
        constructor(){
             this.a =10;
        }
    }

    class B2 extends A2{
        ceshi(){
            super.a //继承父类的属性
            console.log('hello ')
        }
    }
    const b= new B2()
    console.log(b.a)
    b.ceshi()
}
