安装在jquery官下载js文件
引用方法：
<head>
<script src="jquery-1.10.2.min.js"></script>
</head>
#########################################################
$表示使用jquery
基础语法：$(selector).action()
	选择符(selector) '查询和查找'Html元素。
	action()执行对元素的操作。
	实例：
		jQuery选择器：
		$(this).hide() 
		$("p").hide() - 隐藏所有 <p> 元素
		$("p.test").hide() - 隐藏所有 class="test" 的 <p> 元素
		$("#test").hide() - 隐藏所有 id="test" 的元素
文档就绪事件__为了防止文档完成就加载jQuery代码.
 $(document).ready(function)(){
	jQuery 代码
}
###########################################################
jQuery事件：
click() 单击事件
例：
	<p id="test">lock in</p>
	<script>
    	$("#test").click(function () {
        	        $(this).hide();
            	})
	</script>
	.show()显示
	.toggle()取反
	参数：
	speed:显示速度毫秒整型。
	callback:显示隐藏后执行的函数名称
	
dblclick()  双击事件
mouseenter() 鼠标经过
mouseleave() 鼠标离开
mousedown() 鼠标移到元素上方
############################################
淡入淡出
jQuery Fading方法：实现淡入淡出效果。
fadeIn()
fadeOut()
fadeToggle()
fadeTo()
例：
<button id="button">ceshi</button>
<div id="one" style="color: black">HEllo</div>
<script>
	$("#button").click(function () {
        	$("#one").fadeOut(1000);
    	})
    	$("#button").click(function () {
        $("#one").fadeIn(1000);
</script>
#################################################
滑动效果：
jQuery()拥有的滑动方法
slideDown()
slideUp()收起
slideToggle()
例：
<div id="one" style="background-color: black">HEllo</div>
<div id="two" style="background-color: aqua">Word</div>
<script>
    $("#one").click(function () {
        $("#two").slideToggle()

    })
</script>
###########################################################
jQuery 动画 animate()方法
语法：$(selector).animate({params},speed,callback)
	params:定义形成动画的CSS属性。

	例：
		<div id="one" >HEllo</div>
		<div id="two" style="background-color: aqua">Word</div>
		<script>
    			$("#one").click(function () {
        		$("#two").animate({height:'250px'})
    			})
		</script>
	常用调：
		 left:'250px',
   		 opacity:'0.5',
   		 height:'150px',
   		 width:'150px'
		 支持相对值：'+=150px'
########################################################################
jQuery取html值并可以赋值：
text() 取出文本部份
html() 取html部份
val()
例：<div id="one" >HEllo</div>
	<div id="two" style="background-color: aqua">Word</div>
	<script>
    		$("#one").click(function () {
       			var a =$("#two").text()
        		console.log(a)
    		})
	</script>
取value值，比如input 的value
	<div id="one" >HEllo</div>
	<input id="there" value="ceshi">
	<script>
    		$("#one").click(function () {
        	var a =$("#there").val()
        	console.log(a)
    		})
	</script>
取属性值：
	<div id="one" >HEllo</div>
	<div id="two" style="height: 100px">Word</div>
	<script>
    		$("#one").click(function () {
        	var a =$("#two").attr('style')
        	console.log(a)
    		})
	</script>
################################################
添加元素：
append() - 在被选元素的结尾插入内容
prepend() - 在被选元素的开头插入内容
after() - 在被选元素之后插入内容
before() - 在被选元素之前插入内容
例：
	<p id="test">lock in</p>
	<div id="one" >HEllo</div>
	<script>
    		$("#one").click(function () {
        	$("#test").append('追加文本')
	</script>
删除元素。
	remove() 删除被选元素（及其子元素）
	empty()  从被选元素中删除子元素
#############################################################
Ajax 部份：
什么是Ajax
简短地说，在不重载整个网页的情况下，AJAX 通过后台加载数据，并在网页上进行显示
jQuery ajax()方法一般不用直接用get post方法：
	语法：$(selector).load(URL,data,callback);
	URL:本站的哪个接口。
	data:objcte对象
	callback:执行请求后执行的方法
	<button id="jia">jia</button>
	<p id="valud">{{ forms }}</p>
	<script>

   		 $("#jia").click(function () {
       		 $.ajax(
               		 {
                   	 url: "/app/login/",
                    type: 'POST',
                    data:{ceshi:'heloword'}
               		 })
    	})
	</script>


load() 方法从服务器加载数据，并把返回的数据放入被选元素中。
 
语法：
	$(selector).load(URL,data,callback);

get() 向指定地址发送get请求
	<button id="jia">jia</button>
	<p id="valud">{{ forms }}</p>
	<script>
   	 	$("#jia").click(function () {
        	$.get("./",function (forms) {
            	alert(forms)
       	})
    	})
	</script>
post() 向指定地址发送post请求。
	<button id="jia">jia</button>
	<p id="valud">{{ forms }}</p>	
	<script>
    		var form={name:1234}
    		$("#jia").click(function () {
        	$.post("./",
                	{name:1234}，
                	function (form) {
			 	$("#valud").load('./ #valud')
				#重新加载#valud './'向本页发起请求
       				 })
   		 })
		</script>
		#{name:1234}是一个objcte对象
