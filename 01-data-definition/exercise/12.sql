CREATE TABLE `categories`
(
	`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `category` VARCHAR(50) NOT NULL,
    `daily_rate` DOUBLE NOT NULL,
    `weekly_rate` DOUBLE NOT NULL,
    `monthly_rate` DOUBLE NOT NULL,
    `weekend_rate` DOUBLE NOT NULL
);

CREATE TABLE `cars`
(
	`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `plate_number` VARCHAR(30) NOT NULL,
    `make` VARCHAR(30) NOT NULL,
    `model` VARCHAR(30) NOT NULL,
    `car_year` YEAR NOT NULL,
    `category_id` INT NOT NULL,
    `doors` INT NOT NULL,
    `picture` BLOB,
    `car_condition` VARCHAR(30),
    `available` BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE `employees`
(
	`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `first_name` VARCHAR(30) NOT NULL,
    `last_name` VARCHAR(30) NOT NULL,
    `title` VARCHAR(30) NOT NULL,
    `notes` TEXT
);

CREATE TABLE `customers`
(
	`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `driver_license_number` VARCHAR(30) NOT NULL,
    `full_name` VARCHAR(50) NOT NULL,
    `address` VARCHAR(50) NOT NULL,
    `city` VARCHAR(50) NOT NULL,
    `zip_code` INT NOT NULL,
    `notes` TEXT
);

CREATE TABLE `rental_orders`
(
	`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	`employee_id` INT NOT NULL,
	`customer_id` INT NOT NULL,
	`car_id` INT NOT NULL,
	`car_condition` VARCHAR(20),
	`tank_level` DOUBLE,
	`kilometrage_start` DOUBLE,
	`kilometrage_end` DOUBLE,
	`total_kilometrage` DOUBLE,
	`start_date` DATE,
	`end_date` DATE,
	`total_days` INT,
	`rate_applied` DOUBLE,
	`tax_rate` DOUBLE,
	`order_status` VARCHAR(30),
	`notes` TEXT
);

INSERT INTO `categories`
(`category`, `daily_rate`, `weekly_rate`, `monthly_rate`, `weekend_rate`)
VALUES 
('1', 1, 2, 3, 4),
('2', 1, 2, 3, 4),
('3', 1, 2, 3, 4);

INSERT INTO `cars`
(`plate_number`, `make`, `model`, `car_year`, `category_id`, `doors`, `car_condition`)
VALUES 
('1', '1', '1', '2000', 1, 2, 'New'),
('2', '2', '2', '2000', 1, 2, 'Used'),
('3', '3', '3', '2000', 1, 2, 'Used');

INSERT INTO `employees`
(`first_name`, `last_name`, `title`)
VALUES 
('Pesho', 'Petrov', 'Worker'),
('Pesho', 'Petrov', 'Worker'),
('Pesho', 'Petrov', 'Worker');

INSERT INTO `customers`
(`driver_license_number`, `full_name`, `address`, `city`, `zip_code`)
VALUES 
('1111', 'Pesho Petrov', 'Some address', 'Sofia', 1000),
('1111', 'Pesho Petrov', 'Some address', 'Sofia', 1000),
('1111', 'Pesho Petrov', 'Some address', 'Sofia', 1000);

INSERT INTO `rental_orders`
(`employee_id`, `customer_id`, `car_id`, `car_condition`, `start_date`)
VALUES 
(1, 1, 1, 'New','2000-01-01'),
(1, 1, 1, 'New','2000-01-01'),
(1, 1, 1, 'New', '2000-01-01');