--01
SELECT `first_name`, `last_name` FROM `employees` WHERE LOWER(`first_name`) LIKE 'sa%' ;

--02
SELECT `first_name`, `last_name` FROM `employees` WHERE LOWER(`last_name`) LIKE '%ei%' ;

--03
SELECT `first_name`  FROM `employees` WHERE `department_id` IN (3, 10) AND `hire_date` BETWEEN '1995-01-01' AND '2005-12-31' ORDER BY `employee_id`;

--04
SELECT `first_name`, `last_name` FROM `employees` WHERE `job_title` NOT LIKE '%engineer%' ORDER BY `employee_id`;

--05
SELECT `name` FROM `towns` WHERE CHAR_LENGTH(`name`) IN (5,6) ORDER BY `name` ASC;

--06
SELECT `town_id`, `name` FROM `towns` WHERE LOWER(SUBSTRING(`name`, 1, 1)) IN ('m', 'k', 'b', 'e') ORDER BY `name` ASC;

--07
SELECT `town_id`, `name` FROM `towns` WHERE LOWER(SUBSTRING(`name`, 1, 1)) NOT IN ('r', 'b', 'd') ORDER BY `name` ASC;

--08
CREATE VIEW `v_employees_hired_after_2000` AS SELECT `first_name`, `last_name` FROM `employees` WHERE `hire_date` >= '2001-01-01';
SELECT * FROM `v_employees_hired_after_2000`;

--09
SELECT `first_name`, `last_name` FROM `employees` WHERE CHAR_LENGTH(`last_name`) = 5;

--10
SELECT `country_name`, `iso_code` FROM `countries`
WHERE CHAR_LENGTH(`country_name`) - CHAR_LENGTH(REPLACE(LOWER(`country_name`), 'a', '')) >= 3
ORDER BY `iso_code`;

--11
SELECT `peak_name`, `river_name`, LOWER(CONCAT(`peak_name`, SUBSTRING(`river_name`, 2))) AS `mix` FROM `peaks`, `rivers`
WHERE LOWER(RIGHT(`peak_name`, 1)) = LOWER(LEFT(`river_name`, 1)) ORDER BY `mix` ASC;

--12
SELECT `name`, DATE_FORMAT(`start`, '%Y-%m-%d') AS `start` FROM `games` WHERE `start` >= '2011-01-01' AND `start` <= '2012-12-31'
ORDER BY `start` ASC, `name` ASC LIMIT 50;

--13
SELECT `user_name`, SUBSTRING_INDEX(`email`, '@', - 1) as `provider` FROM `users` ORDER BY `provider` ASC, `user_name` ASC;

--14
SELECT `user_name`, `ip_address` FROM `users` WHERE `ip_address` LIKE '___.1%.%.___' ORDER BY `user_name` ASC;

--15
SELECT `name` AS `game`,
CASE
    WHEN HOUR(`start`) BETWEEN 0 AND 11 THEN 'Morning'
    WHEN HOUR(`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
END AS `Part of the Day`,
CASE
    WHEN `duration` <= 3 THEN 'Extra Short'
    WHEN `duration` BETWEEN 4 AND 6 THEN 'Short'
    WHEN `duration` BETWEEN 7 AND 10 THEN 'Long'
    ELSE 'Extra Long'
END AS `Duration`
FROM `games`
ORDER BY `name`;

--16
SELECT `product_name`, `order_date`, DATE_ADD(`order_date`, INTERVAL 3 DAY) AS 'pay_due', DATE_ADD(`order_date`, INTERVAL 1 MONTH) AS 'deliver_due' FROM `orders`;