--076. Display the number of emps for each job group deptno wise

SELECT 
	employee.job, 
	employee.dept_no, 
	COUNT(*) AS total
FROM employee
GROUP BY employee.job, employee.dept_no;

--Result
+-----------+---------+-------+
| job       | dept_no | total |
+-----------+---------+-------+
| ANALYST   |      20 |     2 |
| CLERK     |      10 |     1 |
| CLERK     |      20 |     2 |
| CLERK     |      30 |     1 |
| MANAGER   |      10 |     1 |
| MANAGER   |      20 |     1 |
| MANAGER   |      30 |     1 |
| PRESIDENT |      10 |     1 |
| SALESMAN  |      30 |     4 |
+-----------+---------+-------+

--077. List the Mgr no & no. of emps working for those Mgrs in the asc Mgrno.

SELECT
	employee.manager,
	COUNT(*) AS total
FROM employee
WHERE 1=1
	AND employee.manager IS NOT NULL
GROUP BY employee.manager;

--Result

+---------+-------+
| manager | total |
+---------+-------+
|    7902 |     1 |
|    7788 |     1 |
|    7782 |     1 |
|    7566 |     2 |
|    7839 |     3 |
|    7698 |     5 |
+---------+-------+

--078. List the dept details where at least two emps are working.

SELECT 
	department.name,
	COUNT(*) AS total
FROM employee
INNER JOIN department
	ON 1=1
	AND employee.dept_no = department.dept_no
GROUP BY department.name
HAVING total > 1;

--Result

+------------+-------+
| name       | total |
+------------+-------+
| ACCOUNTING |     3 |
| RESEARCH   |     5 |
| SALES      |     6 |
+------------+-------+

--079. Display the grade, number of emps, max sal of each grade

SELECT
	salarygrade.grade,
	MAX(employee.salary) AS max_sal,
	COUNT(*)
FROM employee, salarygrade
WHERE 1=1
	AND employee.salary BETWEEN salarygrade.low_salary AND high_salary
GROUP BY salarygrade.grade;

--Result

+-------+---------+----------+
| grade | max_sal | COUNT(*) |
+-------+---------+----------+
|     1 | 1100.00 |        6 |
|     2 | 1300.00 |        6 |
|     3 | 1600.00 |        4 |
|     4 | 3000.00 |       10 |
|     5 | 5000.00 |        2 |
+-------+---------+----------+

--080. Display dname, grade, no of emps where atleast two emps are ‘CLERKS'

SELECT
	department.name,
	salarygrade.grade,
	COUNT(*) AS emp_count
FROM employee, salarygrade, department
WHERE 1=1
	AND employee.salary BETWEEN salarygrade.low_salary AND high_salary
	AND department.dept_no = employee.dept_no
	AND employee.job = 'CLERK'
GROUP BY department.name, salarygrade.grade
HAVING emp_count > 1;

--Result

+------------+-------+-----------+
| name       | grade | emp_count |
+------------+-------+-----------+
| ACCOUNTING |     2 |         2 |
| RESEARCH   |     1 |         4 |
| SALES      |     1 |         2 |
+------------+-------+-----------+

--081. List the details of the dept where the max no of emps are working

SELECT 
	department.*,
	COUNT(*) AS max_emp
FROM employee, department
WHERE 1=1
	AND department.dept_no = employee.dept_no
GROUP BY department.name
ORDER BY max_emp DESC
LIMIT 1;

+---------+------------+----------+---------+
| dept_no | name       | location | max_emp |
+---------+------------+----------+---------+
|      30 | SALES      | CHICAGO  |       6 |
+---------+------------+----------+---------+

--082. Display the emps whose Mgr name is Jones

SELECT
	employee.*
FROM employee
WHERE 1=1
	AND employee.manager = (
		SELECT 
			employee_no
		FROM employee
		WHERE 1=1
			AND employee.name = 'JONES'
			AND employee.job = 'MANAGER'
		);
		
--Result

+-------------+-------+---------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job     | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+
|        7788 | SCOTT | ANALYST |    7566 | 1987-07-13  | 3000.00 |      20 |      NULL |
|        7902 | FORD  | ANALYST |    7566 | 1981-12-03  | 3000.00 |      20 |      NULL |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+

--083. List the emps whose salary is more than 3000 after giving 20% increment

SELECT 
	employee.*
	employee.salary *1.20 AS increment_sal
FROM employee
WHERE 1=1
	AND employee.salary *1.20 > 3000;
	
--Result

+-------------+-------+-----------+---------+-------------+---------+---------+-----------+---------------+
| employee_no | name  | job       | manager | hiredate_dt | salary  | dept_no | commisson | increment_sal |
+-------------+-------+-----------+---------+-------------+---------+---------+-----------+---------------+
|        7566 | JONES | MANAGER   |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |     3570.0000 |
|        7698 | BLAKE | MANAGER   |    7839 | 1981-05-01  | 2850.00 |      30 |      NULL |     3420.0000 |
|        7788 | SCOTT | ANALYST   |    7566 | 1987-07-13  | 3000.00 |      20 |      NULL |     3600.0000 |
|        7839 | KING  | PRESIDENT |    NULL | 1981-11-17  | 5000.00 |      10 |      NULL |     6000.0000 |
|        7902 | FORD  | ANALYST   |    7566 | 1981-12-03  | 3000.00 |      20 |      NULL |     3600.0000 |
+-------------+-------+-----------+---------+-------------+---------+---------+-----------+---------------+

--084. List the emps with their dept names

SELECT
	employee.name,
	department.name AS dept_name
FROM employee
INNER JOIN department
	ON 1=1
	AND employee.dept_no = deparment.dept_no
LIMIT 5;

--Result

+--------+------------+
| name   | dept_name  |
+--------+------------+
| CLARK  | ACCOUNTING |
| KING   | ACCOUNTING |
| MILLER | ACCOUNTING |
| SMITH  | RESEARCH   |
| JONES  | RESEARCH   |
+--------+------------+

--085. List the emps who are not working in sales dept

SELECT
	employee.name,
	department.name AS dept_name
FROM employee
INNER JOIN department
	ON 1=1
	AND employee.dept_no = department.dept_no
	AND department.name <> 'SALES'
LIMIT 5; 

--Result
+--------+------------+
| name   | dept_name  |
+--------+------------+
| CLARK  | ACCOUNTING |
| KING   | ACCOUNTING |
| MILLER | ACCOUNTING |
| SMITH  | RESEARCH   |
| JONES  | RESEARCH   |
+--------+------------+

--086. List the emps name, dept, sal & comm. For those whose salary is between 2000 and 5000 while loc is CHICAGO

SELECT
	employee.name,
	department.name AS dept_name,
	department.location,
	employee.salary,
	employee.commison
FROM employee
INNER JOIN department
	ON 1=1
	AND employee.dept_no = department.dept_no
	AND employee.salary BETWEEN 2000 AND 5000
	AND department.location = 'CHICAGO'
	
--Result

+-------+-----------+----------+---------+-----------+
| name  | dept_name | location | salary  | commisson |
+-------+-----------+----------+---------+-----------+
| JONES | SALES     | CHICAGO  | 2975.00 |      NULL |
| BLAKE | SALES     | CHICAGO  | 2850.00 |      NULL |
| CLARK | SALES     | CHICAGO  | 2450.00 |      NULL |
| SCOTT | SALES     | CHICAGO  | 3000.00 |      NULL |
| KING  | SALES     | CHICAGO  | 5000.00 |      NULL |
| FORD  | SALES     | CHICAGO  | 3000.00 |      NULL |
+-------+-----------+----------+---------+-----------+
	
--087. List the emps whose salary is > his Manager’s salary

SELECT
	emp1.*
FROM employee AS emp1, employee AS emp2
WHERE 1=1
	AND emp1.manager = emp2.employee_no
	AND emp1.salary > emp2.salary;
	
--Result

+-------------+-------+---------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job     | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+
|        7788 | SCOTT | ANALYST |    7566 | 1987-07-13  | 3000.00 |      20 |      NULL |
|        7902 | FORD  | ANALYST |    7566 | 1981-12-03  | 3000.00 |      20 |      NULL |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+

--088. List the grade, employee name for the deptno 10 or deptno 30 but salgrade is not 4 while they joined the company before ’31-DEC-82’

SELECT 
	sgrade.grade,
	emp.name,
	dept.dept_no,
	emp.hiredate_dt
FROM employee AS emp, salarygrade AS sgrade, department AS dept
WHERE 1=1
	AND dept.dept_no = emp.dept_no
	AND emp.salary BETWEEN sgrade.low_salary AND sgrade.high_salary
	AND sgrade.grade <> 4
	AND dept.dept_no IN (10, 30)
	AND emp.hiredate_dt < '1982-12-31'
LIMIT 5;

--Result

+-------+--------+---------+-------------+
| grade | name   | dept_no | hiredate_dt |
+-------+--------+---------+-------------+
|     1 | JAMES  |      30 | 1981-12-03  |
|     2 | MILLER |      10 | 1982-01-23  |
|     2 | WARD   |      30 | 1981-02-22  |
|     2 | MARTIN |      30 | 1981-09-28  |
|     3 | ALLEN  |      30 | 1981-02-20  |
+-------+--------+---------+-------------+

--089. List the name, job, dname, loc for those who are working as a ‘MGRs

SELECT
	employee.name,
	department.name AS dept_name,
	department.location,
	employee.job,
FROM employee
INNER JOIN department
	ON 1=1
	AND employee.dept_no = department.dept_no
	AND employee.job = 'MANAGER'
	
--Result

+-------+------------+----------+---------+
| name  | dept_name  | location | job     |
+-------+------------+----------+---------+
| CLARK | ACCOUNTING | NEW YORK | MANAGER |
| JONES | RESEARCH   | DALLAS   | MANAGER |
| BLAKE | SALES      | CHICAGO  | MANAGER |
+-------+------------+----------+---------+

--090. List the emps whose mgr name is ‘JONES’ and also list their manager name

SELECT 
	emp1.name,
	emp2.name AS mgr_name
FROM employee AS emp1, employee AS emp2
WHERE 1=1
	AND emp1.manager = emp2.employee_no
	AND emp2.name = 'JONES'
	
--Result

+-------+----------+
| name  | mgr_name |
+-------+----------+
| SCOTT | JONES    |
| FORD  | JONES    |
+-------+----------+

--091. List the name and salary of FORD if his salary is equal to hisal of his Grade

SELECT
	emp.name,
	emp.salary
FROM employee AS emp, salarygrade AS sgrade
WHERE 1=1
	AND emp.salary BETWEEN sgrade.low_salary AND sgrade.high_salary
	AND emp.name = 'FORD'
	AND emp.salary = sgrade.high_salary;

--Result
	
+------+---------+
| name | salary  |
+------+---------+
| FORD | 3000.00 |
+------+---------+

--092. List the name, job, dname, Manager, salary,dept wise.

SELECT 
	emp.name,
	dept.name AS dept_name,
	emp.manager,
	emp.salary
FROM employee AS emp, department AS dept
WHERE 1=1
	AND emp.dept_no = dept.dept_no
ORDER BY dept.dept_no
LIMIT 5;

--Result

+--------+------------+---------+---------+
| name   | dept_name  | manager | salary  |
+--------+------------+---------+---------+
| CLARK  | ACCOUNTING |    7839 | 2450.00 |
| KING   | ACCOUNTING |    NULL | 5000.00 |
| MILLER | ACCOUNTING |    7782 | 1300.00 |
| SMITH  | RESEARCH   |    7902 |  800.00 |
| JONES  | RESEARCH   |    7839 | 2975.00 |
+--------+------------+---------+---------+

--093. List the emps name, job, salary, grade and dname except ‘CLERK’s and sort on the basis of highest salary

SELECT 
	emp.name,
	dept.name AS dept_name,
	emp.manager,
	emp.salary,
	sgrade.grade
FROM employee AS emp, department AS dept, salarygrade AS sgrade
WHERE 1=1
	AND emp.salary BETWEEN sgrade.low_salary AND sgrade.high_salary
	AND emp.dept_no = dept.dept_no
	AND emp.job <> 'CLERK'
ORDER BY emp.salary DESC
LIMIT 5;

--Result

+-------+------------+---------+---------+-------+
| name  | dept_name  | manager | salary  | grade |
+-------+------------+---------+---------+-------+
| KING  | ACCOUNTING |    NULL | 5000.00 |     5 |
| SCOTT | RESEARCH   |    7566 | 3000.00 |     4 |
| FORD  | RESEARCH   |    7566 | 3000.00 |     4 |
| JONES | RESEARCH   |    7839 | 2975.00 |     4 |
| BLAKE | SALES      |    7839 | 2850.00 |     4 |
+-------+------------+---------+---------+-------+

--094. List the emps name, job and Manager who are without Manager

SELECT 
	emp.name,
	emp.manager,
	emp.job
FROM employee AS emp
WHERE 1=1
	AND emp.manager IS NULL	;
	
--Result

+------+---------+-----------+
| name | manager | job       |
+------+---------+-----------+
| KING |    NULL | PRESIDENT |
+------+---------+-----------+

--095. List the names of emps who are getting the highest salary dept wise

SELECT 
	emp.name, 
	emp.job, 
	emp.salary, 
	dept.name 
FROM employee AS emp, department AS dept
WHERE 1=1
	AND emp.dept_no = dept.dept_no 
	AND emp.dept_no IN (
		SELECT 
			DISTINCT dept_no 
		FROM employee AS emp 
		GROUP BY emp.dept_no
	)
	AND salary IN (
		SELECT MAX(employee.salary) 
		FROM employee
		GROUP BY dept_no
	) ;
	
--Result

+-------+-----------+---------+------------+
| name  | job       | salary  | name       |
+-------+-----------+---------+------------+
| KING  | PRESIDENT | 5000.00 | ACCOUNTING |
| SCOTT | ANALYST   | 3000.00 | RESEARCH   |
| FORD  | ANALYST   | 3000.00 | RESEARCH   |
| BLAKE | MANAGER   | 2850.00 | SALES      |
+-------+-----------+---------+------------+

