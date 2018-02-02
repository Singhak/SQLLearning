--121. List the name of dept where highest no of emps are working

SELECT 
	dept.name,
	emp.dept_no,
	COUNT(emp.employee_no) AS emp_count
FROM employee AS emp
INNER JOIN department AS dept
	ON 1=1
	AND emp.dept_no = dept.dept_no
GROUP BY dept.dept_no, dept.name
ORDER BY emp_count DESC
/* We Limit 1 since we need geive name of department where highest no of employee working*/
LIMIT 1;

--Result

+-------+---------+-----------+
| name  | dept_no | emp_count |
+-------+---------+-----------+
| SALES |      30 |         6 |
+-------+---------+-----------+

--122. Count the no of emps who are working as ‘Managers’

SELECT 
	COUNT(employee.employee_no) AS mgr_count
FROM employee
 WHERE 1=1
	AND employee.employee_no IN (
		SELECT 
			emp.manager
		FROM employee AS emp
	);
	
--Result

+-----------+
| mgr_count |
+-----------+
|         6 |
+-----------+

--123. List the emps who joined in the company on the same date

SELECT 
	emp.hiredate_dt,
	COUNT(*) AS join_count
FROM employee AS emp
GROUP BY hiredate_dt
HAVING join_count > 1

--Result

+-------------+------------+
| hiredate_dt | join_count |
+-------------+------------+
| 1981-12-03  |          2 |
| 1987-07-13  |          2 |
+-------------+------------+

--124. List the details of the emps whose grade is equal to one tenth of sales deptno.

SELECT
 DISTINCT
	emp.name,
	emp.dept_no,
	sgrade.grade
FROM employee AS emp, salarygrade AS sgrade
WHERE 1=1
	AND emp.salary BETWEEN sgrade.low_salary AND sgrade.high_salary
	AND sgrade.grade IN (
		SELECT
			department.dept_no/10
		FROM department
		WHERE department.name = 'SALES'
	)
	
--Result

+--------+---------+-------+
| name   | dept_no | grade |
+--------+---------+-------+
| ALLEN  |      30 |     3 |
| TURNER |      30 |     3 |
+--------+---------+-------+
	
--125. List the name of the dept where more than avg. no of emps are working

SELECT 
	dept.name,
	COUNT(emp.employee_no) AS emp_count
FROM employee AS emp
INNER JOIN department AS dept
	ON 1=1
	AND emp.dept_no = dept.dept_no
GROUP BY dept.dept_no, dept.name
HAVING emp_count > ( 
		SELECT 
			AVG(emp_count.cnt)
		FROM (
			SELECT 
				COUNT(employee.employee_no) AS cnt
			FROM employee
			GROUP BY employee.dept_no
		) AS emp_count
	)
		
--Result

+----------+-----------+
| RESEARCH |         5 |
| SALES    |         6 |
+----------+-----------+

--126. List the managers name who is having max no of emps working under him

SELECT
	emp.manager,
	emp.name,
	COUNT(*) num_emp
FROM employee AS emp
GROUP BY emp.manager
ORDER BY num_emp DESC
LIMIT 1; /* Since we need one max num emps workin*/

--Result

+---------+-------+---------+
| manager | name  | num_emp |
+---------+-------+---------+
|    7698 | ALLEN |       5 |
+---------+-------+---------+

--128. Produce the output of EMP table ‘EMP_AND_JOB’ for ename and job

SELECT 
	CONCAT_WS('_', emp.name,"AND", emp.job) AS EMP_AND_JOB /* you can use emp.name || '_' || 'AND_' || emp.job */
FROM employee AS emp
LIMIT 5;

--Result

+---------------------+
| EMP_AND_JOB         |
+---------------------+
| SMITH_AND_CLERK     |
| ALLEN_AND_SALESMAN  |
| WARD_AND_SALESMAN   |
| JONES_AND_MANAGER   |
| MARTIN_AND_SALESMAN |
+---------------------+

--Produce the following output from EMP like below
--EMPLOYEE
----------------
--SMITH(clerk)
--ALLEN(salesman)
SELECT 
	CONCAT(emp.name,"(", LOWER(emp.job),")") AS EMPLOYEE
FROM employee AS emp
LIMIT 5;

--Result

+------------------+
| EMPLOYEE         |
+------------------+
| SMITH(clerk)     |
| ALLEN(salesman)  |
| WARD(salesman)   |
| JONES(manager)   |
| MARTIN(salesman) |
+------------------+

--130. List the emps with hiredate in format June 4,1988.

SELECT 
	emp.name,
	DATE_FORMAT(emp.hiredate_dt,'%M %d,%Y') AS hiredate
FROM employee AS emp
LIMIT 5;

--Result

+--------+-------------------+
| name   | hiredate          |
+--------+-------------------+
| SMITH  | December 17,1980  |
| ALLEN  | February 20,1981  |
| WARD   | February 22,1981  |
| JONES  | April 02,1981     |
| MARTIN | September 28,1981 |
+--------+-------------------+

--131. Print a list of emp’s listing ‘just salary’ if salary is more than 1500, ‘On target’ if salary is 1500 and ‘Below 1500’ if salary is less than 1500.
SELECT
	emp.name,
	CASE
		WHEN emp.salary > 1500 THEN 'just salary'
		WHEN emp.salary < 1500 THEN 'below 1500'
		ELSE
			'on target'
	END AS salary
FROM employee AS emp
LIMIT 5;

--Result

+--------+-------------+
| name   | salary      |
+--------+-------------+
| SMITH  | below 1500  |
| ALLEN  | just salary |
| WARD   | below 1500  |
| JONES  | just salary |
| MARTIN | below 1500  |
+--------+-------------+
	
--132. Select the details of all the emps who are sub-ordinates to BLAKE.

SELECT *
FROM employee
WHERE 1=1
	AND employee.manager = (
		SELECT 
			employee_no
		FROM employee
		WHERE 1=1
			AND employee.name = 'BLAKE'
		);

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

--133. List the emps who are working as managers using co-related subquery

/*Using Sub Query :*/
SELECT 
	* 
FROM employee
WHERE 1=1
	AND employee_no IN (
	SELECT 
		employee.manager 
	FROM employeee
	) ;
/*Using Co-Releated Query :*/
SELECT 
	DISTINCT A.* 
FROM employee A, employee B 
WHERE 1=1
	AND A.employee_no =B.manager ;

/*Using Co-Releated Sub Query :*/
SELECT 
	DISTINCT A.* 
FROM employee A, employee B 
WHERE 1=1
	AND employee_no IN (
	SELECT 
		employee.manager 
	FROM employeee
	) ;

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

--134. List the emps whose Mgr name is ‘JONES’ and also with his Manager Name.

SELECT
	emp.*,
	emp2.name
FROM employee AS emp, employee AS emp2
WHERE 1=1
	AND emp.manager = emp2.employee_no
	AND emp2.name = 'JONES';

--Result

+-------------+-------+---------+---------+-------------+---------+---------+-----------+-------+
| employee_no | name  | job     | manager | hiredate_dt | salary  | dept_no | commisson | name  |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+-------+
|        7788 | SCOTT | ANALYST |    7566 | 1987-07-13  | 3000.00 |      20 |      NULL | JONES |
|        7902 | FORD  | ANALYST |    7566 | 1981-12-03  | 3000.00 |      20 |      NULL | JONES |
+-------------+-------+---------+---------+-------------+---------+---------+-----------+-------+

--135. Find out how many managers are there in the company.

SELECT
	COUNT(*) AS mgr_count
FROM employee
WHERE 1=1
	AND employee_no IN (
	SELECT 
		employee.manager
	FROM employee
	);
	
--Result

+-----------+
| mgr_count |
+-----------+
|         6 |
+-----------+
