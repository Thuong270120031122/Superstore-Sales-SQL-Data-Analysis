use STORE
go 

select * from superstore


use STORE
go

SELECT TOP 5 *
FROM superstore

-- TONG DOANH THU VA LOI  NHUAN MOI NAM
SELECT YEAR(OrderDate) as year,
		SUM(CONVERT(FLOAT,Sales)) as total_sales,
		SUM(CONVERT(FLOAT,Profit)) as total_profit
FROM superstore
GROUP BY YEAR(OrderDate)
ORDER BY year ASC;

-- TONG DOANH THU VA LOI NHUAN MOI QUY TRONG NAM
SELECT YEAR(OrderDate) as year,
		CASE 
			WHEN DATEPART(MONTH,OrderDate) IN (1,2,3) THEN 'Q1'
			WHEN DATEPART(MONTH,OrderDate) IN (4,5,6) THEN 'Q2'
			WHEN DATEPART(MONTH,OrderDate) IN (7,8,9) THEN 'Q3'
			ELSE 'Q4'
		END AS quarter,
		SUM(CONVERT(FLOAT,Sales)) as total_sales,
		SUM(CONVERT(FLOAT,Profit)) as total_profit
FROM superstore
GROUP BY YEAR(OrderDate),
		CASE 
			WHEN DATEPART(MONTH,OrderDate) IN (1,2,3) THEN 'Q1'
			WHEN DATEPART(MONTH,OrderDate) IN (4,5,6) THEN 'Q2'
			WHEN DATEPART(MONTH,OrderDate) IN (7,8,9) THEN 'Q3'
			ELSE 'Q4'
		END
ORDER BY year, quarter;
--KHU VỰC NÀO TẠO RA DOANH THU LỢI NHUẬN CÁO NHẤT?
SELECT Region,
		SUM(CONVERT(FLOAT,Sales)) as total_sales,
		SUM(CONVERT(FLOAT,Profit)) as total_profit
FROM superstore
GROUP BY Region
ORDER BY total_profit DESC

-- TỶ SUẤT LỢI NHUẬN CỦA TỪNG KHU VỰC
SELECT Region, ROUND((SUM(CONVERT(FLOAT,Profit)) / SUM(CONVERT(FLOAT,Sales))) *100,2) AS profit_margin
FROM superstore
GROUP BY Region
ORDER BY profit_margin DESC

--4: TIỂU BANG VÀ THÀNH PHỐ NÀO MANG LẠI LỢI NHUẬN CAO NHẤT
SELECT TOP 10 State,
		SUM(CONVERT(FLOAT,Sales)) as total_sales,
		SUM(CONVERT(FLOAT,Profit)) as total_profit,
		ROUND((SUM(CONVERT(FLOAT,Profit)) / SUM(CONVERT(FLOAT,Sales))) *100,2) AS profit_margin 
FROM superstore
GROUP BY State
ORDER BY total_profit DESC

--QUAN SAT 10 BANG ĐỨNG CUỐI CỦA CHÚNG TA
SELECT TOP 10 State,
		SUM(CONVERT(FLOAT,Sales)) as total_sales,
		SUM(CONVERT(FLOAT,Profit)) as total_profit
FROM superstore
GROUP BY State
ORDER BY total_profit ASC

-- TOP 10 THANH PHỐ CÓ LỢI NHUẬN ĐỨNG ĐẦU
SELECT TOP 10 City,
		SUM(CONVERT(FLOAT,Sales)) as total_sales,
		SUM(CONVERT(FLOAT,Profit)) as total_profit,
		ROUND((SUM(CONVERT(FLOAT,Profit)) / SUM(CONVERT(FLOAT,Sales))) *100,2) AS profit_margin
FROM superstore
GROUP BY City
ORDER BY total_profit DESC
-- TOP 10 THÀNH PHỐ ĐỨNG CUỐI BẢNG LÀ:

SELECT TOP 10 City,
		SUM(CONVERT(FLOAT,Sales)) as total_sales,
		SUM(CONVERT(FLOAT,Profit)) as total_profit
FROM superstore
GROUP BY City
ORDER BY total_profit ASC

-- 5.MỐI QUAN HỆ CHIẾT KHẤU, BÁN HÀNG VÀ TỔNG CHIẾT KHẤU CHO MỖI DANH MỤC
SELECT Discount, AVG(CONVERT(FLOAT,Sales)) as Avg_Sales
FROM superstore
GROUP BY Discount
ORDER BY Discount;

-- HÃY XEM TỔNG GIẢM GIÁ CHO MỖI LOẠI SẢN PHẨM
SELECT Category, ROUND(SUM(CONVERT(FLOAT,Discount)),2) AS total_discount
FROM superstore
GROUP BY Category
ORDER BY total_discount DESC;

-- PHÓNG TO SẢN PHẨM DANH MỤC ĐỂ XEM LOẠI SẢN PHẨM NÀO ĐANG ĐƯỢC ƯA CHUỘNG NHẤT
SELECT Category, SubCategory, ROUND(SUM(CONVERT(FLOAT,Discount)),2) AS total_discount
FROM superstore
GROUP BY Category, SubCategory
ORDER BY total_discount DESC;
--6.SẢN PHẨM NÀO TẠO RA DOANH THU VÀO LỢI NHUẬN CAO NHẤT Ở MỖI KHU VỰC VÀ TIỂU BANG

SELECT Category,
		SUM(CONVERT(FLOAT,Sales)) as total_sales,
		SUM(CONVERT(FLOAT,Profit)) as total_profit,
		ROUND((SUM(CONVERT(FLOAT,Profit)) / SUM(CONVERT(FLOAT,Sales))) *100,2) AS profit_margin 
FROM superstore
GROUP BY Category
ORDER BY total_profit DESC;

--TÔNG DOANH THU VÀ TỔNG LỢI NHUẬN CAO NHẤT CỦA MỖI SẢN PHẨM THEO MỖI KHU VỰC
SELECT Region, Category,
		SUM(CONVERT(FLOAT,Sales)) as total_sales,
		SUM(CONVERT(FLOAT,Profit)) as total_profit 
FROM superstore
GROUP BY Region,Category
ORDER BY total_profit DESC;

-- TỔNG DOANH THU VÀ TỔNG LỢi NHUẬN CAO NHẤT MỖI SẢN PHẨM VÀ TIỂU BANG
SELECT State, Category, 
		SUM(CONVERT(FLOAT,Sales)) as total_sales,
		SUM(CONVERT(FLOAT,Profit)) as total_profit 
FROM superstore
GROUP BY State, Category
ORDER BY total_profit DESC;

-- TỔNG DOANH THU VÀ LỢI NHUẬN THẤP NHẤT CỦA MỖI SẢN PHẨM VÀ TIỂU BANG
SELECT State, Category, 
		SUM(CONVERT(FLOAT,Sales)) as total_sales,
		SUM(CONVERT(FLOAT,Profit)) as total_profit 
FROM superstore
GROUP BY State, Category
ORDER BY total_profit ASC;

-- CÂU 7: DANH MỤC PHỤ NÀO TẠO RA DOANH THU VÀ LỢI NHUẬN CAO NHẤT Ở TỪNG KHU VỰC VÀ TIỂU BANG
-- QUAN SÁT TỔNG DOANH THU VÀ TỔNG LỢI NHUẬN CỦA MỖI DANH MỤC THEO TỶ SUẤT LỢI NHUẬN CỦA CHÚNG
SELECT SubCategory,
		SUM(CONVERT(FLOAT,Sales)) as total_sales,
		SUM(CONVERT(FLOAT,Profit)) as total_profit,
		ROUND((SUM(CONVERT(FLOAT,Profit)) / SUM(CONVERT(FLOAT,Sales))) *100,2) AS profit_margin 
FROM superstore
GROUP BY SubCategory
ORDER BY total_profit DESC;
--TỔNG DOANH THU VÀ LỢI NHUẬN CAO NHẤT CỦA MỖI DANH MỤC THEO TỪNG KHU VỰC
SELECT Region, SubCategory,
		SUM(CONVERT(FLOAT,Sales)) as total_sales,
		SUM(CONVERT(FLOAT,Profit)) as total_profit 
FROM superstore
GROUP BY Region, SubCategory
ORDER BY total_profit DESC

--THẤP NHẤT
SELECT Region, SubCategory,
		SUM(CONVERT(FLOAT,Sales)) as total_sales,
		SUM(CONVERT(FLOAT,Profit)) as total_profit 
FROM superstore
GROUP BY Region, SubCategory
ORDER BY total_profit ASC

--DOANH THU VÀ LỢI NHUẬN CAO NHẤT CỦA MỖI DANH MỤC THEO MỖI BANG:
SELECT State, SubCategory,
		SUM(CONVERT(FLOAT,Sales)) as total_sales,
		SUM(CONVERT(FLOAT,Profit)) as total_profit 
FROM superstore
GROUP BY State, SubCategory
ORDER BY total_profit DESC;

-- DOANH THU VÀ LỢI NHUẬN THẤP NHẤT
SELECT State, SubCategory,
		SUM(CONVERT(FLOAT,Sales)) as total_sales,
		SUM(CONVERT(FLOAT,Profit)) as total_profit 
FROM superstore
GROUP BY State, SubCategory
ORDER BY total_profit ASC;

-- CÂU 8: TÊN CỦA MỖI SẢN PHẨM MÀ MANG LẠI LỢI NHUẬN NHIỀU NHẤT VÀ ÍT NHẤT CHO CHÚNG TÔI.
SELECT ProductName, 
		SUM(CONVERT(FLOAT,Sales)) as total_sales,	
		SUM(CONVERT(FLOAT,Profit)) as total_profit 
FROM superstore
GROUP BY ProductName
ORDER BY total_profit DESC

-- TÊN MỖI SẢN PHẨM MÀ MANG LẠI LỢI NHUẬN ÍT NHẤT
SELECT ProductName, 
		SUM(CONVERT(FLOAT,Sales)) as total_sales,	
		SUM(CONVERT(FLOAT,Profit)) as total_profit 
FROM superstore
GROUP BY ProductName
ORDER BY total_profit ASC;

--CÂU 9: Phân khúc nào tận dụng tối đa lợi nhuận và doanh thu của chúng tôi
-- what segment makes the most of our profits and sales

SELECT Segment, ROUND(SUM(CONVERT(FLOAT,Sales)),2) as total_sales,
				ROUND(SUM(CONVERT(FLOAT,Profit)),2) as total_profit
FROM superstore
GROUP BY Segment
ORDER BY total_profit DESC

-- CÂU 10: HOW MANY CUSTOMERS DO WE HAVE (UNIQUE CUSTOMER IDS)
-- IN TOTAL AND HOW MUCH PER REGION AND STATE?

SELECT COUNT(DISTINCT CustomerID) as total_customers
FROM superstore;
--chúng ta có 793 khách hàng giữa 2014 và 2017.
-- khách hàng theo khu vực cụ thể, chúng ta có:
SELECT Region, COUNT(DISTINCT CustomerID) as total_customers
FROM superstore
GROUP BY Region
ORDER BY total_customers DESC;

--Chúng tôi chắc chắn đã có khách hàng di chuyển khắp các khu vực, 
--điều này giải thích tại sao tổng của họ không bằng 793. Vì có thể có gấp đôi
--đếm. Miền Tây là khu vực có thị trường lớn nhất. Theo tiểu bang, đây là những con số:

SELECT State, COUNT(DISTINCT CustomerID) as total_customers
FROM superstore
GROUP BY State
ORDER BY total_customers DESC;

-- Chúng tôi có nhiều khách hàng nhất ở California, New York và Texas.
-- Những khu vực mà chúng tôi có ít người đi qua nhất là
SELECT State, COUNT(DISTINCT CustomerID) as total_customers
FROM superstore
GROUP BY State
ORDER BY total_customers ASC;

--CÂU 11: CHƯƠNG TRÌNH THƯỞNG CHO KHÁCH

SELECT TOP 15 CustomerID,
		ROUND(SUM(CONVERT(FLOAT,Sales)),2) as total_sales,
		ROUND(SUM(CONVERT(FLOAT,Profit)),2) as total_profit		
FROM superstore
GROUP BY CustomerID
ORDER BY total_sales DESC;

use STORE
GO
select * from superstore
-- 12. THỜI GIAN VẬN CHUYỂN TRUNG BÌNH CHO MỖI LỚP VÀ TỔNG
-- THỜI GIAN VẬN CHUYỂN TRUNG BÌNH
SELECT ROUND(AVG(DATEDIFF(day, OrderDate, ShipDate)), 1) AS avg_shipping_time
FROM superstore;

--THỜI GIAN VẬN CHUYỂN Ở MỖI CHẾ ĐỘ VẬN CHUYỂN LÀ
SELECT ShipMode, AVG(DATEDIFF(DAY, OrderDate, ShipDate)) AS avg_shipping_time
FROM superstore
GROUP BY ShipMode
ORDER BY avg_shipping_time
