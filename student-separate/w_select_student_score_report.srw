$PBExportHeader$w_select_student_score_report.srw
$PBExportComments$“学生成绩单”主窗口
forward
global type w_select_student_score_report from window
end type
type dw_1 from datawindow within w_select_student_score_report
end type
end forward

global type w_select_student_score_report from window
integer width = 2523
integer height = 1800
boolean titlebar = true
string title = "学生成绩单"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
end type
global w_select_student_score_report w_select_student_score_report

on w_select_student_score_report.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_select_student_score_report.destroy
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)							// 把数据窗口 dw_1 与事务处理对象关联
dw_1.retrieve(s_info)									// 数据窗口 dw_1 检索数据
end event

type dw_1 from datawindow within w_select_student_score_report
integer x = 73
integer y = 64
integer width = 2350
integer height = 1572
integer taborder = 10
string title = "none"
string dataobject = "d_student_score_report"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

