QGuiApplication
QQuickView  [kwɪk]
rootContext
setContextProperty      [ˈprɑ:pərti]
engine()                [ˈendʒɪn]
transparent             [trænsˈpærənt]
setFlags                 [f'læɡz]
FramelessindowHint       ['freɪmlɪs]

Rectangle                [ˈrɛkˌtæŋɡəl]
width
height
property
stringify
parse
border
radius
Rotation                 [roʊˈteɪʃn]
Scale
Translate                 [trænsˈleɪt]
MouseArea                  [maʊs] [ˈeriə]
propagateComposedEvents     [ˈprɒpəgeɪt]
hoverEnabled
anchors.fill:parent         [ˈæŋkə(r)]
onEntered
onExited
onWheel 			wēl
wheel.angleDelta		ˈaNGgəl ˈdeltə

pathview:
	delegate		ˈdēlē gāt
	pathLine		paTH Lin
	pathAttribute		ai te biu te
	incrementCurrentIndex() ˈkə-rənt
	decrementCurrentIndex() 
	pathItemCount 		kount
	preferredHightlighBegin:  
	preferredHightEnd
Grid()
	spacing.margins [prɪ'fəd]  ['mɑ:dʒɪnz]
	columns			 ['kɒləm] 
PropertyAnimation		[ˈprɑ:pərti] [ˌænəˈmeʃən] 
NumberAnimation			
ColorAnimation
PauseAnimation			[pɔz] 
SequentiAnimation		 ['si:kwənt]
ParallelAnimation		[ˈpærəlel] 
AnchorAnimation			 [ˈæŋkə(r)] 
ParentAnimation		
SmothedAnimation		 [smu:ðd]		
PathAnimation
Vector3dAnimation	
PropertyAction			
ScriptAction	
#
//index.py
from PyQt.QtGui import QGuiAppliction
from PyQt.QtQuick import QQuickView
from PyQt.QtCore import QUrl,Qt,pyQtSlot,QObject,QThread
class signal(QObject): //定义可以在Qml 里调用的函数
	@pyqtSlot(int,str,result=int) //信号int,str表示俩个参数的类型。result表示函数要返回的类型.最终要转成C++ 的类型
    def get(int_value,str_value)
    	print(int_value,str_value)
        return 1
class My_main(QQuickView): //窗口
	def __init__(self):
    	super().__init__()
        self.__initui__()
    def __initui__(self):
    	self.setGeometry(0,0,800,480) //窗口x,y,width,height
        self.setColor(Qt.transparent) //打开窗口透明
        self.setFlags(Qt.FramelessWindowHint)
        context=self.rootContext() //定义上下文
        context.setContextProperty('index',singnale_index) //绑定信号可以在qml中调用
		self.setSource(QUrl('./main.qml')) //设置qml的位置

class update_value(Qthread): //创建线程
	def __init__(self):
    	super().__init__()
    def run(self)://线程的启动时执行
    	print('.......xxxx....')
if __name__=='__main__':
	app=QGuiApplication(sys.argv) //实例化应用
    singnale_index=signal()		//实例化信号
    my_main=My_main()			//实例化窗口
    my_main.show()				// 显示窗口
    update=update_value() //实例化线程
    update.start() //线程启动
    sys.exit(app.exec_())
//qml 文件,main.qml
import QtQuick 2.4

Rectangle { //定义一个方形的窗口
	id:root //窗口的id
    width:800 //设置宽度
    height:480 //设置高度
    property int kds:3 //定义一个窗口int形属性
    color:Qt.rgba(0.3,0.1,0.5,0.3)//窗口rgba值
    radius:5 //倒角
    Timer{	//定时执行
    	interval:1000 //一秒执行
        running:true //是否执行
        onTriggered:{ //要执行的 function
        	console.log('hello word')
        }
    }
    Text{
    	font.pixelSize:20 字体大小
        x:10
        y:10
        text:'hello word'
    }
}

// canvas
import QtQuick 2.4
Reactangle{
	id:xe
    Canvas{
    	width:xe.width
        height:xe.height
        onPaint:{ //开始绘图
        	var ctx=getContext("2d")
            ctx.lineWidth=2 //线宽
            ctx.arc(10,10,50,Math.PI*0,Math.PI*2,false) //圆
            ctx.stroke()//画图
           	ctx.moveTo(0,0) //移动画笔
            ctx.lineTo(root.width,0)画线
            ctx.stroke()

        MouseArea{ //鼠标事件
        	anchors.fill:parent //鼠标事件区域继承xe.width,xe.height
            onPressed:{xe.color="gray"} //选中时事件颜色
            onReleased:{ xe.color=Qt.rgba(0.1,0.2,0.4,0.5)} //释法鼠标时事件。颜色
            onClicked:{ //单击事件
            	console.log(123)
            }
        }
        }
    }
}
//Component 不加载，加载时loader
Rectangle {
    width:800;height:100
    Component{
        id:test1
        Rectangle {
            width:10
            height:10
            color:Qt.rgba(1,0,0,0.5)
        }
    }
    Loader {sourceComponent:test1;width:100/2;height:100/2}

}
//减变
    Rectangle{
        width:50
        height:50
        scale: 0.8 //缩放
        rotation: 45 //旋转
        border.width:1 //描边
     	border.color:"#2A070C" //描边颜色
        gradient: Gradient { //渐变
            GradientStop { position: 0.0; color: "aqua" }
            GradientStop { position: 1.0; color: "teal" }
        }  Keys.onUpPressed: rectangle.y -= 10
        Keys.onDownPressed: //上键事件
        Keys.onLeftPressed: rectangle.x += 10
        Keys.onRightPressed: rectangle.x -= 10
        
    }
  // 动画
          SequentialAnimation on x { //动画序列 
            id: xAnim
            // Animations on properties start running by default
            running: false //不运行
            loops: Animation.Infinite // The animation is set to loop indefinitely
            NumberAnimation { from: 0; to: 200; duration: 500; easing.type: Easing.InOutQuad } //入出慢
            NumberAnimation { from: 200; to: 0; duration: 500; easing.type: Easing.InOutQuad }
            PauseAnimation { duration: 250 } // 停止运行时间
        }
  onClicked: xAnim.running = true