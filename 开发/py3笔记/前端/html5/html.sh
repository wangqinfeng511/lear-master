
一、
	<table>标签:
		<thead> #标题部分.
			<tr> #一行
			<th> 一列标题</th>
			</tr>
		</thead>
	
		<tbody> #主体部分.
			<tr>
				<td> 一列内容</td>
			</tr>
		</tbody>
		<tfoot> #底部部分.
			<tr> 
				<td>底部一列内容</td>
			</tr>
		</tfoot>
		属性:
			align: 表格对齐方式: left center right justify char
			Bgcolor: 表格着色.
			cellpading: 单元格与其它内容的空白 px %
			cellspacing: 单元格间的空白 px %
			frame: table的最外边框显示方式
				void 不显示外边框
				abvle 显示上部分的外边框.
				below 显示下部分的外边框.
				hsides 赤示上部分和下部分的外边框.
				vsides 显示左右边框.
				lhs 	显示左边外侧边框.
				rhs	显示右边框.
				box 	显示四边.
			rules: 内部单元格边框.
				none 无
				groups 右边.
				rows	下边
				cols	右边
				all 全部
			border 边框.
			valign:行内容的对齐方式:top,middle, botton, baseline
		单元格的合并:
			colspan="2" #本单元格与右侧单元格合并.
			rowspan="2" #本单元格与下单元格合并.

列表:
	无序列表:<ul> type:disc(圆点),square(正方形),circle(实心圆)
		<ul><li></li></ul>
	有序列表:<ol> type: 1(1~N),a(a~z),A(A~Z),i(罗马小写),I(大写罗马)
		<ol><li></li></ol>
	定义列表:
		<dl><dd></dd><dl>
	<div contenteditable="true"></div> #打开div编辑。
				-webkit-user-modify:div是否可读写。
						read-only 只读。
						read-write 可读写
						read-write-plaintext-only 可读写，只可沾贴文字部分，样式会丢失去。
				-webkit-user-select:none #文字不可选。autoi（可选）,none,text 
				-webkit-box-reflect:元素倒影。
				-webkit-filter:滤镜。
					none:无SVG滤镜效果。
					blur:模糊效果 px
					brightness 亮度%
					contrast 对比度 %
					grayscale 灰度 %
					hue-rotate 色相反转%
					invert   反色%
					opacity  透明度 %
					saturate 饱和度%
					sepla	戒色程度 %
					drop-shadow 阴影(x y radius color)
				float:  浮动：
					left：1px
					right:20px
					top:6px
				 z-index:-1 设定图象Z轴的位置。
				 padding 2px: 设定子元素间的距离。
				 margin-left|top|  div之间的距离。

				 position: 定位
					   absolute 绝对定位。相对于static以外的第一个元素进行定位。通过left,top,right bottom属性规定。
					   relative 相对定位。
					   fixed    绝对定位，相对于浏览器进行定位。通过left,top,right bottom属性规定。
					   inherit  从父级继承定位。
				 box-shadow: 0 0  10px 10px red; #阴影属性，x y size 实像素 color 支持叠加以,分隔
				 box-shadow: inset 0 0 0 10px red #内阴影
				 text-shadow: 0 -1px 3px aqua #文阴影
				 border:dashed 2px red; 	#续线边框。solid实线
				 border-radius: 10px 50% 5px 8px; #圆角设置，左上，左下，右上，右下角，一个值时表示所有角。支持百分比
				 calc() 计算器返回计算后的值。例width: calc(100% - 100px); 总宽度－100像素
				 border-sizing:
						border-box #添加完边框大小不变（不计算border,padding）。默认大小为主＋边。
					 	content-box #默认值。	
				 background-origin: #绘制区域。
					border-box,
					content-box,
					padding-box;
				 background-color: red;
           			 background-position: ;
           			 background-image: url("a.jpg") center center / cover no-repeat;
					#x y size 不平铺 size是background-size
						  linear-gradient(red,yellow) #红到黄的渐变。
								 to top,red,yellow #直持左右
								  90deg,red,yellow #90度渐变
								  #0deg = to top
								  #90deg = to right
								  #270deg = to bottom
								  #支持负值,支持多色渐变,支持px %
								  red 50%, yellow 70% #此时红占百分之五十，黄占百分之五十，渐变部分为百分之二十
						background-image: repeating-linear-gradient(red 15px,yellow 20px) #重复线性渐变。		  
				 background-size: x y #x和y的百分比。contain等比列缩放来适应元素，cover等比例放大来填满元素，auto无变化
           			 background-repeat: ;
				 background-color:rgba(255,255,255,.5) #.5表示透明度
	<nav></nav>		<!--一般用于放导行栏部分-->
	<main></main> 		<!--主体部分-->
	<footer></footer> 	<!--底部部分-->
	<figure> 		<!--一般用于包含标题的图片-->
		<img src='....'></img>
		<figcaption> 标题部份</figcaption>
	</figure>
	<section></section> 	<!--官方建意只包含h和img标签-->
	<datalist> #用于input下自动提醒功能。
		<input type="text" list="abc"/>
		<datalist id="abc">
			<option>a</option>
			<option>acc</option>
			<option>add</option>
		</datalist>
	<details> #详细信息	
	<details open> #open属性表示默认展开。
	    <summary> 我是替换详细信息字样的</summary>
	        我就是你要看的详细信息！
	</details>
	<audio> #音频文件播放器。
		属性有：
			src 文件源。
			controls 显示浏览器自带的播放器。
			autoplay 自动播放。
			muted    默认静音。
			loop	 徇环。
			preload  预加载。
	<video> #视频文件播放器
			width	 播放器宽。
			height	 播放器高。
                        controls 显示浏览器自带的播放器。
                        autoplay 自动播放。
                        muted    默认静音。
                        loop     徇环。
                        preload  预加载。
			poster	 未播放时显示的静态图片。
		<source>
		属性有：
			src 文件源。
			type 指定文件类型和编码格式。
				例audio： 
				<source src="horse.ogg" type="audio/ogg">
   				<source src="horse.mp3" type="audio/mpeg">
				video:
				<source="video.WMV" type="video/WMV" /> <!--MP4 for Mozilla Firefox -->
				<source="video.ogg" type="video/ogg" />
	<input> #常用类型
		text button submit password checkbox radio file reset
		h5新提供的类型# 
			number 数字，
			ranger 滑块，
				属性：mix max step步进
			search 
			tel
			url
		h5新提供的属性：
			autofocus :自动聚焦
			autocomplete: on/off #是否自动完成表单只能用在form内的input.主要是历史记录的自动完成。
			pattern  :正则，匹配后可提交不匹配不能提交。例pattern="[0-9]{1}"
		placeholder:默认显示提醒字符	
			
二、
	<!--用于判断是否小于ie9小于加载js用于解决ie6-ie8不支持nav问题-->
	<!--[if lt IE9]> 
		<script src='htmlshiv.min.js'/>
	<![endif]--> 
三、可用css选择器：
	a>b,a+b,a~b
	<style>
		标签选择器。
		h1{}	  		 #所有在的h1标签会被更改。 
		.list>li{}		 #class=list，下的每一个li标签被设置。
		.list p+div{}		 #class=list时p标签的div会被设置。
			例：
				<div class="list">
        				<p>c</p>
        				<div>我会被选中</div>
        				<div>我不会被选中</div>
   				 </div>

		.list p~div{}		 #class=list时与p标签同级的div会被设置。
			例：<div class="list">
        			<p>c</p>
       				<div>我会被选中</div>
        			<div>我也会被选中</div>
   			   </div>
		.list::first-letter{}	 #class=list时首字母会被设置。
			例：<style> .list::first-letter{font-size: 50px;color: red}</style>
				<p class=list>我的第一个字会变成红色</p>
		.list::first-line{}  	 #class=list时首行被设置。
		.list::selection{}   	 #class=list时，被选定时设置。
		:target{}		#标签跳转设置。比如本页标签。
		:hover{}		#shu标停留时，.box:hover:after{}
		属性选择器：
		div[data-hover]{} 	#div标签中有data-hover属性会被选择。
		div[class='abc']	#div class='abc'的会被选择。
		div[class*="ab"]	#div class中包含ab字符的会被选择。^首部，$尾部。支持[][]多匹配。
		伪类选择器：
		.list li:nth-child(n){} 	#class=list 的第n个li会被选择设定。3n - 1支持运算符但两边有空格
		.list li:nth-child(2n){} 	#class=list 能被2整除的li会被选择设定，第2，4，6个li
		.list li:nth-last-child(){} 	#class=list倒数第几个ls被选定。
		.list li:first-child{} 		#class=list选定第一个li时行设定。
		.list li:nth-of-type(n){} 	#class=list同类型的第几个。
		.list li:nth-last-of-type(){} 	#class=list 从li开始下面第几个标签。
		first-of-type{}			
		last-of-type{}
		.box h3:only-child{}		#class=box 下只有一个h3标签会被选中。
		.box h3:only-of-type{}		#class=box 下只有一个h3类型的标签会被选中。
		.box :empty{}			#class=box 内容为空时选中
		:after 				#选择器在被选元素的内容后面插入内容
						例：.box:after{
							content:'我是伪元素' #我会出现在class=box后面追加一文字
							}
		:before()			#前追加					
		form选择器：
			:enabled{}		#激活时选定。例：.list :enabled{color:red}
			:disabled{}		#未激活时选定。
			:checked{}		#选中时选定，比如raido标签。
				例：
					 <style>
        					.lock span{ #class=lock,下的span标签进行描边，并显示边框。
           						#border: solid 1px aquamarine; ＃边框
            						width: 20px;
            						height: 20px;
            						display: inline-block;
							background:url(./a.png) 0 0 no-repeat;	#背景为图片位置都为x=0 y=0 不重复
        						}
        					.lock input:checked + span{ #当class=lock，input被选中时lock下的span标签被设上边框被设为红色。
            						#border: solid 2px red;
            						width: 20px;
            						height: 20px;
            						display: inline-block;
							background:url(./b.png) 0 0 no-repeat;
        						}
					<style>
					<label for="id" class="lock"> #for=input_id 表示此lable下的任意元素被单击时input都会受到check事件。
            					<input id="id" type="checkbox">
            					<span>  </span>
        				</label>
iframe 标签 网页嵌套：
	例子：配合form实现返回数据缓存。
		<iframe name="tmp_data" style="display:none"></iframe>
		<form id="get_data" method="get" action="/api" target="tmp_data"> 
		在执行sumbit()时返回的数据结果存到iframe中。
		js里取出数据：
			var d=window.frames["tmp_data"].docment.body.innerText;
			JSON.parse(d);	
