--046. List all the information of emps with loc and the grade of all the emps belong to the grade ranges from 2 to 4 working at the dept those are not starting with char set ‘OP’ and not ending with ‘S’ with the design having a char ‘a’ any where joined in the year 81 but not in the month of Mar or Sep and sal not end with ‘00’ in the asc order of grades.

SELECT
	DISTINCT
	employee.*,
	salarygrade.grade,
	department.location,
	department.name
FROM employee
INNER JOIN department
	ON 1=1
	AND department.dept_no =  employee.dept_no
INNER JOIN salarygrade
	ON 1=1
	AND employee.salary BETWEEN salarygrade.low_salary AND salarygrade.high_salary
WHERE 1=1
	AND YEAR(employee.hiredate_dt) = 1981 
	AND MONTH(employee.hiredate_dt) NOT IN (3,8) /*march and sept*/
	AND CAST(employee.salary AS UNSIGNED) NOT LIKE '%00' /* Salary in float so converting to Integer*/
	AND employee.job LIKE '%a%'
	AND salarygrade.grade BETWEEN 2 AND 4
	AND department.name NOT LIKE 'OP%'
	AND department.name NOT LIKE '%S'
ORDER BY salarygrade.grade;

--Result

+-------------+-------+---------+---------+-------------+---------+---------+-----------+-------+----------+------------+
| employee_no | name  | job     | manager | hiredate_dt | salary  | dept_no | commisson | grade | location | name       |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+-------+----------+------------+
|        7782 | CLARK | MANAGER |    7839 | 1981-06-09  | 2450.00 |      10 |      NULL |     4 | NEW YORK | ACCOUNTING |
|        7566 | JONES | MANAGER |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |     4 | DALLAS   | RESEARCH   |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+-------+----------+------------+

--047. List the details of the depts along with empno, ename or without the emps

SELECT
	employee_no
	employee.name,
	department.*
FROM employee
INNER JOIN department
	ON 1=1
	AND department.dept_no = employee.dept_no
LIMIT 5;

--Result

+-------------+--------+---------+------------+----------+
| employee_no | name   | dept_no | name       | location |
+-------------+--------+---------+------------+----------+
|        7782 | CLARK  |      10 | ACCOUNTING | NEW YORK |
|        7839 | KING   |      10 | ACCOUNTING | NEW YORK |
|        7934 | MILLER |      10 | ACCOUNTING | NEW YORK |
|        7369 | SMITH  |      20 | RESEARCH   | DALLAS   |
|        7566 | JONES  |      20 | RESEARCH   | DALLAS   |
+-------------+--------+---------+------------+----------+

-- 048. List the details of the emps whose salaries more than the employee BLAKE
 --1 way with sub-query
SELECT *
FROM employee
WHERE 1=1
	AND employee.salary >(
	SELECT 
		employee.salary 
	FROM employee 
	WHERE employee.name = 'BLAKE'
	);
	
-- 2way self join

SELECT 
	emp_1.*
FROM employee AS emp_1, employee AS emp_2
WHERE 1=1
	AND emp_1.salary > emp_2.salary
	AND emp_2.name = 'BLAKE';

--Result

+-------------+-------+-----------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job       | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+-----------+---------+-------------+---------+---------+-----------+
|        7566 | JONES | MANAGER   |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |
|        7788 | SCOTT | ANALYST   |    7566 | 1987-07-13  | 3000.00 |      20 |      NULL |
|        7839 | KING  | PRESIDENT |    NULL | 1981-11-17  | 5000.00 |      10 |      NULL |
|        7902 | FORD  | ANALYST   |    7566 | 1981-12-03  | 3000.00 |      20 |      NULL |
+-------------+-------+-----------+---------+-------------+---------+---------+-----------+

--049. List the details of the emps whose job is same as ALLEN.

SELECT 
	emp_1.*
FROM employee AS emp_1, employee AS emp_2
WHERE 1=1
	AND emp_1.job = emp_2.job
	AND emp_2.name = 'ALLEN';
	
--Result

+-------------+--------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+
|        7499 | ALLEN  | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |
|        7521 | WARD   | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |
|        7654 | MARTIN | SALESMAN |    7698 | 1981-09-28  | 1250.00 |      30 |   1400.00 |
|        7844 | TURNER | SALESMAN |    7698 | 1981-09-08  | 1500.00 |      30 |      0.00 |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+

--050. List the emps who are senior to King

SELECT 
	emp_1.*
FROM employee AS emp_1, employee AS emp_2
WHERE 1=1
	AND emp_1.hiredate_dt < emp_2.hiredate_dt
	AND emp_2.name = 'KING'
LIMIT 5;

--Result

+-------------+--------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+
|        7369 | SMITH  | CLERK    |    7902 | 1980-12-17  |  800.00 |      20 |      NULL |
|        7499 | ALLEN  | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |
|        7521 | WARD   | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |
|        7566 | JONES  | MANAGER  |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |
|        7654 | MARTIN | SALESMAN |    7698 | 1981-09-28  | 1250.00 |      30 |   1400.00 |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+

--051. List the emps who are senior to their own MGRs

SELECT *
FROM employee AS emp_1
WHERE 1=1
	AND emp_1.hiredate_dt < (
		SELECT 
			employee.hiredate_dt
		FROM employee
		WHERE 1=1
			AND employee_no = emp_1.manager
	);
	
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

--052. List the emps of deptno 20 whose jobs are same as deptno 10

SELECT *
FROM employee AS emp_1
WHERE 1=1
	AND emp_1.job IN (
		SELECT 
			employee.job
		FROM employee
		WHERE 1=1
			AND employee.dept_no = 10
	)
	AND emp_1.dept_no = 20;
	
--Result

+-------------+-------+---------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job     | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+
|        7369 | SMITH | CLERK   |    7902 | 1980-12-17  |  800.00 |      20 |      NULL |
|        7566 | JONES | MANAGER |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |
|        7876 | ADAMS | CLERK   |    7788 | 1987-07-13  | 1100.00 |      20 |      NULL |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+

--053. List the emps whose Sal is same as FORD or SMITH in desc order of Sal

SELECT *
FROM employee AS emp_1
WHERE 1=1
	AND emp_1.salary IN (
		SELECT 
			employee.salary
		FROM employee
		WHERE 1=1
			AND employee.name = 'SMITH'
			OR employee.name = 'FORD'
	)
	AND emp_1.name NOT IN ('FORD', 'SMITH')
;

+-------------+-------+---------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job     | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+
|        7788 | SCOTT | ANALYST |    7566 | 1987-07-13  | 3000.00 |      20 |      NULL |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+

-- 054. List the emps whose Jobs are same as MILLER or Sal is more than ALLEN

SELECT 
	emp_1.*
FROM employee AS emp_1, employee AS emp_2
WHERE 1=1
	AND (emp_1.job = emp_2.job AND emp_2.name = 'MILLER') /*condition 1 */
	OR (emp_1.salary > emp_2.salary AND emp_2.name = 'ALLEN') /*condition 2*/
LIMIT 5;

-- Result

+-------------+-------+-----------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job       | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+-----------+---------+-------------+---------+---------+-----------+
|        7566 | JONES | MANAGER   |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |
|        7698 | BLAKE | MANAGER   |    7839 | 1981-05-01  | 2850.00 |      30 |      NULL |
|        7782 | CLARK | MANAGER   |    7839 | 1981-06-09  | 2450.00 |      10 |      NULL |
|        7788 | SCOTT | ANALYST   |    7566 | 1987-07-13  | 3000.00 |      20 |      NULL |
|        7839 | KING  | PRESIDENT |    NULL | 1981-11-17  | 5000.00 |      10 |      NULL |
+-------------+-------+-----------+---------+-------------+---------+---------+-----------+

-- 055. List the emps whose Sal is > the total remuneration of the CLERK.

SELECT * 
FROM employee 
WHERE 1=1
	AND employee.salary > (
		SELECT 
			SUM(salary) 
		FROM employee 
		WHERE 1=1
			AND JOB='CLERK'
	);
	
--Result

+-------------+------+-----------+---------+-------------+---------+---------+-----------+
| employee_no | name | job       | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+------+-----------+---------+-------------+---------+---------+-----------+
|        7839 | KING | PRESIDENT |    NULL | 1981-11-17  | 5000.00 |      10 |      NULL |
+-------------+------+-----------+---------+-------------+---------+---------+-----------+

--056. List the emps who are Senior to ‘BLAKE’ working at CHICAGO & BOSTON

SELECT 
	emp_1.*
FROM employee AS emp_1
INNER JOIN department
	ON 1=1
	AND department.dept_no = emp_1.dept_no
WHERE 1=1
	AND emp_1.hiredate_dt < (
		SELECT 
			hiredate_dt 
		FROM employee 
		WHERE 1=1
			AND employee.name = 'BLAKE'
		) /*condition 1 */
	AND department.location IN ('CHICAGO', 'BOSTON'); /*condition 2*/
	
--Result
+-------------+-------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+----------+---------+-------------+---------+---------+-----------+
|        7499 | ALLEN | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |
|        7521 | WARD  | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |
+-------------+-------+----------+---------+-------------+---------+---------+-----------+


--057. List the emps of Grade 3,4 belongs to the dept ACCOUNTING and RESEARCH whose sal is more than ALLEN and exp more than TURNER in the asc order of Exp.

SELECT 
	DISTINCT emp_1.*
FROM employee AS emp_1, salarygrade, department
WHERE 1=1
	AND emp_1.salary BETWEEN salarygrade.low_salary AND salarygrade.high_salary
	AND salarygrade.grade IN (3,4)
	AND department.dept_no = emp_1.dept_no
	AND department.name IN ('ACCOUNTING', 'RESEARCH')
	AND emp_1.salary > (SELECT employee.salary FROM employee WHERE employee.name = 'ALLEN')
	AND emp_1.hiredate_dt < (SELECT employee.hiredate_dt FROM employee WHERE employee.name = 'TURNER')

--Result
+-------------+-------+---------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job     | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+
|        7782 | CLARK | MANAGER |    7839 | 1981-06-09  | 2450.00 |      10 |      NULL |
|        7566 | JONES | MANAGER |    7839 | 1981-04-02  | 2975.00 |      20 |      NULL |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+

--058. List the emps whose jobs same as ALLEN Or SMITH.

SELECT 
	*
FROM employee
WHERE 1=1
	AND employee.job IN (
		SELECT 
			employee.job
		FROM employee 
		WHERE employee.name IN ('ALLEN', 'SMITH')
		)
	AND employee.name NOT IN ('ALLEN', 'SMITH');
	
--Result
+-------------+--------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+
|        7521 | WARD   | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |
|        7654 | MARTIN | SALESMAN |    7698 | 1981-09-28  | 1250.00 |      30 |   1400.00 |
|        7844 | TURNER | SALESMAN |    7698 | 1981-09-08  | 1500.00 |      30 |      0.00 |
|        7876 | ADAMS  | CLERK    |    7788 | 1987-07-13  | 1100.00 |      20 |      NULL |
|        7900 | JAMES  | CLERK    |    7698 | 1981-12-03  |  950.00 |      30 |      NULL |
|        7934 | MILLER | CLERK    |    7782 | 1982-01-23  | 1300.00 |      10 |      NULL |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+

--059. Write a Query to display the details of emps whose Sal is same as of
	-- a) Employee Sal of Emp1 table.
	-- b) ¾ Sal of any Mgr of Emp2 table.
	-- c) The Sal of any sales person with exp of 5 yrs belongs to the sales dept of emp3 table.
	-- d) Any Grade 2 employees of Emp4 table.
	-- e) Any Grade 2&3 employee working for SALES dept or OPERATIONS dept joined in 89

SELECT
	emp.salary
FROM employee AS emp
WHERE 1=1
	AND emp.salary IN (SELECT emp1.salary FROM employee AS emp1)
	OR emp.salary = (SELECT (3/4) *emp2.salary FROM employee emp2 WHERE emp2.job = 'MANAGER')
	OR emp.salary = (
		SELECT emp3.salary
		FROM employee AS emp3, department
		WHERE 1=1
			AND emp3.dept_no = department.dept_no
			AND TIMESTAMPDIFF(MONTH, emp3.hiredate_dt, NOW())/12 >= 5
			AND department.name = 'SALES'
		)
	OR emp.salary IN (
		SELECT emp4.salary
		FROM employee AS emp4, salarygrade
		WHERE 1=1
			AND emp4.salary BETWEEN salary.low_grade AND high_grade
			AND salarygrade.grade = 2
		)
	OR emp.salary IN (
		SELECT emp5.salary
		FROM employee AS emp5, salarygrade, department
		WHERE 1=1
			AND emp5.salary BETWEEN salary.low_grade AND high_grade
			AND salarygrade.grade IN (2,3)
			AND EXTRACT(YEAR FROM emp5.hiredate_dt) = 1989
			AND emp5.dept_no = department.dept_no
			AND department.name IN ('SALES', 'OPERATIONS')
		)
		

--Result
+--------+---------+
| name   | salary  |
+--------+---------+
| SMITH  |  800.00 |
| ALLEN  | 1600.00 |
| WARD   | 1250.00 |
| JONES  | 2975.00 |
| MARTIN | 1250.00 |
+--------+---------+

--060. List the jobs of Deptno 10 those are not found in dept 20.

SELECT 
	employee.job
FROM employee
WHERE 1=1
	AND employee.job NOT IN (
		SELECT job 
		FROM employee 
		WHERE 1=1
			AND employee.dept_no = 20
		)
	AND employee.dept_no = 10;
	
--Result
+-----------+
| job       |
+-----------+
| PRESIDENT |
+-----------+
	
