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

--05

SELECT * FROM `countries`
ORDER BY `currency` DESC, `id`

--06

SELECT m.`id`, m2.`title`, m.`runtime`, m.`budget`, m.`release_date`
FROM `movies_additional_info` as m
JOIN `movies` m2 on m.`id` = m2.`movie_info_id`
WHERE year(m.`release_date`) between 1996 and 1999
ORDER by m.`runtime`, m.`id`
LIMIT 20;


--07

SELECT concat(a.`first_name`, ' ', a.`last_name`) as `full_name`,
concat(reverse(a.`last_name`), length(a.`last_name`), '@cast.com') AS 'email',
       2022 - YEAR(a.`birthdate`) AS age, 
       a.`height` 
FROM `actors` AS a
WHERE a.`id` NOT IN (SELECT `actor_id` FROM `movies_actors`)
ORDER BY `height` ASC;

--08

SELECT c.`name`, COUNT(m.`id`) as `movies_count`
FROM `movies` as m
JOIN `countries` as c on c.`id` = m.`country_id`
GROUP BY c.`name`
HAVING `movies_count` >= 7
ORDER BY `name` DESC;

--09

SELECT m.`title`,
       (CASE
            when mi.`rating` <= 4 THEN 'poor'
            when mi.`rating` <= 7 THEN 'good'
            else 'excellent'
        END) as `rating`,
       IF(mi.`has_subtitles`, 'english', '-') `subtitles`,
       mi.`budget`
FROM `movies_additional_info` as `mi`
JOIN `movies` as m on mi.`id` = m.`movie_info_id`
ORDER BY `budget` DESC;

--10

CREATE function udf_actor_history_movies_count(full_name VARCHAR (50))
	returns int
    deterministic
BEGIN
	declare movies_count INT;
    SET movies_count := (
		SELECT count(g.name) movies FROM actors as a
        JOIN movies_actors ma on a.id = ma.actor_id
                 JOIN genres_movies gm on ma.movie_id = gm.movie_id
                 JOIN genres g on g.id = gm.genre_id
        WHERE CONCAT(a.first_name, ' ', a.last_name) = full_name AND g.name = 'History'
        GROUP BY  g.name
    );
    RETURN movies_count;
    END

--11