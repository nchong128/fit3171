SQL> /* 1.	List student name of all students who have marks in the range 
SQL>   of 60 to 70 */
SQL> 
SQL> SELECT
  2      studlname,
  3      studfname,
  4      mark
  5  FROM
  6      uni.student s
  7      JOIN uni.enrolment e ON s.studid = e.studid
  8  WHERE
  9      mark BETWEEN 60 AND 70
 10  ORDER BY
 11      studfname,
 12      studlname,
 13      mark;

STUDLNAME            STUDFNAME                  MARK
-------------------- -------------------- ----------
Lee                  Andy                         67
White                Blake                        67
Solo                 Dani                         67
Smith                David                        67
Ryan                 Jake                         67
Dowe                 James                        65
Chung                John                         65
Chan                 Mary                         67
Smith                Mary                         65
Dewa                 Rani                         60

10 rows selected. 

SQL> 
SQL> /* 2. List all the unit codes, semester and name of the chief examiner for all 
SQL>      the units that are offered in 2014.*/
SQL> 
SQL> SELECT
  2      o.unitcode,
  3      semester,
  4      stafffname,
  5      stafflname
  6  FROM
  7      uni.offering o
  8      JOIN uni.staff s ON o.chiefexam = s.staffid
  9  WHERE
 10      TO_CHAR(ofyear,'yyyy') = '2014'
 11  ORDER BY
 12      o.unitcode,
 13      semester;

UNITCOD   SEMESTER STAFFFNAME           STAFFLNAME          
------- ---------- -------------------- --------------------
FIT1040          3 Rubeus               Hagrid              
FIT5131          1 Minerva              McGonagall          
FIT5131          2 Minerva              McGonagall          

SQL> 
SQL> /* 3. List student name (firstname and surname), unit names, the year and 
SQL>      semester of enrolment of all units taken so far*/
SQL> 
SQL> SELECT
  2      studfname,
  3      studlname,
  4      unitname,
  5      TO_CHAR(e.ofyear,'yyyy') AS enrolyr,
  6      e.semester
  7  FROM
  8      uni.student s
  9      JOIN uni.enrolment e ON s.studid = e.studid
 10      JOIN uni.offering o ON ( e.unitcode = o.unitcode
 11                               AND e.semester = o.semester
 12                               AND e.ofyear = o.ofyear )
 13      JOIN uni.unit u ON o.unitcode = u.unitcode
 14  ORDER BY
 15      studfname,
 16      studlname,
 17      unitname,
 18      e.ofyear,
 19      semester;

STUDFNAME            STUDLNAME            UNITNAME                                                                                             ENRO   SEMESTER
-------------------- -------------------- ---------------------------------------------------------------------------------------------------- ---- ----------
Andrew               Short                Introduction to Databases                                                                            2013          1
Andy                 Lee                  Advanced Data Management                                                                             2013          2
Andy                 Lee                  Introduction to Data Management                                                                      2013          1
Andy                 Lee                  Programming Fundamental                                                                              2013          1
Blake                White                Introduction to Databases                                                                            2013          3
Dani                 Solo                 Programming Foundations                                                                              2013          1
Dani                 Solo                 Software Enginnering                                                                                 2013          2
David                Dumbledore           Advanced Data Management                                                                             2013          2
David                Dumbledore           Programming Fundamental                                                                              2013          1
David                Smith                Programming Foundations                                                                              2013          1
David                Smith                Software Enginnering                                                                                 2013          2

STUDFNAME            STUDLNAME            UNITNAME                                                                                             ENRO   SEMESTER
-------------------- -------------------- ---------------------------------------------------------------------------------------------------- ---- ----------
Gary                 Gupta                Introduction to Databases                                                                            2013          3
Gary                 Gupta                Programming Foundations                                                                              2014          1
Jake                 Brown                Programming Foundations                                                                              2013          1
Jake                 Brown                Software Enginnering                                                                                 2013          2
Jake                 Ryan                 Introduction to Data Management                                                                      2013          2
Jake                 Ryan                 Programming Fundamental                                                                              2013          2
James                Dowe                 Introduction to Data Management                                                                      2013          2
James                Dowe                 Programming Fundamental                                                                              2013          2
John                 Chung                Introduction to Data Management                                                                      2013          2
John                 Chung                Programming Fundamental                                                                              2013          2
John                 Tse                  Programming Foundations                                                                              2013          1

STUDFNAME            STUDLNAME            UNITNAME                                                                                             ENRO   SEMESTER
-------------------- -------------------- ---------------------------------------------------------------------------------------------------- ---- ----------
John                 Tse                  Software Enginnering                                                                                 2013          2
Mary                 Chan                 Introduction to Databases                                                                            2013          1
Mary                 Smith                Advanced Data Management                                                                             2013          2
Mary                 Smith                Introduction to Data Management                                                                      2013          1
Mary                 Smith                Programming Fundamental                                                                              2013          1
Mary                 Smith                Programming Fundamental                                                                              2013          2
Matthew              Long                 Advanced Data Management                                                                             2013          2
Matthew              Long                 Introduction to Data Management                                                                      2013          1
Matthew              Long                 Introduction to Data Management                                                                      2013          2
Matthew              Long                 Programming Fundamental                                                                              2013          1
Rani                 Dewa                 Introduction to Data Management                                                                      2013          1

STUDFNAME            STUDLNAME            UNITNAME                                                                                             ENRO   SEMESTER
-------------------- -------------------- ---------------------------------------------------------------------------------------------------- ---- ----------
Rani                 Dewa                 Introduction to Data Management                                                                      2013          2
Rani                 Dewa                 Programming Fundamental                                                                              2013          1
Ruth                 Nguyen               Introduction to Databases                                                                            2013          3
Ruth                 Nguyen               Programming Foundations                                                                              2014          1
Samuel               Nguyen               Introduction to Data Management                                                                      2013          2
Samuel               Nguyen               Programming Fundamental                                                                              2013          2
Tay                  Lee                  Introduction to Databases                                                                            2013          1
Theo                 Gupta                Introduction to Data Management                                                                      2013          2
Theo                 Gupta                Programming Fundamental                                                                              2013          2

42 rows selected. 

SQL> 
SQL> 
SQL> /* 4. List all the unit codes and the unit names and their year and semester 
SQL>      offerings. */
SQL> 
SQL> SELECT
  2      u.unitcode,
  3      unitname,
  4      TO_CHAR(ofyear,'YYYY') AS offeringyr,
  5      semester
  6  FROM
  7      uni.unit u
  8      JOIN uni.offering o ON u.unitcode = o.unitcode
  9  ORDER BY
 10      unitcode,
 11      offeringyr,
 12      semester;

UNITCOD UNITNAME                                                                                             OFFE   SEMESTER
------- ---------------------------------------------------------------------------------------------------- ---- ----------
FIT1004 Introduction to Data Management                                                                      2013          1
FIT1004 Introduction to Data Management                                                                      2013          2
FIT1040 Programming Fundamental                                                                              2013          1
FIT1040 Programming Fundamental                                                                              2013          2
FIT1040 Programming Fundamental                                                                              2014          3
FIT2077 Advanced Data Management                                                                             2013          1
FIT2077 Advanced Data Management                                                                             2013          2
FIT5131 Programming Foundations                                                                              2013          1
FIT5131 Programming Foundations                                                                              2013          2
FIT5131 Programming Foundations                                                                              2014          1
FIT5131 Programming Foundations                                                                              2014          2

UNITCOD UNITNAME                                                                                             OFFE   SEMESTER
------- ---------------------------------------------------------------------------------------------------- ---- ----------
FIT5132 Introduction to Databases                                                                            2013          1
FIT5132 Introduction to Databases                                                                            2013          3
FIT5136 Software Enginnering                                                                                 2013          2

14 rows selected. 

SQL> 
SQL> 
SQL> /* 5. List the unit code, semester, class type (lecture or tutorial), 
SQL>      day and time for all units taught by Albus Dumbledore in 2013. 
SQL>      Sort the list according to the unit code.*/
SQL> 
SQL> SELECT
  2      unitcode,
  3      semester,
  4      cltype,
  5      clday,
  6      TO_CHAR(cltime,'HHAM') AS time
  7  FROM
  8      uni.staff s
  9      JOIN uni.schedclass sc ON s.staffid = sc.staffid
 10  WHERE
 11      TO_CHAR(ofyear,'yyyy') = '2013'
 12      AND stafffname = 'Albus'
 13      AND stafflname = 'Dumbledore'
 14  ORDER BY
 15      unitcode,
 16      semester,
 17      cltype,
 18      clday,
 19      cltime;

UNITCOD   SEMESTER C CLDAY  TIME
------- ---------- - ------ ----
FIT1004          1 L Mon    02PM
FIT1004          2 L Mon    10AM
FIT1004          2 T Mon    12PM
FIT2077          1 L Tues   10AM

SQL> 
SQL> /* OR*/
SQL> 
SQL> SELECT
  2      unitcode,
  3      semester,
  4      cltype,
  5      clday,
  6      TO_CHAR(cltime,'HHAM') AS time
  7  FROM
  8      uni.staff s
  9      JOIN uni.schedclass sc ON s.staffid = sc.staffid
 10  WHERE
 11      EXTRACT(YEAR FROM ofyear) = '2013'
 12      AND stafffname = 'Albus'
 13      AND stafflname = 'Dumbledore'
 14  ORDER BY
 15      unitcode,
 16      semester,
 17      cltype,
 18      clday,
 19      cltime;

UNITCOD   SEMESTER C CLDAY  TIME
------- ---------- - ------ ----
FIT1004          1 L Mon    02PM
FIT1004          2 L Mon    10AM
FIT1004          2 T Mon    12PM
FIT2077          1 L Tues   10AM

SQL> 
SQL> /* 6. Create a study statement for Mary Smith. A study statement contains 
SQL>      unit code, unit name, semester and year study was attempted, the mark 
SQL>      and grade. */
SQL> 
SQL> SELECT
  2      e.unitcode,
  3      unitname,
  4      semester,
  5      TO_CHAR(ofyear,'yyyy') AS "YEAR OF ENROLMENT",
  6      mark,
  7      grade
  8  FROM
  9      uni.student s
 10      JOIN uni.enrolment e ON s.studid = e.studid
 11      JOIN uni.unit u ON e.unitcode = u.unitcode
 12  WHERE
 13      studfname = 'Mary'
 14      AND studlname = 'Smith'
 15  ORDER BY
 16      "YEAR OF ENROLMENT",
 17      semester,
 18      unitcode;

UNITCOD UNITNAME                                                                                               SEMESTER YEAR       MARK GR
------- ---------------------------------------------------------------------------------------------------- ---------- ---- ---------- --
FIT1004 Introduction to Data Management                                                                               1 2013         65 C 
FIT1040 Programming Fundamental                                                                                       1 2013         45 N 
FIT1040 Programming Fundamental                                                                                       2 2013         74 D 
FIT2077 Advanced Data Management                                                                                      2 2013         74 D 

SQL> 
SQL> /* 7. List the unit code, unit name and the unit code and unit name of the 
SQL>      pre-requisite units of all units in the database. */
SQL> 
SQL> SELECT
  2      u1.unitcode,
  3      u1.unitname,
  4      has_prereq_of   AS prereq_unitcode,
  5      u2.unitname     AS prereq_unitname
  6  FROM
  7      uni.unit u1
  8      JOIN uni.prereq p ON u1.unitcode = p.unitcode
  9      JOIN uni.unit u2 ON u2.unitcode = p.has_prereq_of
 10  ORDER BY
 11      unitcode,
 12      prereq_unitcode;

UNITCOD UNITNAME                                                                                             PREREQ_ PREREQ_UNITNAME                                                                                     
------- ---------------------------------------------------------------------------------------------------- ------- ----------------------------------------------------------------------------------------------------
FIT2077 Advanced Data Management                                                                             FIT1004 Introduction to Data Management                                                                     
FIT2077 Advanced Data Management                                                                             FIT1040 Programming Fundamental                                                                             
FIT5131 Programming Foundations                                                                              FIT1004 Introduction to Data Management                                                                     
FIT5136 Software Enginnering                                                                                 FIT5131 Programming Foundations                                                                             

SQL> 
SQL> /* 8. List the unit code and unit name of the pre-requisite units of 
SQL>      'Advanced Data Management' unit */
SQL> 
SQL> SELECT
  2      has_prereq_of   AS prereq_unitcode,
  3      u2.unitname     AS prereq_unitname
  4  FROM
  5      uni.unit u1
  6      JOIN uni.prereq p ON u1.unitcode = p.unitcode
  7      JOIN uni.unit u2 ON u2.unitcode = p.has_prereq_of
  8  WHERE
  9      u1.unitname = 'Advanced Data Management'
 10  ORDER BY
 11      prereq_unitcode;

PREREQ_ PREREQ_UNITNAME                                                                                     
------- ----------------------------------------------------------------------------------------------------
FIT1004 Introduction to Data Management                                                                     
FIT1040 Programming Fundamental                                                                             

SQL> 
SQL> /* 9. Find all students (list their id, firstname and surname) who 
SQL>       have a failed unit in the year 2013 */
SQL> 
SQL> SELECT DISTINCT
  2      s.studid,
  3      studlname,
  4      studfname
  5  FROM
  6      uni.student s
  7      JOIN uni.enrolment e ON s.studid = e.studid
  8  WHERE
  9      mark < 50
 10      AND TO_CHAR(ofyear,'yyyy') = '2013'
 11  ORDER BY
 12      s.studid;

    STUDID STUDLNAME            STUDFNAME           
---------- -------------------- --------------------
  11111111 Smith                Mary                
  11111114 Dewa                 Rani                
  11111115 Dumbledore           David               

SQL> 
SQL> /* OR*/
SQL> 
SQL> SELECT DISTINCT
  2      s.studid,
  3      studlname,
  4      studfname
  5  FROM
  6      uni.student s
  7      JOIN uni.enrolment e ON s.studid = e.studid
  8  WHERE
  9      mark < 50
 10      AND EXTRACT(YEAR FROM ofyear) = '2013'
 11  ORDER BY
 12      s.studid;

    STUDID STUDLNAME            STUDFNAME           
---------- -------------------- --------------------
  11111111 Smith                Mary                
  11111114 Dewa                 Rani                
  11111115 Dumbledore           David               

SQL> 
SQL> /* 10.	List the student name, unit code, semester and year for those 
SQL>        students who do not have marks recorded */
SQL> 
SQL> SELECT
  2      s.studid,
  3      studfname,
  4      studlname,
  5      TO_CHAR(ofyear,'yyyy') AS "YEAR OF ENROLMENT",
  6      semester,
  7      e.unitcode
  8  FROM
  9      uni.student s
 10      JOIN uni.enrolment e ON s.studid = e.studid
 11  WHERE
 12      mark IS NULL;

    STUDID STUDFNAME            STUDLNAME            YEAR   SEMESTER UNITCOD
---------- -------------------- -------------------- ---- ---------- -------
  11111117 Jake                 Ryan                 2013          2 FIT1004
  11111128 Gary                 Gupta                2014          1 FIT5131
  11111129 Ruth                 Nguyen               2014          1 FIT5131

SQL> 
SQL> SPOOL OFF
