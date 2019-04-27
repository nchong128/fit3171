SPOOL ./myoutput.txt

--Drop all tables
DROP TABLE enrolment;
DROP TABLE student;
DROP TABLE unit;

--Drop sequences
DROP SEQUENCE stu_seq;

-- Create sequences
CREATE SEQUENCE stu_seq
    START with 11111115 
    INCREMENT BY 1;
    

CREATE TABLE unit
    (
        unit_code   CHAR (7)       NOT NULL,
        unit_name   VARCHAR (50)   NOT NULL,
        CONSTRAINT unit_pk PRIMARY KEY (unit_code)
    );
    
CREATE TABLE student
    (
        stu_nbr     NUMERIC (8)     NOT NULL CHECK (stu_nbr > 10000000),
        stu_lname   VARCHAR (50)    NOT NULL,
        stu_fname   VARCHAR (50)    NOT NULL,
        stu_dob     DATE            NOT NULL,
        CONSTRAINT stu_pk PRIMARY KEY (stu_nbr)
    );

CREATE TABLE enrolment
    (
        stu_nbr         NUMERIC (8),
        unit_code       CHAR (7),
        enrol_year      NUMERIC (4)     NOT NULL,
        enrol_semester  CHAR (1)        NOT NULL,
        enrol_mark      NUMERIC (3),
        enrol_grade     CHAR (2),
        CONSTRAINT enrolment_pk
            PRIMARY KEY (stu_nbr, unit_code, enrol_year, enrol_semester),
        CONSTRAINT enrol_stu_fk FOREIGN KEY (stu_nbr)
            REFERENCES student (stu_nbr) ON DELETE CASCADE,
        CONSTRAINT enrol_unit_fk FOREIGN KEY (unit_code)
            REFERENCES unit (unit_code) ON DELETE CASCADE
    );
    
--Insert the students information
INSERT INTO student VALUES (11111111, 'Bloggs', 'Fred','01-Jan-1990');
INSERT INTO student VALUES (11111112, 'Nice', 'Nick','10-Oct-1994');
INSERT INTO student VALUES (11111113, 'Wheat', 'Wendy','05-May-1990');
INSERT INTO student VALUES (11111114, 'Sheen', 'Cindy','25-Dec-1996');
INSERT INTO student VALUES (stu_seq.nextval, 'Mouse', 'Mickey','12-Aug-1999');
COMMIT;

--Insert unit information
INSERT INTO unit VALUES ('FIT9999', 'FIT Last Unit');
INSERT INTO unit VALUES ('FIT5132', 'Introduction to Databases');
INSERT INTO unit VALUES ('FIT5016', 'Project');
INSERT INTO unit VALUES ('FIT5111', 'Student''s Life');
COMMIT;

--Insert enrolment info
INSERT INTO enrolment VALUES(11111111, 'FIT5132', 2013, '1', 35, 'N');
INSERT INTO enrolment VALUES(11111111, 'FIT5016', 2013, '1', 61, 'C');
INSERT INTO enrolment VALUES(11111111, 'FIT5132', 2013, '2', 42, 'N');
INSERT INTO enrolment VALUES(11111111, 'FIT5111', 2013, '2', 76, 'D');
INSERT INTO enrolment VALUES(11111111, 'FIT5132', 2014, '2', NULL,NULL);

INSERT INTO enrolment VALUES(11111112, 'FIT5132', 2013, '2',83, 'HD');
INSERT INTO enrolment VALUES(11111112, 'FIT5111', 2013, '2',79, 'D');

INSERT INTO enrolment VALUES(11111113, 'FIT5132', 2014, '2', NULL, NULL);
INSERT INTO enrolment VALUES(11111113, 'FIT5111', 2014, '2', NULL, NULL);

INSERT INTO enrolment VALUES(11111114, 'FIT5111', 2014,'2', NULL, NULL );

INSERT INTO enrolment VALUES (stu_seq.currval, 'FIT5132', 2016, '2', NULL, NULL);
COMMIT;


SELECT * from student;
SELECT * from unit;
SELECT * from enrolment;


SPOOL OFF