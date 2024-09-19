-- SUBQUERIES 

SELECT *
FROM employee_demographics
WHERE employee_id IN 
				(select employee_id
                FROM employee_salary
                WHERE dept_id=1)
;

SELECT first_name,salary,
(SELECT avg(salary)
FROM employee_salary) AS AVG_SALARY
FROM employee_salary
; 

select GENDER, avg(AGE), MAX(AGE),MIN(AGE),COUNT(AGE)
FROM employee_demographics
GROUP BY GENDER;

SELECT  avg(MAX_AGE)
FROM 
(select GENDER, 
avg(AGE) AS AVG_AGE, 
MAX(AGE)AS MAX_AGE,
MIN(AGE)AS MIN_AGE,
COUNT(AGE)
FROM employee_demographics
GROUP BY GENDER) AS AGG_TABLE
;

