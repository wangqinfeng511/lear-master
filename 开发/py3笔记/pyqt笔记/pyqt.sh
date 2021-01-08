PyQT关系图：
	QObject<---->QPaintDevice
		|
		QWidget
		|
	QDialog<--->QFrame
QWidget #生关系图：
					QWidget
	   				   |
QcomboBox<---->	QAbstractSpinBox<----->	QGroupBox<---->	QLineEdit<---->	QMainWindow
			｜
	QDateTimeEdit<----->QSpinBox
		|
    QDateEdit<----->QTimeEdit

QDialog #生关系图：
					QDialog
					   |
	QColorDialog<---->QFileDialog<---->QFontDialog<----->QInputDialog

QIODevice #关系图：
					QIODevice
					   |
				QBuffer<---->QFile<---->QProcess

QPaintDevice #生关系图：
					QPainDevice
					   |
		     QImage<---->QPicture<---->QPixMap<---->QPrinter
<<<<<<< HEAD

=======
>>>>>>> 042b8a5ccfedd50220d8609ef3a18c0d5d23617c
QtWidgets  
QWidget： #窗口
	setGeometry(x,y,withd,higt) #设置窗口大小。
	show() #显示窗口。
	setLayout() #指定布局对象。
	setToolTip('王钦丰')
<<<<<<< HEAD
	setFixedsize(int,int) #y设定固定尺寸。
	viwe.sizeHint() #返回当前尺寸。
	setminimumSizeHint() #设定最小缩放尺寸。
=======
>>>>>>> 042b8a5ccfedd50220d8609ef3a18c0d5d23617c
	self.addStretch() #拉伸参数为int，用于图层后的设置。
	#要添加菜单要先添加c=QDockWidget(),c.addaction(new_file(这是一个QAction对象))
QTextEdit: #文本编辑
QScrollBar:
QStatusBar: #底部状态
QListView:
QPixmap:

QVBoxLayout: #X轴布局
	self.addWidget(组件) #布局内添加组件。
	例：
	 self.l1=QpushBonttn
	 vbox=QXBoxLayout()
<<<<<<< HEAD
	 vbox.addWidget(self.l1) 
=======
	 vbox.addWidget(self.l1,x,y) 
>>>>>>> 042b8a5ccfedd50220d8609ef3a18c0d5d23617c
	 vbox.addlayout() #添加层
QHBoxLayout: #X轴布局
        self.addWidget(组件) #布局内添加组件。
        例：
         self.l1=QpushBonttn
         hbox=QHBoxLayout()
         vbox.addWidget(self.l1)
	 vbox.addlayout() #添加层
QGridLayout() #网格化部局
	grid=QGridLayout()
        grid.addWidget(btn,0,1) #y,x
        grid.addWidget(btn1,0,0)
        grid.addWidget(btn2,1,1)
        grid.addWidget(btn3,2,1)
QLineEdit() #行input
	setAlignment()#对齐
			Qt.AlignLeft
			Qt.AlignRight
			Qt.AlignCenter
			Qt.AlignJustify
	clear() #清空
	setEchoMode() #输入响应方试
		QLineEdit.Normal #默认正常显示
		QLineEdit.NoEcho #不显示输入内容。
		QLineEdit.Password #Password方式
		QLineEdit.PasswordEchoOnEdit
	setMaxLength() #最大长度
	setReadOnly() #只读
	setText() #设置text内容
	text() #返回内容。
	setInputMask()
	setFont() #设置字体
	setValidator()
	信号：
	textChanged.connect() #改变内容执行。
	cursorPositionChanged.connect() #单击时执行。
	editingFinished.connect() #回车时执行。
	returnPressed.connect() #回车时执行。
	selectionChanged.connect()
	textEdited.connect() #编辑时执行。

QLabel() #一个标签
	from PyQt5.QtCore import *
	setText() #设置字符。
	setAlignment() #设置对齐方试,参数Qt.AlignCenter 聚中,Qt.AlignRight
	setIndent() #
	setOpenExternalLinks(True) #打开外部链接
	setPixmap() #图片，参数是Pixmap对象from QGui import QPixmap
		#例：
			self.setPixmap(QPixmap('../log.png'))
        self.setOpenExternalLinks(True)	#是否要连接功能
		self.setText("<A href='www.baidu.com'>测试</A>'")
	l3.linkActivated.connect() #单击连接动作
	l3.linkHovered.connect() #悬浮动作
QFormLayout() #层打包
	addRow() #参数可以是一个或多个，可以是窗口，层，
	#######################
	l1=QLabel("Name")
    	l2=QLabel("PassWord")
   	nm1=QLineEdit()
    	nm2=QLineEdit()
    	fbox=QFormLayout()
    	fbox.addRow(l1,nm1)
    	fbox.addRow(l2,nm2)


QPushButton() #按钮
	setCheckable() #不弹起按钮
	move() #xy的位置，图层内测试未通过。
	toggle() #切换状态
	setIcon() #设置图标 setIcon(QIcon(QPixmap('../log.png'))) QIcon,QPixmap 在QGui
	setEnabled() #open状态
	isChecked() #返回当前状态
	setDefault() #设置默认状态
	setText() #设置内容
	text()	#取出内容
	btn.clicked.connect(方法) #单击事件绑定
QRadioButton() #单选。
	setChecked()
	setText()
	text()
	isChecked()
QCheckBox() #多选
	setChecked()
	setText()
	text()
	isChecked()
	setTriState()
QComboBox() #下拉选框。
	addItem()
	addItems()
	Clear()
	count()
	currentText()
	itemText()
	currentIndex()
	setItemText()
	信号：
	activated()
	currentIndexChanged()
	highlighted()
QSpinBox() #可调整数数值
	setMinimun()
	setMaxmun()
	setRange()
	setValue()
	Value()
	setsingleStep() #设置步进值
	setPrefix() #输入前加字符
	setSuffix() #输入后加字符
QDoubleSpinBox() #可调步进浮点
	setRange() #设置值范围。
	setMinimun() #设置最小取值。
	setMaxmun() #设置最大取值。
	Value()    #当前值
	setDecimals() #设置浮点的位数。
	setSinglestep() #设置步进值。
	setPrefix() #输入前加字符
        setSuffix() #输入后加字符
QDial() #旋转按钮
	value()
	setNotchesVisible(True) #显示刻度。
QSlider() #滑动条
	setMinimum() #最小值
	setMaximun() #最大值
	setSingleStep() #步进值
	setValue() #设值
	value()	  #取值	
	setTickInterval() #刻度间隔
	setTickPosition() #刻度显示方试。
		QSlider.NoTicks #无刻度。
		QSlider.TicksBothSides #上下刻度。
		QSlider.TicksAbove #左刻度。
		QSlider.TicksBelow #右刻度
		QSlider.TicksLeft
		QSlider.TicksRight
	信号：
		valueChanged() #值变时执行
		sliderPressed() #按下执行
		sliderMoved() #脱动执行
QMenuBar,QMenu,QAction #采单栏。
	#菜单栏－－》菜单－－》动作
	menuBar() #采单栏。
	addMenu() #添加菜单。
	addAction() #添加子采单。
	setEnabled() #按下
	addSeperator() #分离线
	Clear() #清空
	setShortcut() # 快捷方式
	setText()  #设置字
	setTitle()
	text()
	title()
QMenu #菜单
	new_file=QAction('new',self)
	self.addAction(new_file)
	new_file.triggered.connect(prints)#点击调用函数prints
QToolBar #工具栏
	addAction()
		例：
		td=self.addToolBar('File')
		open=QAction(QIcon(QPixmap('../log.png'),'new',self)
		td.addAction(open)
	addSeperator()
	addWidget()
	addToolBar()
	setMovable()
	setOrientation()
QTextBrowser:文本结果显示：
QDialog #消息框
	QDialog()
QMessageBox #清息盒子
	mess=QMessageBox.warning(self,'user','删除成功！')

Drawing #画图
QListWidget() #一个显按钮列表框。
	例：
	list_widget=QListWidget()
	QListWidgetItem('ceshi',list_widget) # 向list_widget内添加一个字符串按钮。支持图片和文字
	list_widget.sortItem() #Item排序。
QImage() #图片
QFormLay() #布层类。
<<<<<<< HEAD
QTableWidget() #表格视图参数为int ,int 第一个是行数，第二个是列数。
QTableWidgetItem() #用于表格内单格添加格式化参数字符串。
	例：
	mytable=QTableWidget(4,2)
	newItem=QTableWidgetItem("电脑")
	mytable.setItem(0,1,newItem) 第一个int表示行，第二个表示列。
=======
>>>>>>> 042b8a5ccfedd50220d8609ef3a18c0d5d23617c
	
#####################################################
QDockWidget() #指定窗口内添加悬浮窗口。
	例：
	class exp(QWidget):
    		def __init__(self):
        		super().__init__()
        		self.initUI()
   		 def initUI(self):
        		viod=QDockWidget('log', self)
        		viod.setObjectName("logs")
        		list_width=QListWidget()
       			QListWidgetItem('a', list_width)
        		viod.setWidget(list_width) #包含窗口。
        		viod.setAllowedAreas(Qt.LeftDockWidgetArea)#停左
        
#####################################################
QInputDialog 
# 一个例子:
from PyQt5.Qt import *
from PyQt5.QtGui import *
class Btn(QWidget):
    def __init__(self,parent=None):
        super(Btn,self).__init__(parent) #
        button1=QPushButton('添加')
        dial=QDial()
        dial.setNotchesVisible(True)
        layout=QHBoxLayout()
        layout.addWidget(dial)
        layout.addWidget(button1)
        def ceshi():
            print(dial.value())
        button1.clicked.connect(ceshi)

        self.setLayout(layout)

app=QApplication(sys.argv)
forms=Btn()
forms.show()
app.exec_()	
