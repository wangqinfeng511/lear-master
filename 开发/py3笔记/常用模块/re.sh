
import re
s='hello word'
# 匹配正则：
#     .               匹配单字符
#     rel|rel         或匹配
#     ^               起始铆钉
#     $               尾部铆钉
#     *               多次匹配
#     +               1次或多次匹配
#     ?               0次或1次匹配
#     {N}               匹配指定次数
#     {M,N}             匹配M-N的次数
#     [abcd]          单字符或匹配
#      [^abcd]        不匹配字符
#       (...)         子组匹配
#       \d            数字匹配
#       \w            匹配字符和数字
#       \s            匹配空格
#       \b            匹配任何单词边界
class re_lear():
    def match(self):
        #re.match 匹配一个字符串开始部分，匹配返回匹配对象，未匹配返回None
        display=re.match('hello','hello word') #可以匹配。
        # display=re.match('hello','adb hello word') #不可以匹配。
        # group 打印匹配的字符串对象,span()返回匹配的匹配字符串对象的游标
        print(display.group(),display.span())
    def compile(self):
        # re.compile 返回一个正则表达式对象
        self.s_compile=re.compile(s)
    def search(self):
        #全文搜索匹配。
        re_search=re.search('hello','asd hello word')
        print(re_search.span(), re_search.group())
        re_search = re.search('h{2}', 'abh hhello word hello')  # 可以匹配。
        print(re_search.group(),re_search.span())
        print(len('abh hhello word hello'))
        re_search = re.search('h{1,2}h', 'abh hhello word hello')  # 可以匹配。
        print(re_search.group(), re_search.span())
        re_search=re.search('[^a-b].*','adb,hello word hello')
        print(re_search.group(),re_search.span())
        re_search=re.search('\w*\s','hello owr1')
        print(re_search.group())
        re_search = re.search('(\b*)\s(\b*)*', 'hello owr1')
        print(re_search.group())
    def findall(self):
        #搜索指定字符串返回匹配到的字符串
        re_findall=re.findall('he[l]{0,3}o','hello hello word')
        if re_findall :
            print(re_findall)
    def finditer(self):
        #与findall的区别是返回的是一个迭代对象
        re_finditer=re.finditer('he[l]{2}o','hello hello word')
        # for i in re_finditer:
        #     print(i.group())
        print([i for i in  re_finditer][0].group())
    def sub(self):
        #匹配替换 第一参数匹配规则，第二参替换的内容，第三参要匹配的字符串。
        d='hello hello word'
        c=re.sub('hello','test',d)
        print(c)
    def split(self):
        #按匹配规则切分字符串
        c=re.split('o','hello word')
        print(c)
        print('o'.join(c))
if __name__=='__main__':
    relear=re_lear()
    # relear.match()
    # relear.search()
    # relear.findall()
    # relear.finditer()
    # relear.sub()
    relear.split()

import re
str_a='192.168.12.20 - - [08/Aug/2016:16:15:37 +0800] "GET /time/dashboard.php HTTP/1.1" 200 19634 "-" "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; InfoPath.3)" "-"'
o=re.compile(r'(?P<ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*(?P<time>\[.*\]).*(?P<get_put>GET|PUT) (?P<file>[^\s]*).*\" (?P<status>\d{3}).?(?P<file_date> \d+)')
#定义一个匹配规则，r代表一个自然字符串，(?P<ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}) 以字典方式反回。ip为key 匹配到的为value
m=o.search(str_a) #要搜索的字符串。
c=m.groupdict()	 #对搜索的结果返回为字典，要配合(?P)使用
print(c)