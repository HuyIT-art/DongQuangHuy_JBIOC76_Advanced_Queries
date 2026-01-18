drop table customers;
drop table orders;
drop table order_items;
drop table categories;
drop table products;
create table customers(
	customer_id serial primary key,
	customer_name varchar(50) not null,
	email varchar(255) not null,
	city varchar(100),
	join_date date not null
);

create table categories(
	category_id serial primary key,
	category_name varchar(100) not null,
	description text
);

create table products(
	product_id serial primary key,
	product_name varchar(100) not null,
	category_id int references categories(category_id),
	price numeric(15,2) not null check(price >= 0),
	stock_quantity int check(stock_quantity >= 0) default 0
);

create type order_status as enum('pending', 'shipped', 'delivered', 'completed');
drop type order_status cascade;
create table orders(
	order_id serial primary key,
	customer_id int references customers(customer_id),
	order_date date not null,
	total_amount numeric(15,2) not null check(total_amount >= 0),
	status order_status
);

create table order_items(
	item_id serial primary key,
	order_id int references orders(order_id),
	product_id int references products(product_id),
	quantity int not null check(quantity > 0),
	unit_price numeric(15,2) not null check(unit_price >=0)
);
delete from customers;
delete from categories;
delete from products;
delete from orders;
delete from order_items;

insert into customers (customer_name, email, city, join_date) values
('nguyen van a', 'a@gmail.com', 'ha noi', '2023-01-10'),
('tran thi b', 'b@gmail.com', 'hai phong', '2023-02-15'),
('le van c', 'c@gmail.com', 'da nang', '2023-03-20'),
('pham thi d', 'd@gmail.com', 'ha noi', '2023-04-05'),
('hoang van e', 'e@gmail.com', 'hcm', '2023-05-01'),
('do thi f', 'f@gmail.com', 'can tho', '2023-05-18'),
('vu van g', 'g@gmail.com', 'ha noi', '2023-06-02'),
('bui thi h', 'h@gmail.com', 'nam dinh', '2023-06-20');


insert into categories (category_name, description) values
('electronics', 'electronic devices'),
('books', 'books and documents'),
('clothing', 'fashion products'),
('furniture', 'home furniture'),
('sports', 'sports equipment'),
('beauty', 'beauty products'),
('toys', 'children toys'),
('food', 'food and drink');


insert into products (product_name, category_id, price, stock_quantity) values
('laptop', 1, 1500.00, 10),
('smartphone', 1, 900.00, 20),
('sql book', 2, 40.00, 50),
('t-shirt', 3, 20.00, 100),
('office chair', 4, 200.00, 5),
('football', 5, 30.00, 25),
('lipstick', 6, 15.00, 60),
('milk tea', 8, 5.00, 200);


insert into orders (customer_id, order_date, total_amount, status) values
(1, '2023-06-01', 2400.00, 'completed'),
(1, '2023-06-10', 40.00, 'shipped'),
(2, '2023-06-05', 900.00, 'pending'),
(3, '2023-06-07', 200.00, 'completed'),
(4, '2023-06-12', 20.00, 'completed'),
(5, '2023-06-15', 1500.00, 'pending'),
(6, '2023-06-18', 30.00, 'shipped'),
(7, '2023-06-20', 45.00, 'completed');
(1, '2023-06-02', 60.00, 'completed'),
(1, '2023-06-03', 50.00, 'shipped');


insert into order_items (order_id, product_id, quantity, unit_price) values
(1, 1, 50, 1500.00),
(1, 2, 40, 900.00),
(2, 3, 60, 40.00),
(3, 2, 25, 900.00),
(4, 5, 20, 200.00),
(5, 4, 70, 20.00),
(6, 1, 10, 1500.00),
(7, 6, 90, 30.00);






































