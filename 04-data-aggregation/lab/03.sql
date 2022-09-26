SELECT `department_id`, ROUND(MIN(`salary`), 2) AS `Average salary` FROM `employees` WHERE `salary` > 800
GROUP BY `department_id` LIMIT 1;