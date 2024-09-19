-- CTEs

WITH CTE_EXAMPLE(gender,avg_sal,max_sal,min_sal,count_sal) AS 
(
SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, count(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
group by gender
)
SELECT *
FROM CTE_EXAMPLE;


SELECT avg(avg_sal)
FROM CTE_EXAMPLE;




WITH CTE_EXAMPLE AS 
(
SELECT employee_id, gender, birth_date
FROM employee_demographics dem
WHERE birth_date > '1985-01-01'
),
CTE_EXAMPLE2 AS
(
SELECT employee_id, salary
FROM employee_salary
WHERE salary > 50000
)
SELECT *
FROM CTE_EXAMPLE
JOIN CTE_EXAMPLE2
	ON CTE_EXAMPLE.employee_id = CTE_EXAMPLE2.employee_id;