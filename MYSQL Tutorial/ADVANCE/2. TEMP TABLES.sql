-- TEMPORARY TABLES

CREATE temporary table temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

select *
from temp_table;

insert into temp_table
values('Shivaan','Shah','Harry Potter');

select *
from temp_table;

SELECT *
FROM employee_salary;

CREATE temporary TABLE SALARY_OVER_50K
SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT *
FROM SALARY_OVER_50K;