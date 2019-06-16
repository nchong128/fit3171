--
-- PART B PAYROLL REVISION

-- Q1. Display all employees, their current annual salary (not including commission) 
-- and what their annual salary would be if they were given a 10% pay rise.
SELECT
    empno,
    empname,
    empjob,
    empmsal,
    empmsal * 12 AS annual_salary,
    empmsal * 12 * 1.1 AS ann_sal_with_rise
FROM
    payroll.employee
ORDER BY empno;

-- Q2. Display the name of all employees, their birthdate and their age in years.
SELECT
    empname,
    TO_CHAR(empbdate,'DD-Mon-YYYY') AS birthdate,
    floor(months_between(SYSDATE,empbdate) / 12) AS "Age in Yrs"
FROM
    payroll.employee
ORDER BY empname;

--Q3. Display all employees, their job and their current annual salary (including commission).
SELECT
    empno,
    empname,
    empjob,
    empmsal,
    empcomm,
    ( empmsal + nvl(empcomm,0) ) * 12 AS total_salary
FROM
    payroll.employee
ORDER BY empno;

--Q4. Display all employees’ details in the following format: EMPLOYEE N. Smith IS A Trainer AND WORKS IN THE Training DEPARTMENT.
SELECT
    'EMPLOYEE '
     || empinit
     || '. '
     || initcap(empname)
     || ' IS A '
     || initcap(empjob)
     || ' AND WORKS IN THE '
     || initcap(deptname)
     || ' DEPARTMENT.'
FROM
    payroll.employee e
    JOIN payroll.department d ON (
        e.deptno = d.deptno
    )
ORDER BY empname;

--Q5. Display the name of all employees, their birthdate and their age in months.
SELECT
    empname,
    TO_CHAR(empbdate,'dd-Mon-yyyy') AS birthdate,
    round(
        months_between(SYSDATE,empbdate),
        1
    ) AS age_in_months
FROM
    payroll.employee
ORDER BY empname;

--Q6. Display the employees who were born in February.
SELECT
    empname,
    TO_CHAR(empbdate,'dd-Mon-yyyy') AS birthdate
FROM
    payroll.employee
WHERE
    EXTRACT(MONTH FROM empbdate) = 2
ORDER BY empname;

--Q7. Display the employees (using the GREATEST function) who earn more commission than their monthly salary.
SELECT
    empname,
    empmsal,
    empcomm
FROM
    payroll.employee
WHERE
    empcomm = greatest(empcomm,empmsal)
ORDER BY empname;

--Q8. Display the name of all employees and their birthdate in the following format: 
-- EMPLOYEE N. Smith was born on FRIDAY the 17 of DECEMBER , 1965
SELECT
    'EMPLOYEE '
     || empinit
     || '. '
     || initcap(empname)
     || ' was born on '
     || rtrim(TO_CHAR(empbdate,'DAY') )
     || ' the '
     || EXTRACT(DAY FROM empbdate)
     || ' of '
     || rtrim(TO_CHAR(empbdate,'MONTH') )
     || ','
     || EXTRACT(YEAR FROM empbdate)
FROM
    payroll.employee
ORDER BY empname;

--Q9. Display the name of the employees who have registered for a course and the 
-- number of times they have registered.
SELECT
    e.empno,
    e.empname,
    COUNT(*) AS nbr_registrations
FROM
    payroll.employee e
    JOIN payroll.registration r ON (
        e.empno = r.empno
    )
GROUP BY
    e.empno,
    e.empname
ORDER BY empname;

--Q10. Who is the oldest employee?
SELECT
    empno,
    empname,
    TO_CHAR(empbdate,'DD-Mon-YYYY')
FROM
    payroll.employee
WHERE
    empbdate = (
        SELECT
            MIN(empbdate)
        FROM
            payroll.employee
    )
ORDER BY empname;

--Q11. For each department list the department number and name, the number of employees, 
-- the minimum and maximum monthly salary, the total monthly salary and the average salary
-- paid to their employees. Name the columns: NbrOfEmployees, MinSalary, MaxSalary, TotalSalary, AvgSalary
SELECT
    d.deptno,
    d.deptname,
    COUNT(e.empno) "NbrOfEmployees",
    MIN(empmsal) "MinSalary",
    MAX(empmsal) "MaxSalary",
    SUM(empmsal) "TotalSalary",
    round(AVG(empmsal),2) "AvgSalary"
FROM
    payroll.employee e
    RIGHT OUTER JOIN payroll.department d ON (
        e.deptno = d.deptno
    )
GROUP BY
    d.deptno,
    d.deptname
ORDER BY deptno;

--Q12. Display the jobs in each department and the total monthly salary paid for each job.
SELECT
    deptno,
    empjob,
    SUM(empmsal)
FROM
    payroll.employee
GROUP BY
    deptno,
    empjob
ORDER BY deptno,empjob;



--Q13. Which employee earns more than the average salary?
SELECT
    empno,
    empname,
    empmsal
FROM
    payroll.employee
WHERE
    empmsal > (
        SELECT
            AVG(empmsal)
        FROM
            payroll.employee
    )
ORDER BY empno;

--Q14. Which department has the greatest average monthly salary?
SELECT
    d.deptno,
    d.deptname,
    round(AVG(empmsal),2) "AvgSalary"
FROM
    payroll.employee e
    JOIN payroll.department d ON (
        e.deptno = d.deptno
    )
GROUP BY
    d.deptno,
    d.deptname
HAVING
    AVG(empmsal) = (
        SELECT
            MAX(AVG(empmsal) )
        FROM
            payroll.employee
        GROUP BY
            deptno
    )
ORDER BY deptno;

--Q15. Which course has the most offerings?
SELECT
    c.crscode,
    c.crsdesc,
    COUNT(*) "NbrOfferings"
FROM
    payroll.course c
    JOIN payroll.offering o ON (
        c.crscode = o.crscode
    )
GROUP BY
    c.crscode,
    c.crsdesc
HAVING
    COUNT(*) = (
        SELECT
            MAX(COUNT(*) )
        FROM
            payroll.offering
        GROUP BY
            crscode
    )
ORDER BY crscode;

--Q16. Display the name of employees who perform the same job as SCOTT and were 
-- born in the same year. Do not include SCOTT in the output.
SELECT
    e.empname,
    e.empjob,
    TO_CHAR(empbdate,'dd-Mon-yyyy')
FROM
    payroll.employee e
WHERE
        ( e.empjob,EXTRACT(YEAR FROM empbdate) ) = (
            SELECT
                e.empjob,
                EXTRACT(YEAR FROM empbdate)
            FROM
                payroll.employee e
            WHERE
                empname = 'SCOTT'
        )
    AND
        e.empname <> 'SCOTT'
ORDER BY empname;

--Q17. Using the MINUS statement, which employees have never registered in a course.
SELECT
    empno
FROM
    payroll.employee
MINUS
SELECT DISTINCT
    empno
FROM
    payroll.registration
ORDER BY empno;

--Q18. Using the INTERSECT statement, which employees have both registered for 
-- and conducted courses.
SELECT DISTINCT
    empno AS "TrainerAndStudent"
FROM
    payroll.offering
INTERSECT SELECT DISTINCT
    empno
FROM
    payroll.registration
ORDER BY "TrainerAndStudent";
