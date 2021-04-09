// "学生成绩单"窗口 w_select_student_score_report 脚本

/*
  open() for w_select_student_score_report
*/
dw_1.settransobject(sqlca)							// 把数据窗口 dw_1 与事务处理对象关联
dw_1.retrieve(s_info)								// 数据窗口 dw_1 检索数据