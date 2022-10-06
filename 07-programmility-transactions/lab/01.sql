CREATE  FUNCTION  ufn_count_employees_by_town (town_name VARCHAR(20)) RETURNS INT RETURN (
	SELECT COUNT(`employees`.`employee_id`) FROM `employees`
		JOIN `addresses` as a ON a.`address_id` = `employees`.`address_id`
        JOIN `towns` as t ON t.`town_id` = a.`town_id`
        WHERE t.name = town_name
        );