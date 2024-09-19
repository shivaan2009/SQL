-- case statement

SELECT first_name,
last_name,
AGE,
CASE
	WHEN AGE <=30 THEN 'YOUNG' 
    WHEN AGE BETWEEN 31 AND 50 THEN 'OLD'
    WHEN AGE >=50 THEN 'ON DEATH BED'
END AS AGE_BRACKET
FROM employee_demographics;


-- PAY INCREASE AND BOUNUS
-- <50000 = 5%
-- >50000 = 7%
-- FINANCE = 10% BONUS


SELECT first_name,last_name,salary,
CASE
	WHEN salary < 50000 THEN salary + (salary*0.05)
    WHEN salary > 50000 THEN salary + (salary*0.07)
END AS NEW_SALARY,
CASE
	WHEN dept_id = 6 THEN salary * 0.10
END AS BONUS 
FROM employee_salary;

SELECT *
FROM employee_salary;
SELECT *
FROM parks_departments;