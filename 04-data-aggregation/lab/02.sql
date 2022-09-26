SELECT `department_id`, ROUND(AVG(`salary`), 2) AS `Average salary` FROM `employees`
GROUP BY `department_id`;
