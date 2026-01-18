--Phần 3: Subqueries (2 điểm)
--9. Tìm khách hàng có tổng giá trị đơn hàng cao nhất
select c.customer_id "ID", c.customer_name "Tên khách hàng", sum(o.total_amount) "Tổng giá trị đơn hàng"
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having sum(o.total_amount)
= 
(select max(k.total_price) from (select c.customer_id, sum(o.total_amount) total_price
								from customers c join orders o on c.customer_id = o.customer_id
								group by c.customer_id) k);
--Ý tưởng tạo 1 bảng chứa tổng giá trị đơn hàng của từng khác hàng, dùng max để lấy cái lớn nhất trong bảng đđó làm điều kiện
--lọc cho truy vấn chính

--10. Liệt kê sản phẩm chưa từng được bán
--Cách 1:
select p.product_id "ID", p.product_name 
from products p
where (select count(*) from order_items i
		where i.product_id = p.product_id) = 0;
--Ý tưởng: product_id không hiện ở bảng order_items sẽ là chưa bán, chỉ cần so sánh các product_id của order_items
--với product_id của products nếu không có cái nào khớp kết quả sẽ là 0
--Cách 2:
select p.product_id "ID", p.product_name
from products p
where not exists (select 1 from order_items i where i.product_id = p.product_id);
--Ý tưởng: Nếu tồn tại product_id trong order_items thì không hiện, và ngược lại nếu không tồn tại sẽ hiện
--(Where exists(subquery): Nếu tồn tại dòng trong subquery, lấy dòng trong truy vấn chính và ngược lại)

--11. Tìm khách hàng có đơn hàng đầu tiên trong tháng hiện tại
select c.customer_id "ID", c.customer_name "Tên khách hàng"
from customers c join orders o on c.customer_id = o.customer_id
where o.order_date = (select min(o2.order_date) from orders o2
					  where o2.order_date >= date_trunc('month', now())
                      and o2.order_date <  date_trunc('month', now()) + interval '1 month';
--Ý tưởng: lọc ra order_date trong tháng hiện tại, lấy min(order_date) sau đó so sánh với các bản ghi truy vấn chính

--12. Liệt kê sản phẩm có giá cao hơn giá trung bình của danh mục đó
select p.product_id "ID", p.product_name "Tên SP", p.price "Giá"
from products p
where p.price >
(select avg(p2.price) from products p2 where p2.category_id = p.category_id
);
--Ý tưởng: ta lọc category_id ở subquery vơi category_id của truy vấn chính để tạo thành 1 bảng cùng danh muc
--sau đó lấy giá trị trung bình của danh mục đấy so với giá của sản phẩm trong danh mục đó
--do mỗi bản ghi ở truy vấn chính bao gồm product_id và category_id lên sẽ không có chuyện 
--so sánh giá sản phẩm với giá trung bình danh mục không chứa sản phẩm đấy

