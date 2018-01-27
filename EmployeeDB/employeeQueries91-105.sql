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

--096. List the emps whose salary is equal to average of maximum and minimum

SELECT *
FROM employee
WHERE 1=1
	AND employee.salary = (
		SELECT 
			ROUND((MIN(employee.salary) + MAX(employee.salary))/2 , 0)
		FROM employee
	);

--Result

Empty set

--097. List the no of emps in each dept where the number is more than 3.

SELECT 
	emp.dpt_no,
	COUNT(*) AS num_emp
FROM employee AS emp
GROUP BY emp.dept_no
HAVING num_emp > 3;

--Result

+---------+---------+
| dept_no | num_emp |
+---------+---------+
|      20 |       5 |
|      30 |       6 |
+---------+---------+

--098. List the names of depts. Where at least 3 emps are working in each dept

SELECT
	dept.name,
	COUNT(*) AS emp_count
FROM department AS dept, employee AS emp
WHERE 1=1
	AND emp.dept_no = dept.dept_no
GROUP BY dept.name;

--Result

+------------+-----------+
| name       | emp_count |
+------------+-----------+
| ACCOUNTING |         3 |
| RESEARCH   |         5 |
| SALES      |         6 |
+------------+-----------+

--099. List the managers whose salary is more than his emps avg sal.

SELECT 
	emp1.employee_no,
	emp1.salary
FROM employee AS emp1
WHERE 1=1
	AND emp1.salary > (
		SELECT 
			AVG(employee.salary)
		FROM employee
		WHERE employee.manager = emp1.employee_no)
	AND emp1.job = 'MANAGER';
	
--Result

+-------------+---------+
| employee_no | salary  |
+-------------+---------+
|        7698 | 2850.00 |
|        7782 | 2450.00 |
+-------------+---------+

--100. List the name, sal, comm. For those emps whose annual pay is > or = any other employee avg annual salary of the company.

SELECT 
	emp.name,
	(emp.salary * 12) AS annual_sal
FROM employee AS emp
WHERE 1=1
	AND (emp.salary * 12) > (
		SELECT 
			AVG(employee.salary) *12
		FROM employee
	)
	
--Result

+-------+------------+
| name  | annual_sal |
+-------+------------+
| JONES |   35700.00 |
| BLAKE |   34200.00 |
| CLARK |   29400.00 |
| SCOTT |   36000.00 |
| KING  |   60000.00 |
| FORD  |   36000.00 |
+-------+------------+

--101. List the emps whose sal < his Manager but more than other Manager

SELECT DISTINCT emp.*
FROM employee AS emp, employee AS emp1
WHERE 11=1
	AND emp.salary > emp1.salary
	AND emp.manager <> emp1.employee_no
	AND emp.salary < (
		SELECT 
			employee.salary
		FROM employee
		WHERE 1=1
			AND employee_no = emp.manager
		)
LIMIT 5;
		
--Result

+-------------+--------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+
|        7499 | ALLEN  | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |
|        7521 | WARD   | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |
|        7566 | JONES  | MANAGER  |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |
|        7654 | MARTIN | SALESMAN |    7698 | 1981-09-28  | 1250.00 |      30 |   1400.00 |
|        7698 | BLAKE  | MANAGER  |    7839 | 1981-05-01  | 2850.00 |      30 |      NULL |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+

--102. List the employee names and his annual salary dept wise.

SELECT
	emp.name,
	emp.dept_no,
	emp.salary *12 AS annual_Sal
FROM employee AS emp
ORDER BY emp.dept_no, name, salary
LIMIT 5;

--Result

+--------+---------+------------+
| name   | dept_no | annual_Sal |
+--------+---------+------------+
| CLARK  |      10 |   29400.00 |
| KING   |      10 |   60000.00 |
| MILLER |      10 |   15600.00 |
| ADAMS  |      20 |   13200.00 |
| FORD   |      20 |   36000.00 |
+--------+---------+------------+

--103. Find out least 5 earners of the company.

SELECT 
	emp.*
FROM employee AS emp
ORDER BY emp.salary
LIMIT 5;

--Result

+-------------+--------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+
|        7369 | SMITH  | CLERK    |    7902 | 1980-12-17  |  800.00 |      20 |      NULL |
|        7900 | JAMES  | CLERK    |    7698 | 1981-12-03  |  950.00 |      30 |      NULL |
|        7876 | ADAMS  | CLERK    |    7788 | 1987-07-13  | 1100.00 |      20 |      NULL |
|        7521 | WARD   | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |
|        7654 | MARTIN | SALESMAN |    7698 | 1981-09-28  | 1250.00 |      30 |   1400.00 |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+

--104. Find out the no of emps whose salary is > their Manager salary.

SELECT 
	COUNT(*) AS emp_count
FROM employee AS emp, employee AS emp1
WHERE 1=1
	AND emp.salary > emp1.salary
	AND emp.manager = emp1.employee_no;
	
--Result

+-----------+
| emp_count |
+-----------+
|         2 |
+-----------+

--105. List the Mgrs who are not working under ‘PRESIDENT’ but are working under other Manager.

SELECT 
	emp.*
FROM employee AS emp, employee As emp1
WHERE 1=1
	AND emp.manager = emp1.employee_no
	AND emp1.job <> 'PESIDENT'
	AND emp1.job = 'MANAGER'
LIMIT 5;

--Result

+-------------+--------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+
|        7499 | ALLEN  | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |
|        7521 | WARD   | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |
|        7654 | MARTIN | SALESMAN |    7698 | 1981-09-28  | 1250.00 |      30 |   1400.00 |
|        7788 | SCOTT  | ANALYST  |    7566 | 1987-07-13  | 3000.00 |      20 |      NULL |
|        7844 | TURNER | SALESMAN |    7698 | 1981-09-08  | 1500.00 |      30 |      0.00 |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+
	
		



	
