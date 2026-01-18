--Phần 1: ALIAS và Aggregate Functions (2 điểm)
--Liệt kê danh sách sản phẩm với tên sản phẩm được đặt ALIAS là "Tên SP", giá được đặt ALIAS là "Đơn giá"
select product_name "Tên SP", price "Đơn giá"
from products;
--Tính tổng số khách hàng theo từng thành phố
select city, count(customer_id) "Số khách hàng"
from  customers
group by city;
--Tìm giá cao nhất, thấp nhất và trung bình của sản phẩm theo từng danh mục
select c.category_name, c.category_id, max(p.price) "Giá cao nhất", min(p.price) "Giá thấp nhât", avg(p.price) "Giá trung bình"
from categories c join products p on c.category_id = p.category_id
group by c.category_name, c.category_id;
--Đếm số đơn hàng theo từng trạng thái
select status, count(order_id) "Số đơn hàng"
from orders
group by status;