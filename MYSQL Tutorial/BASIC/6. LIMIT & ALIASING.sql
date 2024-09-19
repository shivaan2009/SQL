-- LIMIT AND ALIASING

SELECT *
FROM employee_demographics
order by AGE DESC
LIMIT 2,1
;

-- ALIASING
SELECT GENDER, AVG(AGE) AS avg_age
FROM employee_demographics
GROUP BY GENDER
HAVING avg_age > 40;
