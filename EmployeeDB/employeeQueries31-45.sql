 --031. List the emps who joined in before or after 1981
 
SELECT *
FROM employee
WHERE 1=1
	AND YEAR(employee.hiredate_dt) != 1981;
	
--Result

+-------------+--------+---------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job     | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+---------+---------+-------------+---------+---------+-----------+
|        7369 | SMITH  | CLERK   |    7902 | 1980-12-17  |  800.00 |      20 |      NULL |
|        7788 | SCOTT  | ANALYST |    7566 | 1987-07-13  | 3000.00 |      20 |      NULL |
|        7876 | ADAMS  | CLERK   |    7788 | 1987-07-13  | 1100.00 |      20 |      NULL |
|        7934 | MILLER | CLERK   |    7782 | 1982-01-23  | 1300.00 |      10 |      NULL |
+-------------+--------+---------+---------+-------------+---------+---------+-----------+

--032. List the emps whose empno not starting with digit 78

SELECT *
FROM employee
WHERE 1=1
	AND employee_no NOT LIKE '78%'
LIMIT 3;
	
--Result

+-------------+-------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+----------+---------+-------------+---------+---------+-----------+
|        7369 | SMITH | CLERK    |    7902 | 1980-12-17  |  800.00 |      20 |      NULL |
|        7499 | ALLEN | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |
|        7521 | WARD  | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |
+-------------+-------+----------+---------+-------------+---------+---------+-----------+

--033. List the emps who are working under ‘Mgr’

SELECT *
FROM employee
WHERE employee.manager IN (
	SELECT 
		employee_no 
	FROM employee 
	WHERE employee.job = 'MANAGER'
	);

--Result

+-------------+--------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+
|        7499 | ALLEN  | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |
|        7521 | WARD   | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |
|        7654 | MARTIN | SALESMAN |    7698 | 1981-09-28  | 1250.00 |      30 |   1400.00 |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+

--034. List the emps who joined in any year but not belongs to the month of March

SELECT *
FROM employee
WHERE 1=1
	AND MONTH(hiredate_dt) != 3;

--Result

+-------------+-------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+----------+---------+-------------+---------+---------+-----------+
|        7369 | SMITH | CLERK    |    7902 | 1980-12-17  |  800.00 |      20 |      NULL |
|        7499 | ALLEN | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |
|        7521 | WARD  | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |
+-------------+-------+----------+---------+-------------+---------+---------+-----------+

--035. List all the clerks of deptno 20.

SELECT *
FROM employee
WHERE 1=1
	AND empoyee.dept_no = 20
	AND employee.job = 'CLERK';
	
--Result

+-------------+-------+-------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job   | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+-------+---------+-------------+---------+---------+-----------+
|        7369 | SMITH | CLERK |    7902 | 1980-12-17  |  800.00 |      20 |      NULL |
|        7876 | ADAMS | CLERK |    7788 | 1987-07-13  | 1100.00 |      20 |      NULL |
+-------------+-------+-------+---------+-------------+---------+---------+-----------+

--036. List the emps of deptno 30 or 10 and joined in the year 1981

SELECT *
FROM employee
WHERE 1=1
	AND employee.dept_no IN (30, 10)
	AND YEAR(hiredate_dt) = 1981;
	
--Result

+-------------+-------+-----------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job       | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+-----------+---------+-------------+---------+---------+-----------+
|        7782 | CLARK | MANAGER   |    7839 | 1981-06-09  | 2450.00 |      10 |      NULL |
|        7839 | KING  | PRESIDENT |    NULL | 1981-11-17  | 5000.00 |      10 |      NULL |
|        7499 | ALLEN | SALESMAN  |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |
+-------------+-------+-----------+---------+-------------+---------+---------+-----------+

--037. Display the details of ‘Smith’

SELECT *
FROM employee
WHERE 1=1
	AND employee.name = 'Smith';
	
--Result

+-------------+-------+-------+---------+-------------+--------+---------+-----------+
| employee_no | name  | job   | manager | hiredate_dt | salary | dept_no | commisson |
+-------------+-------+-------+---------+-------------+--------+---------+-----------+
|        7369 | SMITH | CLERK |    7902 | 1980-12-17  | 800.00 |      20 |      NULL |
+-------------+-------+-------+---------+-------------+--------+---------+-----------+

--038. Display the location of ‘Smith’

SELECT 
	employee_no,
	employee.name,
	employee.job,
	department.location
FROM employee
INNER JOIN department
	ON 1=1
	AND employee.dept_no = department.dept_no
WHERE employee.name = 'Smith';

--Result

+-------------+-------+-------+----------+
| employee_no | name  | job   | location |
+-------------+-------+-------+----------+
|        7369 | SMITH | CLERK | DALLAS   |
+-------------+-------+-------+----------+

--039. List the total information of emp table along with dname and loc of all the emps working under ‘Accounting’ & ‘Research’ in the asc deptno

SELECT
	employee.*,
	department.name,
	department.location
FROM employee
INNER JOIN department
	ON 1=1
	AND department.dept_no = employee.dept_no
WHERE 1=1
	AND department.name IN ('Accounting', 'Research')
LIMIT 3;
	
--Result

+-------------+--------+-----------+---------+-------------+---------+---------+-----------+------------+----------+
| employee_no | name   | job       | manager | hiredate_dt | salary  | dept_no | commisson | name       | location |
+-------------+--------+-----------+---------+-------------+---------+---------+-----------+------------+----------+
|        7782 | CLARK  | MANAGER   |    7839 | 1981-06-09  | 2450.00 |      10 |      NULL | ACCOUNTING | NEW YORK |
|        7839 | KING   | PRESIDENT |    NULL | 1981-11-17  | 5000.00 |      10 |      NULL | ACCOUNTING | NEW YORK |
|        7934 | MILLER | CLERK     |    7782 | 1982-01-23  | 1300.00 |      10 |      NULL | ACCOUNTING | NEW YORK |
+-------------+--------+-----------+---------+-------------+---------+---------+-----------+------------+----------+


--040. List the empno, ename, sal, dname of all the ‘Mgrs’ and ‘Analyst’ working in NEWYORK, DALLAS with an exp more than 7 years without receiving the Comma Asc order of Loc.

SELECT
	employee_no,
	employee.name,
	employee.salary,
	department.name,
	department.location
FROM employee
INNER JOIN department
	ON 1=1
	AND department.dept_no = employee.dept_no
WHERE 1=1
	AND employee.commisson IS NULL
	AND department.location IN ('NEW YORK','DALLAS')
	AND TIMESTAMPDIFF(MONTH, employee.hiredate_dt, NOW())/ 12 > 7
LIMIT 5;
	
--Result

+-------------+--------+---------+------------+----------+
| employee_no | name   | salary  | name       | location |
+-------------+--------+---------+------------+----------+
|        7782 | CLARK  | 2450.00 | ACCOUNTING | NEW YORK |
|        7839 | KING   | 5000.00 | ACCOUNTING | NEW YORK |
|        7934 | MILLER | 1300.00 | ACCOUNTING | NEW YORK |
|        7369 | SMITH  |  800.00 | RESEARCH   | DALLAS   |
|        7566 | JONES  | 2975.00 | RESEARCH   | DALLAS   |
+-------------+--------+---------+------------+----------+

--041. List the empno, ename, sal, dname, loc, deptno, job of all emps working at CHICAGO or working for ACCOUNTING dept wit ann sal > 28000, but the sal should not be = 3000 or 2800 who doesn’t belongs to the Mgr and whose no is having a digit ‘7’ or ‘8’ in 3rd position in the asc order of deptno and desc order of job

SELECT 
	employee_no,
	employee.name,
	employee.job,
	employee.salary,
	department.name,
	department.location
FROM employee
INNER JOIN department
	ON 1=1
	AND department.dept_no = employee.dept_no
WHERE 1=1
	AND department.name = 'ACCOUNTING'
	AND employee.salary*12 > 28000
	AND employee.salary NOT IN (2800, 3000)
	AND employee.manager IS NULL /* means doesnot belong to any manager*/
	AND employee_no LIKE '__7%' 
	OR employee_no LIKE '__8%'
ORDER BY employee.dept_no ASC, job DESC;

--Result

+-------------+-------+---------+---------+------------+----------+
| employee_no | name  | job     | salary  | name       | location |
+-------------+-------+---------+---------+------------+----------+
|        7782 | CLARK | MANAGER | 2450.00 | ACCOUNTING | NEW YORK |
|        7788 | SCOTT | ANALYST | 3000.00 | RESEARCH   | DALLAS   |
+-------------+-------+---------+---------+------------+----------+

--042. Display the total information of the emps along with grades in the asc order

SELECT 
	employee.*,
	salarygrade.grade
FROM employee
INNER JOIN salarygrade
	ON 1=1
	AND employee.salary BETWEEN salarygrade.low_salary AND salarygrade.high_salary
ORDER BY salarygrade.grade ASC
LIMIT 5;

--Result

+-------------+-------+-------+---------+-------------+---------+---------+-----------+-------+
| employee_no | name  | job   | manager | hiredate_dt | salary  | dept_no | commisson | grade |
+-------------+-------+-------+---------+-------------+---------+---------+-----------+-------+
|        7876 | ADAMS | CLERK |    7788 | 1987-07-13  | 1100.00 |      20 |      NULL |     1 |
|        7900 | JAMES | CLERK |    7698 | 1981-12-03  |  950.00 |      30 |      NULL |     1 |
|        7369 | SMITH | CLERK |    7902 | 1980-12-17  |  800.00 |      20 |      NULL |     1 |
|        7900 | JAMES | CLERK |    7698 | 1981-12-03  |  950.00 |      30 |      NULL |     1 |
|        7369 | SMITH | CLERK |    7902 | 1980-12-17  |  800.00 |      20 |      NULL |     1 |
+-------------+-------+-------+---------+-------------+---------+---------+-----------+-------+

--043. List all the grade 2 and grade 3 emps

SELECT
	/* We are using Distinct because insalarygrade there is no primary key to join table so there is change of duplicate rows*/
	DISTINCT employee.*,
	salarygrade.grade
FROM employee
INNER JOIN salarygrade
	ON 1=1
	AND employee.salary BETWEEN salarygrade.low_salary AND salarygrade.high_salary
WHERE 1=1
	AND salarygrade.grade IN (2, 3)
LIMIT 5;

--Result

+-------------+--------+----------+---------+-------------+---------+---------+-----------+-------+
| employee_no | name   | job      | manager | hiredate_dt | salary  | dept_no | commisson | grade |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+-------+
|        7499 | ALLEN  | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |     3 |
|        7521 | WARD   | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |     2 |
|        7654 | MARTIN | SALESMAN |    7698 | 1981-09-28  | 1250.00 |      30 |   1400.00 |     2 |
|        7844 | TURNER | SALESMAN |    7698 | 1981-09-08  | 1500.00 |      30 |      0.00 |     3 |
|        7934 | MILLER | CLERK    |    7782 | 1982-01-23  | 1300.00 |      10 |      NULL |     2 |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+-------+

--044. Display all grade 4,5 Analyst and Mgr

SELECT
	/* We are using Distinct because insalarygrade there is no primary key to join table so there is change of duplicate rows*/
	DISTINCT employee.*,
	salarygrade.grade
FROM employee, salarygrade
WHERE 1=1
	AND employee.salary BETWEEN salarygrade.low_salary AND salarygrade.high_salary
	AND salarygrade.grade IN (4, 5)
	AND employee.job IN ('ANALYST', 'MANAGER');

--Result

+-------------+-------+---------+---------+-------------+---------+---------+-----------+-------+
| employee_no | name  | job     | manager | hiredate_dt | salary  | dept_no | commisson | grade |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+-------+
|        7566 | JONES | MANAGER |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |     4 |
|        7698 | BLAKE | MANAGER |    7839 | 1981-05-01  | 2850.00 |      30 |      NULL |     4 |
|        7782 | CLARK | MANAGER |    7839 | 1981-06-09  | 2450.00 |      10 |      NULL |     4 |
|        7788 | SCOTT | ANALYST |    7566 | 1987-07-13  | 3000.00 |      20 |      NULL |     4 |
|        7902 | FORD  | ANALYST |    7566 | 1981-12-03  | 3000.00 |      20 |      NULL |     4 |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+-------+

--045. List the empno, ename, sal, dname, grade, exp, ann sal of emps working for dept 20 or 10

SELECT
	/* We are using Distinct because in salarygrade there is no primary key to join table so there is change of duplicate rows*/
	DISTINCT
	employee_no,
	employee.name,
	employee.salary,
	employee.salary *12 AS annual_salary,
	employee.dept_no,
	department.name,
	salarygrade.grade
FROM employee
INNER JOIN salarygrade
	ON 1=1
	AND employee.salary BETWEEN salarygrade.low_salary AND salarygrade.high_salary
INNER JOIN department
	ON 1=1
	AND department.dept_no = employee.dept_no
WHERE 1=1
	AND employee.dept_no IN (20, 10)
LIMIT 5;

--Result

+-------------+--------+---------+---------------+---------+------------+-------+
| employee_no | name   | salary  | annual_salary | dept_no | name       | grade |
+-------------+--------+---------+---------------+---------+------------+-------+
|        7369 | SMITH  |  800.00 |       9600.00 |      20 | RESEARCH   |     1 |
|        7876 | ADAMS  | 1100.00 |      13200.00 |      20 | RESEARCH   |     1 |
|        7934 | MILLER | 1300.00 |      15600.00 |      10 | ACCOUNTING |     2 |
|        7782 | CLARK  | 2450.00 |      29400.00 |      10 | ACCOUNTING |     4 |
|        7566 | JONES  | 2975.00 |      35700.00 |      20 | RESEARCH   |     4 |
+-------------+--------+---------+---------------+---------+------------+-------+
