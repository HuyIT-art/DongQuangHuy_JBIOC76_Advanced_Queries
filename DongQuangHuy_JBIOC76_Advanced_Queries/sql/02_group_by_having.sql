--Phần 2: GROUP BY và HAVING (2 điểm)
--5. Tìm các khách hàng có từ 3 đơn hàng trở lên
select c.customer_id "ID", c.customer_name "Tên khách hàng", count(o.order_id) "Số đơn hàng"
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name having count(o.order_id) >= 3;
--6. Liệt kê các danh mục có tổng số lượng sản phẩm tồn kho > 100
select c.category_id "ID", c.category_name "Danh mục", sum(p.stock_quantity) "Số lượng tồn kho"
from categories c join products p on c.category_id = p.category_id
group by c.category_id, c.category_name having sum(p.stock_quantity) > 100;
--7. Tìm các thành phố có số khách hàng >= 5
select city, count(customer_id) "Số khách hàng"
from customers
group by city having count(customer_id) >= 5;
--8. Liệt kê các sản phẩm có tổng số lượng bán ra > 50
select p.product_id "ID", p.product_name "Tên SP", sum(i.quantity) "Tổng số lượng bán ra"
from products p join order_items i on p.product_id = i.product_id
group by p.product_id, p.product_name having sum(i.quantity) >= 50
order by p.product_id asc;