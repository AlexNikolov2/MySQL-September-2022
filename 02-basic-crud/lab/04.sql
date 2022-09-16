CREATE VIEW `v_top_paid_employee` AS
SELECT *from `employees` ORDER By `salary` DESC LIMIT 1;

SELECT * from `v_top_paid_employee`