CREATE TABLE `users`
(
	`id` INT PRIMARY KEY UNIQUE AUTO_INCREMENT,
    `username` VARCHAR(30) UNIQUE NOT NULL,
    `password` VARCHAR(26) NOT NULL,
    `profile_picture` BLOB,
    `last_login_time` TIMESTAMP,
    `is_deleted` BOOLEAN
);

INSERT INTO `users`
(`username`, `password`)
VALUES
('Pesho', '12345'),
('Hitler', '12345'),
('Mark', '12345'),
('Mikel', '12345'),
('Luis', '12345');