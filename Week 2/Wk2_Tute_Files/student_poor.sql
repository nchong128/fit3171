set echo on

create table student_poor (
  stu_nbr number(8) not null,
  stu_lname varchar(50) not null,
  stu_fname varchar(50) not null,
  unit_code char(7) not null,
  unit_name varchar(100) not null,
  enrol_year number(4) not null,
  enrol_semester char(1) not null,
  enrol_mark number(3), 
  enrol_grade char(3),
    constraint pk_student_poor primary key (stu_nbr,unit_code,enrol_year,enrol_semester));

-- Adding data to the table


insert into student_poor values (1111,'Gupta','Amy','FIT9131','Foundation of Programming',2016,1,80,'HD');
insert into student_poor values (2222,'Potter','Fred','FIT9131','Foundation of Programming',2016,1,75,'D');
insert into student_poor values (2222,'Potter','Fred','FIT9132','Introduction to database',2016,1,85,'HD');
insert into student_poor values (2222,'Potter','Fred','FIT9134','Operating Systems',2016,2,65,'C');
insert into student_poor values (2222,'Potter','Fred','FIT9135','Data Communication',2016,2,80,'HD');
insert into student_poor values (3333,'Wang','Wendy','FIT9133','Foundation of Phyton',2016,1,55,'P');

COMMIT;

set echo off

