$PBExportHeader$w_teacher_manage.srw
$PBExportComments$“成绩管理”主窗口
forward
global type w_teacher_manage from window
end type
type pb_4 from picturebutton within w_teacher_manage
end type
type pb_3 from picturebutton within w_teacher_manage
end type
type pb_2 from picturebutton within w_teacher_manage
end type
type pb_1 from picturebutton within w_teacher_manage
end type
type ddlb_cname from dropdownlistbox within w_teacher_manage
end type
type st_4 from statictext within w_teacher_manage
end type
type st_2 from statictext within w_teacher_manage
end type
type st_6 from statictext within w_teacher_manage
end type
type st_3 from statictext within w_teacher_manage
end type
type st_5 from statictext within w_teacher_manage
end type
type st_1 from statictext within w_teacher_manage
end type
type dw_1 from datawindow within w_teacher_manage
end type
end forward

global type w_teacher_manage from window
integer width = 2560
integer height = 1620
boolean titlebar = true
string title = "成绩管理"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
windowanimationstyle openanimation = rightroll!
windowanimationstyle closeanimation = rightroll!
pb_4 pb_4
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
ddlb_cname ddlb_cname
st_4 st_4
st_2 st_2
st_6 st_6
st_3 st_3
st_5 st_5
st_1 st_1
dw_1 dw_1
end type
global w_teacher_manage w_teacher_manage

on w_teacher_manage.create
this.pb_4=create pb_4
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.ddlb_cname=create ddlb_cname
this.st_4=create st_4
this.st_2=create st_2
this.st_6=create st_6
this.st_3=create st_3
this.st_5=create st_5
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.pb_4,&
this.pb_3,&
this.pb_2,&
this.pb_1,&
this.ddlb_cname,&
this.st_4,&
this.st_2,&
this.st_6,&
this.st_3,&
this.st_5,&
this.st_1,&
this.dw_1}
end on

on w_teacher_manage.destroy
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.ddlb_cname)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.st_6)
destroy(this.st_3)
destroy(this.st_5)
destroy(this.st_1)
destroy(this.dw_1)
end on

event open;// “成绩管理”主窗口 w_teacher_manage 的 open() 事件脚本

declare cnamecursor cursor for 		// 定义游标——获取已有学生选课的课程名称
select distinct c.cname 
from c,t,sc 
where c.tno = t.tno and c.cno = sc.cno and t.tno = :t_info; 
open cnamecursor;
if sqlca.sqlcode = -1 then 
	MessageBox("SQL ERROR",string(sqlca.sqldbcode) + ": " + sqlca.sqlerrtext,StopSign!)
else
	cname_info=""
	do 										// 为下拉列表框控件 ddlb_cname 初始化
		if cname_info <> "" then 
			ddlb_cname.additem(cname_info)
		end if 
	fetch cnamecursor into :cname_info;
	loop while sqlca.sqlcode = 0
	if sqlca.sqlcode = -1 then 
		MessageBox("SQL ERROR",string(sqlca.sqldbcode) + ": " + sqlca.sqlerrtext,StopSign!)
	end if 
end if
close cnamecursor;
st_6.text = tname_info
pb_2.enabled=false		// 使 “输入成绩” 按钮无效
end event

type pb_4 from picturebutton within w_teacher_manage
integer x = 2048
integer y = 736
integer width = 389
integer height = 168
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "退出"
boolean originalsize = true
alignment htextalign = right!
vtextalign vtextalign = vcenter!
end type

event clicked;// "退出" 按钮 pb_4 的 clicked() 事件脚本

close(parent)
end event

type pb_3 from picturebutton within w_teacher_manage
integer x = 2048
integer y = 512
integer width = 389
integer height = 168
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "成绩分布"
boolean originalsize = true
alignment htextalign = right!
vtextalign vtextalign = vcenter!
end type

event clicked;// “成绩分布” 按钮 pb_3 的 clicked() 事件脚本

open(w_course_score_dis)
end event

type pb_2 from picturebutton within w_teacher_manage
integer x = 2048
integer y = 288
integer width = 389
integer height = 168
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "输入成绩"
boolean originalsize = true
alignment htextalign = right!
vtextalign vtextalign = vcenter!
end type

event clicked;// “输入成绩” 按钮 pb_2 的 clicked() 事件脚本

if pb_2.text = "输入成绩" then 
	dw_1.object.datawindow.readonly = "no"
	pb_2.text='保存'
	pb_1.enabled = false
	pb_3.enabled = false
	pb_4.enabled = false
	st_4.text = '请输入成绩: '
else
	dw_1.update()
	dw_1.retrieve(c_info)
	//dw_1.update()
	dw_1.object.datawindow.readonly = "yes"
	pb_2.text = "输入成绩"
	pb_1.enabled = true
	pb_3.enabled = true
	pb_4.enabled = true
	st_4.text = '已选修此课程的学生: '
end if 
end event

type pb_1 from picturebutton within w_teacher_manage
integer x = 2048
integer y = 64
integer width = 389
integer height = 168
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "查询"
boolean originalsize = true
alignment htextalign = right!
vtextalign vtextalign = vcenter!
end type

event clicked;// “查询” 按钮 pb_1 的 clicked() 事件脚本

if ddlb_cname.text = "" then 
	 MessageBox("出错!","请选择课程名!",StopSign!)
else
	cname_info = upper(ddlb_cname.text)
	select c.cno, t.tname into : c_info, :tname_info 
	from c,t 
	where cname = :cname_info and c.tno = t.tno;
	c_info =trim(c_info)
	st_5.text = ddlb_cname.text
	//st_6.text = tname_info
    dw_1.settransobject(sqlca)							// 把数据窗口 dw_2 与事务处理对象关联
	dw_1.retrieve(c_info)									// 数据窗口 dw_2 检索数据
	dw_1.object.datawindow.readonly = "yes" 		// 设置数据窗口 dw_2 为只读方式
	pb_2.enabled=true
end if 
end event

type ddlb_cname from dropdownlistbox within w_teacher_manage
integer x = 73
integer y = 288
integer width = 919
integer height = 1156
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean autohscroll = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_teacher_manage
integer x = 1170
integer y = 192
integer width = 736
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217858
long backcolor = 67108864
string text = "已选修此课程的学生："
end type

type st_2 from statictext within w_teacher_manage
integer x = 73
integer y = 192
integer width = 526
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217858
long backcolor = 67108864
string text = "请选择课程名："
boolean focusrectangle = false
boolean disabledlook = true
end type

type st_6 from statictext within w_teacher_manage
integer x = 1550
integer y = 64
integer width = 357
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_3 from statictext within w_teacher_manage
integer x = 1170
integer y = 64
integer width = 366
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217858
long backcolor = 67108864
string text = "任课老师："
boolean focusrectangle = false
end type

type st_5 from statictext within w_teacher_manage
integer x = 334
integer y = 64
integer width = 654
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_1 from statictext within w_teacher_manage
integer x = 69
integer y = 64
integer width = 233
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217858
long backcolor = 67108864
string text = "课程："
alignment alignment = center!
long bordercolor = 16777215
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_teacher_manage
integer x = 1170
integer y = 320
integer width = 736
integer height = 1124
integer taborder = 10
string title = "none"
string dataobject = "d_score_input"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

