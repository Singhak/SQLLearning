--106. List the records from emp whose deptno is not in dept

SELECT 
	emp.*
FROM employee AS emp
LEFT JOIN department AS dept
	ON dept.dept_no = emp.dept_no
WHERE 1=1
	AND dept.dept_no IS NULL

--Result
Empyt set

--107. List the name, sal, comm. And netpay(sal + commisson) is more than any other employee sal.

SELECT 
	emp.name,
	(emp.salary + IFNULL(emp.commisson,0)) AS net_pay
FROM employee AS emp
WHERE 1=1
	AND (emp.salary + IFNULL(emp.commisson,0)) >= (
		SELECT 
			MAX(employee.salary)
		FROM employee
	)
	
--Result

+------+---------+
| name | net_pay |
+------+---------+
| KING | 5000.00 |
+------+---------+

--108. List the enames who are retiring after ’31-DEC-89’ the max job period is 20Y

SELECT 
	emp.name,
	emp.hiredate_dt,
	ROUND(
		TIMESTAMPDIFF(MONTH, hiredate_dt, NOW())/12 ,
		0
	) AS exprns_yr
FROM employee AS emp
WHERE 1=1
	AND TIMESTAMPDIFF(MONTH, hiredate_dt, NOW())/12 > 35
	LIMIT 5;
	
--Result

+--------+-------------+-----------+
| name   | hiredate_dt | exprns_yr |
+--------+-------------+-----------+
| SMITH  | 1980-12-17  |        37 |
| ALLEN  | 1981-02-20  |        37 |
| WARD   | 1981-02-22  |        37 |
| JONES  | 1981-04-02  |        37 |
| MARTIN | 1981-09-28  |        36 |
+--------+-------------+-----------+

--109. List those emps whose sal is odd value.

SELECT
	emp.*
FROM employee AS emp
WHERE 1=1
	AND emp.salary % 2 <> 0;
	
--Result

+-------------+-------+---------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job     | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+
|        7566 | JONES | MANAGER |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+

--110. List the emps whose sal contain 3 digits

SELECT
	emp.name,
	emp.job,
	CAST(emp.salary AS UNSIGNED) AS salary
FROM employee AS emp
WHERE 1=1
	AND length(CAST(emp.salary AS UNSIGNED)) = 3;
	
--Result

+-------+-------+--------+
| name  | job   | salary |
+-------+-------+--------+
| SMITH | CLERK |    800 |
| JAMES | CLERK |    950 |
+-------+-------+--------+

--111. List the emps who joined in the month of ‘DEC’

SELECT 
	emp.*
FROM employee
WHERE 1=1
	AND MONTH(hiredate_dt) = 12

--Result

+-------------+-------+---------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job     | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+
|        7369 | SMITH | CLERK   |    7902 | 1980-12-17  |  800.00 |      20 |      NULL |
|        7900 | JAMES | CLERK   |    7698 | 1981-12-03  |  950.00 |      30 |      NULL |
|        7902 | FORD  | ANALYST |    7566 | 1981-12-03  | 3000.00 |      20 |      NULL |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+

--112. List the emps whose names contains ‘A'

SELECT
	emp.*
FROM employee AS emp
WHERE 1=1
	AND emp.name LIKE '%a%'
LIMIT 5;
	
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

--113. List the emps whose deptno is available in his salary

SELECT
	emp.name,
	emp.job,
	emp.dept_no,
	CAST(emp.salary AS UNSIGNED) AS salary
FROM employee AS emp
WHERE 1=1
	AND CAST(emp.salary AS UNSIGNED) LIKE CONCAT(CONCAT('%', emp.dep),'%');
	
--Result
Empty set

--114. List the emps whose date from hiredate = last 2 chars of salary.

SELECT
	emp.name,
	emp.job,
	emp.dept_no,
	emp.hiredate_dt,
	CAST(emp.salary AS UNSIGNED) AS salary
FROM employee AS emp
WHERE 1=1
	AND SUBSTR(CAST(emp.salary AS UNSIGNED), LENGTH(CAST(emp.salary AS UNSIGNED))-1, 2) = DATE_FORMAT(emp.hiredate_dt, '%d');
	
--Result

Empty set

--115. List the emps whose 10% of sal is equal to year of Joining menas if 1980 then 80 only

SELECT
	emp.*
FROM employee AS emp
WHERE 1=1
	AND CAST(emp.salary AS UNSIGNED) *0.1 = DATE_FORMAT(emp.hiredate_dt, '%y')
	
--Result

+-------------+-------+-------+---------+-------------+--------+---------+-----------+
| employee_no | name  | job   | manager | hiredate_dt | salary | dept_no | commisson |
+-------------+-------+-------+---------+-------------+--------+---------+-----------+
|        7369 | SMITH | CLERK |    7902 | 1980-12-17  | 800.00 |      20 |      NULL |
+-------------+-------+-------+---------+-------------+--------+---------+-----------+
	
--116. List first 50% of chars of ename in lower case and remaining are upper case

SELECT
	emp.name,
	LOWER(SUBSTR(emp.name, 1, LENGTH(emp.name)/2)) AS lower_name,
	UPPER(SUBSTR(emp.name, LENGTH(emp.name)/2)) AS upper_name
FROM employee AS emp
LIMIT 5;

--Result

+--------+------------+------------+
| name   | lower_name | upper_name |
+--------+------------+------------+
| SMITH  | smi        | ITH        |
| ALLEN  | all        | LEN        |
| WARD   | wa         | ARD        |
| JONES  | jon        | NES        |
| MARTIN | mar        | RTIN       |
+--------+------------+------------+

--117. List the dname whose no of emps is = to no of chars in the dname.

SELECT 
	dept.name,
	COUNT(*) AS emp_count
FROM employee AS emp, department AS dept
WHERE 1=1
	AND emp.dept_no = dept.dept_no
GROUP BY dept.name
HAVING emp_count = LENGTH(dept.name);

--Result
Empty set

--118. List the emps those who joined in company before 15th of the month.

SELECT 
	emp.*
FROM employee AS emp
WHERE 1=1
	AND DATE_FORMAT(emp.hiredate_dt) < 15
LIMIT 5;

--Result

+-------------+--------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+
|        7566 | JONES  | MANAGER  |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |
|        7698 | BLAKE  | MANAGER  |    7839 | 1981-05-01  | 2850.00 |      30 |      NULL |
|        7782 | CLARK  | MANAGER  |    7839 | 1981-06-09  | 2450.00 |      10 |      NULL |
|        7788 | SCOTT  | ANALYST  |    7566 | 1987-07-13  | 3000.00 |      20 |      NULL |
|        7844 | TURNER | SALESMAN |    7698 | 1981-09-08  | 1500.00 |      30 |      0.00 |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+

--119. List the dname, no of chars of which is no of emp’s in any other dept

SELECT 
	dept.name,
	LENGTH(dept.name) AS len_dept
FROM department AS dept
WHERE 1=1
	AND LENGTH(dept.name) IN (
		SELECT 
			COUNT(*) AS emp_count
		FROM employee AS emp, department AS dept
		WHERE 1=1
			AND emp.dept_no = dept.dept_no
		GROUP BY dept.name
	)
	
--Result

+-------+----------+
| name  | len_dept |
+-------+----------+
| SALES |        5 |
+-------+----------+

--120. List the emps who are working as managers

SELECT 
	emp.*
FROM employee AS emp
WHERE 1=1
	AND emp.employee_no IN (
		SELECT 
			employee.manager
		FROM employee
	)
	
--Result
	
+-------------+-------+-----------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job       | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+-----------+---------+-------------+---------+---------+-----------+
|        7566 | JONES | MANAGER   |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |
|        7698 | BLAKE | MANAGER   |    7839 | 1981-05-01  | 2850.00 |      30 |      NULL |
|        7782 | CLARK | MANAGER   |    7839 | 1981-06-09  | 2450.00 |      10 |      NULL |
|        7788 | SCOTT | ANALYST   |    7566 | 1987-07-13  | 3000.00 |      20 |      NULL |
|        7839 | KING  | PRESIDENT |    NULL | 1981-11-17  | 5000.00 |      10 |      NULL |
|        7902 | FORD  | ANALYST   |    7566 | 1981-12-03  | 3000.00 |      20 |      NULL |
+-------------+-------+-----------+---------+-------------+---------+---------+-----------+






