-- UNIONS

select first_name, last_name
FROM employee_demographics
union all
select first_name, last_name
FROM employee_salary;


select first_name, last_name, 'old man' as label
FROM employee_demographics
where age > 40 and gender = 'male'
union
select first_name, last_name, 'old women' as label
FROM employee_demographics
where age > 40 and gender = 'female'
union 
select first_name, last_name, 'highly paid employee' as label
FROM employee_salary
where salary > 70000
order by first_name,last_name;


