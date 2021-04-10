// "系统登录"窗口 w_login 脚本

/*
  open() for "系统登录"窗口 w_login
*/
p_1.picturename = '3.png'							// 图3 红色交通灯

/*
  modified() for 用户名框 sle_user
*/
if keydown(KeyEnter!) or keydown(KeyTab!) then 
	p_1.picturename = '2.png'						// 图2 黄色交通灯
	sle_pwd.setfocus()
end if 

/*
  modified() for 密码框 sle_pwd
*/
if keydown(KeyEnter!) or keydown(KeyTab!) then 
	p_1.picturename = '1.png'						// 图1 绿色交通灯
	pb_login.SetFocus()
end if

/*
  clicked() for "退出"按钮 pb_exit
*/
close(parent)

/*
  clicked() for "登录"按钮 pb_login
*/
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

ls_user = upper(sle_user.text)									// 将 sle_user 字符串转换为大写字符
ls_pwd=upper(sle_pwd.text)
ls_confirm_pwd = ""
ls_confirm_user = ""

select t.logn, t.pswd, t.tno, t.tname, t.tclass 
into :ls_confirm_user, :ls_confirm_pwd, :t_info, :tname_info, :tclass_info 
from t where t.logn = :ls_user;									// 读教师表 t
t_info = trim(t_info)											// 从 t_info 字符串中删除开始和结束部分的空格
tname_info = trim(tname_info)
if SQLCA.SQLCODE <> 0 then 										// 若登录者不是教师
	select s.logn, s.pswd, s.sno, s.sname 
	into :ls_confirm_user, :ls_confirm_pwd, :s_info, :sname_info 
	from s where s.logn = :ls_user;								// 读学生表 s
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
			open(w_select_course)								// 打开"学生选课管理"主窗口
			close(parent)
			return 
	end if
elseif trim(ls_user) <> trim(upper(ls_confirm_user)) then 		// 判断老师是否合法
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
			open(w_manage)										// 打开"管理员维护"主窗口
			close(parent)
		else 
			open(w_teacher_manage)								// 打开"成绩管理"主窗口
			close(parent)
	end if 
end if 