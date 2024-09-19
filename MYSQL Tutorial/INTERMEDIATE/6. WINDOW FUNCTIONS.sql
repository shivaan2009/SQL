-- WINDOW FUNCTIONS

SELECT GENDER , AVG(SALARY) AS AVG_SALARY
FROM employee_demographics AS DEM
JOIN employee_salary AS SAL
	ON DEM.employee_id=SAL.employee_id 
GROUP BY GENDER;



SELECT DEM.first_name ,DEM.last_name,gender, AVG(SALARY) OVER(partition by GENDER)
FROM employee_demographics AS DEM
JOIN employee_salary AS SAL
	ON DEM.employee_id=SAL.employee_id;



SELECT DEM.first_name ,DEM.last_name,gender,salary,
sum(SALARY) OVER(partition by GENDER ORDER BY DEM.employee_id) AS ROLLING_TOTAL
FROM employee_demographics AS DEM
JOIN employee_salary AS SAL
	ON DEM.employee_id=SAL.employee_id;



SELECT DEM.employee_id,DEM.first_name ,DEM.last_name,gender,salary,
row_number() OVER(partition by GENDER order by SALARY DESC) AS ROW_NUM,
RANK() OVER(partition by GENDER order by SALARY DESC) AS RANK_NUM,
DENSE_RANK() OVER(partition by GENDER order by SALARY DESC) AS DENSE_RANK_NUM
FROM employee_demographics AS DEM
JOIN employee_salary AS SAL
	ON DEM.employee_id=SAL.employee_id;