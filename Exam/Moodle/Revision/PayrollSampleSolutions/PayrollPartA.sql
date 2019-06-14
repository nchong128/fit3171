--
-- PART A PAYROLL REVISION

-- Q1. Display the employees who earn less than $1000.
SELECT
    *
FROM
    payroll.employee
WHERE
    empmsal < 1000
ORDER BY empno;
--        
-- Q2. List the department number of departments that have employees.

SELECT DISTINCT
    deptno
FROM
    payroll.employee
ORDER BY deptno;
--
-- Q3. Display the trainers who earn less than 2500 each month and are working in department 20.

SELECT
    *
FROM
    payroll.employee
WHERE
        empjob = 'TRAINER'
    AND
        empmsal < 2500
    AND
        deptno = 20
ORDER BY empno;
--
-- Q4. Display the name,job,monthly salary and commission of employees whose monthly salary is higher 
-- than their commission. Rename the columns: Name,Job,Monthly Salary and Commission.

SELECT
    empname AS "Name",
    empjob AS "Job",
    empmsal AS "Monthly Salary",
    empcomm AS "Commission"
FROM
    payroll.employee
WHERE
    empmsal > empcomm
ORDER BY empname;
-- as an alternative NVL(empcomm,0) could be used here although it does not alter the output
--
-- Q5. Display the employees whose job ends with the letter R.

SELECT
    empname,
    empjob
FROM
    payroll.employee
WHERE
    empjob LIKE '%R'
ORDER BY empname;
--
-- Q6. Display the employees that have a name starting with 'J','K' or 'M'.

SELECT
    empname,
    empjob
FROM
    payroll.employee
WHERE
        empname LIKE 'J%'
    OR
        empname LIKE 'K%'
    OR
        empname LIKE 'M%'
ORDER BY empname;
--
-- Q7. Display the employees who were born before 1970 and earn more than 1500 each month.
-- Question listed 1960 it should have been 1970

SELECT
    empname,
    empjob,
    to_char(empbdate,'Dd-Mon-YYYY') as BIRTHDATE,
    empmsal
FROM
    payroll.employee
WHERE
        empbdate < TO_DATE('01-JAN-1970','dd-MON-YYYY')
    AND
        empmsal > 1500
ORDER BY empname;
--
-- Q8. Display the employees that don't have a commission.

SELECT
    empname,
    empjob,
    to_char(empbdate,'Dd-Mon-YYYY') as BIRTHDATE,
    empmsal,
    empcomm
FROM
    payroll.employee
WHERE
    empcomm IS NULL
ORDER BY empname;
--
-- Q9. Display the employee name,job,department name,location and monthly salary of employees that work in New York.

SELECT
    e.empname,
    e.empjob,
    d.deptname,
    d.deptlocation,
    e.empmsal
FROM
    payroll.employee e join payroll.department d on e.deptno = d.deptno
WHERE
    d.deptlocation = 'NEW YORK'
ORDER BY e.empname;

--
-- Q10. Display the name and job of employees who do not work in New York or Chicago.

SELECT
    e.empname,
    e.empjob,
    d.deptname,
    d.deptlocation
FROM
    payroll.employee e join payroll.department d on e.deptno = d.deptno
WHERE
        d.deptlocation NOT IN (
            'NEW YORK','CHICAGO'
        )
ORDER BY e.empname;
--
-- Q11. Display the employees who were born in the first half of the 60s. Display the output in birth date order.

SELECT
    empname,
    empjob,
    to_char(empbdate,'Dd-Mon-YYYY') as BIRTHDATE,
    empmsal
FROM
    payroll.employee
WHERE
    empbdate BETWEEN TO_DATE('01-JAN-1960','DD-MON-YYYY') AND TO_DATE('31-DEC-1964','DD-MON-YYYY')
ORDER BY empbdate;
--
-- Q12. Display the employees who earn less than 1500 or greater than 3000 per month.

SELECT
    empname,
    empjob,
    empmsal
FROM
    payroll.employee
WHERE
    empmsal NOT BETWEEN 1500 AND 3000
ORDER BY empname;
--
-- Q13. Display the employees who have a manager.

SELECT
    empname,
    empjob,
    mgrno
FROM
    payroll.employee
WHERE
    mgrno IS NOT NULL
ORDER BY empname;
--
-- Q14. Display the employees who either work in Dallas or as a manager,and earn more than 2500.

SELECT
    e.empname,
    e.empjob,
    d.deptname,
    d.deptlocation,
    e.empmsal
FROM
    payroll.employee e
    JOIN payroll.department d ON (
        e.deptno = d.deptno
    )
WHERE
    (
            d.deptlocation = 'DALLAS'
        OR
            e.empjob = 'MANAGER'
    ) AND
        e.empmsal > 2500
ORDER BY e.empname;
--
-- Q15. Display the name,job,monthly salary and salary grade of all employees. Display 
-- the list in monthly salary order within salary grade order.

SELECT
    e.empname,
    e.empjob,
    e.empmsal,
    s.salgrade
FROM
    payroll.employee e,
    payroll.salgrade s
WHERE
    e.empmsal BETWEEN s.sallower AND s.salupper
ORDER BY
    s.salgrade,
    e.empmsal;
-- OR    

SELECT
    e.empname,
    e.empjob,
    e.empmsal,
    s.salgrade
FROM
    payroll.employee e
    JOIN payroll.salgrade s ON (
        e.empmsal BETWEEN s.sallower AND s.salupper
    )
ORDER BY
    s.salgrade,
    e.empmsal;

--
-- Q16. Display the name and location of all departments,and the name of their employees. 
-- Display the output in employee name order within department name order.

SELECT
    d.deptname,
    d.deptlocation,
    e.empname
FROM
    payroll.employee e
    RIGHT OUTER JOIN payroll.department d ON (
        e.deptno = d.deptno
    )
ORDER BY
    d.deptname,
    e.empname;
--
-- Q17. Display the name of all employees,their job and the name of their manager. 
-- List the output in employee name order within manager name order.

SELECT
    e.empname "Employee",
    e.empjob AS "Emp Job",
    m.empname AS "Manager"
FROM
    payroll.employee e
    LEFT OUTER JOIN payroll.employee m ON (
        e.mgrno = m.empno
    )
ORDER BY
    m.empname,
    e.empname;
-- here NVL(m.empname,'NA') could be used to display a value rather than leave the 
-- managers name null for the director
--
-- Q18. For each employee display their employment history. In the listing include 
-- the employees' name,the name of the department they worked for,the begin and end 
-- date and their monthly salary. Display the output in begin date order (most recent at the 
-- top of the list) within employee name order.

SELECT
    e.empname,
    d.deptname,
    to_char(histbegindate,'DD-Mon-YYY') as HISTBEGIN,
    to_char(histenddate,'Dd-Mon-YYYY') as HISTEND,
    h.histmsal
FROM
    payroll.employee e
    JOIN payroll.history h ON (
        e.empno = h.empno
    )
    JOIN payroll.department d ON (
        d.deptno = h.deptno
    )
ORDER BY
    e.empname,
    h.histbegindate DESC;
--
-- Q19. Display the employee name,empjob,monthly salary and annual salary of all employees.

SELECT
    empname,
    empjob,
    empmsal,
    empmsal * 12 AS "Annual Salary"
FROM
    payroll.employee
ORDER BY empname;
--
-- Q20. Display the employee name,empjob,monthly salary,empcommission and annual income 
-- (salary and empcommission) of all employees.

SELECT
    empname,
    empjob,
    empmsal,
    empcomm,
    empmsal * 12 + nvl(empcomm,0) AS "Annual Income"
FROM
    payroll.employee
ORDER BY empname;
