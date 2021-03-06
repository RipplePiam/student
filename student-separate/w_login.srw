$PBExportHeader$w_login.srw
$PBExportComments$“系统登录”主窗口
forward
global type w_login from window
end type
type pb_exit from picturebutton within w_login
end type
type pb_login from picturebutton within w_login
end type
type p_1 from picture within w_login
end type
type st_2 from statictext within w_login
end type
type st_1 from statictext within w_login
end type
type sle_pwd from singlelineedit within w_login
end type
type sle_user from singlelineedit within w_login
end type
end forward

global type w_login from window
integer width = 1531
integer height = 832
boolean titlebar = true
string title = "系统登录"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event login pbm_keydown
pb_exit pb_exit
pb_login pb_login
p_1 p_1
st_2 st_2
st_1 st_1
sle_pwd sle_pwd
sle_user sle_user
end type
global w_login w_login

event open;// w_login 主窗口的 open() 事件脚本

p_1.picturename = '3.png'			// 红灯




end event

on w_login.create
this.pb_exit=create pb_exit
this.pb_login=create pb_login
this.p_1=create p_1
this.st_2=create st_2
this.st_1=create st_1
this.sle_pwd=create sle_pwd
this.sle_user=create sle_user
this.Control[]={this.pb_exit,&
this.pb_login,&
this.p_1,&
this.st_2,&
this.st_1,&
this.sle_pwd,&
this.sle_user}
end on

on w_login.destroy
destroy(this.pb_exit)
destroy(this.pb_login)
destroy(this.p_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_pwd)
destroy(this.sle_user)
end on

type pb_exit from picturebutton within w_login
integer x = 146
integer y = 448
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

event clicked;// "退出"按钮 pb_exit 的 clicked() 事件脚本

close(parent)
end event

type pb_login from picturebutton within w_login
integer x = 937
integer y = 448
integer width = 389
integer height = 168
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "登录"
boolean originalsize = true
alignment htextalign = right!
vtextalign vtextalign = vcenter!
end type

event clicked;// "登录" 按钮 pb_login 的 clicked() 事件脚本
if sle_user.text = "" then 
	MessageBox("提醒:","请输入用户名!")
	sle_user.SetFocus()
	return
end if 
if sle_pwd.text = "" then 
	MessageBox("提醒:","请输入密码!")
	sle_pwd.SetFocus()
	return
end if

string ls_user, ls_pwd, ls_confirm_user, ls_confirm_pwd

ls_user = upper(sle_user.text)											// 将 sle_user 字符串转换为大写字符
ls_pwd=upper(sle_pwd.text)
ls_confirm_pwd = ""
ls_confirm_user = ""

select t.logn, t.pswd, t.tno, t.tname, t.tclass 
into :ls_confirm_user, :ls_confirm_pwd, :t_info, :tname_info, :tclass_info 
from t where t.logn = :ls_user;											// 读教师表 t
t_info = trim(t_info)														// 从 t_info 字符串中删除开始和结束部分的空格
tname_info = trim(tname_info)
if SQLCA.SQLCODE <> 0 then 											// 若登录者不是教师
	select s.logn, s.pswd, s.sno, s.sname 
	into :ls_confirm_user, :ls_confirm_pwd, :s_info, :sname_info 
	from s where s.logn = :ls_user;									// 读学生表 s
	s_info = trim(s_info)
	if trim(ls_user) <> trim(upper(ls_confirm_user)) then 		// 判断学生是否合法
	MessageBox("警告!", "用户名错! 重新注册!", Exclamation!)
	sle_user.text = ""
	sle_pwd.text = ""
	sle_user.SetFocus()
	elseif trim(ls_pwd) <> trim(upper(ls_confirm_pwd)) then 
		MessageBox("警告!", "口令错! 重新注册", Exclamation!)
		sle_pwd.text = ""
		sle_pwd.SetFocus()
		else 
			open(w_select_course)										// 打开"学生选课管理"主窗口
			close(parent)
			return 
	end if
elseif trim(ls_user) <> trim(upper(ls_confirm_user)) then 		 // 判断老师是否合法
	MessageBox("警告!", "用户名错! 重新注册", Exclamation!)
	sle_user.text = ""
	sle_pwd.text = ""
	sle_user.SetFocus()
elseif trim(ls_pwd) <> trim(upper(ls_confirm_pwd)) then
	MessageBox("警告!", "口令错! 重新注册!", Exclamation!)
	sle_pwd.text = ""
	sle_pwd.SetFocus()
	else
		if tclass_info = '系统管理员' then 
			open(w_manage)											// 打开"管理员维护"主窗口
			close(parent)
		else 
			open(w_teacher_manage)								// 打开"成绩管理"主窗口
			close(parent)
	end if 
end if 
end event

type p_1 from picture within w_login
integer x = 146
integer y = 128
integer width = 151
integer height = 228
boolean focusrectangle = false
end type

type st_2 from statictext within w_login
integer x = 512
integer y = 288
integer width = 357
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217858
long backcolor = 67108864
string text = "口   令:"
boolean focusrectangle = false
boolean disabledlook = true
end type

type st_1 from statictext within w_login
integer x = 512
integer y = 96
integer width = 357
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217858
long backcolor = 67108864
string text = "用户名:"
boolean focusrectangle = false
end type

type sle_pwd from singlelineedit within w_login
integer x = 878
integer y = 288
integer width = 448
integer height = 100
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;// w_login 窗口的 sle_pwd 控件 checkkey() 事件脚本

if keydown(KeyEnter!) or keydown(KeyTab!) then 
	p_1.picturename = '1.png'								// 绿灯
	pb_login.SetFocus()
end if
end event

type sle_user from singlelineedit within w_login
integer x = 878
integer y = 96
integer width = 457
integer height = 100
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

event modified;// w_login 窗口的 sle_user 控件 checkkey() 事件脚本

if keydown(KeyEnter!) or keydown(KeyTab!) then 
	p_1.picturename = '2.png'								// 黄灯
	sle_pwd.setfocus()
end if 
end event

