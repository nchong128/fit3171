/* DML Part 1a Sample answers*/
/**/
SET ECHO ON

SPOOL sql_basic_parta.txt

/* 1. List all tudents and their details. */

SELECT
    *
FROM
    uni.student
ORDER BY
    studid;

/* 2. List ALL units AND their details. */

SELECT
    *
FROM
    uni.unit
ORDER BY
    unitcode;

/* 3. List all students who have the surname 'Smith'.*/

SELECT
    *
FROM
    uni.student
WHERE
    studlname = 'Smith'
ORDER BY
    studid;

/* 4. List the student's details for those students who have surname starts with the letter 'S'.*/

SELECT
    studid,
    studfname   AS firstname,
    studlname   AS lastname,
    studdob,
    studaddress,
    studphone,
    studemail
FROM
    uni.student
WHERE
    studlname LIKE 'S%'
ORDER BY
    studid;

/* 5. List the student's surname, firstname and address for those students who have surname
starts with the letter 'S' and firstname contains the letter 'i'.*/

SELECT
    *
FROM
    uni.student
WHERE
    studlname LIKE 'S%'
    AND studfname LIKE '%i%'
ORDER BY
    studid;

/* 6. List the unit code and semester of all units that are offered in the year 2014. */

SELECT
    unitcode,
    semester
FROM
    uni.offering
WHERE
    TO_CHAR(ofyear,'yyyy') = '2014'
ORDER BY
    unitcode,
    semester;
  
/* OR*/

SELECT
    unitcode,
    semester
FROM
    uni.offering
WHERE
    EXTRACT(YEAR FROM ofyear) = 2014
ORDER BY
    unitcode,
    semester;

/* 7. List the unit code of all units that are offered in semester 1 of 2014. */

SELECT
    unitcode
FROM
    uni.offering
WHERE
    TO_CHAR(ofyear,'yyyy') = '2014'
    AND semester = 1
ORDER BY
    unitcode;

/* OR */

SELECT
    unitcode
FROM
    uni.offering
WHERE
    EXTRACT(YEAR FROM ofyear) = '2014'
    AND semester = 1
ORDER BY
    unitcode;
  
  
  
/* 8. Assuming that a unit code is created based on the following rules:
a. The first three letters represent faculty abbreviation, eg FIT for the Faculty of Information Technology.
b. The first digit of the number following the letter represents the year level.
List the unit details of all first year units in the Faculty of Information Technology.*/

SELECT
    *
FROM
    uni.unit
WHERE
    unitcode LIKE 'FIT1%'
ORDER BY
    unitcode;

/* 9. List the unit code and semester of all units that were offered in either semester 1 or summer of 2013.*/

SELECT
    unitcode,
    semester
FROM
    uni.offering
WHERE
    semester IN (
        1,
        3
    )
    AND TO_CHAR(ofyear,'yyyy') = '2013'
ORDER BY
    unitcode,
    semester;

/* alternative solution */

SELECT
    unitcode,
    semester
FROM
    uni.offering
WHERE
    ( semester = 1
      OR semester = 3 )
    AND TO_CHAR(ofyear,'yyyy') = '2013'
ORDER BY
    unitcode,
    semester;

/* 10. List the student number, mark, unit code and semester for those tudents who have passed any unit in semester 1 of 2013. */

SELECT
    studid,
    mark,
    unitcode,
    semester
FROM
    uni.enrolment
WHERE
    mark > 49
    AND semester = 1
    AND TO_CHAR(ofyear,'yyyy') = '2013'
ORDER BY
    studid,
    unitcode;
  
/* OR*/

SELECT
    studid,
    mark,
    unitcode,
    semester
FROM
    uni.enrolment
WHERE
    mark > 49
    AND semester = 1
    AND EXTRACT(YEAR FROM ofyear) = '2013'
ORDER BY
    studid,
    unitcode;
  
/* OR*/

SELECT
    studid,
    mark,
    unitcode,
    semester
FROM
    uni.enrolment
WHERE
    grade <> 'N'
    AND semester = 1
    AND TO_CHAR(ofyear,'yyyy') = '2013'
ORDER BY
    studid,
    unitcode;

SPOOL OFF

SET ECHO OFF