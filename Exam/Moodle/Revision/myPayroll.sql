----PART A
--1
select empno, empname, empmsal
from payroll.employee
where empmsal < 1000
order by empmsal;

--2
select deptno
from payroll.employee
group by deptno
order by deptno asc;

--3
select *
from payroll.employee
where empjob = 'TRAINER' and deptno = 20 and empmsal < 2500
order by empname;

--4
select empname as name, empjob as job, empmsal as monthly_salary, empcomm as commission
from payroll.employee
where empmsal > empcomm;

--5
select *
from payroll.employee
where empjob like '%R'
order by empname;

--6
select *
from payroll.employee
where
    empname like 'J%' or
    empname like 'K%' or
    empname like 'M%';

--7
select * 
from payroll.employee
where to_char(empbdate, 'YYYY') < 1960 and empmsal > 1500;

--8
select * 
from payroll.employee
where empcomm is null;

--9
select e.empname, e.empjob, d.deptname, d.deptlocation, e.empmsal
from payroll.employee e join payroll.department d on
e.deptno = d.deptno
where d.deptlocation = 'NEW YORK';

--10
select e.empname as "Employee Name", e.empjob as "Job"
from payroll.employee e join payroll.department d on e.deptno = d.deptno
where d.deptlocation not in ('NEW YORK', 'CHICAGO');

--11
select *
from payroll.employee
where to_char(empbdate,'YYYY') between 1960 and 1964
order by empbdate;

--12
select *
from payroll.employee
where empmsal < 1500 or empmsal > 3000
order by empname;

--13
select *
from payroll.employee
where mgrno is not null
order by empname;

--14
select *
from payroll.employee e join payroll.department d on e.deptno = d.deptno
where (d.deptlocation = 'DALLAS' or e.empjob = 'MANAGER') and e.empmsal > 2500
order by e.empname;

--15

select
    empname,
    empjob, 
    empmsal,
    (select salgrade
    from payroll.salgrade 
    where sallower <= empmsal
    and salupper >= empmsal) as salgrade
from payroll.employee
order by salgrade, empmsal;

--OR
select 
    e.empname,
    e.empjob, 
    e.empmsal,
    s.salgrade
from payroll.employee e join payroll.salgrade s on
    e.empmsal between s.sallower and s.salupper;

--16
select d.deptname, d.deptlocation, e.empname
from payroll.department d left outer join payroll.employee e on d.deptno = e.deptno
order by d.deptname, e.empname;

--17
select e.empname, e.empjob, m.empname as manager_name
from payroll.employee e join payroll.employee m on e.mgrno = m.empno
order by m.empname, e.empname;

--18
select
    e.empname,
    d.deptname, 
    to_char(h.histbegindate, 'DD-Mon-YYYY') as begin_date, 
    to_char(h.histenddate, 'DD-Mon-YYYY') as end_date, 
    h.histmsal
from
    (payroll.employee e
        join payroll.history h on e.empno = h.empno)
    join payroll.department d on d.deptno = h.deptno
order by e.empname, h.histbegindate desc;

--19
select empname as "Employee Name", empjob, empmsal, (empmsal * 12) as "Annual Salary"
from payroll.employee
order by empname;

--20
select 
    empname, 
    empjob, 
    empmsal, 
    empcomm, 
    (empmsal * 12 + nvl(empcomm,0)) as annual_income
from payroll.employee
order by empname;


----PART B
--1
select empname, 12*empmsal as annual_salary, 12*empmsal*1.1 as raised_sal 
from payroll.employee
order by empname;

--2
select 
    empname, 
    to_char(empbdate, 'DD-Mon-YYYY') as birthdate, 
    floor(months_between(sysdate, empbdate) / 12) as age
from payroll.employee
order by empname;

--3

select empname, empjob, (empmsal + nvl(empcomm, 0)) * 12 as annual_sal
from payroll.employee
order by empname;

--4
select 'EMPLOYEE ' || e.empinit || '.' || initcap(e.empname) || ' IS A ' || initcap(e.empjob) ||
    ' AND WORKS IN THE ' || initcap(d.deptname) || ' DEPARTMENT' as statement
from payroll.employee e join payroll.department d on e.deptno = d.deptno;

--5
select empname, empbdate, floor(months_between(sysdate, empbdate))
from payroll.employee
order by empname;


--6
select empname, to_char(empbdate, 'DD-MM-YYYY') as bday
from payroll.employee
where to_char(empbdate, 'MON') = 'FEB';

--7
select empname, empmsal ,empcomm
from payroll.employee
where greatest(empcomm, empmsal) = empcomm;

--8
select
'EMPLOYEE '
|| empinit 
|| '.' 
|| initcap(empname)
|| ' was born on '
|| rtrim(to_char(empbdate, 'Day'))
|| ' the '
|| to_char(empbdate, 'dd')
|| ' of '
|| rtrim(upper(to_char(empbdate, 'Month')))
|| ', '
|| extract(year from empbdate) as statement
from payroll.employee;

--9
select e.empno, e.empname, count(*)
from payroll.employee e join payroll.registration r on e.empno = r.empno
group by e.empno, e.empname;

--10
select empno, empname
from payroll.employee
where empbdate = (select min(empbdate) from payroll.employee);

--11
select d.deptno, d.deptname, count(e.empno) as "NbrOfEmployees" , min(e.empmsal) as "MinSalary" ,max(e.empmsal) as "MaxSalary" , sum(e.empmsal) as "TotalSalary",
round(avg(e.empmsal),2) as "AvgSalary"
from payroll.department d left outer join payroll.employee e on d.deptno = e.deptno
group by d.deptno, d.deptname;

--12
--13
--14
--15
--16
--17
--18