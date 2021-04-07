-- PowerBuilder+JDBC连接MySQL数据库

-- 创建数据库student
create database student; 

-- 使用数据库student
use student; 

-- 创建学生表
create table s( 
sno char(4) primary key, 
sname char(8), 
sex char(2), 
age char(2), 
sdept char(10), 
fees int not null default 0, 
logn char(10), 
pswd char(10) 
);

-- 创建教师表
create table t( 
tno char(4) primary key, 
tname char(8) not null, 
tdebt char(10), 
tclass char(10), 
logn char(10), 
pswd char(10) 
);

-- 创建课程表
create table c( 
cno char(4) primary key, 
cname char(20) not null, 
credit int default 0, 
cdept char(10), 
tno char(4), 
foreign key (tno) references t(tno) 
);

-- 创建学习表
create table sc( 
sno char(4), 
cno char(4), 
grade float check(grade between 0 and 100), 
point float, 
primary key (sno,cno), 
foreign key (sno) references s(sno), 
foreign key (cno) references c(cno) 
);
