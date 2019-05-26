-- Q1. Display the number of enrolments with a mark assigned, and the average mark for all enrolments

SELECT
    COUNT(mark) AS enrolwithmark,
    AVG(mark) AS averagemark
FROM
    uni.enrolment;

SELECT
    COUNT(mark) AS enrolwithmark,
    TO_CHAR(AVG(mark),'999.99') AS averagemark
FROM
    uni.enrolment;

-- Q2. Select the highest mark ever in any unit

SELECT
    MAX(mark)
FROM
    uni.enrolment;

--Q3. Select the highest mark ever for each unit (show the unit code only) 

SELECT
    unitcode,
    MAX(mark)
FROM
    uni.enrolment
GROUP BY
    unitcode
ORDER BY
    unitcode;

--Q4. For each student (show the id only), select the highest mark he/she ever received

SELECT
    studid,
    MAX(mark)
FROM
    uni.enrolment
GROUP BY
    studid
ORDER BY
    studid;

--Q5. For each unit, print unit code, unit name and the highest mark ever in that unit. Print the 
--    results in descending order of highest marks.

SELECT
    u.unitcode,
    u.unitname,
    MAX(mark) AS maximum_marks
FROM
    uni.unit u
    JOIN uni.enrolment e ON u.unitcode = e.unitcode
GROUP BY
    u.unitcode,
    u.unitname
ORDER BY
    MAX(mark) DESC;

-- Q6. For each offering of a unit with marks show the unit code, unitname, offering details and and 
--     average mark

SELECT
    e.unitcode,
    unitname,
    semester,
    ofyear,
    TO_CHAR(AVG(mark),'999.99')
FROM
    uni.enrolment e
    JOIN uni.unit u ON e.unitcode = u.unitcode
GROUP BY
    e.unitcode,
    unitname,
    semester,
    ofyear
ORDER BY
    unitcode;

SELECT
    e.unitcode,
    unitname,
    semester,
    ofyear,
    nvl(TO_CHAR(AVG(mark),'999.99'),'No Grades')
FROM
    uni.enrolment e
    JOIN uni.unit u ON e.unitcode = u.unitcode
GROUP BY
    e.unitcode,
    unitname,
    semester,
    ofyear
ORDER BY
    unitcode;

--Q7. For each student that is enrolled in at least 3 different units, print his/her name and average 
--    mark. Also, display the number of units he/she is enrolled in.

SELECT
    s.studid,
    studfname,
    studlname,
    COUNT(DISTINCT unitcode) AS num_units,
    round(AVG(mark),2) AS average_marks
FROM
    uni.student s
    JOIN uni.enrolment e ON e.studid = s.studid
GROUP BY
    s.studid,
    studfname,
    studlname
HAVING
    COUNT(DISTINCT unitcode) >= 3
ORDER BY
    studid;

--Q8. For each unit, count the total number of HDs */

SELECT
    unitcode,
    COUNT(grade) AS num_of_hds
FROM
    uni.enrolment
WHERE
    grade = 'HD'
GROUP BY
    unitcode
ORDER BY
    unitcode; 

--Q9. For each unit, print the total number of HDs, Ds, and Cs. The output should contain three 
--    columns named unitcode, grade_type, num where grade_type is HD, D or C and num is the number 
--    of students that obtained the grade.

SELECT
    unitcode,
    grade   AS grade_type,
    COUNT(*) AS num
FROM
    uni.enrolment
WHERE
    grade IN (
        'HD',
        'D',
        'C'
    )
GROUP BY
    unitcode,
    grade
ORDER BY
    unitcode,
    grade_type; 

--Q10. For each unit, print the student ids of the students who obtained maximum marks in that unit

SELECT
    unitcode,
    studid,
    mark
FROM
    uni.enrolment
WHERE
    ( unitcode,
      mark ) IN (
        SELECT
            unitcode,
            MAX(mark)
        FROM
            uni.enrolment
        GROUP BY
            unitcode
    )
ORDER BY
    unitcode,
    studid;
