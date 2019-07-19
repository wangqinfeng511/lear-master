一、py:
from kivy.app import App
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.gridlayout import GridLayout
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.stacklayout import StackLayout
from kivy.uix.pagelayout import PageLayout
class app_layout(FloatLayout):
    pass

class app_main(App):
    def build(self):
        # return FloatLayout()
        # return GridLayout()
        # return BoxLayout()
        # return StackLayout()
        return PageLayout()
if __name__=='__main__':
    app_main().run()
二、kv:
<CustButton@Button>: #别名组件并设置通用属性
    font_size:32	#文字大小
    color:0,0,0,1	#颜色
    background_normal:''
    background_color:0.88,0.88,0.88,1 #背景颜色
    size_hint:.4,.3		#组件大小
<CustLabel@Label>:
    size_hint:.4,.3
    background_color:0.3,0.4,0,0,3
<FloatLayout>: 		#浮动布局
    CustButton:
        text:'Top Left'	
        pos_hint:{"x":0,"top":1}  #位置锚定
    CustButton:
        text:'Bottom Left'
        pos_hint:{"right":1,"y":0}
    CustLabel:
        text:"Top Right"
        pos_hint:{"right":1,"top":1}
    CustButton:
        text:"center"
        pos_hint:{"center_x":0.5,"center_y":0.5}
<GridLayout>:		#网格布局
    cols:2		#横切
    rows:2		#竖切
    spacing:10		#组件内组件的间距
    padding:10		#组件的四遍间距
    CustButton:
        text:'1st'
        size_hint_x:None
        width:200
    CustButton:
        text:'2nd'
    CustButton:
        text:'3rd'
        size_hint_x:None
        width:200
    CustButton:
        text:'4th'
<BoxLayout>:		#盒子不接
    orientation:"vertical"	#方向：垂直
    spacing:10
    padding:10
    Button:
        text:"1st"
        size_hint:.7,.5
    Button:
        text:"2nd"
    Button:
        text:"3rd"
<StackLayout>:
    orientation: "lr-tb" #方向
    spacing:10
    padding:10
    Button:
        text:'1'
        size_hint:None,.15 #组件高度
        width: 50
    Button:
        text:'2'
        size_hint:None,.15
        width:200
    Button:
        text:'3'
        size_hint:None,.15
        width:200
    Button:
        text:'4'
        size_hint:None,.15
        width:200
<PageLayout>: #页面布局
    Button:
        text:'1'
    Button:
        text:'2'
####################计算器的实现
py:
from kivy.app import App
from kivy.uix.gridlayout import GridLayout
class MasterGridLayout(GridLayout):
    def calculate(self,exp):
        if exp:
            try:
                self.display.text=str(eval(exp))
            except Exception:
                self.display.text='Error'
class app_main(App):
    def build(self):
        return MasterGridLayout()
if __name__=='__main__':
    app_main().run()
kv:
<CustButton@Button>
    font_size:20
<MasterGridLayout>:
    id:master
    rows:5
    padding:10
    spacing:10
    display:entry
    BoxLayout:
        TextInput:
            id:entry
            font_size:32
            multline:False
    BoxLayout:
        spacing:10
        CustButton:
            text:'7'
            on_press:entry.text=entry.text+self.text
        CustButton:
            text:'8'
            on_press:entry.text=entry.text+self.text
        CustButton:
            text:'9'
            on_press:entry.text=entry.text+self.text
        CustButton:
            text:'+'
            on_press:entry.text=entry.text+self.text
    BoxLayout:
        spacing:10
        CustButton:
            text:'4'
            on_press:entry.text=entry.text+self.text
        CustButton:
            text:'5'
            on_press:entry.text=entry.text+self.text
        CustButton:
            text:'6'
            on_press:entry.text=entry.text+self.text
        CustButton:
            text:'-'
            on_press:entry.text=entry.text+self.text
    BoxLayout:
        spacing:10
        CustButton:
            text:'1'
            on_press:entry.text=entry.text+self.text
        CustButton:
            text:'2'
            on_press:entry.text=entry.text+self.text
        CustButton:
            text:'3'
            on_press:entry.text=entry.text+self.text
        CustButton:
            text:'*'
            on_press:entry.text=entry.text+self.text
    BoxLayout:
        spacing:10
        CustButton:
            text:'0'
            on_press:entry.text=entry.text+self.text
        CustButton:
            text:'.'
            on_press:entry.text=entry.text+self.text
        CustButton:
            text:'='
            on_press:master.calculate(entry.text)
        CustButton:
            text:'/'
            on_press:entry.text=entry.text+self.text
###################add todo:
py:
from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.properties import ObjectProperty
from kivy.uix.listview import ListItemButton
class StudentListButton(ListItemButton):
    pass
class StudentDB(BoxLayout):
    first_name_text_input=ObjectProperty()
    last_name_text_input=ObjectProperty()
    student_list=ObjectProperty()
    def submit_students(self):
        student_name=self.first_name_text_input.text+" "+self.last_name_text_input.text
        self.student_list.adapter.data.extend([student_name])
    def delete_student(self):
        if self.student_list.adapter.selection:
            selection=self.student_list.adapter.selection[0].text
            self.student_list.adapter.data.remove(selection)
    def replace_student(self):
        if self.student_list.adapter.selection:
            self.delete_student()
            self.submit_students()

class StudentDBApp(App):
    def build(self):
        return StudentDB()
dbApp=StudentDBApp()
dbApp.run()
###################kv:
#: import main studentdb
#: import ListAdapter kivy.adapters.listadapter.ListAdapter

<StudentDB>:
    orientation:"vertical"
    first_name_text_input:first_name
    last_name_text_input:last_name
    student_list: students_list_view
    padding:10
    spacing:50
    BoxLayout:
        size_hint_y: None
        height:"25dp"
        Label:
            text:"First name"
        TextInput:
            id:first_name
        Label:
            text:"Last name"
        TextInput:
            id:last_name
    BoxLayout:
        size_hint_y:None
        height:"40dp"
        Button:
            text:"Submit"
            size_hint_x:15
            on_press:root.submit_students()
        Button:
            text:"Delete"
            size_hint_x:15
            on_press:root.delete_student()
        Button:
            text:"Replace"
            size_hint_x:15
            on_press:root.replace_student()
    ListView:
        id: students_list_view
        adapter:
            ListAdapter(data=["look user"],cls=main.StudentListButton)
#########todo
from kivy.app import App
from kivy.adapters.listadapter import ListAdapter
from kivy.uix.listview import ListItemButton
from kivy.uix.boxlayout import BoxLayout
from kivy.properties import ObjectProperty #用于数据绑定
from kivy.adapters.listadapter import ListAdapter


class Todos(ListItemButton):
    pass

class Action(BoxLayout):
    todo_name_dom=ObjectProperty() #用于kv数据传输
    todo_user_dom=ObjectProperty()
    todo_list=ObjectProperty()
    def add_todo(self):
        string=self.todo_name_dom.text+self.todo_user_dom.text
        self.todo_list.adapter.data.extend([string]) #
    def delete_todo(self):
        string=self.todo_list.adapter.selection[0].text
        self.todo_list.adapter.data.remove(string)
    def rest_todo(self):
        self.add_todo()
        self.delete_todo()
class AddTodo(App):
    def build(self):
        return Action()

if __name__ =='__main__':
    AddTodo().run()
####kv:
#: import startmain start_main
#: import ListAdapter kivy.adapters.listadapter.ListAdapter
<Action>:
    orientation:"vertical"
    todo_name_dom:todo_name #数据绑定 py内的定义 ：id
    todo_user_dom:todo_action
    todo_list:todos
    BoxLayout:
        size_hint_y:None
        height:"40dp"
        Label:
            text:'name'
        TextInput:
            id:todo_name
        Label:
            text:'name'
        TextInput:
            id:todo_action
    BoxLayout:
        size_hint_y:None
        height:"60dp"
        Button:
            text:'AddTodo'
            on_press:root.add_todo()
        Button:
            text:'DeleteTodo'
            on_press:root.delete_todo()
        Button:
            text:'RestTodo'
    ListView:
        id:todos
        adapter:
            ListAdapter(data=["look user"],cls=startmain.Todos) #数据列表
##########第五讲
py:
from kivy.app import App
from kivy.core.window import Window
from kivy.uix.screenmanager import ScreenManager,Screen
Builder.load_string(""" 
<ScreenOne>:
    BoxLayout:
        Button:
            text:"Go to Screen 2"
            on_press:
                root.manager.transition.direction="left"
                root.manager.transition.duration=1
                root.manager.current="screen_two"
<ScreenTwo>:
    BoxLayout:
        Button:
            text:"Go to Screen 2"
            on_press:
                root.manager.transition.direction="left"
                root.manager.transition.duration=1
                root.manager.current="screen_two"
                
""")

class ScreenOne(Screen):
        pass
class ScreenTwo(Screen):
    pass
class CustomPopup(Popup):
    pass
screen_manager=ScreenManager()
screen_manager.add_widget(ScreenOne(name='screen_one'))
screen_manager.add_widget(ScreenTwo(name='screen_two'))
class SampleApp(App):
    def build(self):
        Window.clearcolor=(1,1,1,1)
        return screen_manager
        # return SampBoxLayout()

if __name__ =='__main__':
    SampleApp().run()
#############check
	from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.properties import ObjectProperty
from kivy.core.window import Window
from kivy.uix.popup import Popup
from kivy.lang import Builder

class CustomPopup(Popup):
    pass
screen_manager=ScreenManager()
screen_manager.add_widget(ScreenOne(name='screen_one'))
screen_manager.add_widget(ScreenTwo(name='screen_two'))
class SampBoxLayout(BoxLayout):
    checkbox_is_active=ObjectProperty(False)
    def checkbox_18_clicked(self,instance,value):
        if value is True:
            print("Checkbox Checked")
        else:
            print("Checkbox is Unchecked")
    blue=ObjectProperty(True)
    red=ObjectProperty(False)
    green=ObjectProperty(False)
    def switch_on(self,instance,value):
        if value is True:
            print("CheckBox Checked")
        else:
            print("CheckBox is Unchecked")
    def open_popup(self):
        the_popup=CustomPopup()
        the_popup.open()
    def spinner_clicked(self,value):
        print("Spinner Value"+value)
class SampleApp(App):
    def build(self):
        Window.clearcolor=(1,1,1,1)
        return SampBoxLayout()

if __name__ =='__main__':
    SampleApp().run()
########kv:
#: import CheckBox kivy.uix.checkbox

<CustLabel@Label>:
    color:0,0,0,1
<customPopup>:
    size_hint:.5,.5
    auto_dismiss:False
    title:"The Popup"
    Button:
        text:"Close"
        on_press:root.dismiss()
SampBoxLayout:
<SampBoxLayout>:
    orientation:"vertical"
    padding:10
    spacing:10
    BoxLayout:
        orientation:"horizontal"
        size_hint_x:.22
        CustLabel:
            text:"Are you over 18"
            size_hint_x:.80
        CheckBox:
            on_active:root.checkbox_18_clicked(self,self.active)
            size_hint_x:.55
    BoxLayout:
        orientation:"horizontal"
        size_hint_x:.55
        CustLabel:
            text:"Favorite Color"
            size_hint_x:.265
        CheckBox:
            group:"fav_color"
            value:root.blue
            size_hint_x:.05
            on_active:root.switch_on(self,self.active)
        CustLabel:
            text:"Favorite Color"
            size_hint_x:.265

        CheckBox:
            group:"fav_color"
            value:root.red
            size_hint_x:.05
        CustLabel:
            text:"Favorite Color"
            size_hint_x:.265
        CheckBox:
            group:"fav_color"
            value:root.green
            size_hint_x:.05
    BoxLayout:
        orientation:"horizontal"
        height:30
        BoxLayout:
            orientation:"horizontal"
            size_hint_x:.25
        CustLabel:
            text:str(slider_id.value)
        Slider:
            id:slider_id
            min:-100
            max:100
            value:0
            step:1
    BoxLayout:
        orientation:"horizontal"
        size_hint_x:.25
        CustLabel:
            text:"On/Off"
        Switch:
            id:switch_id
            on_active:root.switch_on(self,self.active)
    BoxLayout:
        orientation:"horizontal"
        height:30
        BoxLayout:
            orientation:"horizontal"
            size_hint_x:.25
            Button:
                text:'Open Popup'
                on_press: root.open_popup()
        BoxLayout:
            orientation:"horizontal"
            size_hint_x:.25
            Spinner:
                text:'First'
                values:["First","Second","Third"]
                id:spinner_id
                on_text:root.spinner_clicked(spinner_id.text)
    BoxLayout:
        orientation:"horizontal"
        height:30
        BoxLayout:
            orientation:"horizontal"
            size_hint_x:.25
            TabbedPanel:
                do_default_tab:False
                TabbedPanelItem:
                    text:'1st Tab'
                    Label:
                        text:"Content of 1ST Panel"
                TabbedPanelItem:
                    text:'2nd Tab'
                    Label:
                        text:"Content of 2ND Panel"
                TabbedPanelItem:
                    text:'3rd Tab'
                    Label:
                        text:"Content of 3RD Panel"
###打包
sudo pip install buildozer
brew install cython
sudo pip3 install cython
buildozer android debug deploy
buildozer -v android clean
buildozer -v android debug
#########canvas 线
with self.canvas.before: 画图之前
with self.canvas.after:
    canvas:
        Color:
            rgba:.1,1,.1,1
        Line:
            width:2
            ellipse: (0,0,100,100)
        #弧度x,y,width,height,start,stop,step
        Line:
            width:1
            ellipse:(0,50,100,100,90,180,36)
        #角度画圆
        Line:
            width:3
            circle:(50,100,min(30,30)/2,0,90)
        #方形
        Line:
            width:2
            rectangle:(100,100,30,50)
        #贝塞尔曲线
        Line:
            width:1
            bezier:
                (0,0,10,30,30,0,40,1000,300,300,800,30)
Touch:
    def on_touch_move(self, touch):
        if self.collide_point(*touch.pos):#判断是否在区域
            if self.collide_point(*touch.pos):
                if touch.x > self.x:
                    self.x = touch.x - self.width / 2
                else:
                    self.x = touch.x + self.width / 2
                if touch.y > self.y:
                    self.y = touch.y - self.height / 2
                else:
                    self.y = touch.y + self.height / 2
class Test(Widget,Testa):
    def on_touch_down(self, touch):
        touch.push()
        #坐标入摘
        touch.apply_transform_2d(self.to_widget)
        # to_local() 从父空间到局部空间的坐标
        # to_parent() 从局部空间到父空间获得坐标：
        # to_window()  从局部空间到窗口空间获得坐标：
        # to_widget() 从窗口空间到局部空间的坐标
        super(Testa,self).__init__()
        touch.pop()
        #坐标出宅
if touch.is_double_tap: #是否双击
if touch.is_triple_tap: #三连击
#动画：
		anim.repeat=True 重复
		duration 或 d: float, 默认 1. 秒
		transition 或 t :过渡 
		step:步进值
	属性：
		animated_properties #返回动画定义的属性比如x=self.x+100,self.x=200+100=300
		cancel(widget) 清除动画
		cancel_all(widget,*larges)  清楚所有列：animation.cancel_all(widget,'x')
		duration:动画时长
		have_properties_to_animate #控件是否具有动画属性
		stop_property(widget,prop) #停止指定属性
		transition	#返回变化值
	event:
		on_start() #开始时触发
		on_complete() #
		on_progress: #动画变化时执行
	动画渐变：
		in_back
		in_bounce
		in_circ
		in_cubic
		in_elastic
		in_expo
		in_out_back
		in_out_bounce
		in_out_circ
		in_out_cubic
		in_out_elastic
		in_out_expo
		in_out_quad
		in_out_quart
		in_out_quint
		in_out_sine
		in_quad
		in_quart
		in_quint
		in_sine
		linear
		out_back
		out_bounce
		out_circ
		out_cubic
		out_elastic
		out_expo
		out_quad
		out_quart
		out_quint
		out_sine
APP:
	def build_config(self,config): 
		config.setdefaults('section1',{'key':'value'})
		print(config.get('section1','key'))
	方法：
		on_start(self):
			start时执行
		on_stop(self):
			stop时执行
		on_pause(self)
			暂停
		build() 渲染时执行
		build_config(config):渲染配置
		get_application_config(): 获取配置
		build_settings()
		directory:返回应用目录
		self.get_application_icon() 获取icon的路径
		get_application_name() 获取应用的名字
		self.get_running_app() 获取运行中的实例
		 self.load_kv('./myapps.kv') 指定加载的kv 文件
		self.title='test' 修改窗口标题
		user_data_dir
		self.user_data_dir 返回数据目录
异步数据加载：
	from kivy.loader import Loader
	image=Lader.image('url')
缓存：
	from kivy.cache import Cache
	Cache.register('mycache',limit=10,timeout=5) #创建缓存
	instance=Label(text='hello word') #创建Label
	key='objectid'	#密码
	Cache.append('mycache',key,instance) #压入缓存
	inst=Cache.get('mycache',key)	#获取缓存
添加属性在kv里调用
	self.create_property()
打包允许连接外围
android.permissions = INTERNET