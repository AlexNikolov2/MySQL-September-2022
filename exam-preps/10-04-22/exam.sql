--01

CREATE TABLE `countries`(
`id` INT auto_increment primary key,
`name` varchar(30) Not null  unique, 
`continent` varchar(30) not null, 
`currency` varchar(5) not null);

CREATE TABLE `genres`
(
    `id`   INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE `actors`(
`id` INT primary key auto_increment,
`first_name` varchar(50) not null,
`last_name` varchar(50) not null,
`birthdate` date not null,
`height` int,
`awards`int,
`country_id` int not null,
constraint `fk_people_countries`
foreign key(`country_id`) references countries(`id`) 
);

CREATE TABLE `movies_additional_info`
(
    `id`           INT PRIMARY KEY AUTO_INCREMENT,
    `rating`       DECIMAL(10, 2) NOT NULL,
    `runtime`      INT NOT NULL,
    `picture_url`  VARCHAR(80)    NOT NULL,
    `budget`       DECIMAL(10, 2) ,
    `release_date` DATE           NOT NULL,
    `has_subtitles` TINYINT(1),
    `description`  TEXT
);
 
CREATE TABLE `movies`
(
    `id`           INT PRIMARY KEY AUTO_INCREMENT,
    `title`        VARCHAR(70) UNIQUE NOT NULL ,
    `country_id`   INT NOT NULL,
    `movie_info_id`   INT NOT NULL UNIQUE ,
    CONSTRAINT `fk_movies_countries`
        FOREIGN KEY (`country_id`) REFERENCES countries (`id`),
    CONSTRAINT `fk_movies_movie_info`
        FOREIGN KEY (`movie_info_id`) REFERENCES movies_additional_info (id)
);
 
CREATE TABLE `movies_actors`
(
    `movie_id` INT,
    `actor_id` INT,
    KEY `pk_movie_actor` (`movie_id`, `actor_id`),
    CONSTRAINT `fk_movies_actors_movies`
        FOREIGN KEY (`movie_id`) REFERENCES movies (id),
    CONSTRAINT `fk_movies_actors_actors`
        FOREIGN KEY (`actor_id`) REFERENCES actors (id)
);
 
CREATE TABLE `genres_movies`
(
    `genre_id` INT,
    `movie_id` INT,
    KEY `pk_genre_movies`(`genre_id`,`movie_id`),
    CONSTRAINT `fk_genres_movies_genres`
        FOREIGN KEY (`genre_id`) REFERENCES genres(id),
    CONSTRAINT `fk_genres_movies_movies`
        FOREIGN KEY (`movie_id`) REFERENCES movies(id)
);

--02

INSERT INTO `actors`(`first_name`, `last_name`, `birthdate`, `height`, `awards`, `country_id`)
SELECT (REVERSE(a.`first_name`)),(REVERSE(a.`last_name`)),(DATE (a.`birthdate` - 2)),(a.`height` + 10),(a.`country_id`),(3) FROM `actors` as a
WHERE a.`id` <= 10;

--03

UPDATE `movies_additional_info` m
SET m.`runtime` = m.`runtime` - 10
WHERE m.`id` BETWEEN 15 AND 25;

--04

DELETE c, m
FROM `countries` AS c 
LEFT JOIN `movies` AS m
ON c.`id` =  m.`country_id`
WHERE m.`country_id` IS NULL;