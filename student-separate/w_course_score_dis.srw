$PBExportHeader$w_course_score_dis.srw
$PBExportComments$“课程成绩分布”主窗口
forward
global type w_course_score_dis from window
end type
type dw_1 from datawindow within w_course_score_dis
end type
end forward

global type w_course_score_dis from window
integer width = 3291
integer height = 1640
boolean titlebar = true
string title = "成绩分布情况"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
end type
global w_course_score_dis w_course_score_dis

on w_course_score_dis.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_course_score_dis.destroy
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)							// 把数据窗口 dw_1 与事务处理对象关联
dw_1.retrieve()											// 数据窗口 dw_1 检索数据
end event

type dw_1 from datawindow within w_course_score_dis
integer x = 73
integer y = 64
integer width = 3113
integer height = 1412
integer taborder = 10
string title = "none"
string dataobject = "d_score_dis"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

