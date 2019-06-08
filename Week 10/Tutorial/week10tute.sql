--Q1
SELECT MAX(se.mark) as max_mark
FROM SHAREDSAMPLES.ENROLMENT se
WHERE 
    se.unitcode = 'FIT1004' AND 
    se.semester = 1 AND
    to_char(ofyear, 'YYYY') = '2013';
    
--Q2

SELECT AVG(se.mark) as avg_mark
FROM SHAREDSAMPLES.ENROLMENT se
WHERE 
    se.unitcode = 'FIT1040' AND 
    se.semester = 2 AND
    to_char(ofyear, 'YYYY') = '2013';
    

    
--Q3
SELECT TO_CHAR(ofyear, 'YYYY') as OFFERING_YEAR, semester, ROUND(avg(mark),1)
FROM SHAREDSAMPLES.enrolment e
WHERE unitcode = 'FIT1040'
GROUP BY ofyear, semester
ORDER BY ofyear ASC;

--Q4
--Repeat students are counted each time
SELECT COUNT(STUDID)
FROM SHAREDSAMPLES.ENROLMENT en
WHERE en.unitcode = 'FIT1040' AND TO_CHAR(en.ofyear, 'YYYY') = '2013';

--Repeat students are counted only once
SELECT COUNT(DISTINCT STUDID)
FROM SHAREDSAMPLES.ENROLMENT en
WHERE en.unitcode = 'FIT1040' AND TO_CHAR(en.ofyear, 'YYYY') = '2013';

--Q5
SELECT semester, unitcode, TO_CHAR(ofyear, 'YYYY') AS year, count(studid) AS count
FROM SHAREDSAMPLES.enrolment e
WHERE TO_CHAR(ofyear, 'YYYY') = '2013'
GROUP BY semester, unitcode, ofyear
ORDER BY count ASC, unitcode ASC, semester ASC;

--Q6
SELECT count(has_prereq_of) as COUNT
FROM SHAREDSAMPLES.prereq
WHERE unitcode = 'FIT2077';

--Q7
SELECT prq.unitcode, COUNT(prq.has_prereq_of) as num_of_prereq
FROM SHAREDSAMPLES.PREREQ prq
GROUP BY prq.unitcode;


--Q8
SELECT pq.has_prereq_of, u.unitname, count(pq.unitcode) as count
FROM SHAREDSAMPLES.prereq pq
    JOIN SHAREDSAMPLES.unit u
    ON u.unitcode = pq.has_prereq_of
GROUP BY pq.has_prereq_of, u.unitname;



--Q9
--Find the unit with the highest number of enrolments in a given offering in the year 2013
SELECT unitcode, TO_CHAR(ofyear, 'YYYY') as year,semester,  count(studid) as stu_count
FROM sharedsamples.enrolment
GROUP BY unitcode, semester, ofyear
HAVING count(studid) = 
    (SELECT MAX(COUNT(studid))
    FROM SHAREDSAMPLES.enrolment
    WHERE TO_CHAR(ofyear, 'YYYY') =  '2013'
    GROUP BY unitcode, semester);    
    
--Q10
--Who is the oldest student in FIT1004, display the student full name and DOB
SELECT
studfname || ' ' || studlname AS FULLNAME,
studdob AS DOB
FROM SHAREDSAMPLES.student st JOIN SHAREDSAMPLES.enrolment e ON st.studid = e.studid
WHERE
    e.unitcode = 'FIT1004' AND
    studdob = (
    SELECT MIN(st.studdob)
    FROM SHAREDSAMPLES.student st
    JOIN SHAREDSAMPLES.enrolment e
    ON st.studid = e.studid
    WHERE e.unitcode = 'FIT1004')
ORDER BY fullname;

--Q11
--Find all students enrolled in FIT1004 in sem 1, 2013 who have scored more than the average mark of FIT1004 in the same offering
--Display the student's name and mark. Sort the list in the order of the mark from highest to lowest

SELECT st.studfname || ' ' || st.studlname as full_name, e.mark
FROM SHAREDSAMPLES.student st
JOIN SHAREDSAMPLES.enrolment e
ON st.studid = e.studid
WHERE
    e.unitcode = 'FIT1004' AND
    semester = '1' AND
    TO_CHAR(ofyear, 'YYYY') = '2013' AND
    e.mark > (
    SELECT AVG(mark)
    FROM SHAREDSAMPLES.enrolment
    WHERE
        semester = '1' AND 
        TO_CHAR(ofyear, 'YYYY') = '2013' AND
        unitcode = 'FIT1004')
ORDER BY mark desc;

--Triggers
SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;

CREATE OR REPLACE TRIGGER maintain_dept_emp_count
AFTER DELETE OR INSERT OR UPDATE OF dept_no ON EMPLOYEE
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE department
        SET dept_empcnt = dept_empcnt + 1
        WHERE dept_no = :new.dept_no;
    ELSE
        IF DELETING THEN
            UPDATE department
            SET dept_empcnt = dept_empcnt - 1
            WHERE dept_no = :old.dept_no;
    ELSE
        IF UPDATING THEN
            UPDATE department
                SET dept_empcnt = dept_empcnt - 1
                WHERE dept_no = :old.dept_no;
            UPDATE department
                SET dept_empcnt = dept_empcnt + 1
                WHERE dept_no = :new.dept_no;
        END IF;
        END IF ; 
        END IF;
END;
/

INSERT INTO department VALUES(30, 'Finance', 300);

INSERT INTO department VALUES(31, 'Accounting', 0);

INSERT INTO EMPLOYEE VALUES (0000, 'Croc', 123456.12, TO_DATE('2018','YYYY'), 30);

UPDATE EMPLOYEE
SET dept_no = 31
WHERE emp_no = 0000;

SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;

DELETE FROM EMPLOYEE
WHERE emp_no = 0000;

--Task B
SELECT * FROM ENROLMENT;

--QUESTION 1
CREATE OR REPLACE TRIGGER unit_upd_cascade
AFTER UPDATE OF unit_code ON unit
FOR EACH ROW
BEGIN
    UPDATE ENROLMENT
    SET unit_code = :new.unit_code
    WHERE unit_code = :old.unit_code;
END;
/

SELECT * FROM UNIT;
SELECT * FROM ENROLMENT;

UPDATE UNIT
SET unit_code = 'FIT6969'
WHERE unit_code = 'FIT9132';

--Question 2 
CREATE OR REPLACE TRIGGER unit_stu_count_update
AFTER INSERT OR DELETE ON enrolment
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE unit
        SET UNIT_CURRENT_STU_COUNT = UNIT_CURRENT_STU_COUNT + 1
        WHERE unit_code = :new.unit_code;
    ELSE
        IF DELETING THEN
            UPDATE unit
            SET UNIT_CURRENT_STU_COUNT = UNIT_CURRENT_STU_COUNT - 1
            WHERE unit_code = :old.unit_code;
        
        END IF;
    END IF;
END;
/

--Question 3
CREATE OR REPLACE TRIGGER calculate_grade
AFTER INSERT OR UPDATE OF enrol_mark ON enrolment
FOR EACH ROW
BEGIN
    UPDATE enrolment
    SET enrol_grade =
    CASE 
    WHEN enrol_mark >= 80 THEN 'HD'
    WHEN enrol_mark BETWEEN 70 AND 79 THEN 'D'
    WHEN enrol_mark BETWEEN 60 AND 69 THEN 'C'
    WHEN enrol_mark BETWEEN 50 AND 59 THEN 'P'
    WHEN enrol_mark < 50 THEN 'N'
    END;  
END;
/

DROP TRIGGER calculate_grade;

SELECT * FROM ENROLMENT;

UPDATE ENROLMENT SET enrol_mark  = 80 WHERE STU_NO = '11111123' AND UNIT_CODE = 'FIT9131';
COMMIT;

ROLLBACK;

---
CREATE VIEW enrolment_smart AS SELECT * FROM enrolment WHERE enrol_mark > 50;

SELECT * FROM ENROLMENT_SMART;

--Triggers

SELECT * FROM ENROLMENT;
SELECT * FROM UNIT;

UPDATE unit
SET unit_code = 'FIT6000'
WHERE unit_code = 'FIT9132';

CREATE OR REPLACE TRIGGER unit_name_update
AFTER UPDATE OF unit_code ON unit
FOR EACH ROW
BEGIN
    -- Trigger body
    --:new.unit_code
    UPDATE enrolment
    SET unit_code = :new.unit_code
    WHERE unit_code = :old.unit_code;
END;
/

CREATE OR REPLACE TRIGGER stu_count_manage
    AFTER INSERT OR DELETE ON enrolment
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE unit
        SET unit_current_stu_count = unit_current_stu_count + 1
        WHERE unit_code = :new.unit_code;
        ELSE
            IF DELETING THEN
                UPDATE unit
                SET unit_current_stu_count = unit_current_stu_count - 1
                WHERE unit_code = :old.unit_code;
            END IF;
    END IF;
END;
/

DELETE FROM enrolment WHERE stu_no = 11111121 AND unit_Code = 'FIT9131';





























