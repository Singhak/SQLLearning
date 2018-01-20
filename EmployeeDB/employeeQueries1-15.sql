-- 001. Display all the information of the emp table.
SELECT *
FROM employee
LIMIT 5;

-- Result

+-------------+--------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+
|        7369 | SMITH  | CLERK    |    7902 | 2019-12-17  |  800.00 |      20 |      NULL |
|        7499 | ALLEN  | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |
|        7521 | WARD   | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |
|        7566 | JONES  | MANAGER  |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |
|        7654 | MARTIN | SALESMAN |    7698 | 1981-09-28  | 1250.00 |      30 |   1400.00 |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+

--002. Display unique jobs from EMP table.

SELECT
	DISTINCT job
FROM employee;

--Result
+-----------+
| job       |
+-----------+
| CLERK     |
| SALESMAN  |
| MANAGER   |
| ANALYST   |
| PRESIDENT |
+-----------+

-- 003. List the details of the emps in asc order of their salaries.

SELECT *
FROM employee
ORDER BY employee.salary ASC
LIMIT 5;

--Result

+-------------+--------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+
|        7369 | SMITH  | CLERK    |    7902 | 2019-12-17  |  800.00 |      20 |      NULL |
|        7900 | JAMES  | CLERK    |    7698 | 1981-12-03  |  950.00 |      30 |      NULL |
|        7876 | ADAMS  | CLERK    |    7788 | 1987-07-13  | 1100.00 |      20 |      NULL |
|        7521 | WARD   | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |
|        7654 | MARTIN | SALESMAN |    7698 | 1981-09-28  | 1250.00 |      30 |   1400.00 |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+

--004. List the details of the emps in asc order of the Deptnos and desc of Jobs.

SELECT *
FROM employee
ORDER BY
	employee.dept_no ASC,
	employee.job DESC
LIMIT 5;

--Result

+-------------+--------+-----------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job       | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+-----------+---------+-------------+---------+---------+-----------+
|        7839 | KING   | PRESIDENT |    NULL | 1981-11-17  | 5000.00 |      10 |      NULL |
|        7782 | CLARK  | MANAGER   |    7839 | 1981-06-09  | 2450.00 |      10 |      NULL |
|        7934 | MILLER | CLERK     |    7782 | 1982-01-23  | 1300.00 |      10 |      NULL |
|        7566 | JONES  | MANAGER   |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |
|        7876 | ADAMS  | CLERK     |    7788 | 1987-07-13  | 1100.00 |      20 |      NULL |
+-------------+--------+-----------+---------+-------------+---------+---------+-----------+

-- 005. Display all the unique job groups in the descending order

SELECT
	DISTINCT employee.job
FROM employee
ORDER BY job DESC;

-- Result

+-----------+
| job       |
+-----------+
| SALESMAN  |
| PRESIDENT |
| MANAGER   |
| CLERK     |
| ANALYST   |
+-----------+

-- 006. Display all the details of all manager

SELECT *
FROM employee
WHERE 1=1
	AND job = 'MANAGER';
	
--Result

+-------------+-------+---------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job     | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+
|        7566 | JONES | MANAGER |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |
|        7698 | BLAKE | MANAGER |    7839 | 1981-05-01  | 2850.00 |      30 |      NULL |
|        7782 | CLARK | MANAGER |    7839 | 1981-06-09  | 2450.00 |      10 |      NULL |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+

-- 007. List the emps who joined before 1981.
SELECT *
FROM employee
WHERE EXTRACT(YEAR FROM employee.hiredate_dt) < 1981; /* we can use YERAR(employee.hiredate_dt) also or direct comparison  employee.hiredate_dt < 01-01-19981*/

--Result

+-------------+-------+-------+---------+-------------+--------+---------+-----------+
| employee_no | name  | job   | manager | hiredate_dt | salary | dept_no | commisson |
+-------------+-------+-------+---------+-------------+--------+---------+-----------+
|        7369 | SMITH | CLERK |    7902 | 1980-12-17  | 800.00 |      20 |      NULL |
+-------------+-------+-------+---------+-------------+--------+---------+-----------+

-- 008. List the Empno, Ename, Sal, Annual Sal of all Employees in the ASC order of AnnSal

SELECT 
	employee.employee_no,
	employee.name,
	employee.salary,
	employee.salary * 12 AS annual_salary
FROM employee
ORDER BY annual_salary
LIMIT 3;

--Result

+-------------+-------+---------+---------------+
| employee_no | name  | salary  | annual_salary |
+-------------+-------+---------+---------------+
|        7369 | SMITH |  800.00 |       9600.00 |
|        7900 | JAMES |  950.00 |      11400.00 |
|        7876 | ADAMS | 1100.00 |      13200.00 |
+-------------+-------+---------+---------------+

-- 009. Display the empno , ename, job, hiredate, exp of all Mgrs

SELECT
	employee.employee_no,
	employee.name,
	employee.job,
	employee.hiredate_dt,
	ROUND
		(
			TIMESTAMPDIFF(MONTH, employee.hiredate_dt, NOW())/ 12,
			0
		) AS experience
FROM employee
WHERE 1=1
	AND job = 'MANAGER';
	
--Result

+-------------+-------+---------+-------------+------------+
| employee_no | name  | job     | hiredate_dt | experience |
+-------------+-------+---------+-------------+------------+
|        7566 | JONES | MANAGER | 1981-04-02  |         37 |
|        7698 | BLAKE | MANAGER | 1981-05-01  |         37 |
|        7782 | CLARK | MANAGER | 1981-06-09  |         37 |
+-------------+-------+---------+-------------+------------+

-- 010. List the empno, ename, sal, exp of all emps working for Mgr 7839.

SELECT
	employee.employee_no,
	employee.name,
	employee.salary,
	ROUND
		(
			TIMESTAMPDIFF(MONTH, employee.hiredate_dt, NOW())/ 12,
			0
		) AS experience /* For experience you can also use SYSDATE() - hiredate_dt*/
FROM employee
WHERE 1=1
	AND employee.manager = '7839';
	
--Result

+-------------+-------+---------+-------------+------------+
| employee_no | name  | job     | hiredate_dt | experience |
+-------------+-------+---------+-------------+------------+
|        7566 | JONES | MANAGER | 1981-04-02  |         37 |
|        7698 | BLAKE | MANAGER | 1981-05-01  |         37 |
|        7782 | CLARK | MANAGER | 1981-06-09  |         37 |
+-------------+-------+---------+-------------+------------+

-- 011. Display the details of the emps whose commission. Is more than their salary.

SELECT *
FROM employee
WHERE employee.salary < employee.commisson;

--Result

+-------------+--------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+
|        7654 | MARTIN | SALESMAN |    7698 | 1981-09-28  | 1250.00 |      30 |   1400.00 |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+

-- 012. List the emps in the asc order of Designations

SELECT *
FROM employee
ORDER BY job
LIMIT 3;

-- Result

+-------------+-------+---------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job     | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+
|        7788 | SCOTT | ANALYST |    7566 | 1987-07-13  | 3000.00 |      20 |      NULL |
|        7902 | FORD  | ANALYST |    7566 | 1981-12-03  | 3000.00 |      20 |      NULL |
|        7900 | JAMES | CLERK   |    7698 | 1981-12-03  |  950.00 |      30 |      NULL |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+

-- 013. List the emps along with their exp and daily sal is more than Rs.100
SELECT
	employee.employee_no,
	employee.name,
	employee.job,
	employee.salary,
	employee.hiredate_dt,
	ROUND(employee.salary/30, 2) AS daily_salary,
	ROUND
		(
			TIMESTAMPDIFF(MONTH, employee.hiredate_dt, NOW())/ 12,
			0
		) AS experience
FROM employee
WHERE 1=1
	AND employee.salary/30 > 100;

-- Result

+-------------+------+-----------+---------+-------------+--------------+------------+
| employee_no | name | job       | salary  | hiredate_dt | daily_salary | experience |
+-------------+------+-----------+---------+-------------+--------------+------------+
|        7839 | KING | PRESIDENT | 5000.00 | 1981-11-17  |       166.67 |         36 |
+-------------+------+-----------+---------+-------------+--------------+------------+

-- 014. List the emps who are either ‘CLERK’ or ‘ANALYST’ in the desc order

SELECT *
FROM employee
WHERE 1=1
	AND job IN ('CLERK','ANALYST')
ORDER BY job DESC;

--Result

+-------------+--------+---------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job     | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+---------+---------+-------------+---------+---------+-----------+
|        7369 | SMITH  | CLERK   |    7902 | 1980-12-17  |  800.00 |      20 |      NULL |
|        7876 | ADAMS  | CLERK   |    7788 | 1987-07-13  | 1100.00 |      20 |      NULL |
|        7900 | JAMES  | CLERK   |    7698 | 1981-12-03  |  950.00 |      30 |      NULL |
|        7934 | MILLER | CLERK   |    7782 | 1982-01-23  | 1300.00 |      10 |      NULL |
|        7788 | SCOTT  | ANALYST |    7566 | 1987-07-13  | 3000.00 |      20 |      NULL |
|        7902 | FORD   | ANALYST |    7566 | 1981-12-03  | 3000.00 |      20 |      NULL |
+-------------+--------+---------+---------+-------------+---------+---------+-----------+

-- 015. List the emps who joined on 1May81,31Dec81, 17Dec81, 19Jan80 in asc order of seniority

SELECT *
FROM employee
WHERE 1=1
	AND	hiredate_dt IN ('1981-05-01','1981-12-31', '1981-12-17', '1980-01-19')
ORDER BY hiredate_dt ASC;

--Result

+-------------+-------+---------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job     | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+
|        7698 | BLAKE | MANAGER |    7839 | 1981-05-01  | 2850.00 |      30 |      NULL |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+

