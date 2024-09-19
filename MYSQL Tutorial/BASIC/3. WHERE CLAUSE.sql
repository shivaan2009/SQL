-- WHERE CLAUSE
 
SELECT *
FROM employee_salary
WHERE first_name = 'Leslie'
;



SELECT *
FROM employee_salary
WHERE salary <= 50000
;

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
;

-- AND OR NOT -- LOGICAL OPEARTORS
SELECT *
FROM employee_demographics
WHERE (first_name = 'leslie' AND age = 44) OR age > 55
;

-- (like statement)
SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%' 
;