alter table `products`
add constraint `FK_category_id`
foreign key (`category_id`) references `categories` (`id`);