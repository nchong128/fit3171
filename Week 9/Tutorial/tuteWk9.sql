--Q6. User2 can't seem to update, because there's an exclusive lock set by User1?
--Q7. User2 can update because the two users are doing different rows. Lock seems like it is a row level granularity. 
--Q8. Deadlock did get generated

--Q2
UPDATE enrolment
SET enrol_mark = 75, enrol_grade = 'D'
WHERE
    stu_nbr = 11111113 AND
    unit_code = 'FIT5132' AND
    enrol_year = 2014 AND
    enrol_semester = 2;
    
SELECT * FROM enrolment;

--Q3
UPDATE enrolment
SET enrol_grade = 'P1'
WHERE enrol_mark BETWEEN 45 AND 54;

UPDATE enrolment
SET enrol_grade = 'P2'
WHERE enrol_mark BETWEEN 55 AND 64;

UPDATE enrolment
SET enrol_grade = 'C'
WHERE enrol_mark BETWEEN 65 AND 74;

UPDATE enrolment
SET enrol_grade = 'D'
WHERE enrol_mark BETWEEN 75 AND 84;

UPDATE enrolment
SET enrol_grade = 'HD'
WHERE enrol_mark BETWEEN 85 AND 100;

--DELETE 
--Q1
SELECT * from ENROLMENT;

DELETE FROM enrolment
WHERE stu_nbr = 11111114 AND
enrol_semester = 2 AND
enrol_year = 2014;

COMMIT;

--Q2
DELETE FROM enrolment
WHERE stu_nbr = 11111113;

DELETE FROM student
WHERE stu_nbr = 11111113;

COMMIT;

--Q3
insert into student values (11111113,'Wheat','Wendy','05-May-1990');
insert into enrolment values (11111113,'FIT5132',2014,'2',null,null);
insert into enrolment values (11111113,'FIT5111',2014,'2',null,null);
commit;

alter table enrolment drop constraint ENROL_STU_FK;
-- add the constraint back but now as delete cascade
alter table enrolment add constraint ENROL_STU_FK 
  foreign key (stu_nbr) references student (stu_nbr) on delete cascade; 
  
DELETE FROM student
WHERE stu_nbr = 11111113;

SELECT * FROM ENROLMENT;

--Transaction Management
CREATE TABLE account (
    id NUMBER(5,0) NOT NULL,
    balance NUMBER(5,0) NOT NULL,
    PRIMARY KEY (id)
);


INSERT INTO account VALUES(1, 100);
INSERT INTO account VALUES(2, 200);
COMMIT;

SELECT * FROM account;

grant select, update on account to ygao0031;

SET autocommit off;

UPDATE account
SET balance = 110
WHERE id = 1;
COMMIT;

SELECT * FROM ACCOUNT;

UPDATE ACCOUNT SET BALANCE = 150 WHERE ID = 2;
COMMIT;

UPDATE account SET BALANCE = 150 WHERE ID = 2;

COMMIT;

--Q8
SELECT * FROM ygao0031.sample_1;

-- Update something on account
UPDATE account SET balance = 6969 WHERE id = 2; 

UPDATE ygao0031.sample_1 SET gold = -100 WHERE username = '420blaze';

--Table creation practice
CREATE TABLE animal (
    animal_id       NUMBER(5,0) NOT NULL,
    animal_name     VARCHAR(50) NOT NULL,
    animal_gender   CHAR(3)     NOT NULL,
    PRIMARY KEY(animal_id)
);