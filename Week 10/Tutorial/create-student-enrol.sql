--
-- Create student model and load data
--

DROP TABLE ENROLMENT CASCADE CONSTRAINTS PURGE;
DROP TABLE STUDENT CASCADE CONSTRAINTS PURGE;
DROP TABLE UNIT CASCADE CONSTRAINTS PURGE;

CREATE TABLE ENROLMENT 
    ( 
     stu_no CHAR (8)  NOT NULL , 
     unit_code CHAR (7)  NOT NULL , 
     enrol_semester INTEGER  NOT NULL , 
     enrol_year INTEGER  NOT NULL , 
     enrol_mark NUMBER (4,1) , 
     enrol_grade CHAR (2) 
    );

ALTER TABLE ENROLMENT 
    ADD CONSTRAINT ENROLMENT_PK PRIMARY KEY ( unit_code, enrol_semester, enrol_year, stu_no ) ;


CREATE TABLE STUDENT 
    ( 
     stu_no CHAR (8)  NOT NULL , 
     stu_fname VARCHAR2 (50)  NOT NULL , 
     stu_gname VARCHAR2 (50)  NOT NULL , 
     stu_dob DATE  NOT NULL , 
     stu_avg_mark NUMBER (4,1) 
    ) ;

ALTER TABLE STUDENT 
    ADD CONSTRAINT STUDENT_PK PRIMARY KEY ( stu_no ) ;

CREATE TABLE UNIT 
    ( 
     unit_code CHAR (7)  NOT NULL , 
     unit_name VARCHAR2 (50)  NOT NULL , 
     unit_current_stu_count NUMBER (4) 
    );

ALTER TABLE UNIT 
    ADD CONSTRAINT UNIT_PK PRIMARY KEY ( unit_code ) ;

ALTER TABLE ENROLMENT 
    ADD CONSTRAINT STUDENT_ENROLMENT_FK FOREIGN KEY 
    (stu_no) REFERENCES STUDENT (stu_no);

ALTER TABLE ENROLMENT 
    ADD CONSTRAINT UNIT_ENROLMENT_FK FOREIGN KEY 
    (unit_code) REFERENCES UNIT (unit_code);

insert into STUDENT values ('11111121','Bloggs','Fred',to_date('01-FEB-91','DD-MON-RR'),46.0);
insert into STUDENT values ('11111122','Nice','Nick',to_date('15-SEP-92','DD-MON-RR'),66.0);
insert into STUDENT values ('11111123','Wheat','Wendy',to_date('23-OCT-89','DD-MON-RR'),75.0);
insert into STUDENT values ('11111124','Sheen','Cindy',to_date('12-MAR-89','DD-MON-RR'),75.5);
insert into STUDENT values ('11111125','Wang','Andrew',to_date('11-AUG-90','DD-MON-RR'),64.3);
insert into STUDENT values ('11111126','Xu','Mary',to_date('26-NOV-92','DD-MON-RR'),60.8);
insert into STUDENT values ('11111127','Yang','Sarah',to_date('10-OCT-91','DD-MON-RR'),67.5);
insert into STUDENT values ('11111128','Li','Richard',to_date('24-DEC-91','DD-MON-RR'),68.5);
insert into STUDENT values ('11111129','Brown','Robert',to_date('27-JUN-89','DD-MON-RR'),77.8);
insert into STUDENT values ('11111130','Sheen','Michael',to_date('05-MAY-87','DD-MON-RR'),70.3);
   
insert into UNIT values ('FIT9132','Introduction to databases',10);
insert into UNIT values ('FIT9131','Programming foundations',0);
insert into UNIT values ('FIT9134','Computer architecture and operating systems',0); 
insert into UNIT values ('FIT9135','Data communications',0);
insert into UNIT values ('FIT5057','Project management',0);

insert into ENROLMENT values ('11111121','FIT9131',1,2014,35,'N ');
insert into ENROLMENT values ('11111122','FIT9131',1,2014,62,'C ');
insert into ENROLMENT values ('11111123','FIT9131',1,2014,76,'D ');
insert into ENROLMENT values ('11111124','FIT9131',1,2014,85,'HD');
insert into ENROLMENT values ('11111125','FIT9131',1,2014,64,'C ');
insert into ENROLMENT values ('11111126','FIT9131',1,2014,58,'P ');
insert into ENROLMENT values ('11111127','FIT9131',1,2014,68,'C ');
insert into ENROLMENT values ('11111128','FIT9131',1,2014,73,'D ');
insert into ENROLMENT values ('11111129','FIT9131',1,2014,89,'HD');
insert into ENROLMENT values ('11111130','FIT9131',1,2014,74,'D ');
insert into ENROLMENT values ('11111121','FIT9135',1,2014,46,'N ');
insert into ENROLMENT values ('11111122','FIT9135',1,2014,70,'D ');
insert into ENROLMENT values ('11111123','FIT9135',1,2014,83,'HD');
insert into ENROLMENT values ('11111124','FIT9135',1,2014,92,'HD');
insert into ENROLMENT values ('11111125','FIT9135',1,2014,66,'C ');
insert into ENROLMENT values ('11111126','FIT9135',1,2014,62,'C ');
insert into ENROLMENT values ('11111127','FIT9135',1,2014,70,'D ');
insert into ENROLMENT values ('11111128','FIT9135',1,2014,65,'C ');
insert into ENROLMENT values ('11111129','FIT9135',1,2014,78,'D ');
insert into ENROLMENT values ('11111130','FIT9135',1,2014,68,'C ');
insert into ENROLMENT values ('11111121','FIT9135',2,2014,48,'N ');
insert into ENROLMENT values ('11111122','FIT9135',2,2014,65,'C ');
insert into ENROLMENT values ('11111123','FIT9135',2,2014,79,'D ');
insert into ENROLMENT values ('11111124','FIT9135',2,2014,80,'HD');
insert into ENROLMENT values ('11111125','FIT9135',2,2014,72,'D ');
insert into ENROLMENT values ('11111126','FIT9135',2,2014,65,'C ');
insert into ENROLMENT values ('11111127','FIT9135',2,2014,70,'D ');
insert into ENROLMENT values ('11111128','FIT9135',2,2014,76,'D ');
insert into ENROLMENT values ('11111129','FIT9135',2,2014,85,'HD');
insert into ENROLMENT values ('11111130','FIT9135',2,2014,72,'D ');
insert into ENROLMENT values ('11111121','FIT5057',1,2015,55,'P ');
insert into ENROLMENT values ('11111122','FIT5057',1,2015,67,'C ');
insert into ENROLMENT values ('11111123','FIT5057',1,2015,62,'C ');
insert into ENROLMENT values ('11111124','FIT5057',1,2015,45,'N ');
insert into ENROLMENT values ('11111125','FIT5057',1,2015,55,'P ');
insert into ENROLMENT values ('11111126','FIT5057',1,2015,58,'P ');
insert into ENROLMENT values ('11111127','FIT5057',1,2015,62,'C ');
insert into ENROLMENT values ('11111128','FIT5057',1,2015,60,'C ');
insert into ENROLMENT values ('11111129','FIT5057',1,2015,59,'P ');
insert into ENROLMENT values ('11111130','FIT5057',1,2015,67,'C ');
insert into ENROLMENT values ('11111121','FIT9132',2,2015,null,null);
insert into ENROLMENT values ('11111122','FIT9132',2,2015,null,null);
insert into ENROLMENT values ('11111123','FIT9132',2,2015,null,null);
insert into ENROLMENT values ('11111124','FIT9132',2,2015,null,null);
insert into ENROLMENT values ('11111125','FIT9132',2,2015,null,null);
insert into ENROLMENT values ('11111126','FIT9132',2,2015,null,null);
insert into ENROLMENT values ('11111127','FIT9132',2,2015,null,null);
insert into ENROLMENT values ('11111128','FIT9132',2,2015,null,null);
insert into ENROLMENT values ('11111129','FIT9132',2,2015,null,null);
insert into ENROLMENT values ('11111130','FIT9132',2,2015,null,null);


-- Create structures for use by audit
drop sequence audit_seq;
drop table audit_log purge;

create sequence audit_seq start with 1 increment by 1;

create table audit_log (
  audit_no number(6) constraint audit_log_pk primary key,
  audit_date date not null,
  audit_user varchar(30) not null,
  audit_stu_no char (8)  not null,
  audit_unit_code char (7)  not null
);

commit;
