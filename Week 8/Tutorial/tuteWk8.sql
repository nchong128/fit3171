select *
from SHAREDSAMPLES.student;

select *
from SHAREDSAMPLES.unit;

select *
from SHAREDSAMPLES.student
where studlname = 'Smith';

select studfname as firstname, studlname as lastname
from SHAREDSAMPLES.student
where studlname like 'S%';

select studfname, studlname, studaddress
from SHAREDSAMPLES.student
where studlname like 'S%' and studfname like '%i%';

select unitcode, ofyear
from SHAREDSAMPLES.offering
where to_char(ofyear, 'yyyy') = '2014';

select unitcode
from SHAREDSAMPLES.offering
where to_char(ofyear, 'yyyy') = '2014' and semester = 1;

select unitcode, unitname, unitdesc
from SHAREDSAMPLES.unit
where unitcode like 'FIT1%';

select unitcode,semester
from SHAREDSAMPLES.offering
where (semester = 1) or (semester = 3 and to_char(ofyear,'yyyy') = '2013');

select studid, mark, unitcode, semester
from SHAREDSAMPLES.enrolment
where to_char(ofyear,'yyyy') = 'f' and semester = 1 and mark >= 50;

--Part B
select SHAREDSAMPLES.student.studfname, SHAREDSAMPLES.student.studlname
from SHAREDSAMPLES.enrolment join SHAREDSAMPLES.student
on SHAREDSAMPLES.enrolment.studid = SHAREDSAMPLES.student.studid;

select SHAREDSAMPLES.staff.stafffname, SHAREDSAMPLES.staff.stafflname, SHAREDSAMPLES.offering.unitcode, SHAREDSAMPLES.offering.semester
from SHAREDSAMPLES.offering join SHAREDSAMPLES.staff
on SHAREDSAMPLES.offering.chiefexam = SHAREDSAMPLES.staff.staffid;

select s.studfname as firstname,
    s.studlname as lastname,
    e.unitcode,
    o.ofyear as year,
    o.semester
from SHAREDSAMPLES.student s
join SHAREDSAMPLES.enrolment e on s.studid = e.studid
join SHAREDSAMPLES.offering o on (e.unitcode = o.unitcode and
                                    e.semester = o.semester and
                                    e.ofyear = o.ofyear)
join SHAREDSAMPLES.unit u on o.unitcode = u.unitcode
order by s.studfname, s.studlname;

--List all the unit codes and the unit names and their year and semester offerings.
select 
    unit.unitcode,
    unit.unitname,
    to_char(offering.ofyear, 'yyyy') as year,
    offering.semester as sem
from SHAREDSAMPLES.unit join SHAREDSAMPLES.offering
on SHAREDSAMPLES.unit.unitcode = SHAREDSAMPLES.offering.unitcode
order by unit.unitcode, sem;

--List the unit code, semester, class type (lecture or tutorial),
--day and time for all units taught by Albus Dumbledore in 2013.
--Sort the list according to the unit code.
select sc.unitcode, sc.semester, sc.cltype as type, sc.clday as day, sc.cltime as time
from SHAREDSAMPLES.staff s
    join SHAREDSAMPLES.schedclass sc on s.staffid = sc.staffid
where s.stafffname = 'Albus' and s.stafflname = 'Dumbledore' and to_char(sc.ofyear, 'yyyy') = '2013';    

--Create a study statement for Mary Smith. A study statement contains unit code
--unit name, semester and year study was attempted, the mark and grade.
select
    o.unitcode,
    u.unitname,
    o.semester, 
    to_char(o.ofyear, 'yyyy') as year,
    e.mark, 
    e.grade
from SHAREDSAMPLES.student s
join SHAREDSAMPLES.enrolment e on s.studid = e.studid
join SHAREDSAMPLES.offering o on (e.unitcode = o.unitcode and
                                    e.semester = o.semester and
                                    e.ofyear = o.ofyear)
join SHAREDSAMPLES.unit u on o.unitcode = u.unitcode
where s.studfname = 'Mary' and s.studlname = 'Smith'
order by year;
    
--List the unit code, unit name and the unit code and unit name of the
--pre-requisite units of all units in the database.
select u.unitcode, u.unitname, pr.has_prereq_of as pre_unitcode, u2.unitname as pre_unitname
from SHAREDSAMPLES.unit u
    join SHAREDSAMPLES.prereq pr on (u.unitcode = pr.unitcode)
    join SHAREDSAMPLES.unit u2 on (u2.unitcode = pr.has_prereq_of);
    
--List the unit code and unit name of the pre-requisite units of ‘Advanced Data Management’ unit.
select u2.unitcode, u2.unitname
from SHAREDSAMPLES.unit u
    join SHAREDSAMPLES.prereq pr on (u.unitcode = pr.unitcode)
    join SHAREDSAMPLES.unit u2 on (u2.unitcode = pr.has_prereq_of)
where u.unitname = 'Advanced Data Management';    

--Find all students (list their id, firstname and surname) who have a failed unit in the year 2013.
-- dOUBT??!?!
select s.studid, s.studfname, s.studlname
from SHAREDSAMPLES.student s
    join SHAREDSAMPLES.enrolment e on s.studid = e.studid
where grade = 'N' ;    

--List the student name, unit code, semester and year for those students who do not have marks recorded