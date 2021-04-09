// "学生选课管理"窗口 w_select_course 脚本

/*
  open() for w_select_course
*/
int hascol;
dw_1.settransobject(sqlca);
dw_1.retrieve();									// d_c 获取数据
dw_1.object.datawindow.readonly = "yes"				// 设置数据窗口 dw_1 为只读
hascol = dw_1.retrieve();
st_1.text = string(hascol)							// 记录总数
dw_2.Visible = false								// d_t_select 不可见
st_3.Visible = false								// “双击教师号”不可见
pb_2.enabled = false								// 保存按钮不可用

/*
  losefocus() for 课程数据窗口dw_1
*/
this.AcceptText();									// 保证用户在数据窗口中最后输入的内容不丢失

/*
  clicked() for "新增"按钮 pb_1
*/
long  row_1
int row
pb_1.enabled = false								// “新增”按钮不可用
// dw_1.enabled = true
dw_1.object.datawindow.readonly = "no"				// d_c 可编辑
dw_2.Visible = true									// d_t_select 可见
st_3.visible = true									// “双击教师号”可见
dw_2.settransobject(sqlca)
dw_2.retrieve()										// d_t_select 获取数据
dw_2.object.datawindow.readonly = "yes"				// 设置数据窗口 dw_2 为只读方式

row = dw_1.RowCount()
row_1 = dw_1.InsertRow(row+1)
dw_1.scrolltorow(row+1)
dw_1.SetRow(row_1)
dw_1.setfocus()
// st_3.enabled = false
pb_1.enabled = false								// “新增” 不可用
pb_2.enabled = true									// “保存” 可用

/*
  clicked() for "保存"按钮 pb_2
*/
int row,hascol,SQLSTATE;
string ck,tk;
row = dw_1.getrow();
c_info = dw_1.getitemstring(row, "cno")						// 获取当前课程号
select c.cno into :ck from c where (c.cno = :c_info);
ck = trim(ck)												// 获取数据源匹配课程号

t_info = dw_1.getitemstring(row, "tno")						// 获取当前教师号
select t.tno into :tk from t where (t.tno = :t_info) and t.tno <> "T0";	
tk = trim(tk)												// 获取数据源匹配教师号

if c_info = ck then
	MessageBox("出错!","不能增加, 此课程号已存在!",StopSign!)
	dw_1.DeleteRow(row)
else
	if t_info = tk then
		dw_1.update()
		dw_1.retrieve()
		hascol = dw_1.retrieve()
		st_1.text = string(hascol)
		dw_1.object.datawindow.readonly = "yes"				// 设置数据窗口 dw_1 为只读方式
	else
		MessageBox("出错!","不能增加, 此教师号不存在!",StopSign!)
		dw_1.DeleteRow(row)
	end if
end if
dw_2.visible  = false
st_3.visible = false
pb_1.enabled = true
pb_2.enabled = false

/*
  clicked() for "删除"按钮 pb_3
*/
int row,hascol;
string kk
row = dw_1.getrow();
c_info = dw_1.getitemstring(row, "cno")						// 获取当前课程号
select sc.cno into :kk from sc where (sc.cno = :c_info);	// 获取选课表中的课程号
if c_info = kk then
	MessageBox("出错!","不能删除, 此课程已有学生选!",StopSign!)
else
	if MessageBox("警告!", "是否删除课号为 "+c_info+" 的课程信息?",Exclamation!,OKCancel! , 2 ) = 1 then 
		MessageBox('提示信息', '记录将被删除!')				// 选择确定
		dw_1.DeleteRow(row);
		dw_1.update();
		hascol = dw_1.retrieve();
		st_1.text = string(hascol)
	else
  		MessageBox('提示信息','记录将会保留!')				// 选择取消
	end if
end if
pb_1.enabled = true											// 新增 可用
pb_2.enabled = false										// 保存 不可用

/*
  clicked() for "退出"按钮 pb_4
*/
close(parent);