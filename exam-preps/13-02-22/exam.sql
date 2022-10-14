--01

CREATE TABLE `brands` (
`id` INT AUTO_INCREMENT PRIMARY KEY,
 `name` VARCHAR(40) NOT NULL UNIQUE
 );
 
 CREATE TABLE `categories` (
 `id` INT AUTO_INCREMENT PRIMARY KEY,
 `name` VARCHAR(40) NOT NULL UNIQUE
 );
 
 CREATE TABLE `reviews` (
 `id` INT AUTO_INCREMENT PRIMARY KEY,
 `content` TEXT,
 `rating` DECIMAL(10,2) NOT NULL,
 `picture_url` VARCHAR(80) NOT NULL,
 `published_at` DATETIME NOT NULL
 );
 
 CREATE TABLE `products` (
 `id` INT AUTO_INCREMENT PRIMARY KEY,
 `name` VARCHAR(40) NOT NULL,
 `price` DECIMAL(19,2) NOT NULL,
 `quantity_in_stock` INT,
 `description` TEXT,
 `brand_id` INT NOT NULL,
 `category_id` INT NOT NULL,
 `review_id` INT,
 CONSTRAINT `fkey_products_rewies`
 FOREIGN KEY(`review_id`)
 REFERENCES `reviews`(`id`),
 CONSTRAINT `fkey_products_brands`
 FOREIGN KEY(`brand_id`)
 REFERENCES `brands`(`id`),
 CONSTRAINT `fkey_products_categories`
 FOREIGN KEY(`category_id`)
 REFERENCES `categories`(`id`)
 );

CREATE TABLE `customers` (
`id` INT AUTO_INCREMENT PRIMARY KEY,
`first_name` VARCHAR(20) NOT NULL,
`last_name` VARCHAR(20) NOT NULL,
`phone` VARCHAR(30) NOT NULL UNIQUE,
`address` VARCHAR(60) NOT NULL,
`discount_card` BIT(1) NOT NULL 
);

CREATE TABLE `orders`(
`id` INT AUTO_INCREMENT PRIMARY KEY,
`order_datetime` DATETIME NOT NULL,
`customer_id` INT NOT NULL,
CONSTRAINT `fkey_orders_customers`
FOREIGN KEY(`customer_id`)
REFERENCES `customers` (`id`) 
);

CREATE TABLE `orders_products` (
`order_id` INT,
`product_id` INT,
 KEY (`order_id`, `product_id`),
CONSTRAINT `fkey_orders_products_orders`
FOREIGN KEY (`order_id`)
REFERENCES `orders` (`id`),
CONSTRAINT `fkey_orders_products_products`
FOREIGN KEY (`product_id`)
REFERENCES `products` (`id`)
);

--02

INSERT INTO `reviews` (`content`, `picture_url`, `published_at`, `rating`) 
	select left(`description`, 15), reverse(`name`),'2010-10-10' , `price`/ 8 FROM `products` where `id` >= 5


--03

UPDATE `products`
SET `quantity_in_stock` = `quantity_in_stock` - 5
where `quantity_in_stock` between 60 and 70;

--04

