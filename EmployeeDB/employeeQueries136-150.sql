--136. List the emps who are drawing less than 1000. sort the output by salary.

SELECT 
	employee.*
FROM employee
WHERE 1=1
	AND employee.salary < 1000
ORDER BY employee.salary;

--Result

+-------------+-------+-------+---------+-------------+--------+---------+-----------+
| employee_no | name  | job   | manager | hiredate_dt | salary | dept_no | commisson |
+-------------+-------+-------+---------+-------------+--------+---------+-----------+
|        7369 | SMITH | CLERK |    7902 | 1980-12-17  | 800.00 |      20 |      NULL |
|        7900 | JAMES | CLERK |    7698 | 1981-12-03  | 950.00 |      30 |      NULL |
+-------------+-------+-------+---------+-------------+--------+---------+-----------+

--137. List the employee name, job, annual sal, deptno, dept name, and grade who earn 36000 a year or who are not CLERKS.

SELECT
	emp.name,
	emp.job,
	emp.dept_no,
	(emp.salary * 12) AS nnual_sal
FROM employee AS emp, salarygrade AS sgrade
WHERE 1=1
	AND emp.salary BETWEEN sgrade.low_salary AND sgrade.high_salary
	AND (emp.salary * 12) = 36000
	AND emp.job <> 'CLERK'
	
--Result

+-------+---------+---------+------------+
| name  | job     | dept_no | annual_sal |
+-------+---------+---------+------------+
| SCOTT | ANALYST |      20 |   36000.00 |
| FORD  | ANALYST |      20 |   36000.00 |
+-------+---------+---------+------------+

--138. Find out the job that was filled in the Second half of 1980 and same job that was filled during the same period of 1981

SELECT
	emp2.job,
	emp2.hiredate_dt
FROM employee AS emp, employee AS emp2
WHERE 1=1
	AND emp.hiredate_dt BETWEEN '1980-06-01' AND '1980-12-30'
	AND emp2.hiredate_dt BETWEEN '1981-01-01' AND '1981-12-31'
	AND emp2.job = emp.job
	
--Result

+-------+-------------+
| job   | hiredate_dt |
+-------+-------------+
| CLERK | 1981-12-03  |
+-------+-------------+

--139. Find out the emps who joined in the company before their managers.

SELECT
	emp.*
FROM employee AS emp, employee AS emp2
WHERE 1=1
	AND emp.hiredate_dt < emp2.hiredate_dt
	AND emp2.employee_no = emp.manager;
	
--Result

+-------------+-------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+----------+---------+-------------+---------+---------+-----------+
|        7369 | SMITH | CLERK    |    7902 | 1980-12-17  |  800.00 |      20 |      NULL |
|        7499 | ALLEN | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |
|        7521 | WARD  | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |
|        7566 | JONES | MANAGER  |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |
|        7698 | BLAKE | MANAGER  |    7839 | 1981-05-01  | 2850.00 |      30 |      NULL |
|        7782 | CLARK | MANAGER  |    7839 | 1981-06-09  | 2450.00 |      10 |      NULL |
+-------------+-------+----------+---------+-------------+---------+---------+-----------+

--140. List all the emps by name and number along with their manager’s name and number also list KING who has no ‘Manager’

SELECT 
	emp.employee_no,
	emp.name,
	emp2.employee_no AS mgr_no,
	emp2.name AS mgr_name
FROM employee AS emp
LEFT JOIN employee AS emp2
	ON emp.manager = emp2.employee_no
	
--Result

+-------------+--------+--------+----------+
| employee_no | name   | mgr_no | mgr_name |
+-------------+--------+--------+----------+
|        7369 | SMITH  |   7902 | FORD     |
|        7499 | ALLEN  |   7698 | BLAKE    |
|        7521 | WARD   |   7698 | BLAKE    |
|        7566 | JONES  |   7839 | KING     |
|        7654 | MARTIN |   7698 | BLAKE    |
|        7698 | BLAKE  |   7839 | KING     |
|        7782 | CLARK  |   7839 | KING     |
|        7788 | SCOTT  |   7566 | JONES    |
|        7839 | KING   |   NULL | NULL     |
+-------------+--------+--------+----------+

--141. Find all the emps who earn minimum sal for each job wise in asc order of sal

SELECT 
	employee.name,
	employee.job,
	employee.salary
FROM employee
WHERE 1=1
	AND salary IN (
		SELECT 
			MIN(salary) 
		FROM employee
		GROUP BY job
	) 
ORDER BY salary ;

--Result

+--------+-----------+---------+
| name   | job       | salary  |
+--------+-----------+---------+
| SMITH  | CLERK     |  800.00 |
| WARD   | SALESMAN  | 1250.00 |
| MARTIN | SALESMAN  | 1250.00 |
| CLARK  | MANAGER   | 2450.00 |
| SCOTT  | ANALYST   | 3000.00 |
| FORD   | ANALYST   | 3000.00 |
| KING   | PRESIDENT | 5000.00 |
+--------+-----------+---------+

--142. Find out all the emps who earn highest sal in each job type. Sort in des order of sal

SELECT 
	employee.name,
	employee.job,
	employee.salary
FROM employee
WHERE 1=1
	AND salary IN (
		SELECT 
			MAX(salary) 
		FROM employee
		GROUP BY job
	) 
ORDER BY salary DESC;

--Result

+--------+-----------+---------+
| name   | job       | salary  |
+--------+-----------+---------+
| KING   | PRESIDENT | 5000.00 |
| SCOTT  | ANALYST   | 3000.00 |
| FORD   | ANALYST   | 3000.00 |
| JONES  | MANAGER   | 2975.00 |
| ALLEN  | SALESMAN  | 1600.00 |
| MILLER | CLERK     | 1300.00 |
+--------+-----------+---------+

--143. Find out the most recently hired emps in each dept order by hiredate

SELECT 
	emp.dept_no,
	emp.hiredate_dt
FROM employee AS emp
WHERE 1=1
	AND emp.hiredate_dt IN (
		SELECT 
			MAX(hiredate_dt) 
		FROM employee
		GROUP BY dept_no
	)  
ORDER BY emp.hiredate_dt

--Result

+---------+-------------+
| dept_no | hiredate_dt |
+---------+-------------+
|      30 | 1981-12-03  |
|      20 | 1981-12-03  |
|      10 | 1982-01-23  |
|      20 | 1987-07-13  |
|      20 | 1987-07-13  |
+---------+-------------+

--144. List the emp name, sal and deptno for each emp who earns a sal greater than the avg for their dept order by deptno

SELECT
	emp.*
FROM employee AS emp
WHERE 1=1
	AND employee.salary > (
		SELECT AVG(employee.salary)
		FROM employee
		GROUP BY employee.dept_no
		HAVING employee.dept_no = emp.dept_no
	)
	
--Result

+-------------+-------+-----------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job       | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+-----------+---------+-------------+---------+---------+-----------+
|        7499 | ALLEN | SALESMAN  |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |
|        7566 | JONES | MANAGER   |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |
|        7698 | BLAKE | MANAGER   |    7839 | 1981-05-01  | 2850.00 |      30 |      NULL |
|        7788 | SCOTT | ANALYST   |    7566 | 1987-07-13  | 3000.00 |      20 |      NULL |
|        7839 | KING  | PRESIDENT |    NULL | 1981-11-17  | 5000.00 |      10 |      NULL |
|        7902 | FORD  | ANALYST   |    7566 | 1981-12-03  | 3000.00 |      20 |      NULL |
+-------------+-------+-----------+---------+-------------+---------+---------+-----------+

--145. List the deptno where there are no emps

SELECT 
	dept_no, 
	name 
FROM department 
WHERE 1=1
	AND dept_no NOT IN (
		SELECT 
			dept_no 
		FROM employee
	);
	
----------------------

SELECT
	DISTINCT
	dept.dept_no,
	dept.name
FROM employee AS emp
RIGHT JOIN department AS dept
	ON emp.dept_no = dept.dept_no
WHERE 1=1
	emp.employee_no IS NULL

--Result

+---------+------------+
| dept_no | name       |
+---------+------------+
|      40 | OPERATIONS |
+---------+------------+

--146. List the no of emps and avg salary within each dept for each job.

SELECT 
	dept_no,
	COUNT(*) AS emp_count,
	ROUND(AVG(emp.salary),2) AS avg_sal
FROM employee AS emp
GROUP BY dept_no

--Result

+---------+-----------+---------+
| dept_no | emp_count | avg_sal |
+---------+-----------+---------+
|      10 |         3 | 2916.67 |
|      20 |         5 | 2175.00 |
|      30 |         6 | 1566.67 |
+---------+-----------+---------+

--147. Find the max avg salary drawn for each job except for ‘PRESIDENT’

SELECT 
	dept_no,
	ROUND(MAX(emp.salary),2) AS avg_sal
FROM employee AS emp
WHERE 1=1
	AND emp.name = 'PRESIDENT'
GROUP BY dept_no
	
--Result

+---------+---------+
| dept_no | avg_sal |
+---------+---------+
|      10 | 2450.00 |
|      20 | 3000.00 |
|      30 | 2850.00 |
+---------+---------+

--148. Find the name and job of the emps who earn Max salary and Commission

SELECT
	name,
	job
FROM employee
WHERE 1=1
	AND salary > (
		SELECT 
			MAX(salary)
		FROM employee
	)
	AND commisson > (
		SELECT 
			MAX(commisson)
		FROM employee
	)

--Result

+------+-----------+
| name | job       |
+------+-----------+
| KING | PRESIDENT |
+------+-----------+

--149. List the name, job and salary of the emps who are not belonging to the dept 10 but who have the same job and salary as the emps of dept 10.

SELECT 
	*
FROM employee AS emp
WHERE 1=1
	AND emp.job IN (
		SELECT 
			job
		FROM employee
		WHERE dept_no = 10
	)
AND emp.dept_no <> 10

--Result

+-------------+-------+---------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job     | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+
|        7369 | SMITH | CLERK   |    7902 | 1980-12-17  |  800.00 |      20 |      NULL |
|        7566 | JONES | MANAGER |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |
|        7698 | BLAKE | MANAGER |    7839 | 1981-05-01  | 2850.00 |      30 |      NULL |
|        7876 | ADAMS | CLERK   |    7788 | 1987-07-13  | 1100.00 |      20 |      NULL |
|        7900 | JAMES | CLERK   |    7698 | 1981-12-03  |  950.00 |      30 |      NULL |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+

--150. List the deptno, name, job, salary and sal+comm. Of the emps who earn the second highest earnings (sal+comm)

SELECT 
	job,
	salary,
	(salary + commisson) AS total_sal
FROM employee
WHERE 1=1
	AND (salary + commisson) <> (
		SELECT
			MAX(salary + commisson)
		FROM employee
	)
ORDER BY total_sal DESC
LIMIT 1;

--Result

+----------+---------+-----------+
| job      | salary  | total_sal |
+----------+---------+-----------+
| SALESMAN | 1600.00 |   1900.00 |
+----------+---------+-----------+