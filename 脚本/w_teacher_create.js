// "教师信息维护"窗口 w_teacher_create 脚本

/*
  open() for w_teacher_create
*/
int sum,hascol
dw_1.settransobject(sqlca);
dw_1.retrieve();
dw_1.enabled = true
hascol = dw_1.retrieve();
pb_2.enabled = false
st_1.text = string(hascol)

/*
  clicked() for "新增"按钮 pb_1
*/
long row_1
int row
row = dw_1.RowCount()
row_1 = dw_1.InsertRow(row+1)
dw_1.scrolltorow(row+1)
dw_1.setfocus()
pb_1.enabled = false
pb_2.enabled = true

/*
  clicked() for "保存"按钮 pb_2
*/
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

/*
  clicked() for "删除"按钮 pb_3
*/
int row,hascol;
string kk = ''
row = dw_1.getrow();
t_info = dw_1.getitemstring(row, "tno")
select c.tno into :kk from c where (c.tno = :t_info);
if t_info = kk then
	MessageBox("出错!","不能删除, 该教师已排课!",StopSign!)
else
	if MessageBox("警告!", "删除工号为 "+t_info+" 的教师信息?",Exclamation!,OKCancel! , 2 ) = 1 then 
		MessageBox('提示信息', '记录将被删除!',Exclamation!)			// 选择确定
		dw_1.DeleteRow(row);
		dw_1.update();
		hascol = dw_1.retrieve();
		st_1.text = string(hascol)
	else
  		MessageBox('提示信息','记录将会保留!',Exclamation!)				// 选择取消
	end if
end if
pb_1.enabled = true
pb_2.enabled = false

/*
  clicked() for "退出"按钮 pb_4
*/
close(parent);

/*
  
*/