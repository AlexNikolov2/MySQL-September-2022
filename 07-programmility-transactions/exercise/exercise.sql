--01

create procedure usp_get_employees_salary_above_35000()
BEGIN
	select `first_name`, `last_name` from `employees` where `salary` > 35000 order by `first_name` asc, `last_name` asc, `employee_id` asc;
end

--02

create procedure usp_get_employees_salary_above(target_salary DECIMAL(10,4))
BEGIN
	select `first_name`, `last_name` from `employees` where `salary` >= target_salary order by `first_name` asc, `last_name` asc, `employee_id` asc;
end

--03
