--  Maintaining Data Lab
--============================

-- 1. UPDATE
----------------------------------------------------------------------------
-- Q1.

select * from unit;

update unit set unit_name = 'place holder unit' where unit_code = 'FIT9999';
commit;

select * from unit;

-- Q2

select * from enrolment;

update enrolment set enrol_mark = 75, enrol_grade = 'D' where stu_nbr = 11111113 
    and enrol_semester = '2'  and enrol_year = 2014 and unit_code='FIT5132';
commit;

select * from enrolment;

-- Q3

select * from enrolment;

update enrolment set enrol_grade = 'P1' where enrol_mark >= 45 and enrol_mark <= 54;
update enrolment set enrol_grade = 'P2' where enrol_mark >= 55 and enrol_mark <= 64;
update enrolment set enrol_grade = 'C' where enrol_mark >= 65 and enrol_mark <= 74;
update enrolment set enrol_grade = 'D' where enrol_mark >= 75 and enrol_mark <= 84;
update enrolment set enrol_grade = 'HD' where enrol_mark >= 85;
commit;

--Alternative solution for Q3
update enrolment 
set enrol_grade = 
CASE
when enrol_mark between 45 and 54 then 'P1'
when enrol_mark between 55 and 64 then 'P2'
when enrol_mark between 65 and 74 then 'C'
when enrol_mark between 75 and 84 then 'D'
when enrol_mark between 85 and 100 then 'HD'
END;
commit;

select * from enrolment;

-- 2. DELETE
----------------------------------------------------------------------------
-- Q1.

select * from enrolment;

delete from enrolment where stu_nbr = 11111114 and enrol_semester = '2' and enrol_year = 2014;
commit;

select * from enrolment;

-- Q2.

select * from student;
select * from enrolment;

delete from student where stu_nbr = 11111113;

/*

delete from student where stu_nbr = 11111113
Error report -
SQL Error: ORA-02292: integrity constraint (AAA.FK_ENROLMENT_STUDENT) violated - child record found
02292. 00000 - "integrity constraint (%s.%s) violated - child record found"
*Cause:    attempted to delete a parent key value that had a foreign
           dependency.
*Action:   delete dependencies first then parent or disable constraint.

*/

-- Child records need to be deleted first and then the parent record:

delete from enrolment where stu_nbr = 11111113;
delete from student where stu_nbr = 11111113;
commit;

select * from student;
select * from enrolment;

-- Q3.
insert into student values (11111113,'Wheat','Wendy','05-May-1990');
insert into enrolment values (11111113,'FIT5132',2014,'2',null,null);
insert into enrolment values (11111113,'FIT5111',2014,'2',null,null);
commit;

select * from student;
select * from enrolment;

-- drop the constraint
alter table enrolment drop constraint FK_ENROLMENT_STUDENT;
-- add the constraint back but now as delete cascade
alter table enrolment add constraint FK_ENROLMENT_STUDENT 
  foreign key (stu_nbr) references student (stu_nbr) on delete cascade; 

-- delete Wendy Wheat
delete from student where stu_nbr = 11111113;
commit;

select * from student;
select * from enrolment;

