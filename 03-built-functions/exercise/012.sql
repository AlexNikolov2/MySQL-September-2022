SELECT `name`, DATE_FORMAT(`start`, '%Y-%m-%d') AS `start` FROM `games` WHERE `start` >= '2011-01-01' AND `start` <= '2012-12-31'
ORDER BY `start` ASC, `name` ASC LIMIT 50;