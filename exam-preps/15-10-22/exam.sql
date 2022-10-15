--01

create table `waiters`(
`id` int primary key auto_increment,
`first_name` varchar(50) not null,
`last_name` varchar(50) not null,
`email` varchar(50) not null,
`phone` varchar(50),
`salary` decimal(10,2)
);

create table `tables`(
`id` int primary key auto_increment,
`floor` int not null,
`reserved` tinyint(1),
`capacity` int not null
);

create table `orders`(
`id` int primary key auto_increment,
`table_id` int not null,
`waiter_id` int not null,
`order_time` time not null,
`payed_status` tinyint(1),
constraint `fk_table` foreign key (`table_id`) references `tables`(`id`),
constraint `fk_waiter` foreign key (`waiter_id`) references `waiters`(`id`)
);

create table `products`(
`id` int primary key auto_increment,
`name` varchar(30) not null unique,
`type` varchar(30) not null,
`price` decimal(10,2) not null
);

create table `clients`(
`id` int primary key auto_increment,
`first_name` varchar(50) not null,
`last_name` varchar(50) not null,
`birthdate` date not null,
`card` varchar(50),
`review` text
);

create table `orders_products`(
`order_id` int,
`product_id` int,
constraint `fk_order` foreign key (`order_id`) references `orders`(`id`),
constraint `fk_product` foreign key(`product_id`) references `products`(`id`)
);

create table `orders_clients`(
`order_id` int,
`client_id` int,
constraint `fk_order_2` foreign key(`order_id`) references `orders`(`id`),
constraint `fk_clients` foreign key(`client_id`) references `clients`(`id`)
)

--02

insert into products(name, type ,price) (select concat(w.last_name, ' ', 'specialty'),
 "Cocktail", CEILING(w.salary * 0.01) from waiters as w where w.id > 6); 

 --03

update `orders`
set `table_id` = `table_id` - 1
where `id` between 12 and 23;

--04

delete `w` from `waiters` as `w` left join `orders` on `w`.`id` = `orders`.`waiter_id` where `orders`.`waiter_id` is null;

--05

SELECT * FROM `clients` order by `birthdate` desc, `id` desc;

--06

SELECT `first_name`, `last_name`, `birthdate`, `review` FROM `clients` where `card` is null and `birthdate` >= '1978-01-01' and `birthdate` <= '1993-12-31'
order by `last_name` desc, `id` desc limit 5;

--07


SELECT concat(`last_name`, `first_name`, char_length(`first_name`), 'Restaurant') as `username`, reverse(substring(`email`, 2, 12)) as `password` from `waiters` 
where `salary` is not null order by `password` desc

--08

select `p`.`id`, `p`.`name`, count(`p`.`id`) as `count` from `products` as `p` 
join `orders_products` as `op` on  `p`.`id` = `op`.`product_id`
group by `p`.`name`
having `count` >= 5
order by count desc, `p`.`name` asc;

--09

select `o`.`table_id`, `t`.`capacity`,  count(`oc`.`client_id`) as `count_clients`,
 (case 
  when `t`.`capacity` > count(`oc`.`order_id`) then 'Free seats'
  when `t`.`capacity` = count(`oc`.`order_id`) then 'Full'
  when `t`.`capacity` < count(`oc`.`order_id`) then 'Extra seats'
 end)
  as `availability` from tables as `t`
join `orders` as `o` on `o`.`table_id` = `t`.id
join `orders_clients` as `oc` on `oc`.`order_id` = `o`.`id`
where `t`.`floor` = 1
group by `o`.`table_id`
order by `o`.`table_id` desc;

--10

CREATE function udf_client_bill(full_name varchar(50)) returns decimal(19,2) deterministic 
begin
	return (
		select sum(`p`.`price`) from `clients` as `c`
			join `orders_clients` as `oc` on `oc`.`client_id` = `c`.`id`
            join `orders` as `o` on `oc`.`order_id` = `o`.`id`
            join `orders_products` as `op` on `op`.`order_id` = `o`.`id`
            join `products` as `p` on `p`.`id` = `op`.`product_id` 
            WHERE `c`.`first_name` = SUBSTRING_INDEX(SUBSTRING_INDEX(full_name, ' ', 1), ' ', -1)  AND
					`c`.`last_name` = SUBSTRING_INDEX(SUBSTRING_INDEX(full_name, ' ', 3), ' ', -1)
		);
end;

--11

create procedure udp_happy_hour (`type` varchar(50))
begin
	update `products` as `p`
    set `price` = `price` * 0.8
    where `type` = `p`.`type` and `p`.`price` >= 10.00;
    end;