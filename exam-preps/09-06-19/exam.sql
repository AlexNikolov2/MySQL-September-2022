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