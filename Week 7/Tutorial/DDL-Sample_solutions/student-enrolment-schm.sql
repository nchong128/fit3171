spool tables_from_scratch1_run.txt
set echo on

--
-- DDL for Student Unit Enrolment model
--

--
-- Place DROP commands at head of schema file
--

drop table enrolment purge;
drop table student purge;
drop table unit purge;

-- Create Tables
-- Here using both table and column constraints
--
create table student (
  stu_nbr number(8) not null,
  stu_lname varchar(50) not null,
  stu_fname varchar(50) not null,
  stu_dob date not null,
    constraint pk_student primary key (stu_nbr),
    constraint ck_stu_nbr check (stu_nbr > 10000000));
  
create table unit (
  unit_code char(7) not null,
  unit_name varchar(50) not null constraint uq_unit_name unique,
    constraint pk_unit primary key (unit_code));
  
create table enrolment (
  stu_nbr number(8) not null,
  unit_code char(7) not null,
  enrol_year number(4) not null,
  enrol_semester char(1) not null,
  enrol_mark number(3), 
  enrol_grade char(3),
    constraint pk_enrolment primary key (stu_nbr, unit_code, enrol_year, enrol_semester),
    constraint enrol_sem_value check (enrol_semester in ('1', '2', '3')),
    constraint fk_enrolment_student foreign key (stu_nbr)
      references student (stu_nbr),
    constraint fk_enrolment_unit foreign key (unit_code)
      references unit (unit_code));

set echo off
spool off
