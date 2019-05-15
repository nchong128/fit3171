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
SELECT en.semester, TO_CHAR(en.ofyear,'YYYY') as year, AVG(en.mark) as average
FROM SHAREDSAMPLES.ENROLMENT en
WHERE en.unitcode = 'FIT1040'
GROUP BY en.semester, en.ofyear
ORDER BY en.ofyear;

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
SELECT unitcode, semester, ofyear, count(unitcode) as num_enrolments
FROM SHAREDSAMPLES.ENROLMENT en
WHERE TO_CHAR(ofyear, 'YYYY') = '2013'
GROUP BY unitcode, semester, ofyear
ORDER BY num_enrolments ASC ;

--Q6
SELECT COUNT(prq.unitcode) as num_of_prereq
FROM SHAREDSAMPLES.PREREQ prq
WHERE prq.unitcode = 'FIT2077';

--Q7
SELECT prq.unitcode, COUNT(prq.has_prereq_of) as num_of_prereq
FROM SHAREDSAMPLES.PREREQ prq
GROUP BY prq.unitcode;

--Q8
SELECT prq.has_prereq_of as prereq_unit, unit.unitname as prereq_name, COUNT(prq.unitcode) as count
FROM SHAREDSAMPLES.PREREQ prq
    JOIN SHAREDSAMPLES.UNIT unit 
    ON prq.has_prereq_of = unit.unitcode
GROUP BY prq.has_prereq_of, unit.unitname
ORDER BY prereq_unit;    

--Q9
--Find the unit with the highest number of enrolments in a given offering in the year 2013
SELECT en.unitcode, TO_CHAR(en.ofyear,'YYYY'), en.semester, count(en.studid) as COUNT
FROM SHAREDSAMPLES.ENROLMENT en
GROUP BY en.unitcode, en.ofyear, en.semester
HAVING COUNT(en.studid) = (
    SELECT max(count(en.studid))
    FROM SHAREDSAMPLES.ENROLMENT en
    WHERE TO_CHAR(en.ofyear, 'YYYY') = '2013'
    GROUP BY en.unitcode, en.ofyear, en.semester );
    
--Q10
--Who is the oldest student in FIT1004, display the student full name and DOB
SELECT stu.studfname || ' ' || stu.studlname as full_name, stu.studdob as dob
FROM SHAREDSAMPLES.STUDENT stu
WHERE stu.studdob = (
    SELECT MIN(stu.STUDDOB)
    FROM SHAREDSAMPLES.STUDENT stu JOIN SHAREDSAMPLES.ENROLMENT en 
    ON stu.studid = en.studid
    WHERE en.unitcode = 'FIT1004' )
ORDER BY full_name;

--Q11
--Find all students enrolled in FIT1004 in sem 1, 2013 who have scored more than the average mark of FIT1004 in the same offering
--Display the student's name and mark. Sort the list in the order of the mark from highest to lowest


