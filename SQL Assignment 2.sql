Question 1:
CREATE VIEW customer_HDD_product
AS
SELECT DISTINCT A.customer_id, A.First_Name, A.Last_Name
FROM sale.customer A, sale.orders B, sale.order_item C, product.product D
WHERE A.customer_id = B.customer_id
AND B.order_id = C.order_id
AND C.product_id = D.product_id
AND D.product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'

CREATE VIEW customer_polk_product
AS
SELECT DISTINCT A.customer_id, A.First_Name, A.Last_Name
FROM sale.customer A, sale.orders B, sale.order_item C, product.product D
WHERE A.customer_id = B.customer_id
AND B.order_id = C.order_id
AND C.product_id = D.product_id
AND D.product_name = 'Polk Audio - 50 W Woofer - Black'

CREATE VIEW buyed_both AS
SELECT *, other_product = 'YES'
FROM customer_HDD_product
WHERE customer_id IN (
SELECT customer_id
FROM customer_polk_product)

CREATE VIEW buyed_one AS
SELECT *, other_product = 'NO'
FROM customer_HDD_product
WHERE customer_id NOT IN (
SELECT customer_id
FROM customer_polk_product)

(
 SELECT 
  * 
   FROM buyed_both
)
UNION
(
 SELECT 
  * 
   FROM buyed_one
)
ORDER BY customer_id ASC

Question 2:

CREATE TABLE ACTÝONS(
                    [Visitor_ID] INT PRIMARY KEY  NOT NULL,
                    [Adv_Type] VARCHAR(10),
                    [Action ] VARCHAR(10)
                    );


INSERT INTO ACTÝONS(Visitor_ID, Adv_Type, [Action ]) 
VALUES 
(1,'A','Left'),
(2,'A','Order'),
(3,'B','Left'),
(4,'A','Order'),
(5,'A','Review'),
(6,'A','Left'),
(7,'B','Left'),
(8,'B','Order'),
(9,'B','Review'),
(10,'A','Review');
----Return all table ------
select*
FROM ACTÝONS

----return count of total Actions for each advertisement--- 
SELECT Adv_Type,COUNT(Visitor_ID) Total_cnt
FROM ACTÝONS
GROUP by Adv_Type

--create new table from above query---
SELECT Adv_Type,COUNT(Visitor_ID) Total_cnt
INTO total_table
FROM ACTÝONS 
GROUP by Adv_Type

----return order count for each advertisement-----
SELECT Adv_Type,COUNT(Visitor_ID) Order_cnt 
FROM ACTÝONS
WHERE [Action ]= 'order'
GROUP BY Adv_Type

----Create new table above query---
select Adv_Type, COUNT(Visitor_ID) Order_cnt 
INTO total_order
FROM ACTÝONS
WHERE [Action ]= 'order'
GROUP BY Adv_Type

----- The result is query to return the conversion rate for each Advertisement type.---
SELECT a.Adv_Type, ROUND(cast(b.Order_cnt as float) / a.Total_cnt, 2,1) Conversion_Rate
FROM total_table a, total_order b
WHERE a.Adv_Type = b.Adv_Type
