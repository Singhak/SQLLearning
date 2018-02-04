--151. List the deptno, name, job, salary and sal+comm. Of the salesman

SELECT
	emp.name,
	emp.dept_no,
	emp.job,
	emp.salary,
	(emp.salary + emp.commisson) AS sal_comm
FROM employee AS emp
WHERE 1=1
	AND emp.job = 'SALESMAN'
	
--Result

+--------+---------+----------+---------+----------+
| name   | dept_no | job      | salary  | sal_comm |
+--------+---------+----------+---------+----------+
| ALLEN  |      30 | SALESMAN | 1600.00 |  1900.00 |
| WARD   |      30 | SALESMAN | 1250.00 |  1750.00 |
| MARTIN |      30 | SALESMAN | 1250.00 |  2650.00 |
| TURNER |      30 | SALESMAN | 1500.00 |  1500.00 |
+--------+---------+----------+---------+----------+

--152. List out the name, job, sal of the emps in the department with the highest avg sal

SELECT 
	emp.name,
	emp.job,
	emp.salary
FROM employee AS emp
WHERE 1=1
	AND emp.salary >= (
	SELECT 
		AVG(emp2.salary) AS avg_sal
	FROM employee AS emp2
	GROUP BY emp2.dept_no
	ORDER BY avg_sal DESC
	LIMIT 1;
	)
	
--Result

+-------+-----------+---------+
| name  | job       | salary  |
+-------+-----------+---------+
| JONES | MANAGER   | 2975.00 |
| SCOTT | ANALYST   | 3000.00 |
| KING  | PRESIDENT | 5000.00 |
| FORD  | ANALYST   | 3000.00 |
+-------+-----------+---------+

--153. List the dept in asc order of job and the desc order of empno

SELECT 
	employee_no,
	name,
	job
FROM employee
ORDER BY job ASC, employee_no, name DESC
LIMIT 5;

--Result

+-------------+-------+---------+
| employee_no | name  | job     |
+-------------+-------+---------+
|        7788 | SCOTT | ANALYST |
|        7902 | FORD  | ANALYST |
|        7369 | SMITH | CLERK   |
|        7876 | ADAMS | CLERK   |
|        7900 | JAMES | CLERK   |
+-------------+-------+---------+

--154. List the empno, ename, hiredate, current date & exp in the asc order of exp

SELECT 
	employee_no AS empno,
	job,
	hiredate_dt,
	DATE(NOW()) AS curr_dt,
	ROUND(TIMESTAMPDIFF(MONTH, hiredate_dt, NOW())/12, 0) AS exper
FROM employee
LIMIT 5;

--Result

+-------+----------+-------------+------------+-------+
| empno | job      | hiredate_dt | curr_dt    | exper |
+-------+----------+-------------+------------+-------+
|  7369 | CLERK    | 1980-12-17  | 2018-02-04 |    37 |
|  7499 | SALESMAN | 1981-02-20  | 2018-02-04 |    37 |
|  7521 | SALESMAN | 1981-02-22  | 2018-02-04 |    37 |
|  7566 | MANAGER  | 1981-04-02  | 2018-02-04 |    37 |
|  7654 | SALESMAN | 1981-09-28  | 2018-02-04 |    36 |
+-------+----------+-------------+------------+-------+

--155. List the emps whose ann sal ranging from 23000 to 40000

SELECT
	name,
	job,
	(salary * 12) AS annual_sal
FROM employee
WHERE 1=1
	AND(salary*12) BETWEEN 23000 AND 40000

--Result

+-------+---------+------------+
| name  | job     | annual_sal |
+-------+---------+------------+
| JONES | MANAGER |   35700.00 |
| BLAKE | MANAGER |   34200.00 |
| CLARK | MANAGER |   29400.00 |
| SCOTT | ANALYST |   36000.00 |
| FORD  | ANALYST |   36000.00 |
+-------+---------+------------+

--156. List the emps working under the Mgrs 7369, 7890, 7654, 7900.

SELECT 
	employee.*
FROM employee
WHERE 1=1
	AND employee.manager IN (7369, 7890, 7654, 7698)
;

--Result

+-------------+--------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+
|        7499 | ALLEN  | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |
|        7521 | WARD   | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |
|        7654 | MARTIN | SALESMAN |    7698 | 1981-09-28  | 1250.00 |      30 |   1400.00 |
|        7844 | TURNER | SALESMAN |    7698 | 1981-09-08  | 1500.00 |      30 |      0.00 |
|        7900 | JAMES  | CLERK    |    7698 | 1981-12-03  |  950.00 |      30 |      NULL |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+

--157. List all the 4 chars emps.

SELECT
	employee.*
FROM employee
WHERE 1=1
	AND LENGTH(employee.name) = 4;
	
+-------------+------+-----------+---------+-------------+---------+---------+-----------+
| employee_no | name | job       | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+------+-----------+---------+-------------+---------+---------+-----------+
|        7521 | WARD | SALESMAN  |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |
|        7839 | KING | PRESIDENT |    NULL | 1981-11-17  | 5000.00 |      10 |      NULL |
|        7902 | FORD | ANALYST   |    7566 | 1981-12-03  | 3000.00 |      20 |      NULL |
+-------------+------+-----------+---------+-------------+---------+---------+-----------+

--158. List the emps names starting with ‘M’ and length of name >= 5

SELECT
	employee.*
FROM employee
WHERE 1=1
	AND LENGTH(employee.name) >= 5
	AND employee.name LIKE 'M%'
	
--Result

+-------------+--------+----------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job      | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+
|        7654 | MARTIN | SALESMAN |    7698 | 1981-09-28  | 1250.00 |      30 |   1400.00 |
|        7934 | MILLER | CLERK    |    7782 | 1982-01-23  | 1300.00 |      10 |      NULL |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+

--159. List the emps who joined in the month having a char ‘a’

SELECT 
	name,
	hiredate_dt,
	DATE_FORMAT(hiredate_dt, '%M') AS join_month
FROM employee
WHERE DATE_FORMAT(hiredate_dt, '%M') LIKE '%a%'

--Result

+--------+-------------+------------+
| name   | hiredate_dt | join_month |
+--------+-------------+------------+
| ALLEN  | 1981-02-20  | February   |
| WARD   | 1981-02-22  | February   |
| JONES  | 1981-04-02  | April      |
| BLAKE  | 1981-05-01  | May        |
| MILLER | 1982-01-23  | January    |
+--------+-------------+------------+

--160. List the emps whose job is same as smith.

SELECT
	*
FROM employee
WHERE 1=1
	AND job = (
	SELECt job
	FROM employee
	WHERE 1=1
		AND name = 'SMITH'
	)
	AND name <> 'SMITH'
	
--Result

+-------------+--------+-------+---------+-------------+---------+---------+-----------+
| employee_no | name   | job   | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+--------+-------+---------+-------------+---------+---------+-----------+
|        7876 | ADAMS  | CLERK |    7788 | 1987-07-13  | 1100.00 |      20 |      NULL |
|        7900 | JAMES  | CLERK |    7698 | 1981-12-03  |  950.00 |      30 |      NULL |
|        7934 | MILLER | CLERK |    7782 | 1982-01-23  | 1300.00 |      10 |      NULL |
+-------------+--------+-------+---------+-------------+---------+---------+-----------+
--161. List the unique jobs of depts. 20 or 30 in des order

SELECT 
	DISTINCT
	job,
	dept_no
FROM employee
WHERE 1=1
	AND dept_no IN (10, 20);
	
--Result

+-----------+---------+
| job       | dept_no |
+-----------+---------+
| CLERK     |      20 |
| MANAGER   |      20 |
| MANAGER   |      10 |
| ANALYST   |      20 |
| PRESIDENT |      10 |
| CLERK     |      10 |
+-----------+---------+
	
--162. List the empno, ename, sal, job of emps with the ann sal < 34000 but receiving some comm., Which should not be > sal and designation should be salesman working for dept 30.

SELECT 
	emp.*,
	(emp.salary * 12) AS annual_sal
FROM employee AS emp
WHERE 1=1
	AND emp.commisson IS NOT NULL
	AND emp.commisson < emp.salary
	AND dept_no = 30
	AND job = 'SALESMAN'
	
--Result

+-------------+--------+----------+---------+-------------+---------+---------+-----------+------------+
| employee_no | name   | job      | manager | hiredate_dt | salary  | dept_no | commisson | annual_sal |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+------------+
|        7499 | ALLEN  | SALESMAN |    7698 | 1981-02-20  | 1600.00 |      30 |    300.00 |   19200.00 |
|        7521 | WARD   | SALESMAN |    7698 | 1981-02-22  | 1250.00 |      30 |    500.00 |   15000.00 |
|        7844 | TURNER | SALESMAN |    7698 | 1981-09-08  | 1500.00 |      30 |      0.00 |   18000.00 |
+-------------+--------+----------+---------+-------------+---------+---------+-----------+------------+
		
--163. List the emps who are belongs to dallas or Chicago with the grade same as adams or exp more than smith.

SELECT 
	emp.*
FROM employee AS emp, department AS dept, salarygrade AS sgrade
WHERE 1=1
	AND dept.dept_no = emp.dept_no
	AND emp.salary BETWEEN sgrade.low_salary AND sgrade.high_salary
	AND dept.location IN ('DALLAS', 'CHICAGO')
	AND sgrade.grade = (
		SELECT
		DISTINCT
			grade
		FROM employee AS emp, salarygrade AS sgrade
		WHERE 1=1
			AND emp.salary BETWEEN sgrade.low_salary AND sgrade.high_salary
			AND emp.name = 'ADAMS'
		)
	AND TIMESTAMPDIFF(MONTH, emp.hiredate_dt, NOW())/12 >= (
		SELECT 
			TIMESTAMPDIFF(MONTH, hiredate_dt, NOW())/12
		FROM employee
		WHERE 1=1
		 AND name = 'SMITH'
	)
 AND emp.name NOT IN ('ADAMS','SMITH')

--Result

Empty set

--164. List the second highest paid emp

SELECT 
	emp.*
SELECT *
 FROM employee AS emp
WHERE emp.salary <> (
	SELECT 
		MAX(salary)
	FROM employee
	)
ORDER BY salary DESC
LIMIT 1;

--Result

+-------------+------+---------+---------+-------------+---------+---------+-----------+
| employee_no | name | job     | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+------+---------+---------+-------------+---------+---------+-----------+
|        7902 | FORD | ANALYST |    7566 | 1981-12-03  | 3000.00 |      20 |      NULL |
+-------------+------+---------+---------+-------------+---------+---------+-----------+

------------------------- other way --------------------------------------
/* In this way we can get all member name and salary who are getting second highest salary */
SELECT *
FROM employee
WHERE salary = (
	SELECT salary
	 FROM employee AS emp
	WHERE emp.salary <> (
		SELECT 
			MAX(salary)
		FROM employee
		)
	ORDER BY salary DESC
	LIMIT 1
);

+-------------+-------+---------+---------+-------------+---------+---------+-----------+
| employee_no | name  | job     | manager | hiredate_dt | salary  | dept_no | commisson |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+
|        7788 | SCOTT | ANALYST |    7566 | 1987-07-13  | 3000.00 |      20 |      NULL |
|        7902 | FORD  | ANALYST |    7566 | 1981-12-03  | 3000.00 |      20 |      NULL |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+

--165. List the details of most recently hired emp of dept 30.

SELECT
	emp.*
FROM employee AS emp
WHERE 1=1
	AND emp.hiredate_dt = (
	SELECT MAX(hiredate_dt)
	FROM employee
	WHERE dept_no = 30
	)
	AND dept_no = 30
	
--Result

+-------------+-------+-------+---------+-------------+--------+---------+-----------+
| employee_no | name  | job   | manager | hiredate_dt | salary | dept_no | commisson |
+-------------+-------+-------+---------+-------------+--------+---------+-----------+
|        7900 | JAMES | CLERK |    7698 | 1981-12-03  | 950.00 |      30 |      NULL |
+-------------+-------+-------+---------+-------------+--------+---------+-----------+