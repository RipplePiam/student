$PBExportHeader$w_course_create.srw
$PBExportComments$“课程信息维护”主窗口
forward
global type w_course_create from window
end type
type st_1 from statictext within w_course_create
end type
type st_3 from statictext within w_course_create
end type
type dw_2 from datawindow within w_course_create
end type
type st_2 from statictext within w_course_create
end type
type pb_4 from picturebutton within w_course_create
end type
type pb_3 from picturebutton within w_course_create
end type
type pb_2 from picturebutton within w_course_create
end type
type pb_1 from picturebutton within w_course_create
end type
type dw_1 from datawindow within w_course_create
end type
end forward

global type w_course_create from window
integer width = 3657
integer height = 1480
boolean titlebar = true
string title = "课程信息维护"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_1 st_1
st_3 st_3
dw_2 dw_2
st_2 st_2
pb_4 pb_4
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
dw_1 dw_1
end type
global w_course_create w_course_create

type variables

end variables

on w_course_create.create
this.st_1=create st_1
this.st_3=create st_3
this.dw_2=create dw_2
this.st_2=create st_2
this.pb_4=create pb_4
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.st_3,&
this.dw_2,&
this.st_2,&
this.pb_4,&
this.pb_3,&
this.pb_2,&
this.pb_1,&
this.dw_1}
end on

on w_course_create.destroy
destroy(this.st_1)
destroy(this.st_3)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.dw_1)
end on

event open;// 课程信息窗口 w_course_create 的 open() 事件脚本

int hascol;
// char tno_info
dw_1.settransobject(sqlca);
dw_1.retrieve();										// d_c 获取数据
dw_1.object.datawindow.readonly = "yes"		// 设置数据窗口 dw_1 为只读
hascol = dw_1.retrieve();
st_1.text = string(hascol)							// 记录总数
dw_2.Visible = false									// d_t_select 不可见
st_3.Visible = false									// “双击教师号”不可见
pb_2.enabled = false									// 保存按钮不可用
end event

type st_1 from statictext within w_course_create
integer x = 475
integer y = 64
integer width = 261
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217858
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_3 from statictext within w_course_create
integer x = 2011
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
string text = "请双击教师号："
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_course_create
integer x = 2011
integer y = 160
integer width = 1106
integer height = 1156
integer taborder = 20
string title = "none"
string dataobject = "d_t_select"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_course_create
integer x = 73
integer y = 60
integer width = 379
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

type pb_4 from picturebutton within w_course_create
integer x = 3182
integer y = 836
integer width = 389
integer height = 168
integer taborder = 20
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

event clicked;// "退出"按钮 pb_4 的 clicked() 事件脚本

close(parent);
end event

type pb_3 from picturebutton within w_course_create
integer x = 3182
integer y = 608
integer width = 389
integer height = 168
integer taborder = 20
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
string kk
row = dw_1.getrow();
c_info = dw_1.getitemstring(row, "cno")													// 获取当前课程号
select sc.cno into :kk from sc where (sc.cno = :c_info);								// 获取选课表中的课程号
if c_info = kk then
	MessageBox("出错!","不能删除, 此课程已有学生选!",StopSign!)
else
	if MessageBox("警告!", "是否删除课号为 "+c_info+" 的课程信息?",Exclamation!,OKCancel! , 2 ) = 1 then 
		MessageBox('提示信息', '记录将被删除!')									// 选择确定
		dw_1.DeleteRow(row);
		dw_1.update();
		hascol = dw_1.retrieve();
		st_1.text = string(hascol)
	else
  		MessageBox('提示信息','记录将会保留!')										// 选择取消
	end if
end if
pb_1.enabled = true					// 新增 可用
pb_2.enabled = false					// 保存 不可用

end event

type pb_2 from picturebutton within w_course_create
integer x = 3182
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

event clicked;// "保存"按钮 pb_2 的 clicked() 事件脚本

int row,hascol,SQLSTATE;
string ck,tk;
row = dw_1.getrow();
c_info = dw_1.getitemstring(row, "cno")						// 获取当前课程号
select c.cno into :ck from c where (c.cno = :c_info);
ck = trim(ck)														// 获取数据源匹配课程号

t_info = dw_1.getitemstring(row, "tno")						// 获取当前教师号
select t.tno into :tk from t where (t.tno = :t_info) and t.tno <> "T0";	
tk = trim(tk)															// 获取数据源匹配教师号

if c_info = ck then
	MessageBox("出错!","不能增加, 此课程号已存在!",StopSign!)
	dw_1.DeleteRow(row)
else
	if t_info = tk then
		dw_1.update()
		dw_1.retrieve()
		hascol = dw_1.retrieve()
		st_1.text = string(hascol)
		dw_1.object.datawindow.readonly = "yes"			// 设置数据窗口 dw_1 为只读方式
	else
		MessageBox("出错!","不能增加, 此教师号不存在!",StopSign!)
		dw_1.DeleteRow(row)
	end if
end if
dw_2.visible  = false
st_3.visible = false
pb_1.enabled = true
pb_2.enabled = false

end event

type pb_1 from picturebutton within w_course_create
integer x = 3182
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

long  row_1
int row
pb_1.enabled = false									// “新增”按钮不可用
// dw_1.enabled = true
dw_1.object.datawindow.readonly = "no"		// d_c 可编辑
dw_2.Visible = true									// d_t_select 可见
st_3.visible = true										// “双击教师号”可见
dw_2.settransobject(sqlca)
dw_2.retrieve()											// d_t_select 获取数据
dw_2.object.datawindow.readonly = "yes"		// 设置数据窗口 dw_2 为只读方式

row = dw_1.RowCount()
row_1 = dw_1.InsertRow(row+1)
dw_1.scrolltorow(row+1)
dw_1.SetRow(row_1)
dw_1.setfocus()
// st_3.enabled = false
pb_1.enabled = false									// “新增” 不可用
pb_2.enabled = true									// “保存” 可用
end event

type dw_1 from datawindow within w_course_create
integer x = 73
integer y = 160
integer width = 1870
integer height = 1156
integer taborder = 10
string title = "none"
string dataobject = "d_c"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event losefocus;this.AcceptText();									// 保证用户在数据窗口中最后输入的内容不丢失
end event

