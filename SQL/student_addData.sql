-- 添加数据 for student.s & student.t & student.c & student.sc

-- 使用student数据库 
use student;

-- 添加s表数据 
insert into s values('S1','李铭','男','19','计算机软件','0','S1','S1');
insert into s values('S2','刘晓鸣','男','20','计算机应用','0','S2','S2');
insert into s values('S3','李明','男','22','计算机应用','0','S3','S3');
insert into s values('S4','张鹰','女','21','计算机软件','0','S4','S4');
insert into s values('S5','刘竟静','女','22','计算机软件','0','S5','S5');
insert into s values('S6','刘成刚','男','21','计算机软件','0','S6','S6');
insert into s values('S7','王铭','男','22','计算机应用','0','S7','S7');
insert into s values('S8','宣明尼','女','18','计算机应用','0','S8','S8');
insert into s values('S9','柳红利','女','19','计算机软件','0','S9','S9');

-- 添加 t 表数据
insert into t values('T0','管理员','NULL','系统管理员','T0','T0');
insert into t values('T1','王晓明','计算机应用','教师','T1','T1');
insert into t values('T2','刘红','计算机软件','教师','T2','T2');
insert into t values('T3','吴志钢','计算机应用','教师','T3','T3');
insert into t values('T4','李严劲','计算机软件','教师','T4','T4');
insert into t values('T5','蒋莹岳','计算机应用','教师','T5','T5');

-- 添加c表数据 
insert into c values('C1','PASCAL','4','计算机应用','T1');
insert into c values('C2','数据结构','4','计算机应用','T2');
insert into c values('C3','离散数学','4','计算机应用','T3');
insert into c values('C4','计算机原理','6','计算机软件','T4');
insert into c values('C5','数据库原理','4','计算机应用','T3');
insert into c values('C6','Windows技术','4','计算机软件','T3');
insert into c values('C8','编译原理','4','计算机软件','T5');
insert into c values('C9','系统结构','6','计算机应用','T2');

-- 添加sc表数据 
insert into sc values('S1','C2','56','0');
insert into sc values('S1','C4','78','3');
insert into sc values('S1','C6','66','1.7');
insert into sc values('S1','C8','88','3.7');
insert into sc values('S3','C1','88','3.7');
insert into sc values('S3','C2','76','2.7');
insert into sc values('S4','C1','67','1.7');
insert into sc values('S4','C2','76','2.7');
insert into sc values('S4','C3','67','1.7');
insert into sc values('S5','C1','67','1.7');
insert into sc values('S5','C2','78','3');
insert into sc values('S5','C3','91','4');
insert into sc values('S6','C1','78','3');
