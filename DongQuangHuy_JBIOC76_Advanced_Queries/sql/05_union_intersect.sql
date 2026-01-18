--Phần 5: UNION và INTERSECT (2 điểm)
--17. Gộp danh sách email từ bảng customers và một danh sách email marketing
--Do không có bảng marketing lên em tự tạo và thêm dữ liệu
create table marketing(
	mk_id int primary key,
	email varchar(255)
);

insert into marketing (mk_id, email) values
(1, 'promo1@gmail.com'),
(2, 'a@gmail.com'),      -- trùng với customer
(3, 'promo2@gmail.com'),
(4, 'sale@gmail.com');

select email from customers
union 
select email from marketing;

--18. Tìm khách hàng vừa mua sản phẩm category 'Electronics' vừa mua 'Books'
select distinct c.customer_id, c.customer_name
from customers c
join orders o       on c.customer_id = o.customer_id
join order_items i  on o.order_id = i.order_id
join products p     on i.product_id = p.product_id
join categories ca  on p.category_id = ca.category_id
where ca.category_name = 'electronics'
intersect
select distinct c.customer_ID, c.customer_name
from customers c
join orders o       on c.customer_id = o.customer_id
join order_items i  on o.order_id = i.order_id
join products p     on i.product_id = p.product_id
join categories ca  on p.category_id = ca.category_id
where ca.category_name = 'books';

--19. So sánh danh sách sản phẩm bán chạy tháng này và tháng trước
select p.product_name, i.quantity "Số sản phẩm"
from products p
join order_items i on p.product_id = i.product_id
join orders o      on i.order_id = o.order_id
where extract(month from o.order_date) = extract(month from now())
and   extract(year from o.order_date)  = extract(year from now())
intersect
select p.product_name, i.quantity "Số sản phẩm"
from products p
join order_items i on p.product_id = i.product_id
join orders o      on i.order_id = o.order_id
where extract(month from o.order_date) = extract(month from now()) -1
and   extract(year from o.order_date)  = extract(year from now());
--20. Tìm khách hàng có ở cả hai thành phố Hà Nội và TP.HCM (giả sử có bảng customer_addresses)
create table customer_addresses(
	address_id serial primary key,
	customer_id int references customers(customer_id),
	city varchar(100)
);

insert into customer_addresses (customer_id, city) values
-- Khách hàng 1: có cả Hà Nội và TP.HCM
(1, 'Hà Nội'),
(1, 'TP.HCM'),
-- Khách hàng 2: chỉ Hà Nội
(2, 'Hà Nội'),
-- Khách hàng 3: chỉ TP.HCM
(3, 'TP.HCM'),
-- Khách hàng 4: có nhiều thành phố (có cả Hà Nội & TP.HCM)
(4, 'Đà Nẵng'),
(4, 'Hà Nội'),
(4, 'TP.HCM'),
-- Khách hàng 5: thành phố khác
(5, 'Cần Thơ');

select customer_id "ID"
from customer_addresses
where city = 'Hà Nội'
intersect
select customer_id "ID"
from customer_addresses
where city = 'TP.HCM';
