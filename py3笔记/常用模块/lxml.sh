pip install lxml

from lxml import etree
##################################################################
root = etree.Element('main') #实例化一个etree对像<main></main>
root.append(etree.Element('h1',host_name='centos')) #添加一个子节点。属性为host_name.
etree.SubElement(root, "child2") #为主节点添加多个子节点
root.text = 'helloword' #<main>helloword</main>
root.etree.tostring(root,pretty_print=True) #打印生成的xml
root.remove(child1) #删除子节点
root.clear() #清空所有子节点
child1.getparent().tag #获取父节点
root.find('ceshi') #查出子节点tag叫ceshi
root.findall()
root.find('ceshi').text='heloo'
etree.tostring(root.find('ceshi')).decode()
###############################################################
从XML读出etree对象：
root = etree.XML("<root><a x='123'>aText<b/><c/><b/></a></root>")
对象操作同上
