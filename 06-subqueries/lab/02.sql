SELECT t.`town_id`, t.`name`, a.`address_text` FROM `towns` as t
JOIN `addresses` AS a ON t.`town_id` = a.`town_id` 
WHERE t.`name` IN ('San Francisco', 'Sofia', 'Carnation') 
ORDER BY t.`town_id` ASC, a.`address_id` ASC;