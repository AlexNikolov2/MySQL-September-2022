UPDATE `employees`
SET `salary` = `salary` + 100 WHERE `job_title` = 'Manager' AND `id` >= 1;
SELECT `salary` from employees;