SQL> 
SQL> /* 1. List all tudents and their details. */
SQL> 
SQL> SELECT
  2      *
  3  FROM
  4      uni.student
  5  ORDER BY
  6      studid;

    STUDID STUDFNAME            STUDLNAME            STUDDOB     STUDADDRESS                                                                                          STUDPHONE       STUDEMAIL                                         
---------- -------------------- -------------------- ----------- ---------------------------------------------------------------------------------------------------- --------------- --------------------------------------------------
  11111111 Mary                 Smith                01-Jan-1995 20/1 Princess Highway, Caulfield East, VIC , 3145                                                    0411111222      msmith@monash.edu                                 
  11111112 Matthew              Long                 01-Feb-1997 20/1 Princess Highway, Caulfield East, VIC , 3145                                                    0411111333      mlong@monash.edu                                  
  11111113 Andy                 Lee                  01-Mar-1995 1 King Road, Caulfield South, VIC , 3166                                                             0411111444      alees@monash.edu                                  
  11111114 Rani                 Dewa                 01-Apr-1996 12/1 Princess Highway, Caulfield East, VIC , 3145                                                    0411111555      rdewa@monash.edu                                  
  11111115 David                Dumbledore           02-Jan-1996 1 Queen Avenue, Caulfield East, VIC , 3145                                                           0411111666      dsmith@monash.edu                                 
  11111116 John                 Chung                03-Dec-1996 12/1 Princess Highway, Caulfield East, VIC , 3145                                                    0411111777      jchung@monash.edu                                 
  11111117 Jake                 Ryan                 01-Jan-1990 11 Derby Crescent, Caulfield East, VIC , 3145                                                        0411111888      jryan@monash.edu                                  
  11111118 Theo                 Gupta                12-Jul-1992 12 Princess Highway, Caulfield East, VIC , 3145                                                      0411111999      tgupta@monash.edu                                 
  11111119 Samuel               Nguyen               15-Sep-1996 56 Queen Avenue, Caulfield East, VIC , 3145                                                          0411112222      snguyen@monash.edu                                
  11111120 James                Dowe                 01-Jan-1996 100 Princess Highway, Caulfield East, VIC , 3145                                                     0411112333      jdowes@monash.edu                                 
  11111121 Mary                 Chan                 01-Jan-1991 20/1 Princess Highway, Caulfield East, VIC , 3145                                                    0411111222      msmith@monash.edu                                 

    STUDID STUDFNAME            STUDLNAME            STUDDOB     STUDADDRESS                                                                                          STUDPHONE       STUDEMAIL                                         
---------- -------------------- -------------------- ----------- ---------------------------------------------------------------------------------------------------- --------------- --------------------------------------------------
  11111122 Andrew               Short                01-Feb-1990 20/1 Princess Highway, Caulfield East, VIC , 3145                                                    0411111333      mlong@monash.edu                                  
  11111123 Tay                  Lee                  01-Mar-1988 1 King Road, Caulfield South, VIC , 3166                                                             0411111444      alees@monash.edu                                  
  11111124 Dani                 Solo                 01-Apr-1991 12/1 Princess Highway, Caulfield East, VIC , 3145                                                    0411111555      rdewa@monash.edu                                  
  11111125 David                Smith                02-Jan-1990 1 Queen Avenue, Caulfield East, VIC , 3145                                                           0411111666      dsmith@monash.edu                                 
  11111126 John                 Tse                  03-Dec-1988 12/1 Princess Highway, Caulfield East, VIC , 3145                                                    0411111777      jchung@monash.edu                                 
  11111127 Jake                 Brown                01-Jan-1990 11 Derby Crescent, Caulfield East, VIC , 3145                                                        0411111888      jryan@monash.edu                                  
  11111128 Gary                 Gupta                12-Jul-1992 12 Princess Highway, Caulfield East, VIC , 3145                                                      0411111999      tgupta@monash.edu                                 
  11111129 Ruth                 Nguyen               15-Sep-1991 56 Queen Avenue, Caulfield East, VIC , 3145                                                          0411112222      snguyen@monash.edu                                
  11111130 Blake                White                01-Jan-1992 100 Princess Highway, Caulfield East, VIC , 3145                                                     0411112333      jdowes@monash.edu                                 

20 rows selected. 

SQL> 
SQL> /* 2. List ALL units AND their details. */
SQL> 
SQL> SELECT
  2      *
  3  FROM
  4      uni.unit
  5  ORDER BY
  6      unitcode;

UNITCOD UNITNAME                                                                                             UNITDESC                                                                                                                                                                                                
------- ---------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FIT1004 Introduction to Data Management                                                                      Introduction to relational model and relational DBMS                                                                                                                                                    
FIT1040 Programming Fundamental                                                                              Introduction to programming                                                                                                                                                                             
FIT2077 Advanced Data Management                                                                             Advanced relational database concept and XML                                                                                                                                                            
FIT5131 Programming Foundations                                                                              Introduction to programming concept and algorithms                                                                                                                                                      
FIT5132 Introduction to Databases                                                                            Introduction to relational model and relational DBMS                                                                                                                                                    
FIT5136 Software Enginnering                                                                                 Software modeling and testing                                                                                                                                                                           

6 rows selected. 

SQL> 
SQL> /* 3. List all students who have the surname 'Smith'.*/
SQL> 
SQL> SELECT
  2      *
  3  FROM
  4      uni.student
  5  WHERE
  6      studlname = 'Smith'
  7  ORDER BY
  8      studid;

    STUDID STUDFNAME            STUDLNAME            STUDDOB     STUDADDRESS                                                                                          STUDPHONE       STUDEMAIL                                         
---------- -------------------- -------------------- ----------- ---------------------------------------------------------------------------------------------------- --------------- --------------------------------------------------
  11111111 Mary                 Smith                01-Jan-1995 20/1 Princess Highway, Caulfield East, VIC , 3145                                                    0411111222      msmith@monash.edu                                 
  11111125 David                Smith                02-Jan-1990 1 Queen Avenue, Caulfield East, VIC , 3145                                                           0411111666      dsmith@monash.edu                                 

SQL> 
SQL> /* 4. List the student's details for those students who have surname starts with the letter 'S'.*/
SQL> 
SQL> SELECT
  2      studid,
  3      studfname   AS firstname,
  4      studlname   AS lastname,
  5      studdob,
  6      studaddress,
  7      studphone,
  8      studemail
  9  FROM
 10      uni.student
 11  WHERE
 12      studlname LIKE 'S%'
 13  ORDER BY
 14      studid;

    STUDID FIRSTNAME            LASTNAME             STUDDOB     STUDADDRESS                                                                                          STUDPHONE       STUDEMAIL                                         
---------- -------------------- -------------------- ----------- ---------------------------------------------------------------------------------------------------- --------------- --------------------------------------------------
  11111111 Mary                 Smith                01-Jan-1995 20/1 Princess Highway, Caulfield East, VIC , 3145                                                    0411111222      msmith@monash.edu                                 
  11111122 Andrew               Short                01-Feb-1990 20/1 Princess Highway, Caulfield East, VIC , 3145                                                    0411111333      mlong@monash.edu                                  
  11111124 Dani                 Solo                 01-Apr-1991 12/1 Princess Highway, Caulfield East, VIC , 3145                                                    0411111555      rdewa@monash.edu                                  
  11111125 David                Smith                02-Jan-1990 1 Queen Avenue, Caulfield East, VIC , 3145                                                           0411111666      dsmith@monash.edu                                 

SQL> 
SQL> /* 5. List the student's surname, firstname and address for those students who have surname
SQL>starts with the letter 'S' and firstname contains the letter 'i'.*/
SQL> 
SQL> SELECT
  2      *
  3  FROM
  4      uni.student
  5  WHERE
  6      studlname LIKE 'S%'
  7      AND studfname LIKE '%i%'
  8  ORDER BY
  9      studid;

    STUDID STUDFNAME            STUDLNAME            STUDDOB     STUDADDRESS                                                                                          STUDPHONE       STUDEMAIL                                         
---------- -------------------- -------------------- ----------- ---------------------------------------------------------------------------------------------------- --------------- --------------------------------------------------
  11111124 Dani                 Solo                 01-Apr-1991 12/1 Princess Highway, Caulfield East, VIC , 3145                                                    0411111555      rdewa@monash.edu                                  
  11111125 David                Smith                02-Jan-1990 1 Queen Avenue, Caulfield East, VIC , 3145                                                           0411111666      dsmith@monash.edu                                 

SQL> 
SQL> /* 6. List the unit code and semester of all units that are offered in the year 2014. */
SQL> 
SQL> SELECT
  2      unitcode,
  3      semester
  4  FROM
  5      uni.offering
  6  WHERE
  7      TO_CHAR(ofyear,'yyyy') = '2014'
  8  ORDER BY
  9      unitcode,
 10      semester;

UNITCOD   SEMESTER
------- ----------
FIT1040          3
FIT5131          1
FIT5131          2

SQL> 
SQL> /* OR*/
SQL> 
SQL> SELECT
  2      unitcode,
  3      semester
  4  FROM
  5      uni.offering
  6  WHERE
  7      EXTRACT(YEAR FROM ofyear) = 2014
  8  ORDER BY
  9      unitcode,
 10      semester;

UNITCOD   SEMESTER
------- ----------
FIT1040          3
FIT5131          1
FIT5131          2

SQL> 
SQL> /* 7. List the unit code of all units that are offered in semester 1 of 2014. */
SQL> 
SQL> SELECT
  2      unitcode
  3  FROM
  4      uni.offering
  5  WHERE
  6      TO_CHAR(ofyear,'yyyy') = '2014'
  7      AND semester = 1
  8  ORDER BY
  9      unitcode;

UNITCOD
-------
FIT5131

SQL> 
SQL> /* OR */
SQL> 
SQL> SELECT
  2      unitcode
  3  FROM
  4      uni.offering
  5  WHERE
  6      EXTRACT(YEAR FROM ofyear) = '2014'
  7      AND semester = 1
  8  ORDER BY
  9      unitcode;

UNITCOD
-------
FIT5131

SQL> 
SQL> 
SQL> 
SQL> /* 8. Assuming that a unit code is created based on the following rules:
SQL>a. The first three letters represent faculty abbreviation, eg FIT for the Faculty of Information Technology.
SQL>b. The first digit of the number following the letter represents the year level.
SQL>List the unit details of all first year units in the Faculty of Information Technology.*/
SQL> 
SQL> SELECT
  2      *
  3  FROM
  4      uni.unit
  5  WHERE
  6      unitcode LIKE 'FIT1%'
  7  ORDER BY
  8      unitcode;

UNITCOD UNITNAME                                                                                             UNITDESC                                                                                                                                                                                                
------- ---------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FIT1004 Introduction to Data Management                                                                      Introduction to relational model and relational DBMS                                                                                                                                                    
FIT1040 Programming Fundamental                                                                              Introduction to programming                                                                                                                                                                             

SQL> 
SQL> /* 9. List the unit code and semester of all units that were offered in either semester 1 or summer of 2013.*/
SQL> 
SQL> SELECT
  2      unitcode,
  3      semester
  4  FROM
  5      uni.offering
  6  WHERE
  7      semester IN (
  8          1,
  9          3
 10      )
 11      AND TO_CHAR(ofyear,'yyyy') = '2013'
 12  ORDER BY
 13      unitcode,
 14      semester;

UNITCOD   SEMESTER
------- ----------
FIT1004          1
FIT1040          1
FIT2077          1
FIT5131          1
FIT5132          1
FIT5132          3

6 rows selected. 

SQL> 
SQL> /* alternative solution */
SQL> 
SQL> SELECT
  2      unitcode,
  3      semester
  4  FROM
  5      uni.offering
  6  WHERE
  7      ( semester = 1
  8        OR semester = 3 )
  9      AND TO_CHAR(ofyear,'yyyy') = '2013'
 10  ORDER BY
 11      unitcode,
 12      semester;

UNITCOD   SEMESTER
------- ----------
FIT1004          1
FIT1040          1
FIT2077          1
FIT5131          1
FIT5132          1
FIT5132          3

6 rows selected. 

SQL> 
SQL> /* 10. List the student number, mark, unit code and semester for those tudents who have passed any unit in semester 1 of 2013. */
SQL> 
SQL> SELECT
  2      studid,
  3      mark,
  4      unitcode,
  5      semester
  6  FROM
  7      uni.enrolment
  8  WHERE
  9      mark > 49
 10      AND semester = 1
 11      AND TO_CHAR(ofyear,'yyyy') = '2013'
 12  ORDER BY
 13      studid,
 14      unitcode;

    STUDID       MARK UNITCOD   SEMESTER
---------- ---------- ------- ----------
  11111111         65 FIT1004          1
  11111112         90 FIT1004          1
  11111112         80 FIT1040          1
  11111113         72 FIT1004          1
  11111113         74 FIT1040          1
  11111114         60 FIT1040          1
  11111115         80 FIT1040          1
  11111121         67 FIT5132          1
  11111122         77 FIT5132          1
  11111123         78 FIT5132          1
  11111124         67 FIT5131          1

    STUDID       MARK UNITCOD   SEMESTER
---------- ---------- ------- ----------
  11111125         77 FIT5131          1
  11111126         78 FIT5131          1
  11111127         88 FIT5131          1

14 rows selected. 

SQL> 
SQL> /* OR*/
SQL> 
SQL> SELECT
  2      studid,
  3      mark,
  4      unitcode,
  5      semester
  6  FROM
  7      uni.enrolment
  8  WHERE
  9      mark > 49
 10      AND semester = 1
 11      AND EXTRACT(YEAR FROM ofyear) = '2013'
 12  ORDER BY
 13      studid,
 14      unitcode;

    STUDID       MARK UNITCOD   SEMESTER
---------- ---------- ------- ----------
  11111111         65 FIT1004          1
  11111112         90 FIT1004          1
  11111112         80 FIT1040          1
  11111113         72 FIT1004          1
  11111113         74 FIT1040          1
  11111114         60 FIT1040          1
  11111115         80 FIT1040          1
  11111121         67 FIT5132          1
  11111122         77 FIT5132          1
  11111123         78 FIT5132          1
  11111124         67 FIT5131          1

    STUDID       MARK UNITCOD   SEMESTER
---------- ---------- ------- ----------
  11111125         77 FIT5131          1
  11111126         78 FIT5131          1
  11111127         88 FIT5131          1

14 rows selected. 

SQL> 
SQL> /* OR*/
SQL> 
SQL> SELECT
  2      studid,
  3      mark,
  4      unitcode,
  5      semester
  6  FROM
  7      uni.enrolment
  8  WHERE
  9      grade <> 'N'
 10      AND semester = 1
 11      AND TO_CHAR(ofyear,'yyyy') = '2013'
 12  ORDER BY
 13      studid,
 14      unitcode;

    STUDID       MARK UNITCOD   SEMESTER
---------- ---------- ------- ----------
  11111111         65 FIT1004          1
  11111112         90 FIT1004          1
  11111112         80 FIT1040          1
  11111113         72 FIT1004          1
  11111113         74 FIT1040          1
  11111114         60 FIT1040          1
  11111115         80 FIT1040          1
  11111121         67 FIT5132          1
  11111122         77 FIT5132          1
  11111123         78 FIT5132          1
  11111124         67 FIT5131          1

    STUDID       MARK UNITCOD   SEMESTER
---------- ---------- ------- ----------
  11111125         77 FIT5131          1
  11111126         78 FIT5131          1
  11111127         88 FIT5131          1

14 rows selected. 

SQL> 
SQL> SPOOL OFF
