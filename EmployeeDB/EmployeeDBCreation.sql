-- DROP employeedb if already exist
DROP DATABASE employeedb;

-- Create employedb Database

CREATE DATABASE employeedb;
USE employeedb

--Create department table

CREATE TABLE department(
  dept_no INT,
  name VARCHAR(14),
  location VARCHAR(13),
  PRIMARY KEY (dept_no)
);

-- Create employee table

CREATE TABLE employee (
	employee_no INT,
	name VARCHAR(10),
	job VARCHAR(9),
	manager INT,
	hiredate_dt DATE,
	salary DECIMAL(9,2),
	dept_no INT,
	commisson DECIMAL(7,2),
	PRIMARY KEY(employee_no),
	FOREIGN KEY(dept_no) REFERENCES department(dept_no)
);

--Create bonus table

CREATE TABLE bonus(
  employee_name VARCHAR(10),
  job VARCHAR(9),
  salary DECIMAL(9,2),
  commisson DECIMAL(7,2)
);

--Create salarygrade table

CREATE TABLE salarygrade(
  grade INT,
  low_salary DECIMAL(9,2),
  high_salary DECIMAL(9,2)
);

--Now insert values in each table

INSERT INTO department
VALUES
	(10, 'ACCOUNTING', 'NEW YORK'),
	(20, 'RESEARCH', 'DALLAS'),
	(30, 'SALES', 'CHICAGO'),
	(40, 'OPERATIONS', 'BOSTON');
 
INSERT INTO employee(employee_no, name, job, manager, hiredate_dt, salary, commisson, dept_no)	
VALUES
	( 7839, 'KING', 'PRESIDENT', null, STR_TO_DATE('17-11-1981','%d-%m-%Y'), 5000, null, 10 ),
	( 7698, 'BLAKE', 'MANAGER', 7839, STR_TO_DATE('1-5-1981','%d-%m-%Y'), 2850, null, 30 ),
	( 7782, 'CLARK', 'MANAGER', 7839, STR_TO_DATE('9-6-1981','%d-%m-%Y'), 2450, null, 10 ),
	( 7566, 'JONES', 'MANAGER', 7839, STR_TO_DATE('2-4-1981','%d-%m-%Y'), 2975, NULL, 20 ),
	( 7788, 'SCOTT', 'ANALYST', 7566, STR_TO_DATE('13-JUL-87','%d-%M-%y'), 3000, null, 20 ),
	( 7902, 'FORD', 'ANALYST', 7566, STR_TO_DATE('3-12-1981','%d-%m-%Y'), 3000, null, 20	),
	( 7369, 'SMITH', 'CLERK', 7902, STR_TO_DATE('17-12-1980','%d-%m-%Y'), 800, null, 20 ),
	( 7499, 'ALLEN', 'SALESMAN', 7698, STR_TO_DATE('20-2-1981','%d-%m-%Y'), 1600, 300, 30	),
	( 7521, 'WARD', 'SALESMAN', 7698, STR_TO_DATE('22-2-1981','%d-%m-%Y'), 1250, 500, 30 ),
	( 7654, 'MARTIN', 'SALESMAN', 7698, STR_TO_DATE('28-9-1981','%d-%m-%Y'), 1250, 1400, 30 ),
	( 7844, 'TURNER', 'SALESMAN', 7698, STR_TO_DATE('8-9-1981','%d-%m-%Y'), 1500, 0, 30 ),
	( 7876, 'ADAMS', 'CLERK', 7788, STR_TO_DATE('13-JUL-87', '%d-%M-%y'), 1100, null, 20 ),
	( 7900, 'JAMES', 'CLERK', 7698, STR_TO_DATE('3-12-1981','%d-%m-%Y'), 950, null, 30 ),
	( 7934, 'MILLER', 'CLERK', 7782, STR_TO_DATE('23-1-1982','%d-%m-%Y'), 1300, null, 10 );
 

INSERT INTO salarygrade
VALUES 
	(1, 700, 1200),
	(2, 1201, 1400),
	(3, 1401, 2000),
	(4, 2001, 3000),
	(5, 3001, 9999);
