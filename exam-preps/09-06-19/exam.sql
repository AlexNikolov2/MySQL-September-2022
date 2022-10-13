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

