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

CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(10))
BEGIN
	SELECT `first_name`, `last_name` FROM `employees` AS e 
    JOIN `addresses` AS a ON e.`address_id` = a.`address_id` JOIN `towns` AS t ON a.`town_id` = t.`town_id` 
    WHERE t.`name` = town_name ORDER BY e.`first_name` ASC, e.`last_name` ASC;
END

--05

CREATE FUNCTION ufn_get_salary_level(salary_input DECIMAL(10,4)) RETURNS VARCHAR(7) DETERMINISTIC
	RETURN(
		CASE
			WHEN salary_input < 30000 THEN 'Low'
            WHEN salary_input <= 50000 THEN 'Average'
            ELSE 'High'
		END
    );

    --06