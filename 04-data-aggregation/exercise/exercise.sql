-- 01
SELECT COUNT(`id`) AS `count` FROM `wizzard_deposits`;

--02
SELECT MAX(`magic_wand_size`) AS `longest_magic_wand` FROM `wizzard_deposits`;

--03
SELECT `deposit_group`, MAX(`magic_wand_size`) AS `longest_magic_wand` FROM `wizzard_deposits` GROUP BY `deposit_group` ORDER BY `longest_magic_wand`, `deposit_group`;

--04
SELECT `deposit_group`  FROM `wizzard_deposits` GROUP BY `deposit_group` ORDER BY AVG(`magic_wand_size`) ASC LIMIT 1;

--05
SELECT `deposit_group`, SUM(`deposit_amount`) AS `total_sum` FROM `wizzard_deposits` GROUP By `deposit_group` ORDER BY `total_sum` ASC;

--06
SELECT `deposit_group`, SUM(`deposit_amount`) AS `total_sum` FROM `wizzard_deposits` 
WHERE `magic_wand_creator` = 'Ollivander family' GROUP BY `deposit_group` ORDER BY `deposit_group` ASC;

--07
SELECT `deposit_group`, SUM(`deposit_amount`) AS `total_sum` FROM `wizzard_deposits` 
WHERE `magic_wand_creator` = 'Ollivander family'  GROUP BY `deposit_group` HAVING `total_sum` < 150000 ORDER BY `total_sum` DESC;

--08
SELECT `deposit_group`, `magic_wand_creator`, MIN(`deposit_charge`) AS 'min_deposit_charge' FROM `wizzard_deposits`
GROUP BY `deposit_group` , `magic_wand_creator` ORDER BY `magic_wand_creator` ASC , `deposit_group` ASC;

--09
SELECT 
    CASE
        WHEN `age` <= 10 THEN '[0-10]'
        WHEN `age` <= 20 THEN '[11-20]'
        WHEN `age` <= 30 THEN '[21-30]'
        WHEN `age` <= 40 THEN '[31-40]'
        WHEN `age` <= 50 THEN '[41-50]'
        WHEN `age` <= 60 THEN '[51-60]'
        ELSE '[61+]'
    END AS `age_group`,
    COUNT(*) AS `wizard_count`
FROM `wizzard_deposits` GROUP BY `age_group` ORDER BY `wizard_count` ASC;

--10
SELECT  LEFT(`first_name`, 1) AS `first_letter` FROM `wizzard_deposits`
WHERE `deposit_group` = 'Troll Chest' GROUP BY `first_letter` ORDER BY `first_letter`;

--11
SELECT  `deposit_group`, `is_deposit_expired`, AVG(`deposit_interest`) AS `deposit_interest` FROM `wizzard_deposits`
WHERE `deposit_start_date` > '1985-01-01' GROUP BY `deposit_group` , `is_deposit_expired` ORDER BY `deposit_group` DESC , `is_deposit_expired` ASC;

--12
SELECT  `department_id`, MIN(`salary`) AS `minimum_salary` FROM `employees`
WHERE `department_id` IN (2 , 5, 7) GROUP BY `department_id` ORDER BY `department_id`;

--13
SELECT  `department_id`,
    CASE
        WHEN `department_id` = 1 THEN AVG(`salary`) + 5000
        ELSE AVG(`salary`)
    END AS `avg_salary`
FROM `employees`
WHERE `salary` > 30000 AND `manager_id` != 42 GROUP BY `department_id` ORDER BY `department_id`;

--14
SELECT  `department_id`, MAX(`salary`) AS `max_salary` FROM `employees` 
GROUP BY `department_id` HAVING NOT `max_salary` BETWEEN 30000 AND 70000 ORDER BY `department_id` ASC;

--15
SELECT COUNT(`salary`) AS `salary` FROM `employees` WHERE `manager_id` IS NULL;

--16
SELECT  `department_id`,
    (SELECT DISTINCT `salary` FROM `employees` AS `e`
		WHERE `e`.`department_id` = `employees`.`department_id`
        ORDER BY `salary` DESC LIMIT 1 OFFSET 2)
        AS `third_highest_salary`
FROM `employees` GROUP BY `department_id` HAVING `third_highest_salary` IS NOT NULL ORDER BY `department_id`;