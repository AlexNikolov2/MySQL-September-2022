SELECT COUNT(`id`) AS `count` FROM `wizzard_deposits`;

SELECT MAX(`magic_wand_size`) AS `longest_magic_wand` FROM `wizzard_deposits`;

SELECT `deposit_group`, MAX(`magic_wand_size`) AS `longest_magic_wand` FROM `wizzard_deposits` GROUP BY `deposit_group` ORDER BY `longest_magic_wand`, `deposit_group`;

SELECT `deposit_group`  FROM `wizzard_deposits` GROUP BY `deposit_group` ORDER BY AVG(`magic_wand_size`) ASC LIMIT 1;