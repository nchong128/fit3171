--
-- Schema to create Department Employee model
--

--
-- Create Table    : 'DEPARTMENT'   
-- dept_no         : Department Number 
-- dept_name       : Name of department 
-- dept_empcnt     : Count of employees in department 
--
CREATE TABLE DEPARTMENT (
    dept_no        NUMBER(2) NOT NULL,
    dept_name      CHAR(20) NOT NULL,
    dept_empcnt    NUMBER(3) NOT NULL,
CONSTRAINT pk_DEPARTMENT PRIMARY KEY (dept_no));

--
-- Create Table    : 'EMPLOYEE'   
-- emp_no          : Employee number 
-- emp_name        : Employee Name 
-- emp_salary      : Employee Salary 
-- emp_sdate       : Employee start date 
-- dept_no         : Department Number (references DEPARTMENT.dept_no)
--
CREATE TABLE EMPLOYEE (
    emp_no         NUMBER(4) NOT NULL,
    emp_name       CHAR(20) NOT NULL,
    emp_salary     NUMBER(8,2) NOT NULL,
    emp_sdate      DATE NOT NULL,
    dept_no        NUMBER(2) NOT NULL,
CONSTRAINT pk_EMPLOYEE PRIMARY KEY (emp_no),
CONSTRAINT fk_EMPLOYEE FOREIGN KEY (dept_no)
    REFERENCES DEPARTMENT (dept_no));

--- Create the sequence for the employee PK
CREATE SEQUENCE employeeNo START WITH 100 INCREMENT BY 1;
