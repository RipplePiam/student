// "课程成绩分布"窗口 w_course_score_dis 脚本

/*
  open() for w_course_score_dis
*/
dw_1.settransobject(sqlca)							// 把数据窗口 dw_1 与事务处理对象关联
dw_1.retrieve()										// 数据窗口 dw_1 检索数据
