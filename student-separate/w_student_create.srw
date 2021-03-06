$PBExportHeader$w_student_create.srw
$PBExportComments$学生信息维护 主窗口
forward
global type w_student_create from window
end type
type pb_4 from picturebutton within w_student_create
end type
type pb_3 from picturebutton within w_student_create
end type
type pb_2 from picturebutton within w_student_create
end type
type pb_1 from picturebutton within w_student_create
end type
type st_2 from statictext within w_student_create
end type
type st_1 from statictext within w_student_create
end type
type dw_1 from datawindow within w_student_create
end type
end forward

global type w_student_create from window
integer width = 2597
integer height = 1480
boolean titlebar = true
string title = "学生信息维护"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
pb_4 pb_4
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
st_2 st_2
st_1 st_1
dw_1 dw_1
end type
global w_student_create w_student_create

event open;// 学生信息主窗口 w_student_create 的 open() 事件脚本

int sum,hascol
dw_1.settransobject(sqlca);
dw_1.retrieve();
dw_1.enabled = true
hascol = dw_1.retrieve();
pb_2.enabled = false
st_1.text = string(hascol)
end event

on w_student_create.create
this.pb_4=create pb_4
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.st_2=create st_2
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.pb_4,&
this.pb_3,&
this.pb_2,&
this.pb_1,&
this.st_2,&
this.st_1,&
this.dw_1}
end on

on w_student_create.destroy
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_1)
end on

type pb_4 from picturebutton within w_student_create
integer x = 2121
integer y = 832
integer width = 389
integer height = 168
integer taborder = 30
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

event clicked;// "退出"按钮 pb_4 的 clicked() 的事件脚本

close(parent);
end event

type pb_3 from picturebutton within w_student_create
integer x = 2121
integer y = 608
integer width = 389
integer height = 168
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "删除"
boolean originalsize = true
alignment htextalign = right!
vtextalign vtextalign = vcenter!
end type

event clicked;// "删除"按钮 pb_3 的 clicked() 事件脚本

int s,hascol;
string kk
s = dw_1.getrow();
s_info = dw_1.getitemstring(s, "sno")
select sc.sno into :kk from sc where (sc.sno = :s_info);
if s_info = kk then
	MessageBox("出错!","不能删除, 此学生已选课!",StopSign!)
else
	if MessageBox("警告!", "删除学号为 "+s_info+" 的学生信息?",Exclamation!,OKCancel! , 2 ) = 1 then 
		MessageBox('提示信息', '记录将被删除!',Exclamation!)					// 选择确定
		dw_1.DeleteRow(s);
		dw_1.update();
		hascol = dw_1.retrieve();
		st_1.text = string(hascol)
	else
  		MessageBox('提示信息','记录将会保留!',Exclamation!)					// 选择取消
	end if
end if
pb_1.enabled = true
pb_2.enabled = false

end event

type pb_2 from picturebutton within w_student_create
integer x = 2121
integer y = 384
integer width = 389
integer height = 168
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "保存"
boolean originalsize = true
alignment htextalign = right!
vtextalign vtextalign = vcenter!
end type

event clicked;// "保存"按钮 pb_2 的 clicked() 的事件脚本

int s,hascol;
string kk
//pb_1.enabled = false
s = dw_1.getrow();
s_info = dw_1.getitemstring(s, "sno")
select s.sno into :kk from s where (s.sno = :s_info);
kk = trim(kk)
if s_info = kk then
	MessageBox("出错!","不能增加, 此学号已存在!",StopSign!)
else
	dw_1.update()
	hascol = dw_1.retrieve()
	st_1.text = string(hascol)
	pb_1.enabled = true
	pb_2.enabled = false
end if
end event

type pb_1 from picturebutton within w_student_create
integer x = 2121
integer y = 160
integer width = 389
integer height = 168
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "新增"
boolean originalsize = true
alignment htextalign = right!
vtextalign vtextalign = vcenter!
end type

event clicked;// "新增"按钮 pb_1 的 clicked() 事件脚本

long row_1
int s
s = dw_1.RowCount()
row_1 = dw_1.InsertRow(s+1)
dw_1.scrolltorow(s+1)
dw_1.setfocus()
pb_1.enabled = false
pb_2.enabled = true
end event

type st_2 from statictext within w_student_create
integer x = 73
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
string text = "记录总数："
boolean focusrectangle = false
end type

type st_1 from statictext within w_student_create
integer x = 439
integer y = 64
integer width = 306
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

type dw_1 from datawindow within w_student_create
integer x = 73
integer y = 156
integer width = 1979
integer height = 1164
integer taborder = 10
string title = "none"
string dataobject = "d_s"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

