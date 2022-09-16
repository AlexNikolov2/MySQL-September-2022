CREATE TABLE `people`
(
	`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(200) NOT NULL,
    `picture` BLOB,
    `height` DOUBLE(3, 2),
    `weight` DOUBLE(3, 2),
    `gender` ENUM('m', 'f') NOT NULL,
    `birthdate` DATE NOT NULL,
    `biography` LONGTEXT
);

INSERT INTO `people`
(`id`, `name`, `gender`,`birthdate`)
VALUES
(1, 'John Doe', 'm', '2000-01-01'),
(2, 'Jane Doe', 'f', '2000-01-01'),
(3, 'John Doe2', 'm', '2000-01-01'),
(4, 'John Doe3', 'm', '2000-01-01'),
(5, 'John Doe4', 'm', '2000-01-01');