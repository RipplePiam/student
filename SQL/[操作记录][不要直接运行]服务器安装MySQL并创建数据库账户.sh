rem 本脚本不可直接运行！
rem 功能: 从一台新主机到连通MySQL的操作记录

REM 下载MySQL官方yum repository
cd /usr/local/src
wget -i -c https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm

rem 安装mysql
yum -y install mysql80-community-release-el7-3.noarch.rpm

rem 安装MySQL服务器
yum -y install mysql-community-server

rem 启动MySQL服务
systemctl start mysqld.service

rem 查看MySQL运行状态
systemctl status mysqld.service

rem 查看临时密码(密码是localhost:后面的)
grep "password" /var/log/mysqld.log

rem 进入数据库(输入上述密码)
mysql -u root -p

rem 修改密码
rem mysql>ALTER USER 'root'@'localhost' IDENTIFIED BY 'new password';
ALTER USER 'root'@'localhost' IDENTIFIED BY 'YourPassWD';

rem 开启远程访问
rem - 查看用户访问属性
rem mysql>
select user,host from mysql.user;

rem -创建新用户用于远程访问(不建议root)

rem //grant all privileges on *.* to 'root'@'192.168.0.1' identified by 'password' with grant option;
rem //grant all privileges on *.* to 'demo'@'%' identified by 'YourPassWD' with grant option;
rem 上式错误，改用下面式子(创建用户)

rem mysql>
create user 'demo'@'%' identified by 'YourPassWD';
create user 'guest'@'%' identified by 'YourPassWD';

rem 赋予权限
rem -自定义权限
rem mysql>
rem grant create,drop,select,update,delete,insert on *.* to demo;
grant select,update on *.* to 'guest';

rem -全部权限
rem mysql>
grant all privileges on *.* to demo;

rem 查看权限
rem mysql>
show grants for demo;

rem 刷新权限
rem mysql>
flush privileges;

rem 完成后，开启服务器3306端口即可远程登录
rem mysql -h <服务器ip> -P 3306 -u <账户名> -p
rem 参数含义: -h host  -P Port  -u user  -p passwd -D DB
rem 数据可以从本地 workbench 直接复制到远程

rem 创建远程访问用户student用于PowerBuilder
create user 'student'@'%' identified by 'YourPassWD'

rem 限制student用户只能操作student数据库
grant all privileges on student.* to student;

rem 刷新权限
flush privileges;
show grants for student;