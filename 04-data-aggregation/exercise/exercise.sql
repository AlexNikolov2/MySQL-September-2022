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