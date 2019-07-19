安装：pip install django
创建项目：django-admin startproject project-name
创建应用：python manage.py startapp app-name
项目启动：python manage.py runserver 0.0.0.0:8000
############################################################################
Model(models.py)
	文件主要有一个Python类来描述数据表，称为数据模型，用来创建，检索，更新，删除数据库。

View(views.py)
	文件包含了页面的业务逻辑，称为视图。

URL(urls.py)
	可理解为路由。客户传入的请求先进行匹配，再传入view处理。

Template(templates目录)
	html模版。一般放至各app目录下
##########################################################################
django工作流程：用户请求->urls.py->views.py->models.py｜templates
#####################################################################
url.py部份：
import django.conf.urls import url，include  #导入url,inclued模块
from . import views #导入本app的views
	urlpatterns=[ #url匹配列表。
			url(r'^$',index),
			url(r'^hello/$',hello),
			url(r'^polls/',include('polls.urls'),name='index')
			url(r'^(?P<question_id>[0-9]+)',views.detail,name='detail')
]
	indclude导入polls项目的urls文件。name为自定义url名
	index,hello是一个url匹配后的view处理函数，此函数必需有request参数。
####################################################################
项目中添加一个app
vim setting.py
	INSTALLED_APPS=[
		'polls.apps.PollsConfig',
		#polls是项目名，apps.py下的PollsConfig函数。
	]
项目中配置使用的数据库：
	DATABASES = {
    'default': { 
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
	}
使用mysql数据库：
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3', #此处得改为mysql引 
        'NAME': 'db_name',
        'USER': 'user',
        'PASSWORD': 'password',
        'HOST': '127.0.0.1',
        'PORT': 3306,
    }
}
####################################################################
Django数据库部份model部份：
使用orm的好处是我们不用关底层的数据库是什么类型。
from django.db import models
class Question(models.Model):
    question_text = models.CharField(max_length=200)
    #CharField表示char类型，最大长度为200字节
    pub_date = models.DateTimeField('date published')
    #DateTimeField()表示时间类型，存储为utc时间，django.timezone.now()
    def __str__(self):

    #__str__方法表示在print时打印什么。


class Choice(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    #ForeignKey表示外键Question是哪个类，on_delete表示此字段捃行删除时对应类执行什么操作。models.CASCADE表示删除。
    choice_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)
    # IntegerField表示Int类型默认值是0
    def __str__(self):
        return  self.choice_text
############################################################################
写入数据库和更改数据库结构时：
$ python manage.py makemigrations #生成SQL语句文件。在app/migrations/下
$ python manage.py sqlmigrate polls 0001_initial #polls为app名，0001_initial为文件名。
$ python manage.py migrate #写入数据库。
sqlite3数据库使用：
$sqlite3 db.sqlite3
sqlite> .tables #mysql> show tables
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
数据库操作：
from django.utils import timezone
from polls.models import Question, Choice #导和polls下的数据库model和表类。
增：
 q = Question.objects.create(question_text='ceshi',pub_date=timezone.now())
 q.save() 提交。
 外键写入：
 	user的group 外键到group表
	q=User.objects.create(user='fengzi',passwd='fengzi',group=Group.objects.get(group_name='admin'))
查：
for i in Question.objects.all():
     print(i.question_text,i.pub_date) #查全部。
Question.objects.get(id=1).question_text #查id为1的，打印出question_text字段。
########################################################
django shell:
	python manage.py shell
时间运算：timezone.now() - timezone.timedelta(days=2)
改：
 1、先查后改。
 	q =Question.objects.get(id=1)
 	q.question_text='hello2'
	q.save()
2、 真接修改。
	Question.objects.filter(id=1).update(question_text='hello3')

删：
1、先查后删：
	q=Question.objects.get(id=3)
	q.delete()
2、直接删：
 	Question.objects.filter(id=1).delete()
###############################################################
View部分：
view中使用Model
 from django.http import HttpRespone
 from .models import Question

 def index(request):
	 latest_question_list = Question.object.order_by('-pub_date')按时间反序
	 output = ','.join([q.question_text for q in latest_question_list])
	 return HttpResponse(output)

view中使用模板：
	from django.shortcuts import render

	def index(request):
		lists=Question.objects.order_by('-pub_date')
		context={'latest_question_list': lists}
		return render(request,'polls/index.html',context)
	#

#################################################################
template部分：好处是python可以直接传值给html。
html要放在APP目录下的template/app/目录下
一、公用模版和static设置：
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')], #BASE_DIR是原始目录。
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]
...
STATIC_URL = '/static/'
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'static'), #这个是静态文件目录，如图片。
]
二、url和硬编码：
什么是硬编码：在html下引用图片或html的中径名就是硬编码，如果目录改变项目要大调的东西。<img src="/static/django.png"> /static就是url硬编码。
引用静态硬编码：
{% load static %}
<img src="{% static 'django.png' %}" >
{% url 'detail' question.id %} #url硬编码， detail是在url中定义的匹配名。question.id是传入的

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
from django.templante import Template,Context
t = Template('My name{{name}}') #name为python传入的变量名
c= Context({'name':'value'})  #把value传入模版中。要求是个dict
t.render(c) #渲染
Context支持的类型：
For徇环：
#person_list是外部传入的一个可迭代对象
{% for person in person_list %}
<li> {{ person.name }}
{% endfor %}

If语句：
{% if max >10 %}
<li>最大值 {{max}} </li>
{% else %}
<li> 最大值 10 </li>
{% endif %}

过滤器：
 {{ now | date:"F j,Y"}} 对变量now进行时间格式化。
 {{name | length }}  #传入字符的长度。
 总的来说有点像管道。
######################################
