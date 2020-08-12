常用sql语句：
select * from table1 join table2 on table1 'user'=table.'group' where tabl.id=1
select * from table1,table2 where table1, 'user'=table2.'group' and table1.id=1
select count (distinct 'fengzi') from 'fengzi' where table.id=1
select count(*) as ,table1 from 'fengzi' where table.id=1; group by table1 
##################################################################
Django基础组成：
	models.py
	views.py
	urls.py
	latest_books.html
请求简单流程：
	用户请求--》urlcof-->view
				|\
				| \templates
			    models
安装：
	pip install django
新建项目：
	django-admin startproject 项目名
		manage.py #项目管理。
		setting.py #项目配置。
		urls.py	   #url正则匹配。
		wsgi.py	   #布署使用。
运行项目：
	python mange.py  runserver 0.0.0.0:80
############################################################################
vim urls.py
	def hello (request): #定义一个hello request是固定参数。
		return HttpResponse('Hello word') #页面返回的内容。
	urlpatterns=[
		url(r'^hello/$',hello)  #url请求如果以/hello开头，返给hello函数。
	]
创建app，一个项目可包含多个app
python manage.py startapp APP_项目名。
	admin.py	#管理后台
	apps.py		#app设置。
	migrations	#目录版本结构。
	models.py	#数据模型。
	tests.py	#测试单元。
	views.py	#视图。
	没有urls.py	#需要自己创建，并引用。
将app写入工程：
1、 编写app下的views.py
 from django.http import HttpResponse
 def index (request):
 	return HttpResponse("poll install")
2、vim 工程目录下的setting.py #添加APP
	INSTALLED_APPS=[
	'polls.apps.PollsConfig',
	]
3、vim 工程目录下urls.py
	from django.conf.urls import url,include
	urlpatterns = [	    
	    url(r'^polls/',include('polls.urls')),# 匹配后引用项目的url匹配文件。
	    url(r'^hello/$',hello),
	    url(r'^admin/', admin.site.urls),
4、配置app 的urls,cp项目的url到app里。
	from django.conf.urls import url,include
	from .views import index
	urlpatterns = [
	    url(r'^$',index), #上层匹配后传到此处。	
	]
###########################################################################
models 数据模型配置mysql
vim settings.py 
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'mysite', 数据库名
        'USER': 'root',
        'PASSWORD': 'fengzi',
        'HOST':'127.0.0.1',
        'PORT':'3306',
    }
}
vim __init__.py
	import pymysql
	pymysql.install_as_MySQLdb()
######################################Models部分######################################
vim models.py
from django.db import models
class Question(models.Model): #创建表Question
    question_text=models.CharField(max_length=200) #定义字短,question_text,varchar 200长度。
    pub_date=models.DateField('date published')	#定义时间
class Choice(models.Model):	＃创建表Choice 
    question=models.ForeignKey(Question,on_delete=models.CASCADE)　＃创建字段question 外键,Question,表删除时删除外键
    choice_text=models.CharField(max_length=200)　#创建字段choice_text varchar　200
    votes=models.IntegerField(default=0)	#创建字段整型，默认值为０
#使用mysql要安装：pip install mysqlclient 信赖gcc mysql-devel
#同步至数据库。
python manage.py makemigrations #
python manage.py sqlmigrate polls 0001_initial
python manage.py migrate #写入数据库。
#使用mysql要安装：pip install mysqlclient 信赖gcc mysql-devel
ipython 使用django
python manage.py shell
	导入模块：
		from django.utils import timezone
		from appA.models import Choice,Question #导入appA项目的models,　导入Choice,Question表。
	增：
		a=User.objects.add(user='fengzi')
		a.save
		User.objects.create(user='fengzi')
	查：   User.objects.filter(user='fengzi')[0].user
		User.objects.get(user='fengzi').user
		User.objects.all()
	删：
		a=User.objcets.get(user='fengzi')
		a.delete()
		User.objcets.filter(user='fengzi').delete()
		User.objcets.get(user='fengzi').delete()
	改：	a=User.objcets.get(id=1)
		a.user='fengzi2'
		a.save()
		User.objcets.filter(id=1).update(user='fengzi')
		
#$#$#$#$#$##########$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
vim app/moduels.py
from django.db import models
	class Zuhu(models.Model):
		zuhu=CharField(max_length=20)
	class Group(models.Model):
    		group = models.CharField(max_length=30)
    		group_zuhu = models.ForeignKey(Zuhu,on_delete=models.CASCADE)) #一对多外键 on_delete在删除用户组时执行什么CASCADE表示删除关系
	class User(models.Model):
    		user = models.CharField(max_length=30)
		passwd = models.CharField(max_length=20)
    		user_group = models.ManyToManyField(Group) #多对多 外键是一对多，还有个是一对一
一、执行创建数据库后：
	会有三张表：group user 和user_user_group(会自动生成关系表)
	一、一对多
		插入数据。
			Zuhu.objects.create(zuhu='myx') #添加租户。因为用户组的外键是租户表。
			Group.objects.create(group='admin',group_zuhu=Zuhu.objects.get(zuhu='myx')) #添加用户组，指定外键关联至租户myx
		查询：
			查出是myx租户的用户组
			Group.objects.filter(group_zuhu__zuhu='myx')[0].group #filter()返回的是一个列表，我只取出第一个元素。__表示外键的字段名。
			通过租户反查：
			b=Zuhu.objects.get(zuhu='myx')
			b.group_set.filter(group='admin')[0].group
	二、多对多
		插入数据：
		 	a=Group.objects.get(group='admin')
			b=User.objects.create(user='fengzi',passwd='fengzi')
			b.user_group.add(a)
			b.save()
		查询数据:
			User.objects.filter(user_group__group='admin')[0].user
			通过用户组表反查用户：
				b=Group.objects.get(group='admin')
				b.user_set.filter(user='fengzi')[0].user #_set表示返查
#########################################template部分##########################################
template配置：
	TEMPLATE
	'DIRS': [os.path.join(BASE_DIR, 'templates')],

static静态配置
	STATIC_URL = '/static/'
	STATICFILES_DIRS =[
    		os.path.join(BASE_DIR, 'static'),
		]
使用模版，在app/templates/app/index.html
	使用Context({...})可以为模版传值。reander中已经封装了此函数
	{{varname}} html模版中引入View变量，view中传入的变量render(request, '...html',{'varname':value})
		{% block title%} 我会被替换{% endblock%} 
		{% block content%} 我会被替换{% endblock %}
		{% block footer%} 我会被替换{% endblock %}
		title,content,footer不是变量。
		子模板的引用方式：{% extends "base.html" %}|include 
				{% block title %} 我是替换模版中的block的{% endblock%}
		模版for循环：
		{% for i in varname%}
			<div> {{i}} <div>
		{% endfor %}
		{% if varname%}
			<div>{{i}}<div>
		{% endif %}
		过滤器：
			{{now|date:"F j,Y"}}
			{{name | length}}
		硬编码：<img src="/static/django.png"> #/static就是硬编码，因为是写死的。
			{% load static %} #引入set文件中写设置的app路径，此时的{{static 'django.pnp'}}就等同于上面的。
		{% csrf_token %} #token一般模板都要添加。django简单验证token

################################VIEW部分##############################################
逻辑层：
	写业务逻辑部分的
	url反向解析

	from django.shortcuts import reverse
	reverse('detail',kwargs={'name':value}) #detail是一个url匹配的neme属性，在urls内定义的，kwargs是传入此url的参数	
						#此函数的作用是把这个名子变成它对应的url
	reverse_lazy #惰性的在指定的url名不存在是不报错。
	#
	from django.template import Template,Context
	def index(request):
		render(request,'app/index.html',{'ceshi':'ni hao ma'})
		render (request, reverse('index',index.html)) 未测试
	##常用
	request.POST
	from django.http import HttpResponseNotFound 
		return HttpResponseNotFound('not found') #定义错误页。
	raise Http404('feset') #定义错误返回
	##常用装饰器：
		@require_http_methods(['GET','POST']) #用来装饰视图方法的在请求方法匹配时进入函数。
		@gzip_page() #启用页面压缩
################################urls部分###############################################
from django.conf.urls import url, include
urlpatterns=[
	url(r'^$',index) #index是view定义的方法。
	url(r'^hello',hello,name='index') #name属性名字，在view中反解使用。
	url(r'^app',index('app.urls')) #引入app模块的的urls，http://ip:8000/app/...
	url(r'^(?P<question_id>[0-9]+/$)', hellos) #question_id是匹配的取值的变量名
]
###########################form表单部分#################################################
view中定义表单在模版中渲染出来。
from django import forms
class NameForm(forms.Form):
	your_name= forms.CharField(label='Your name',max_length=100) #类继成表定义表单。
				widge=forms.TextInput #指定插件
				常用插件：
					forms.NumberInput #只能输入数字
					forms.EmailInput #email
					forms.URLInput #url
from =NameForm()实例化
form.as_p() #以<p>标签的方试渲染表单
form.is_bound # 是否为绑定表单，有值的表单为绑定
form.as_table() #输出的html为br标签的
form.as_ul()
form.is_valid() #判断是值否合法。
form.cleaned_data['key'] #取值
form['key'].value() #也是取值。
form.errors #打印出错误，比如说is_valid()后打印错误信息，返给前端页面
#view取值：
    if request.method =='POST':
        form = formss(request.POST)
        if form.is_valid():
            user = form.cleaned_data['user']
            passwd = form.cleaned_data['passwd']

html中接受全部表单。{{from}}
html中接受指定单元。{{from.your_name}}
############################################################ModelForm部分#########################################################################################。
from django.forms import ModelForm
	class AuthorForm(ModeForm)
		class Meta: #元类必须的 
			model=Author #指定数据库类名
			fields=['name','title','birth_date'] #显示哪此字段。
			
			#常用属性：
			exclude=() 排除字段
			fields=__all__ 全部字段。
			labels={'user':'name'} #把user字段重命名为name
			widgets={
				'user':Textarea(attrs={'cols':80,'rows':20) 为user字段指定插件.列80，行20
			}
			help_texts={ 
				'user':_('heloowadfdfa') #帮助信息 	
			}
			error_messages={
			'user':{'max_length':_('超过长度值')} #自定义错误信息。	
			}
			def clean_user(self): #为ueser添加认证。方法名为clean_字段名。
				user=self.cleaned_data['user']
				if len(user)>100:
					raise ValidationError('adsfadfasdf')
				return name
			def clean(self):
				#对整个from验证
	def index(request):
    		fo=AuthorForm()
    		return render(request, 'app/index.html', {'forms':fo} )
fo.save()直接写入数据库。
 from 存多对多：
 取出GroupID
 	p=Group.objects.get(group='admin').id
 	fo=Autho({'user':'fengzi3','passwd':'fengzi','user_group':[p]})
	#user_group是多对多所以要求是个列表，因为此用户可以属于多个组。
 	fo.is_value()
 	fo.save()
	####################不保存
	a=fo.save(commit=False)
	a.user='ceshi'
	a.save()
	fo.save_m2m() 保存关系

	form=Autho(request.POST,instance=publiisher) #instace表示更新，默认是写入
##########bootstrap框架使用#######
 pip install django-bootstrap-form
 INSTALLED_APPS = [
    'bootstrapform',]添加
html 
	{% load bootstrap %}
	{{from|bootstrap}}
#####################################使用类视图以前用方法视图。############
views
	from django.http import HttpResponse
	from django.views.generic import View

	class Login(View):
    		greeting="Good Day"
   	 	def get(self,request): #重写get请求，post请求。
       			return HttpResponse(self.greeting)
urls:
	from django.conf.urls import url
	from app.views import Login
	urlpatterns = [
	url(r'^login/$',Login.as_view()) #此处改为类名as_view()
		]
##############################TemplateView模版视图#####################
###########################django rest frameword创建API######################
pip install djangorestframework
settings.py
	INSTALLED_APPS = [
    		'rest_framework',
		]
#创建Serializer class
#############################Basic 认证###########################
Basic认证
Session认证
Token认证
默认使用Basic认证。账号秘
sesson:
	setting.py
	INSTALLED_APPS = [
   		 'django.contrib.sessions',


class Login(View):
    def get (self, request):
        request.session['member_id']=12134145
        return render(request, 'app/index.html')
    def post(self,request):
        print(request.session.get('member_id'))
        return render(request, 'app/index.html',{'forms':12345})

