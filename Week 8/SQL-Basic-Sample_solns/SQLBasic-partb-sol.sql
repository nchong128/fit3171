/* DML Part 1b Sample answers*/
/**/
SET ECHO ON

SPOOL sql_basic_partb.txt

/* 1.	List student name of all students who have marks in the range 
   of 60 to 70 */

SELECT
    studlname,
    studfname,
    mark
FROM
    uni.student s
    JOIN uni.enrolment e ON s.studid = e.studid
WHERE
    mark BETWEEN 60 AND 70
ORDER BY
    studfname,
    studlname,
    mark;

/* 2. List all the unit codes, semester and name of the chief examiner for all 
      the units that are offered in 2014.*/

SELECT
    o.unitcode,
    semester,
    stafffname,
    stafflname
FROM
    uni.offering o
    JOIN uni.staff s ON o.chiefexam = s.staffid
WHERE
    TO_CHAR(ofyear,'yyyy') = '2014'
ORDER BY
    o.unitcode,
    semester;

/* 3. List student name (firstname and surname), unit names, the year and 
      semester of enrolment of all units taken so far*/

SELECT
    studfname,
    studlname,
    unitname,
    TO_CHAR(e.ofyear,'yyyy') AS enrolyr,
    e.semester
FROM
    uni.student s
    JOIN uni.enrolment e ON s.studid = e.studid
    JOIN uni.offering o ON ( e.unitcode = o.unitcode
                             AND e.semester = o.semester
                             AND e.ofyear = o.ofyear )
    JOIN uni.unit u ON o.unitcode = u.unitcode
ORDER BY
    studfname,
    studlname,
    unitname,
    e.ofyear,
    semester;
  

/* 4. List all the unit codes and the unit names and their year and semester 
      offerings. */

SELECT
    u.unitcode,
    unitname,
    TO_CHAR(ofyear,'YYYY') AS offeringyr,
    semester
FROM
    uni.unit u
    JOIN uni.offering o ON u.unitcode = o.unitcode
ORDER BY
    unitcode,
    offeringyr,
    semester;
  

/* 5. List the unit code, semester, class type (lecture or tutorial), 
      day and time for all units taught by Albus Dumbledore in 2013. 
      Sort the list according to the unit code.*/

SELECT
    unitcode,
    semester,
    cltype,
    clday,
    TO_CHAR(cltime,'HHAM') AS time
FROM
    uni.staff s
    JOIN uni.schedclass sc ON s.staffid = sc.staffid
WHERE
    TO_CHAR(ofyear,'yyyy') = '2013'
    AND stafffname = 'Albus'
    AND stafflname = 'Dumbledore'
ORDER BY
    unitcode,
    semester,
    cltype,
    clday,
    cltime;

/* OR*/

SELECT
    unitcode,
    semester,
    cltype,
    clday,
    TO_CHAR(cltime,'HHAM') AS time
FROM
    uni.staff s
    JOIN uni.schedclass sc ON s.staffid = sc.staffid
WHERE
    EXTRACT(YEAR FROM ofyear) = '2013'
    AND stafffname = 'Albus'
    AND stafflname = 'Dumbledore'
ORDER BY
    unitcode,
    semester,
    cltype,
    clday,
    cltime;

/* 6. Create a study statement for Mary Smith. A study statement contains 
      unit code, unit name, semester and year study was attempted, the mark 
      and grade. */

SELECT
    e.unitcode,
    unitname,
    semester,
    TO_CHAR(ofyear,'yyyy') AS "YEAR OF ENROLMENT",
    mark,
    grade
FROM
    uni.student s
    JOIN uni.enrolment e ON s.studid = e.studid
    JOIN uni.unit u ON e.unitcode = u.unitcode
WHERE
    studfname = 'Mary'
    AND studlname = 'Smith'
ORDER BY
    "YEAR OF ENROLMENT",
    semester,
    unitcode;

/* 7. List the unit code, unit name and the unit code and unit name of the 
      pre-requisite units of all units in the database. */

SELECT
    u1.unitcode,
    u1.unitname,
    has_prereq_of   AS prereq_unitcode,
    u2.unitname     AS prereq_unitname
FROM
    uni.unit u1
    JOIN uni.prereq p ON u1.unitcode = p.unitcode
    JOIN uni.unit u2 ON u2.unitcode = p.has_prereq_of
ORDER BY
    unitcode,
    prereq_unitcode;

/* 8. List the unit code and unit name of the pre-requisite units of 
      'Advanced Data Management' unit */

SELECT
    has_prereq_of   AS prereq_unitcode,
    u2.unitname     AS prereq_unitname
FROM
    uni.unit u1
    JOIN uni.prereq p ON u1.unitcode = p.unitcode
    JOIN uni.unit u2 ON u2.unitcode = p.has_prereq_of
WHERE
    u1.unitname = 'Advanced Data Management'
ORDER BY
    prereq_unitcode;

/* 9. Find all students (list their id, firstname and surname) who 
       have a failed unit in the year 2013 */

SELECT DISTINCT
    s.studid,
    studlname,
    studfname
FROM
    uni.student s
    JOIN uni.enrolment e ON s.studid = e.studid
WHERE
    mark < 50
    AND TO_CHAR(ofyear,'yyyy') = '2013'
ORDER BY
    s.studid;
  
/* OR*/

SELECT DISTINCT
    s.studid,
    studlname,
    studfname
FROM
    uni.student s
    JOIN uni.enrolment e ON s.studid = e.studid
WHERE
    mark < 50
    AND EXTRACT(YEAR FROM ofyear) = '2013'
ORDER BY
    s.studid;

/* 10.	List the student name, unit code, semester and year for those 
        students who do not have marks recorded */

SELECT
    s.studid,
    studfname,
    studlname,
    TO_CHAR(ofyear,'yyyy') AS "YEAR OF ENROLMENT",
    semester,
    e.unitcode
FROM
    uni.student s
    JOIN uni.enrolment e ON s.studid = e.studid
WHERE
    mark IS NULL;

SPOOL OFF

SET ECHO OFF
