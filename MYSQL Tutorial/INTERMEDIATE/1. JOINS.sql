-- JOINS

select *
FROM employee_demographics;

select *
FROM employee_salary;

select DEM.employee_id,AGE,occupation
FROM employee_demographics AS DEM
INNER JOIN employee_salary AS SAL
	ON DEM.employee_id = SAL.employee_id
;


select *
FROM employee_demographics AS DEM
RIGHT JOIN employee_salary AS SAL
	ON DEM.employee_id = SAL.employee_id
;

-- SELF JOIN
select EMP1.employee_id AS EMP_SANTA,
EMP1.first_name AS FIRST_NAME_SANTA,
EMP1.last_name AS LAST_NAME_SANTA,
EMP2.employee_id AS EMP_SANTA,
EMP2.first_name AS FIRST_NAME_SANTA,
EMP2.last_name AS LAST_NAME_SANTA
FROM employee_salary AS EMP1
JOIN employee_salary AS EMP2
	ON EMP1.employee_id + 1 = EMP2.employee_id 
    ;


-- JOINING MULTIPLE TABLES
select *
FROM employee_demographics AS DEM
INNER JOIN employee_salary AS SAL
	ON DEM.employee_id = SAL.employee_id
INNER JOIN parks_departments AS PD
		ON SAL.dept_id = PD.department_id
;

SELECT *
FROM parks_departments