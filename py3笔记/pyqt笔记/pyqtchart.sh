QChartView() #用于图专用视图装载。
QChart() #画布用来装载绘图
饼图：
   series = QPieSeries() #饼图组内可包多饼角
        series.append('User', 20) #直接设定饼角大小
        series.append('空闲', 40)
        slice0 = QPieSlice()  #实例化一个饼角。
        slice0.setColor(QColor(255,0,0)) #设置饼角的着色。
        slice0.setValue(60) #设定饼角的值。
        slice0.setLabel('这是什么') #设定饼角的注释。
        series.append(slice0)
        char=QChart()		  #所有的图都要写入char才能写入charview
        char.addSeries(series)   #添加饼图至char.
        char.setGeometry(500,500,500,500) #设置char的大小和位置
        charView=QChartView(char)  #添加char到视图.
#####################################################        
	lay=QFormLayout()	#图层
        lay.addRow(charView)    #添加视图到图层。
        self.setLayout(lay)	#绑定视图到UI
        self.show()
###########################################################
线图：
	series=QLineSeries()
        series.append(10,8)
        series.append(20,6)
        series.append(30,28)
        series.append(40, 18)

        char=QChart()
        char.setTitle('测试')
        char.createDefaultAxes()

        char.addSeries(series)
        char.setGeometry(500,500,500,500)
        charView=QChartView(char)
        charView.setRenderHint(True)
        lay=QFormLayout()
        lay.addRow(charView)
        self.setLayout(lay)
        self.show()
#################################################################
定时绘图：
	qtimer=Qtimer
	self.qtimer.timeout.connect(self.update)
	self.qtimer.start(1000)
def painEvent(self,event):
	在重新self.update时执行。是qt内置方法，要重写。
