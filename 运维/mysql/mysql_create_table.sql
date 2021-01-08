#database kucun
#用户表：
create table user(id int not null primary key auto_increment,name varchar(255) unique key,password varchar(255));
#权限表：
create table qx(id int not null primary key auto_increment,qx_type varchar(255) unique key);

create table user_qx(id int not null primary key auto_increment,user_id int,qx_id int,foreign key(user_id) references user(id),foreign key(qx_id) references qx(id) );

#销售商表
create table xss(id int not null primary key auto_increment,name varchar(255),addrs varchar(255),call_s varchar(255));
#出入库记录表：
create table crkjl( id int not null primary key auto_increment,cpml_id int,type int,number int,event_time date,foreign key(cpml_id) references cpml(id));
#库存表：
create table kcb(id int not null primary key auto_increment,cpml_id int,number int,yxq date,ph varchar(50),scrq date,foreign key(cpml_id) references cpml(id));
#产品目录表：
create table cpml(id int not null primary key auto_increment,cpml_id int,number int,yxq date,ph varchar(50),scrq date,foreign key(xss_id) references xss(id));



