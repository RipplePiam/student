$PBExportHeader$w_teacher_create.srw
$PBExportComments$教师信息维护
forward
global type w_teacher_create from window
end type
type dw_1 from datawindow within w_teacher_create
end type
type st_1 from statictext within w_teacher_create
end type
type st_2 from statictext within w_teacher_create
end type
type pb_1 from picturebutton within w_teacher_create
end type
type pb_2 from picturebutton within w_teacher_create
end type
type pb_3 from picturebutton within w_teacher_create
end type
type pb_4 from picturebutton within w_teacher_create
end type
end forward

global type w_teacher_create from window
integer width = 2738
integer height = 1480
boolean titlebar = true
string title = "教师信息维护"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
st_1 st_1
st_2 st_2
pb_1 pb_1
pb_2 pb_2
pb_3 pb_3
pb_4 pb_4
end type
global w_teacher_create w_teacher_create

on w_teacher_create.create
this.dw_1=create dw_1
this.st_1=create st_1
this.st_2=create st_2
this.pb_1=create pb_1
this.pb_2=create pb_2
this.pb_3=create pb_3
this.pb_4=create pb_4
this.Control[]={this.dw_1,&
this.st_1,&
this.st_2,&
this.pb_1,&
this.pb_2,&
this.pb_3,&
this.pb_4}
end on

on w_teacher_create.destroy
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.pb_3)
destroy(this.pb_4)
end on

event open;// 教师信息主窗口 w_teacher_create 的 open() 事件脚本

int sum,hascol
dw_1.settransobject(sqlca);
dw_1.retrieve();
dw_1.enabled = true
hascol = dw_1.retrieve();
pb_2.enabled = false
st_1.text = string(hascol)
end event

type dw_1 from datawindow within w_teacher_create
integer x = 73
integer y = 156
integer width = 2126
integer height = 1164
integer taborder = 10
string title = "none"
string dataobject = "d_t"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_teacher_create
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

type st_2 from statictext within w_teacher_create
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

type pb_1 from picturebutton within w_teacher_create
integer x = 2267
integer y = 160
integer width = 389
integer height = 168
integer taborder = 10
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
int row
row = dw_1.RowCount()
row_1 = dw_1.InsertRow(row+1)
dw_1.scrolltorow(row+1)
dw_1.setfocus()
pb_1.enabled = false
pb_2.enabled = true
end event

type pb_2 from picturebutton within w_teacher_create
integer x = 2267
integer y = 384
integer width = 389
integer height = 168
integer taborder = 10
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

int row,hascol;
string kk
//pb_1.enabled = false
row = dw_1.getrow();
t_info = dw_1.getitemstring(row, "tno")
select t.tno into :kk from t where (t.tno = :t_info);
kk = trim(kk)
if t_info = kk then
	MessageBox("出错!","不能增加, 此学号已存在!",StopSign!)
else
	dw_1.update()
	hascol = dw_1.retrieve()
	st_1.text = string(hascol)
	pb_1.enabled = true
	pb_2.enabled = false
end if
end event

type pb_3 from picturebutton within w_teacher_create
integer x = 2267
integer y = 608
integer width = 389
integer height = 168
integer taborder = 10
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

int row,hascol;
string kk = ''
row = dw_1.getrow();
t_info = dw_1.getitemstring(row, "tno")
select c.tno into :kk from c where (c.tno = :t_info);
if t_info = kk then
	MessageBox("出错!","不能删除, 该教师已排课!",StopSign!)
else
	if MessageBox("警告!", "删除工号为 "+t_info+" 的教师信息?",Exclamation!,OKCancel! , 2 ) = 1 then 
		MessageBox('提示信息', '记录将被删除!',Exclamation!)							// 选择确定
		dw_1.DeleteRow(row);
		dw_1.update();
		hascol = dw_1.retrieve();
		st_1.text = string(hascol)
	else
  		MessageBox('提示信息','记录将会保留!',Exclamation!)							// 选择取消
	end if
end if
pb_1.enabled = true
pb_2.enabled = false

end event

type pb_4 from picturebutton within w_teacher_create
integer x = 2267
integer y = 832
integer width = 389
integer height = 168
integer taborder = 10
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

