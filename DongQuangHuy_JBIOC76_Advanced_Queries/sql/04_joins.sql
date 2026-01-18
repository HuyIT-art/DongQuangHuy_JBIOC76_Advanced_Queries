--Phần 4: JOINs (2 điểm)
--13. Hiển thị thông tin đơn hàng kèm tên khách hàng và email (INNER JOIN)
select o.order_id "Đơn hàng", o.status "Tình trạng", c.customer_name "Tên khách hàng", c.email "Email"
from customers c inner join orders o on c.customer_id = o.customer_id;
--Ý tưởng: Gộp 2 bagr orders và customers, lấy phần id chung để hiện id đơn hàng ở bảng đơn hàng đồng thời
--hiện tên khách hàng ở bảng customers

--14. Liệt kê tất cả khách hàng và số đơn hàng của họ (LEFT JOIN)
select c.customer_id "ID", c.customer_name "Tên khách hàng", count(order_id) "Số đơn hàng"
from customers c left join orders o on o.customer_id = c.customer_id
group by c.customer_id, c.customer_name
order by c.customer_id;
--Ý tưởng: bảng customers sẽ chứa id đầy đủ của khách hàng nên đặt bên trái để có thể lấy 
--được hết cả khách hàng không có đơn hàng nào

--15. Hiển thị tất cả sản phẩm và số lượng đã bán (LEFT JOIN)
select p.product_id "ID", p.product_name "Tên SP", sum(i.quantity) "Số lượng đã bán"
from products p left join order_items i on p.product_id = i.product_id
group by p.product_id, p.product_name;
--Ý tưởng: lấy left join cho bảng products vì nó chứa toàn bộ id của sản phẩm bao gồm cả
--sản phẩm chưa bán trong order_items

--16. Liệt kê tất cả danh mục và số sản phẩm trong mỗi danh mục (LEFT JOIN)
select c.category_id "ID", c.category_name "Tên danh mục", count(p.stock_quantity)"Số sản phẩm"
from categories c left join products p on c.category_id = p.category_id
group by c.category_id , c.category_name;
--Ý tưởng: lấy left join cho bảng categories vì nó chưa toàn bộ id của danh mục không có sản phẩm nào