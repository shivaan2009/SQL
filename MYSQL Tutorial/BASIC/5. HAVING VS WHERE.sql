-- HAVING VS WHERE

SELECT gender, avg(age)
FROM employee_demographics
GROUP BY gender
HAVING avg(AGE)> 40;


SELECT occupation, avg(salary) 
FROM employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary)> 75000
;