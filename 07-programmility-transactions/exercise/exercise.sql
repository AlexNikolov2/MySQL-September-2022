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

CREATE PROCEDURE usp_get_towns_starting_with(starting_string VARCHAR(10))
BEGIN
	SELECT `name` FROM `towns` WHERE LEFT(`name`, CHAR_LENGTH(starting_string)) = starting_string ORDER BY `name` ASC;
END

--04