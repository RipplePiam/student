// "学生信息维护"窗口 w_student_create 脚本

/*
  open() for w_student_create
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
int s
s = dw_1.RowCount()
row_1 = dw_1.InsertRow(s+1)
dw_1.scrolltorow(s+1)
dw_1.setfocus()
pb_1.enabled = false
pb_2.enabled = true

/*
  clicked() for "保存"按钮 pb_2
*/
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

/*
  clicked() for "删除"按钮 pb_3
*/
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

/*
  clicked() for "退出"按钮 pb_4
*/
close(parent);