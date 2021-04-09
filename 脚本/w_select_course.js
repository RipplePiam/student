// "学生选课管理"窗口 w_select_course 脚本

/*
  open() for w_select_course
*/
dw_1.settransobject(sqlca)							// 给数据窗口控件 dw_1 设置通信区域 sqlca
dw_1.retrieve(s_info)								// 从数据库的 s 表中检索数据到控件 dw_1
dw_1.object.datawindow.readonly="yes"				// 设置数据窗口为只读方式

dw_2.settransobject(sqlca)							// 给数据窗口控件 dw_2 设置通信区域 sqlca
dw_2.retrieve(s_info)								// 从数据库的 c 表和 sc 表中检索数据到控件 dw_2
dw_2.object.datawindow.readonly="yes"				// 设置数据窗口为只读方式

dw_3.settransobject(sqlca)							// 给数据窗口控件 dw_3 设置通信区域 sqlca
dw_3.retrieve()										// 从数据库的 c 表中检索数据到控件 dw_3
dw_3.object.datawindow.readonly="yes"				// 设置数据窗口为只读方式

dw_4.settransobject(sqlca)							// 将"已选课程"数据窗口与事务处理对象关联
dw_4.retrieve(s_info)								// 检索数据
dw_4.object.datawindow.readonly="yes"				// 设置数据窗口为只读方式

sle_1.SetFocus()									// 设置焦点

/*
  doubleclicked() for "可选课程"数据窗口 dw_2
*/
open(w_select_student_score_report)

/*
  clicked() for "选课" 按钮 pb_1
*/
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

/*
  clicked() for "退课"按钮 pb_2
*/
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

/*
  clicked() for "关闭"按钮 pb_3
*/
close(parent)