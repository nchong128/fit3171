/* 1.	Find the maximum mark for FIT1004 in semester 1, 2013.*/

select
  max(mark)
from
  SHAREDSAMPLES.enrolment
where
  unitcode='FIT1004'
  and
  semester = 1
  and
  to_char(ofyear,'YYYY')= '2013';

/* 2.	Find the average mark of FIT1040 in semester 2, 2013.*/

select
  avg(mark)
from
  SHAREDSAMPLES.enrolment
where
  unitcode='FIT1040'
  and
  semester = 2
  and
  to_char(ofyear,'YYYY')= '2013';

-- the ROUND function can be used with AVG function to limit the
-- number of digits after the decimal point.

select
  round(avg(mark),1) as rounded_avg_mark
from
  SHAREDSAMPLES.enrolment
where
  unitcode='FIT1040'
  and
  semester = 2
  and
  to_char(ofyear,'YYYY')= '2013';


/* 3.	List the average mark for each offering of FIT1040.  In the listing, 
      you need to include the year and semester number. Sort the result 
      according to the year. */

select
  to_char(ofyear,'YYYY') as "YEAR of OFFER",
  semester,
  round(avg(mark),1) as avg_mark
from
  SHAREDSAMPLES.enrolment
where
  unitcode='FIT1040'
group by
  ofyear,
  semester
order by
  ofyear,
  semester;


/* 4a.	Find the number of students enrolled in the unit FIT1040 in the year 
        2013. Count a repeat student TWICE here. */

select
  count(studid) as student_count
from
  SHAREDSAMPLES.enrolment
where
  unitcode='FIT1040'
  and
  to_char(ofyear,'YYYY')= '2013';


/* 4b.	Find the number of students enrolled in the unit FIT1040 in the year 
        2013. Count a repeat student ONCE. */

select
  count(distinct studid) as student_count
from
  SHAREDSAMPLES.enrolment
where
  unitcode='FIT1040'
  and
  to_char(ofyear,'YYYY')= '2013';


/* 5.	Find the total number of enrolments per semester for each unit in the 
      year 2013. The list should also include the unitcode, semester and year. 
      Order the list in the increasing order of enrolment number.*/

select
  unitcode,
  to_char(ofyear,'YYYY') as "YEAR of OFFER",
  semester,
  count(studid) as total
from
  SHAREDSAMPLES.enrolment
where
  to_char(ofyear,'YYYY')= '2013'
group by
  unitcode,
  ofyear,
  semester
order by
  total;


/* 6.	Find the total number of prerequisite units for FIT2077. */

select
  count(has_prereq_of) as no_prereqs
from
  SHAREDSAMPLES.prereq
where
  unitcode='FIT2077';


/* 7.	Find the total number of prerequisite units for each unit. 
      In the list, include the unitcode for which the count is applicable. */

select
  unitcode,
  count(has_prereq_of) as no_prereqs
from
  SHAREDSAMPLES.prereq
group by
  unitcode
order by
  unitcode;


/*8.	For each pre-requisite unit, calculate how many times it has been 
      used as prerequisite. Include the name of the prerequisite unit in 
      the listing. */

select
  has_prereq_of as unitcode,
  u.unitname,
  count(u.unitcode) as no_times_used
from
  SHAREDSAMPLES.prereq p
  join
  SHAREDSAMPLES.unit u
  on  
  u.unitcode = has_prereq_of
group by
  has_prereq_of,
  u.unitname
order by
  unitcode;


/*9.  Find the unit with the highest number of enrolments in a given 
      offering in the year 2013. 
      
      Note year has been included in the output here to make it more
      informative */

select
  unitcode, 
  to_char(ofyear,'YYYY') as year, 
  semester,
  count(studid) as student_count
from
  SHAREDSAMPLES.enrolment
group by
  unitcode,
  ofyear,
  semester
having
  count(studid) =
  (
    select
      max(count (studid))
    from
      SHAREDSAMPLES.enrolment
    group by
      unitcode,
      ofyear,
      semester
    having
      to_char(ofyear,'YYYY')= '2013'
  )
order by
  unitcode;

/*10. Who is the oldest student in FIT1004 throughout the whole history 
      of the offering? Display the student full name and the date of birth.
      Making use of Oracle concatenate operator || here */

select
  studfname
  || ' '
  || studlname as fullname,
  studdob
from
  SHAREDSAMPLES.student s
  join
  SHAREDSAMPLES.enrolment e
  on
  s.studid = e.studid
where
  e.unitcode = 'FIT1004'
  and
  studdob =
  (
    select
      min(studdob)
    from
      SHAREDSAMPLES.student s
      join
      SHAREDSAMPLES.enrolment e
      on
      s.studid = e.studid
    where
      e.unitcode = 'FIT1004'
  )
order by
  s.studid;

            
/*11. Find all students enrolled in FIT1004 in semester 1, 2013 who 
      have scored more than the average mark of FIT1004 in the same 
      offering? Display the students' name and the mark. Sort the list in 
      the order of the mark from the highest to the lowest.*/

select
  studfname,
  studlname,
  mark
from
  SHAREDSAMPLES.student s
  join
  SHAREDSAMPLES.enrolment e
  on
  s.studid = e.studid
where
  unitcode='FIT1004'
  and
  semester = 1
  and
  to_char(ofyear,'YYYY')= '2013'
  and
  mark >
  (
    select
      avg(mark)
    from
      SHAREDSAMPLES.enrolment
    where
      unitcode='FIT1004'
      and
      semester = 1
      and
      to_char(ofyear,'YYYY')= '2013'
  )
order by
  mark desc;
