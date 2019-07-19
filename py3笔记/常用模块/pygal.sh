import pygal #输出图型模块。返回一个xml文件。
line_chat=pygal.Line() #实例化一个线图。
line_chat.title='test chat' #指定头部信息。
line_chat.x_labels=[str(x) for x in range(0,30)] #返回一个0-30的字符串。
line_chat.add('sin',[math.sin(x) for x in range(0,360)]) #输入一个变化的值。
line_chat.render(is_unicode=True) #返回一个xml文件。
