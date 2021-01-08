from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import  Integer, String, Column, create_engine, ForeignKey
from sqlalchemy.orm import sessionmaker, relationship


Dbmysql = declarative_base()
Session = sessionmaker()
class User(Dbmysql):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(12), nullable=False, unique=True)
    fullname = Column(String(128), index=True, nullable=True)
    password = Column(String(128), nullable=False)
    #addresses=relationship("Address",back_populates='user')
    addresses = relationship("Address",back_populates='user',foreign_keys=[Address.user_id]) #创建addresses字段，relationship()关联，“Address”创建表类名，back_populates='user'#跳至Address.user字段，foreign_keys='对应表的字段，要求是外键'


class Address (Dbmysql):
    __tablename__ = 'addresses'
    id = Column(Integer, primary_key=True, autoincrement=True)
    address = Column(String(128), unique=True, nullable=False)
    user_id = Column(Integer, ForeignKey('users.id'), nullable=False) #Foreignkey()设置外键对应另一张表的主键字段。users.id为users表的id字段，
    #user=relationship("User", back_populates="addresses")[Address(address='fengzi'),Address(address='ruili')]
    user=relationship("User", back_populates="addresses", foreign_keys=[user_id]) #User 类名， addresses 类下的字段名，foreign_keys=本表的对应外键字段名 

engine = create_engine('mysql+pymysql://fengzi:fengzi@192.168.12.105:3306/ceshi', echo=True)
Dbmysql.metadata.drop_all(engine)
Dbmysql.metadata.create_all(engine)
Session.configure(bind=engine)
session = Session()
ceshi=[Address(address='fengzi'),Address(address='ruili')] #外键表的插入要求是一个列。格式为：[类名(要插入的字段名=值，可插入多个字段),可插入多次。]
user = User(name='ruili', fullname='fengzi', password='fengzi',addresses=ceshi) #字段插入
session.add(user)			插入至会话。
try:
    session.commit()			事务同步至数据库
except Exception as e:
    session.rollback()			出错时事务回滚
    raise e

#####################################################################
if 0: #select join
    ret = session.query(User).join(Address).all() #全表查询。
    for i in ret:
        c=None
        for a in i.email_addresses:
            c=a.email_address
        print(i.name, i.fullname, c) #输打印指定字段。 
if 0:
    ret = session.query(User.name).count() #count()统计行数。
    print(ret)

if 0:
    a = aliased(session.query(Address).outerjoin(User).subquery()) #subquery()子查询
    ret = session.query(a).all()	#打印所有
    print(ret)
if 1:
    for kw in session.query(User).filter(User.name.any(title='post1')).all():
        print(kw.name)  

