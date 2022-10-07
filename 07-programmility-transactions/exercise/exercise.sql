--01

create procedure usp_get_employees_salary_above_35000()
BEGIN
	select `first_name`, `last_name` from `employees` where `salary` > 35000 order by `first_name` asc, `last_name` asc, `employee_id` asc;
end

--02

create procedure usp_get_employees_salary_above(target_salary DECIMAL(10,4))
BEGIN
	select `first_name`, `last_name` from `employees` where `salary` >= target_salary order by `first_name` asc, `last_name` asc, `employee_id` asc;
end

--03

CREATE PROCEDURE usp_get_towns_starting_with(starting_string VARCHAR(10))
BEGIN
	SELECT `name` FROM `towns` WHERE LEFT(`name`, CHAR_LENGTH(starting_string)) = starting_string ORDER BY `name` ASC;
END

--04

CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(10))
BEGIN
	SELECT `first_name`, `last_name` FROM `employees` AS e 
    JOIN `addresses` AS a ON e.`address_id` = a.`address_id` JOIN `towns` AS t ON a.`town_id` = t.`town_id` 
    WHERE t.`name` = town_name ORDER BY e.`first_name` ASC, e.`last_name` ASC;
END

--05

CREATE FUNCTION ufn_get_salary_level(salary_input DECIMAL(10,4)) RETURNS VARCHAR(7) DETERMINISTIC
	RETURN(
		CASE
			WHEN salary_input < 30000 THEN 'Low'
            WHEN salary_input <= 50000 THEN 'Average'
            ELSE 'High'
		END
    );

--06

CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(7))
BEGIN
	SELECT `first_name`, `last_name` FROM `employees` WHERE `salary` < 30000 AND salary_level = 'low'
    OR `salary` >= 30000 AND `salary` <= 50000 AND salary_level = 'average' OR `salary` > 50000 AND salary_level = 'high'
    ORDER BY `first_name` DESC, `last_name` DESC;
END

--07

CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
RETURNS BIT
RETURN word REGEXP (concat('^[', set_of_letters, ']+$'));

--08

CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
	SELECT CONCAT(`first_name`, ' ', `last_name`) AS `full_name` FROM `account_holders` ORDER BY `full_name` ASC;
END

--09 // to be solved tomorrow

--10

CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(10, 4), interest_rate DECIMAL(10, 4), years INT) RETURNS DECIMAL(10, 4) DETERMINISTIC
BEGIN
	RETURN sum * POW((1 + interest_rate), years);
END

--11

CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(10, 4), interest_rate DECIMAL(10, 4), years INT) RETURNS DECIMAL(10, 4) DETERMINISTIC
BEGIN
	RETURN sum * POW((1 + interest_rate), years);
END;
        --same function
CREATE PROCEDURE usp_calculate_future_value_for_account(
    account_id INT, interest_rate DECIMAL(19, 4))
BEGIN
    SELECT 
         a.id AS 'account_id', h.first_name, h.last_name, a.balance AS 'current_balance',
         ufn_calculate_future_value(a.balance, interest_rate, 5) AS 'balance_in_5_years'
    FROM
        `account_holders` AS h JOIN `accounts` AS a ON h.id=a.account_holder_id
    WHERE a.id = account_id;
END

--12

CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(10, 4)) 
BEGIN
	IF money_amount > 0 THEN START TRANSACTION;
		UPDATE `accounts` AS a SET a.`balance` = a.`balance` + money_amount WHERE a.`id` = account_id;
		
		IF(
			SELECT a.`balance` FROM `accounts` AS a WHERE a.`id` = account_id
		) < 0
			THEN ROLLBACK;
		ELSE
			COMMIT;
		END IF;
	END IF;
END

--13

CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(20, 4)) 
BEGIN
	IF money_amount > 0 THEN START TRANSACTION;
		UPDATE `accounts` AS a SET a.`balance` = a.`balance` - money_amount WHERE a.`id` = account_id;
		
		IF(
			SELECT a.`balance` FROM `accounts` AS a WHERE a.`id` = account_id
            ) < 0
			THEN ROLLBACK;
		ELSE
			COMMIT;
		END IF;
	END IF;
END

--14

CREATE PROCEDURE usp_transfer_money(
    from_account_id INT, to_account_id INT, money_amount DECIMAL(19, 4))
BEGIN
    IF `money_amount` > 0 
        AND from_account_id <> to_account_id
        AND (SELECT a.id 
            FROM accounts AS a WHERE a.id = to_account_id) IS NOT NULL
        AND (SELECT a.id 
            FROM `accounts` AS a WHERE a.id = from_account_id) IS NOT NULL
        AND (SELECT a.balance 
            FROM `accounts` AS a WHERE a.id = from_account_id) >= money_amount
    THEN
        START TRANSACTION;
        
        UPDATE `accounts` AS a 
        SET 
            a.balance = a.balance + money_amount
        WHERE
            a.id = to_account_id;
            
        UPDATE `accounts` AS a 
        SET 
            a.balance = a.balance - money_amount
        WHERE
            a.id = from_account_id;
        
        IF (SELECT a.balance 
            FROM `accounts` AS a WHERE a.id = from_account_id
		) < 0 THEN ROLLBACK;
        ELSE
            COMMIT;
        END IF;
    END IF;
END

--15 // for tomorrow

--16 // for tomorrow