-- 061. List the emps of Emp1 who are not found in deptno 20
SELECT *
FROM employee
WHERE 1=1
	AND employee_no NOT IN (
		SELECT 
			employee_no 
		FROM employee 
		WHERE employee.dept_no = 20);
		
--Result

+-------------+--------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+
|        7499 | ALLEN  | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |
|        7521 | WARD   | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |
|        7654 | MARTIN | SALESMAN |    7698 | 1981-09-28  | 1250.00 |      30 |   1400.00 |
|        7698 | BLAKE  | MANAGER  |    7839 | 1981-05-01  | 2850.00 |      30 |      NULL |
|        7782 | CLARK  | MANAGER  |    7839 | 1981-06-09  | 2450.00 |      10 |      NULL |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+

--062. Find the highest Sal of the Emp table.

SELECT 
	MAX(employee.salary)
FROM employee;

--Result

+----------------+
| highest_salary |
+----------------+
|        5000.00 |
+----------------+

--063. Find the details of highest paid employee

SELECT *
FROM employee
WHERE 1=1
	AND employee.salary = (
		SELECT 
			MAX(employe.salary) AS highest_salary
		FROM employee
		);
		
--Result

+-------------+------+-----------+---------+-------------+---------+---------+-----------+
| employee_no | name | job       | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+------+-----------+---------+-------------+---------+---------+-----------+
|        7839 | KING | PRESIDENT |    NULL | 1981-11-17  | 5000.00 |      10 |      NULL |
+-------------+------+-----------+---------+-------------+---------+---------+-----------+

--064. Find the highest paid employee of sales dept

SELECT 
	employee.*
FROM employee
WHERE employee.salary = (
	SELECT 
		MAX(employee.salary) 
	FROM employee, department 
	WHERE 1=1
		AND department.dept_no = employee.dept_no 
		AND department.name = 'SALES'
	);
	
--Result
+-------------+-------+---------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job     | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+
|        7698 | BLAKE | MANAGER |    7839 | 1981-05-01  | 2850.00 |      30 |      NULL |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+

--065. List the most recently hired emp of grade 3 belongs to the Loc CHICAGO

SELECT 
	DISTINCT
	employee.*,
	salarygrade.grade, 
	department.name
FROM employee, salarygrade, department
WHERE 1=1
	AND employee.salary BETWEEN salarygrade.low_salary AND salarygrade.high_salary
	AND salarygrade.grade = 3
	AND department.dept_no = employee.dept_no
	AND department.location = 'CHICAGO';

--Result

+-------------+--------+----------+---------+-------------+---------+---------+-----------+-------+----------+
| employee_no | name   | job      | manager | hiredate_dt | salary  | dept_no | commisson | grade | location |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+-------+----------+
|        7499 | ALLEN  | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |     3 | CHICAGO  |
|        7844 | TURNER | SALESMAN |    7698 | 1981-09-08  | 1500.00 |      30 |      0.00 |     3 | CHICAGO  |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+-------+----------+

--066. List the emps who are senior to most recently hired emp who is working under Mgr KING

SELECT *
FROM employee
WHERE 1=1
	AND employee.hiredate_dt = (
		SELECT MAX(employee.hiredate_dt)
		FROM employee
		)
	AND employee.manager IN (
		SELECT employee_no
		FROM employee
		WHERE 1=1
			AND employee.name = 'MANAGER'
		);
--Result
Empty set

--067. List the details of emp belongs to New York with the Grade 3 to 5 except ‘PRESIDENT’ whose sal > the highest paid emp of CHICAGO in Group where there is ‘MANAGER’ & ‘ANALYST’ not working for Mgr KING

WHERE 1=1
	AND deparment.location = 'NEW YORK'
	AND salarygrade.grade BETWEEN 3 AND 5
	AND employee.name != 'PRESIDENT'
	AND department.dept_no = employee.dept_no 
	AND employee.salary > (
		SELECT employee.salary
		FROM employee, department
		WHERE  1=1
			AND department.dept_no = employee.dept_no 
			AND department.location = 'CHICAGO'
			AND employee.job NOT IN ('MANAGER', 'ANALYST')
		)
	AND employee.manager NOT IN (
			SELECT 
				employee_no
			FROM employee
			WHERE employee.name = 'KING'
			);
			
--068 Display the details of most senior employee belongs to 1981.

SELECT *
FROM employee
WHERE 1=1
	AND employee.hiredate_dt = (
		SELECT 
			MIN(employee.hiredate_dt)
		FROM employee
		WHERE 1=1
			AND YEAR(employee.hiredate_dt) = 1981
	);
	
--Result

+-------------+-------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+----------+---------+-------------+---------+---------+-----------+
|        7499 | ALLEN | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |
+-------------+-------+----------+---------+-------------+---------+---------+-----------+

--069. List the emps who joined in 81 with job same as the most senior person of year 81.

SELECT *
FROM employee
WHERE 1=1
	AND employee.job = (
		SELECT 
			employee.job
		FROM employee
		WHERE employee.hiredate_dt = (
			SELECT 
				MIN(employee.hiredate_dt)
			FROM employee
			WHERE 1=1
				AND YEAR(employee.hiredate_dt) = 1981
			)
	)
	AND YEAR(employee.hiredate_dt) = 1981;
	
--Result

+-------------+--------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+
|        7499 | ALLEN  | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |
|        7521 | WARD   | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |
|        7654 | MARTIN | SALESMAN |    7698 | 1981-09-28  | 1250.00 |      30 |   1400.00 |
|        7844 | TURNER | SALESMAN |    7698 | 1981-09-08  | 1500.00 |      30 |      0.00 |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+

--070. List the most senior emp working under KING and Grade is more than 3

SELECT *
FROM employee, salarygrade
WHERE 1=1
	AND employee.hiredate_dt = (
		SELECT 
			MAX(employee.hiredate_dt)
		FROM employee
		WHERE 1=1
			AND employee.manager = (
			SELECT 
				employee_no
			FROM employee
			WHERE 1=1
				AND employee.name = 'KING'
			)
		)
	AND employee.salary BETWEEN salarygrade.low_salary AND salarygrade.high_salary
	AND salarygrade.grade = 3;
	
--Result

Empty Set

--071. Find the total sal given to the ‘MGR

SELECT 
	SUM(employee.salary) AS toatal_mgr_sal
FROM employee
WHERE 1=1
	AND employee.job = 'MANAGER';
	
--Result

+----------------+
| toatal_mgr_sal |
+----------------+
|        8275.00 |
+----------------+

--072. Find the total annual sal to distribute job wise in the year 81

SELECT 
	employee.job, 
	SUM(employee.salary * 12) AS total_salary
FROM employee
GROUP BY employee.job;

--Result

+-----------+--------------+
| job       | total_salary |
+-----------+--------------+
| ANALYST   |     72000.00 |
| CLERK     |     49800.00 |
| MANAGER   |     99300.00 |
| PRESIDENT |     60000.00 |
| SALESMAN  |     67200.00 |
+-----------+--------------+

--073. Display the total sal of emps belong to Grade 3.

SELECT 
	SUM(employee.salary) AS grade3_total_msal
FROM employee, salarygrade
WHERE 1=1
	AND employee.salary BETWEEN salarygrade.low_salary AND salarygrade.high_salary
	AND salary.grade = 3;
	
--Result

+-------------------+
| grade3_total_msal |
+-------------------+
|           6200.00 |
+-------------------+

--074. Display the avg salaries of all CLERKS

SELECT
	ROUND(
		AVG(employee.salary),
		2
		) AS celerk_Avgsal
FROM employee
WHERE 1=1
	AND employee.job = 'CLERK';
	
--Result

+---------------+
| celerk_Avgsal |
+---------------+
|       1037.50 |
+---------------+
	
--075. List the emps in dept 20 whose sal is > the avg sal of deptno 10 emps

SELECT *
FROM employee
WHERE 1=1
	AND employee.dept_no = 20
	AND employee.salary > (
		SELECT A
			VG(employee.salary)
		FROM employee
		WHERE 1=1
			AND employee.dept_no = 10
		);
		
--Result

+-------------+-------+---------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job     | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+
|        7566 | JONES | MANAGER |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |
|        7788 | SCOTT | ANALYST |    7566 | 1987-07-13  | 3000.00 |      20 |      NULL |
|        7902 | FORD  | ANALYST |    7566 | 1981-12-03  | 3000.00 |      20 |      NULL |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+

