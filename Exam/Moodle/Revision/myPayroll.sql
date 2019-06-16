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
select d.deptno,d.deptname, e.empjob, sum(nvl(e.empmsal,0)) as "total monthly salary"
from payroll.department d join payroll.employee e on d.deptno = e.deptno
group by d.deptno,d.deptname, e.empjob
order by d.deptno;

--13
select empname, empmsal
from payroll.employee
where empmsal > (select avg(empmsal) from payroll.employee)
order by empmsal asc;

--14
select deptno
from payroll.employee
group by deptno
having avg(empmsal) =
    (
    select max(avg(empmsal)) 
    from payroll.employee 
    group by deptno
    );

--15
select c.crscode, c.crsdesc, count(c.crscode)
from payroll.offering o join payroll.course c on o.crscode = c.crscode
group by c.crscode, c.crsdesc
having count(c.crscode) = (
    select max(count(crscode))
    from payroll.offering
    group by crscode
);

--16
select empname, empjob, empbdate
from payroll.employee
where
    empjob = (
        select empjob 
        from payroll.employee 
        where empname = 'SCOTT'
    ) and
    to_char(empbdate,'YYYY') = (
        select to_char(empbdate, 'YYYY')
        from payroll.employee
        where empname = 'SCOTT'
    ) and 
    empname != 'SCOTT'
order by empname;    

--17
--using the MINUS statement, which employees have never registered in a course
select empno
from payroll.employee
minus
select empno
from payroll.registration
group by empno;

--18
select distinct empno from payroll.registration
intersect
select distinct empno from payroll.offering;

select to_char(empbdate, 'day mm yyyy') from payroll.employee;

create table myvendor (
    name VARCHAR(50) NOT NULL UNIQUE,
    num  NUMBER(5,0) NOT NULL
);

alter table myvendor
add PRIMARY KEY (num);

insert into myvendor VALUES('ryan', 150);

commit;

create table product(
    prod_name VARCHAR(50) NOT NULL,
    num  NUMBER(5,0) NOT NULL,
    FOREIGN KEY (num) references myvendor
);

insert into product values('chicken soup', 30);

select * from product;
select * from myvendor;
select * from product, myvendor;
select * from product full outer join myvendor on product.num = myvendor.num;

create view test_view as
select *
from product;

select * from test_view;
update test_view
set prod_name = 'poodle'
where num = 30;

commit;

create table myproduct (
    prod_num    NUMBER(3,0) NOT NULL ,
    prod_name   VARCHAR(50) NOT NULL,
    prod_type   CHAR(1)     NOT NULL CHECK (prod_type IN ('F','D', 'O')),
    PRIMARY KEY(prod_num)
);

alter table myproduct
add vendor_num number(5,0);

alter table myproduct
add constraint v_p_fk
FOREIGN KEY (vendor_num)
REFERENCES myvendor(num);

alter table myproduct
drop column prod_type;

alter table myproduct
add prod_type CHAR(1);

alter table myproduct
add constraint prod_type_chk
check (prod_type = 'F' OR prod_type = 'D');

alter table myproduct
modify prod_type char(1) not null;

alter table myproduct
drop constraint prod_type_chk;


select * from SHAREDSAMPLES.enrolment;
select unitcode, max(mark)
from sharedsamples.enrolment
group by unitcode;

select count(mark), count(*)
from sharedsamples.enrolment;

select mark from sharedsamples.enrolment;

