-- Group BY

SELECT *
FROM employee_demographics;

SELECT gender, avg(age), max(age),min(age),count(age)
FROM employee_demographics
GROUP BY gender;

SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary
;
-- order by
SELECT *
FROM employee_demographics
order by 5, 4;

