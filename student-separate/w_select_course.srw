$PBExportHeader$w_select_course.srw
$PBExportComments$学生选课主窗口
forward
global type w_select_course from window
end type
type pb_3 from picturebutton within w_select_course
end type
type pb_2 from picturebutton within w_select_course
end type
type pb_1 from picturebutton within w_select_course
end type
type dw_4 from datawindow within w_select_course
end type
type dw_3 from datawindow within w_select_course
end type
type dw_2 from datawindow within w_select_course
end type
type dw_1 from datawindow within w_select_course
end type
type sle_1 from singlelineedit within w_select_course
end type
type st_5 from statictext within w_select_course
end type
type st_4 from statictext within w_select_course
end type
type st_3 from statictext within w_select_course
end type
type st_2 from statictext within w_select_course
end type
type st_1 from statictext within w_select_course
end type
end forward

global type w_select_course from window
integer width = 4091
integer height = 2472
boolean titlebar = true
string title = "学生选课"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
sle_1 sle_1
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
end type
global w_select_course w_select_course

on w_select_course.create
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.sle_1=create sle_1
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.pb_3,&
this.pb_2,&
this.pb_1,&
this.dw_4,&
this.dw_3,&
this.dw_2,&
this.dw_1,&
this.sle_1,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1}
end on

on w_select_course.destroy
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.sle_1)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
end on

event open;// 窗口 w_select_course 的 open() 事件脚本

dw_1.settransobject(sqlca)						// 给数据窗口控件 dw_1 设置通信区域 sqlca
dw_1.retrieve(s_info)								// 从数据库的 s 表中检索数据到控件 dw_1
dw_1.object.datawindow.readonly="yes"	// 设置数据窗口为只读方式

dw_2.settransobject(sqlca)						// 给数据窗口控件 dw_2 设置通信区域 sqlca
dw_2.retrieve(s_info)								// 从数据库的 c 表和 sc 表中检索数据到控件 dw_2
dw_2.object.datawindow.readonly="yes"	// 设置数据窗口为只读方式

dw_3.settransobject(sqlca)						// 给数据窗口控件 dw_3 设置通信区域 sqlca
dw_3.retrieve()										// 从数据库的 c 表中检索数据到控件 dw_3
dw_3.object.datawindow.readonly="yes"	// 设置数据窗口为只读方式

dw_4.settransobject(sqlca)						// 将"已选课程"数据窗口与事务处理对象关联
dw_4.retrieve(s_info)								// 检索数据
dw_4.object.datawindow.readonly="yes"	// 设置数据窗口为只读方式

sle_1.SetFocus()									// 设置焦点

end event

type pb_3 from picturebutton within w_select_course
integer x = 3493
integer y = 792
integer width = 389
integer height = 168
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "关闭"
alignment htextalign = right!
vtextalign vtextalign = vcenter!
end type

event clicked;// 关闭按钮 pb_3 的 clicked() 事件脚本

close(parent)
end event

type pb_2 from picturebutton within w_select_course
integer x = 3493
integer y = 568
integer width = 389
integer height = 168
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "退课"
alignment htextalign = right!
vtextalign vtextalign = vcenter!
end type

event clicked;// 退课 pb_2 clicked()

string ccno,ggrade
if sle_1.text = "" then
	MessageBox("出错!","请输入课程号!",StopSign!)
end if
c_info = upper(sle_1.text)
if c_info <> "" then
	select c.cname into :cname_info from c where c.cno = :c_info;
	if SQLCA.SQLCODE <> 0 then
		MessageBox("出错!","此课程不存在!",StopSign!)
	else
		select sc.cno,sc.grade into :ccno,:ggrade from sc where (sc.cno = :c_info and sc.sno = :s_info);
		if SQLCA.SQLCODE <> 0 then
			MessageBox("出错!","此课程未选!",StopSign!)
		else
			if ggrade <> "" then
				MessageBox("出错!","此课程已登分!",StopSign!)
			else
				delete from sc where sno = :s_info and cno = :c_info;
				dw_4.reset()
				sle_1.text = ""
				dw_4.settransobject(sqlca)
				dw_4.retrieve(s_info)
			end if
		end if
	end if
end if
end event

type pb_1 from picturebutton within w_select_course
integer x = 3493
integer y = 352
integer width = 389
integer height = 168
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "选课"
alignment htextalign = right!
vtextalign vtextalign = vcenter!
end type

event clicked;// "选课" 按钮 pb_1 的 clicked() 事件脚本

string ccname,ccno
c_info = upper(sle_1.text)
if c_info = "" then
	MessageBox("出错!","请输入课程号!",StopSign!)
else
	select c.cname into :ccname from c where c.cno = :c_info;
	if SQLCA.SQLCODE <> 0 then
		MessageBox("出错!","此课程号不存在!",StopSign!)
	else
		select sc.cno into :ccno from sc where (sc.cno = :c_info and sc.sno = :s_info);
		if SQLCA.SQLCODE = 0 then
			MessageBox("出错!","此课程已选!",StopSign!)
		else
			insert into sc(sno,cno) 
			values (:s_info, :c_info);
			dw_4.reset()
			sle_1.text = ""
			dw_4.settransobject(sqlca)
			dw_4.retrieve(s_info)
			dw_4.object.datawindow.readonly = "yes"
		end if
	end if
end if
end event

type dw_4 from datawindow within w_select_course
integer x = 1499
integer y = 1472
integer width = 1838
integer height = 836
integer taborder = 30
string title = "none"
string dataobject = "d_select_student_course"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_select_course
integer x = 1499
integer y = 156
integer width = 1874
integer height = 1160
integer taborder = 20
string title = "none"
string dataobject = "d_c"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_select_course
integer x = 73
integer y = 1468
integer width = 1358
integer height = 840
integer taborder = 20
string title = "none"
string dataobject = "d_select_student_score"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;// 可选课程 dw_2 的 doubleclicked() 事件脚本

open(w_select_student_score_report)
end event

type dw_1 from datawindow within w_select_course
integer x = 73
integer y = 156
integer width = 1358
integer height = 1160
integer taborder = 10
string title = "none"
string dataobject = "d_select_student"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_select_course
integer x = 3438
integer y = 160
integer width = 457
integer height = 132
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_select_course
integer x = 1499
integer y = 1368
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
string text = "已选课程："
boolean focusrectangle = false
end type

type st_4 from statictext within w_select_course
integer x = 1499
integer y = 64
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
string text = "可选课程："
boolean focusrectangle = false
end type

type st_3 from statictext within w_select_course
integer x = 73
integer y = 1368
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
string text = "已修课程成绩："
boolean focusrectangle = false
end type

type st_2 from statictext within w_select_course
integer x = 73
integer y = 64
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
string text = "学生详细信息："
boolean focusrectangle = false
end type

type st_1 from statictext within w_select_course
integer x = 3429
integer y = 64
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
string text = "请输入课程号："
boolean focusrectangle = false
end type

