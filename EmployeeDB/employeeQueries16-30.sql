-- 016. List the emps who are working for the deptno 10 or 20

SELECT *
FROM employee
WHERE 1=1
	AND dept_no IN (10,20)
LIMIT 3;

-- Result

+-------------+--------+-----------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job       | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+-----------+---------+-------------+---------+---------+-----------+
|        7782 | CLARK  | MANAGER   |    7839 | 1981-06-09  | 2450.00 |      10 |      NULL |
|        7839 | KING   | PRESIDENT |    NULL | 1981-11-17  | 5000.00 |      10 |      NULL |
|        7934 | MILLER | CLERK     |    7782 | 1982-01-23  | 1300.00 |      10 |      NULL |
+-------------+--------+-----------+---------+-------------+---------+---------+-----------+

-- 017. List the emps who are joined in the year 1981

SELECT *
FROM employee
WHERE 1=1
	AND YEAR(hiredate_dt) = 1981
LIMIT 3;

--Result

+-------------+-------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+----------+---------+-------------+---------+---------+-----------+
|        7499 | ALLEN | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |
|        7521 | WARD  | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |
|        7566 | JONES | MANAGER  |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |
+-------------+-------+----------+---------+-------------+---------+---------+-----------+

--018. List the emps who are joined in the month of Aug 1980

SELECT *
FROM employee
WHERE 1=1
	AND MONTH(hiredate_dt) = 9
	AND YEAR(hiredate_dt) = 1981;
	
--Result

+-------------+--------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+
|        7654 | MARTIN | SALESMAN |    7698 | 1981-09-28  | 1250.00 |      30 |   1400.00 |
|        7844 | TURNER | SALESMAN |    7698 | 1981-09-08  | 1500.00 |      30 |      0.00 |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+

--019. List the emps whose annul sal ranging from 22000 and 45000

SELECT *
FROM employee
WHERE 1=1
	AND employee.salary*12 BETWEEN 22000 AND 45000;
	
--Result

+-------------+-------+---------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job     | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+
|        7566 | JONES | MANAGER |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |
|        7698 | BLAKE | MANAGER |    7839 | 1981-05-01  | 2850.00 |      30 |      NULL |
|        7782 | CLARK | MANAGER |    7839 | 1981-06-09  | 2450.00 |      10 |      NULL |
|        7788 | SCOTT | ANALYST |    7566 | 1987-07-13  | 3000.00 |      20 |      NULL |
|        7902 | FORD  | ANALYST |    7566 | 1981-12-03  | 3000.00 |      20 |      NULL |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+

--020. List the emps those are having five characters in their names

SELECT *
FROM employee
WHERE 1=1
	AND LENGTH(employee.name) = 5;
	
--Result

+-------------+-------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+----------+---------+-------------+---------+---------+-----------+
|        7369 | SMITH | CLERK    |    7902 | 1980-12-17  |  800.00 |      20 |      NULL |
|        7499 | ALLEN | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |
|        7566 | JONES | MANAGER  |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |
+-------------+-------+----------+---------+-------------+---------+---------+-----------+

--021. List the enames those are starting with ‘s’ and with fire characters

SELECT employee.name
FROM employee
WHERE 1=1
	AND employee.name LIKE 's%';
	
--Result

+-------+
| name  |
+-------+
| SMITH |
| SCOTT |
+-------+

--022. List the emps those are having four chars and third char must be ‘r'

SELECT employee.name
FROM employee
WHERE 1=1
	AND employee.name LIKE '__r_';
	
--Result

+------+
| name |
+------+
| WARD |
| FORD |
+------+

--023. List the 5 character names starting with ‘s’ and ending with ‘h'

SELECT employee.name
FROM employee
WHERE 1=1
	AND employee.name LIKE 's___h';
	
--Result

+-------+
| name  |
+-------+
| SMITH |
+-------+

--024. List the emps who joined in January

SELECT *
FROM employee
WHERE 1=1
	AND MONTH(employee.hiredate_dt) = 1;
	
--Result

+-------------+--------+-------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job   | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+-------+---------+-------------+---------+---------+-----------+
|        7934 | MILLER | CLERK |    7782 | 1982-01-23  | 1300.00 |      10 |      NULL |
+-------------+--------+-------+---------+-------------+---------+---------+-----------+

--025. List the emps who joined in the month of which second character is ‘a'

SELECT
	employee_no,
	employee.name,
	employee.job,
	DATE_FORMAT(employee.hiredate_dt, '%Y-%M-%d') AS joining_date
FROM employee
WHERE 1=1
	AND DATE_FORMAT(employee.hiredate_dt, '%M') LIKE '_a%'; /* In db Month in number format so conver into name fomate then checking condition*/

--Result

+-------------+--------+---------+-----------------+
| employee_no | name   | job     | joining_date    |
+-------------+--------+---------+-----------------+
|        7698 | BLAKE  | MANAGER | 1981-May-01     |
|        7934 | MILLER | CLERK   | 1982-January-23 |
+-------------+--------+---------+-----------------+

--026. List the emps whose sal is 4 digit number ending with zero

SELECT
	employee_no,
	employee.name,
	employee.job,
	employee.salary
FROM employee
WHERE 1=1
	/* Cast of salary to integer because in db salary store as decimal(9,2) which is not appropriate format for this query*/
	AND LENGTH(CAST(employee.salary AS UNSIGNED)) = 4
	AND CAST(employee.salary AS UNSIGNED) LIKE '%0'
LIMIT 3;

--Result

+-------------+--------+----------+---------+
| employee_no | name   | job      | salary  |
+-------------+--------+----------+---------+
|        7499 | ALLEN  | SALESMAN | 1600.00 |
|        7521 | WARD   | SALESMAN | 1250.00 |
|        7654 | MARTIN | SALESMAN | 1250.00 |
+-------------+--------+----------+---------+

--027. List the emps whose names having a character set ‘ll’ together

SELECT 
	employee.name
FROM employee
WHERE 1=1
	AND employee.name LIKE '%ll%';
	
--Result

+--------+
| name   |
+--------+
| ALLEN  |
| MILLER |
+--------+

--028. List the emps those who joined in 80’s

SELECT 
	employee.name,
	employee.hiredate_dt
FROM employee
WHERE 1=1
	AND YEAR(employee.hiredate_dt) = 1980;

--Result

+-------+-------------+
| name  | hiredate_dt |
+-------+-------------+
| SMITH | 1980-12-17  |
+-------+-------------+

--029. List the emps who does not belong to deptno 20

SELECT
	employee.name,
	employee.dept_no
FROM employee
WHERE 1=1
	AND employee.dept_no != 20
LIMIT 3;

--Result

+--------+---------+
| name   | dept_no |
+--------+---------+
| CLARK  |      10 |
| KING   |      10 |
| MILLER |      10 |
+--------+---------+

--030. List all the emps except ‘president’ & ‘Mgr’ in asc order of salaries

SELECT *
FROM employee
WHERE 1=1
	AND employee.job NOT IN ('PRESIDENT', 'MANAGER')
LIMIT 3;
	
--Result

+-------------+-------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+----------+---------+-------------+---------+---------+-----------+
|        7369 | SMITH | CLERK    |    7902 | 1980-12-17  |  800.00 |      20 |      NULL |
|        7499 | ALLEN | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |
|        7521 | WARD  | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |
+-------------+-------+----------+---------+-------------+---------+---------+-----------+