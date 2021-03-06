$PBExportHeader$student.sra
$PBExportComments$Generated Application Object
forward
global type student from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
// 定义全局变量
string s_info, sname_info,s_credit, c_info, cname_info, teacher,t_info,tname_info,tclass_info
int s_term_credit
end variables
global type student from application
string appname = "student"
end type
global student student

on student.create
appname="student"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on student.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;// Profile remote_student
SQLCA.DBMS = "JDBC"
SQLCA.LogPass = "********"
SQLCA.LogId = "student"
SQLCA.AutoCommit = False
SQLCA.DBParm = "Driver='com.mysql.jdbc.Driver',URL='jdbc:mysql://localhost:3306/student?serverTimezone=Asia/Shanghai',PBCatalogOwner='student'"

connect;
if SQLCA.SQLCODE<>0 then
	messageBox("对不起! 不能连接数据库! ", SQLCA.SQLERRTEXT)
	halt
	return
else
	// 调试段<勿删>
	
	/*
	 s_info = 's1'	// 为了调试程序，先初始化全局变量 s_info 为"S1"
	 open(w_select_course) //学生选课管理
	 open(w_student_create) // 学生信息维护
	 open(w_teacher_create) //教师信息维护
	 open(w_course_create) //课程信息维护
	 open(w_select_student_score_report) //学生成绩单
	 open(w_course_score_dis) //课程成绩分布
	 open(w_teacher_manage) //成绩管理
	 open(w_manage) //管理员维护
	 open(w_login) // 系统登录
	 */
	 
	//  发布段<发布前注释调试段代码>
	 open(w_login)  //系统登录
end if



end event

