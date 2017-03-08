set global event_scheduler=ON;
CREATE EVENT EVENT_AM
ON SCHEDULE EVERY 1 DAY 
STARTS TIMESTAMP '2016-01-15 00:00:00'
DO
CALL sync_stu1
#insert into wade.session_count(,count,) values (,select count(*) from plt.sys_session;,);

insert t_stu1(STU_CODE,CERTI_CODE,STU_NAME,GENDER_CODE,SCHOOL_ID,STU_GRADE,STU_CLASS_NAME,integrateCore,NICKNAME,INVITATION_CODE,SHARE_CODE,MOBILE,EMAIL,ACCOUNT_STATUS,LOGIN_PWD,DEAL_PWD,ACC_ID,CREATE_ID,MODIFY_ID,INSERT_TIME,UPDATE_TIME) select * from t_stu where INSERT_TIME>(select max(t_stu1.INSERT_TIME) from t_stu1);

delimiter $$
create procedure sync_stu1()
BEGIN
declare stu_nums long default 0;
declare stu_max_inerttime long default 0;
select count(id) into stu_nums from t_stu1;
if stu_nums=0 then
	insert into t_stu1(stu_code,certi_code,stu_name,gender_code,school_id,stu_grade,stu_class_name,integratecore,nickname,invitation_code,share_code,mobile,email,account_status,login_pwd,deal_pwd,acc_id,create_id,modify_id,insert_time,update_time) select * from t_stu;
else
	select max(INSERT_TIME) into  stu_max_inerttime from t_stu;
	insert into t_stu1(stu_code,certi_code,stu_name,gender_code,school_id,stu_grade,stu_class_name,integratecore,nickname,invitation_code,share_code,mobile,email,account_status,login_pwd,deal_pwd,acc_id,create_id,modify_id,insert_time,update_time) select * from t_stu where INSERT_TIME>stu_max_inerttime;
end if;
END $$
delimiter ;



delimiter $$
create procedure p_account_ctime()
BEGIN
update pub_student set enabled=0 where id in (select sys_user.id  from sys_user inner join cpus_player on cpus_player.id=sys_user.id where sys_user.account>88000001 and sys_user.account<88999999 and TO_DAYs(now()) - TO_DAYS(cpus_player.ctime) > 90);
update sys_user inner join cpus_player on cpus_player.id=sys_user.id set sys_user.enabled=0 where sys_user.account>88000001 and sys_user.account<88999999 and TO_DAYs(now()) - TO_DAYS(cpus_player.ctime) > 90;
END $$
delimiter ;

DELIMITER $$
CREATE EVENT GRADE_COUNT
ON SCHEDULE EVERY 1 MINUTE
STARTS TIMESTAMP '2016-05-30 11:30:00'
DO
	BEGIN
		update grade_count set count=(select count(cpus_player.id) from pub_student cross join cpus_player  where pub_student.gradenum>=1 and pub_student.gradenum<=3 and cpus_player.id=pub_student.id) where grade='low';
		update grade_count set count=(select count(cpus_player.id) from pub_student cross join cpus_player  where pub_student.gradenum>=4 and pub_student.gradenum<=6 and cpus_player.id=pub_student.id) where grade='middle';
		update grade_count set count=(select count(cpus_player.id) from pub_student cross join cpus_player  where pub_student.gradenum>=7 and pub_student.gradenum<=9 and cpus_player.id=pub_student.id) where grade='high';
	END;
$$;
