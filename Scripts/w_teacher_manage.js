// "成绩管理"窗口 w_teacher_manage 脚本

/*
  open() for w_teacher_manage
*/
declare cnamecursor cursor for 						// 定义游标——获取已有学生选课的课程名称
select distinct c.cname 
from c,t,sc 
where c.tno = t.tno and c.cno = sc.cno and t.tno = :t_info; 
open cnamecursor;
if sqlca.sqlcode = -1 then 
	MessageBox("SQL ERROR",string(sqlca.sqldbcode) + ": " + sqlca.sqlerrtext,StopSign!)
else
	cname_info=""
	do 												// 为下拉列表框控件 ddlb_cname 初始化
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
pb_2.enabled=false									// 使 “输入成绩” 按钮无效

/*
  clicked() for “查询” 按钮 pb_1
*/
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
    dw_1.settransobject(sqlca)						// 把数据窗口 dw_2 与事务处理对象关联
	dw_1.retrieve(c_info)							// 数据窗口 dw_2 检索数据
	dw_1.object.datawindow.readonly = "yes" 		// 设置数据窗口 dw_2 为只读方式
	pb_2.enabled=true
end if 

/*
  clicked() for “输入成绩” 按钮 pb_2
*/
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

/*
  clicked() for “成绩分布” 按钮 pb_3
*/
open(w_course_score_dis)

/*
  clicked() for "退出" 按钮 pb_4
*/
close(parent)