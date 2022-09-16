CREATE TABLE `directors`
(
	`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `director_name` VARCHAR(50) NOT NULL,
    `notes` TEXT
);

CREATE TABLE `genres`
(
	`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `genre_name` VARCHAR(50) NOT NULL,
    `notes` TEXT
);

CREATE TABLE `categories`
(
	`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `category_name` VARCHAR(50) NOT NULL,
    `notes` TEXT
);

CREATE TABLE `movies`
(
	`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(50) NOT NULL,
    `director_id` INT NOT NULL,
    `copyright_year` YEAR NOT NULL,
    `length` TIME NOT NULL,
    `genre_id` INT NOT NULL,
    `category_id` INT NOT NULL,
    `rating` INT,
    `notes` TEXT
);

INSERT INTO `directors`
(`director_name`)
VALUES
('Pesho'),
('Pesho'),
('Pesho'),
('Pesho'),
('Pesho');

INSERT INTO `genres`
(`genre_name`)
VALUES
('Horror'),
('Horror'),
('Horror'),
('Horror'),
('Horror');

INSERT INTO `categories`
(`category_name`)
VALUES
('Scary'),
('Scary'),
('Scary'),
('Scary'),
('Scary');

INSERT INTO `movies`
(`id`, `title`, `director_id`, `copyright_year`, `length`, `genre_id`, `category_id`)
VALUES
(1, 'Pesho', 1, '2020', 108, 1, 1),
(2, 'Pesho', 1, '2020', 108, 1, 1),
(3, 'Pesho', 1, '2020', 108, 1, 1),
(4, 'Pesho', 1, '2020', 108, 1, 1),
(5, 'Pesho', 1, '2020', 108, 1, 1);