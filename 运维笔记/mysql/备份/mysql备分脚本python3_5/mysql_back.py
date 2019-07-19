#!/root/.pyenv/shims/python3.5
import os
import datetime
import shutil
f=open('mysql.conf','r+t',encoding='GBK')
ce=f.readlines()
def die(nf):
    c = nf.split('\n')[0].split('=')[1]
    return c
CONF=die(ce[0])
USER=die(ce[1])
PASS=die(ce[2])
IP=die(ce[3])
BACK=die(ce[4])
DATETIME=datetime.datetime.now()
DATETIME=str(DATETIME).split()[0]
f.close()
y,m,d=str(datetime.datetime.now()).split()[0].split('-')
y,m,d=int(y),int(m),int(d)
mo=datetime.datetime(y,m,d).strftime("%W")
DAY=datetime.datetime(y,m,d).strftime("%u")
####################
BACK=BACK+'/'+mo
BACK_TMP=BACK+'/'+'tmp'
os.makedirs(BACK_TMP,exist_ok=True)
os.makedirs(BACK,exist_ok=True)
os.chdir('/home')
def back():
    os.system('innobackupex --user="%s" --host="%s" --password="%s" --apply_log  >/dev/null 2>&1'%(USER,IP,PASS))
    os.system('innobackupex --user="%s" --host="%s" --password="%s" %s >/dev/null 2>&1'%(USER,IP,PASS,BACK_TMP))
    c=os.listdir(BACK_TMP)
    os.chdir(BACK)
    f=open('back_list.txt','w+')
    f.write(str(c[0])+'     '+'all_back\n')
    f.seek(0)
    mysql_dir=f.read()
    f.close()
    a=os.system('echo $?')
    b=BACK+'/'
    os.chdir(BACK_TMP)
    shutil.move(mysql_dir.split()[0],b)
    return a
def z_back():
    def z_bakck_1():
        os.chdir(BACK)
        f = open('back_list.txt', 'a+')
        f.seek(0)
        back_all=f.readlines()[-1].split()[0]
        print(back_all)
        os.system('innobackupex --user="%s" --host="%s" --password="%s" --incremental  --incremental-dasedir=%s    %s  >/dev/null 2>&1'%(USER,IP,PASS,back_all,BACK_TMP+'/'))
        print('...............................................')
        c=os.listdir(BACK_TMP)
        f.write(str(c[0])+'     '+'zen_back\n')
        f.seek(0)
        mysql_dir=BACK_TMP+'/'+f.readlines()[-1].split()[0]
        b = BACK + '/'
        shutil.move(mysql_dir.split()[0],b)
        f.close()
    if os.listdir(BACK).count('back_list.txt')==1:
        z_bakck_1()
    else:
        back()
def beifen():
    if DAY==7:
        back()
        #print('7')
    else:
        #print(1)
        z_back()
beifen()
