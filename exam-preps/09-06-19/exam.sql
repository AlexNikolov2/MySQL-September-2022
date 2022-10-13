--01

CREATE TABLE `branches`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30) NOT NULL
);

CREATE TABLE `employees`(
`id` int primary key auto_increment,
`first_name` varchar(20) not null,
`last_name` varchar(20) not null,
`salary` DECIMAL(10,2) not null,
`started_on` DATE not null,
`branch_id` int not null,
constraint fk_employees_branches
foreign key (`branch_id`) references `branches`(`id`)
);

CREATE TABLE `clients`(
`id` int primary key auto_increment,
`full_name` varchar(50) not null,
`age` int not null
);

CREATE TABLE `employees_clients`(
`employee_id` INT, 
`client_id` int, 
constraint fk_employee_id foreign key(`employee_id`) references `employees`(`id`),
constraint fk_client_id foreign key(`client_id`) references `clients`(`id`)
);

CREATE TABLE `bank_accounts`(
	`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `account_number` VARCHAR(10) NOT NULL,
    `balance` DECIMAL(10, 2) NOT NULL,
    `client_id` INT NOT NULL UNIQUE,
    CONSTRAINT fk_bank_accounts_clients
    FOREIGN KEY (`client_id`)
    REFERENCES `clients`(`id`)
);

CREATE TABLE `cards`(
	`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `card_number` VARCHAR(19) NOT NULL,
    `card_status` VARCHAR(7) NOT NULL,
    `bank_account_id` INT NOT NULL,
    CONSTRAINT fk_cards_bank_accounts
    FOREIGN KEY (`bank_account_id`)
    REFERENCES `bank_accounts`(`id`)
);

--02

INSERT into `cards` (`card_number`, `card_status`, `bank_account_id`)
SELECT reverse(`full_name`), 'Active', `id` FROM `clients` 
WHERE `id` BETWEEN 191 and 200; 

--03

UPDATE `employees_clients` AS ec
	JOIN (
    SELECT ec2.`employee_id`, COUNT(ec2.`client_id`) AS `count` FROM `employees_clients` AS ec2
    GROUP BY ec2.`employee_id`
    ORDER BY `count` , ec2.`employee_id`
    ) AS s 
SET ec.`employee_id` = s.`employee_id`
WHERE ec.`employee_id` = ec.`client_id`;

--04

DELETE FROM `employees` WHERE `id` NOT IN (SELECT `employee_id` FROM `employees_clients`);

--05

SELECT `id`, `full_name` FROM `clients` ORDER BY `id` ASC;


--06

SELECT  `id`,
    CONCAT(`first_name`, ' ', `last_name`) as `full_name`,
    CONCAT('$', `salary`) as `salary`,
    `started_on`
FROM `employees`
WHERE `salary` >= 100000 and DATE(`started_on`) >= '2018-01-01'
ORDER BY `salary` DESC , `id` ASC;

--07

SELECT ca.`id`, concat(ca.`card_number`, ' : ', c.`full_name`) as `card_token` FROM `clients` as c
JOIN `bank_accounts` as ba on c.`id` = ba.`client_id`
JOIn `cards` as ca on ba.`id` = ca.`bank_account_id`
ORDER BY ca.`id` DESC

--08

SELECT concat(`first_name`, ' ', `last_name`) AS `name`,
    `started_on`,
    `count_of_clients`
FROM `employees` AS e
	JOIN (
    SELECT `employee_id`, count(`client_id`) AS `count_of_clients` FROM `employees_clients` GROUP BY `employee_id`
    ) AS c ON e.`id` = c.`employee_id`
ORDER BY `count_of_clients` DESC , `employee_id` ASC LIMIT 5;

--09

SELECT  b.`name`, COUNT(ca.`id`) AS `count_of_cards` FROM `branches` AS b
	LEFT JOIN `employees` AS e ON b.`id` = e.`branch_id`
	LEFT JOIN `employees_clients` AS ec ON e.`id` = ec.`employee_id`
	LEFT JOIN `clients` AS c ON ec.`client_id` = c.`id`
	LEFT JOIN `bank_accounts` AS ba ON c.`id` = ba.`client_id`
	LEFT JOIN `cards` AS ca ON ba.`id` = ca.`bank_account_id`
GROUP BY b.`name` ORDER BY `count_of_cards` DESC , b.`name` ASC;

--10

CREATE FUNCTION udf_client_cards_count(`name` VARCHAR(30)) RETURNS INT DETERMINISTIC
	RETURN (
    SELECT COUNT(ca.`id`) AS `cards` FROM `clients` AS c
	JOIN `bank_accounts` AS b ON c.`id` = b.`client_id`
	JOIN `cards` AS ca on b.`id` = ca.`bank_account_id`
	WHERE c.`full_name` = `name`
    );