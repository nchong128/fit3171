set echo on

create table student_good (
  stu_nbr number(8) not null,
  stu_lname varchar(50) not null,
  stu_fname varchar(50) not null,
    constraint pk_student_good primary key (stu_nbr)
);
  
create table unit_good (
  unit_code char(7) not null,
  unit_name varchar(50) not null constraint uq_unit_name_good unique,
    constraint pk_unit_good primary key (unit_code)
);
  
create table enrolment_good (
  stu_nbr number(8) not null,
  unit_code char(7) not null,
  enrol_year number(4) not null,
  enrol_semester char(1) not null,
  enrol_mark number(3), 
  enrol_grade char(3),
    constraint pk_enrolment_good primary key (stu_nbr, unit_code, enrol_year, enrol_semester),
    constraint enrol_sem_value_good check (enrol_semester in ('1', '2', '3')),
    constraint fk_enrolment_student_good foreign key (stu_nbr)
      references student_good (stu_nbr) on delete set NULL,
    constraint fk_enrolment_unit_good foreign key (unit_code)
      references unit_good (unit_code)
);




insert into student_good values (1111,'Gupta','Amy');
insert into student_good values (2222,'Potter','Fred');
insert into student_good values (3333,'Wang','Wendy');

insert into unit_good values ('FIT9131','Foundation of Programming');
insert into unit_good values ('FIT9132','Introduction to database');
insert into unit_good values ('FIT9134','Operating Systems');
insert into unit_good values ('FIT9135','Data Communication');
insert into unit_good values ('FIT9133','Foundation of Phyton');

insert into enrolment_good values (1111,'FIT9131',2016,1,80,'HD');
insert into enrolment_good values (2222,'FIT9131',2016,1,75,'D');
insert into enrolment_good values (2222,'FIT9132',2016,2,85,'HD');
insert into enrolment_good values (2222,'FIT9134',2016,2,65,'C');
insert into enrolment_good values (2222,'FIT9135',2016,1,80,'HD');
insert into enrolment_good values (3333,'FIT9133',2016,1,55,'P');

COMMIT;

set echo off

