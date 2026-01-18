01_alias_aggregate.sql
Mục tiêu:
Sử dụng alias và các hàm tổng hợp như COUNT, SUM, AVG để thống kê dữ liệu.
Cách tiếp cận:
Dùng alias để đặt tên cột dễ đọc hơn.
Áp dụng hàm tổng hợp trên dữ liệu số.
Kết hợp với GROUP BY khi cần gom nhóm dữ liệu.
Kỹ thuật sử dụng:
AS (alias)
COUNT(), SUM(), AVG(), MAX(), MIN()

02_group_by_having.sql
--Phần 2: GROUP BY và HAVING (2 điểm)
--5. Tìm các khách hàng có từ 3 đơn hàng trở lên
Ý tưởng: gộp id khách hàng giống nhau rồi đếm có bao nhiêu dòng order_id nếu >= 3 thì được

--6. Liệt kê các danh mục có tổng số lượng sản phẩm tồn kho > 100
Ý tưởng: join bảng, sau đó gộp theo id danh mục, dùng hàm sum() để tính sản lượng tồn kho mỗi danh mục

--7. Tìm các thành phố có số khách hàng >= 5
Ý tưởng: Gom tên thành phố sau đó đếm số id của khách hàng ở mỗi thành phố(count) nếu >=5 thỏa mãn

--8. Liệt kê các sản phẩm có tổng số lượng bán ra > 50
Ý tưởng: gom các sản phẩm theo id sau đó dùng sum() đếm số lượng mỗi sản phẩm, nếu > 50 thì thỏa mãn

 03_subqueries.sql
--9. Tìm khách hàng có tổng giá trị đơn hàng cao nhất
Ý tưởng tạo 1 bảng chứa tổng giá trị đơn hàng của từng khác hàng, dùng max để lấy cái lớn nhất trong bảng đó làm điều kiện
lọc cho truy vấn chính

--10. Liệt kê sản phẩm chưa từng được bán
Ý tưởng: Nếu tồn tại product_id trong order_items thì không hiện, và ngược lại nếu không tồn tại sẽ hiện
(Where exists(subquery): Nếu tồn tại dòng trong subquery, lấy dòng trong truy vấn chính và ngược lại)

--11. Tìm khách hàng có đơn hàng đầu tiên trong tháng hiện tại
Ý tưởng: lọc ra order_date trong tháng hiện tại, lấy min(order_date) sau đó so sánh với các bản ghi truy vấn chính

--12. Liệt kê sản phẩm có giá cao hơn giá trung bình của danh mục đó
Ý tưởng: ta lọc category_id ở subquery vơi category_id của truy vấn chính để tạo thành 1 bảng cùng danh muc
sau đó lấy giá trị trung bình của danh mục đấy so với giá của sản phẩm trong danh mục đó
do mỗi bản ghi ở truy vấn chính bao gồm product_id và category_id lên sẽ không có chuyện 
so sánh giá sản phẩm với giá trung bình danh mục không chứa sản phẩm đấy

 04_joins.sql
--13. Hiển thị thông tin đơn hàng kèm tên khách hàng và email (INNER JOIN)
Ý tưởng: Gộp 2 bagr orders và customers, lấy phần id chung để hiện id đơn hàng ở bảng đơn hàng đồng thời
hiện tên khách hàng ở bảng customers

--14. Liệt kê tất cả khách hàng và số đơn hàng của họ (LEFT JOIN)
Ý tưởng: bảng customers sẽ chứa id đầy đủ của khách hàng nên đặt bên trái để có thể lấy 
được hết cả khách hàng không có đơn hàng nào

--15. Hiển thị tất cả sản phẩm và số lượng đã bán (LEFT JOIN)
Ý tưởng: lấy left join cho bảng products vì nó chứa toàn bộ id của sản phẩm bao gồm cả
sản phẩm chưa bán trong order_items

--16. Liệt kê tất cả danh mục và số sản phẩm trong mỗi danh mục (LEFT JOIN)
Ý tưởng: lấy left join cho bảng categories vì nó chưa toàn bộ id của danh mục không có sản phẩm nào

05_union_intersect.sql
--17. Gộp danh sách email từ bảng customers và một danh sách email marketing
Do không có bảng marketing lên em tự tạo và thêm dữ liệu
Cho danh sách email ở bảng customer union vói danh sách email ở bảng marketing

--18. Tìm khách hàng vừa mua sản phẩm category 'Electronics' vừa mua 'Books'
Cho danh sách sản phẩm có danh mục 'Electronics'  ở bảng gộp intersect vói sản phẩm có danh mục 'Books'

--19. So sánh danh sách sản phẩm bán chạy tháng này và tháng trước
Lọc ra các sản phẩm bán được ở tháng này
Lọc ra các sản phẩm bán được ở tháng này -1 
intersect

--20. Tìm khách hàng có ở cả hai thành phố Hà Nội và TP.HCM (giả sử có bảng customer_addresses)
Lọc các khách hàng ở Hà Nội
Lọc các khách hàng ở TP.HCM
intersect