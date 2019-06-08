SELECT * FROM SHAREDSAMPLES.UNIT;
SELECT * FROM SHAREDSAMPLES.PREREQ;

--Q1
SELECT u.unitcode, COUNT(pq.has_prereq_of) as num_of_prereqs
FROM SHAREDSAMPLES.unit u LEFT OUTER JOIN SHAREDSAMPLES.prereq pq
ON u.unitcode = pq.unitcode
GROUP BY u.unitcode
ORDER BY num_of_prereqs;

--Q2
-- My own choice
SELECT u.unitcode, u.unitname
FROM SHAREDSAMPLES.unit u LEFT OUTER JOIN SHAREDSAMPLES.prereq pq
ON u.unitcode = pq.unitcode
GROUP BY u.unitcode, u.unitname
HAVING COUNT(pq.has_prereq_of) = 0;

--Set operators and subqueries
select * from sharedsamples.unit;
select * from sharedsamples.prereq;

SELECT unitcode, unitname
FROM sharedsamples.unit
WHERE unitcode IN (
    SELECT unitcode
    FROM sharedsamples.unit 
    MINUS
    select unitcode
    FROM sharedsamples.prereq);

--Outer join method
SELECT u.unitcode, u.unitname
FROM sharedsamples.unit u LEFT OUTER JOIN sharedsamples.prereq p
ON u.unitcode = p.unitcode
WHERE p.unitcode IS NULL;

--Q3 
SELECT unitcode, semester, TO_CHAR(ofyear, 'YYYY') as YEAR, TO_CHAR(NVL(ROUND(AVG(mark),2),'0.00'),'00.00') as average
FROM SHAREDSAMPLES.enrolment
GROUP BY semester, ofyear, unitcode
ORDER BY AVERAGE;
