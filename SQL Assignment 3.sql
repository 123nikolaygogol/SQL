--ASSIGNMENT 3

--Discount Effects

--Generate a report including product IDs and discount effects on whether the increase in the discount rate positively impacts the number of orders for the products.

--In this assignment, you are expected to generate a solution using SQL with a logical approach. 

--Sample Result:

--Product_id	Discount Effect
--1				Positive
--2				Negative
--3				Negative
--4				Neutral

--herbir üründeki indirim miktarý
--her bir ürünün sipariþ tablosundaki yeri
--indirime göre sipariþ verilen ürünler


WITH T1 AS
(
SELECT DISTINCT B.product_id, B.product_name, C.order_id, C.quantity, C.discount
FROM  product.product B, sale.order_item C
WHERE B.product_id = C.product_id
GROUP BY  B.product_id, B.product_name, C.order_id, C.quantity, C.discount
), T2 AS

(
SELECT DISTINCT product_id, discount, SUM(quantity) OVER(PARTITION BY discount ORDER BY discount) total_product_in_order
FROM T1
)

SELECT DISTINCT T2.product_id,
CASE WHEN LAST_VALUE(T2.total_product_in_order) OVER(PARTITION BY T2.product_id ORDER BY T2.product_id) > FIRST_VALUE(T2.total_product_in_order) OVER(PARTITION BY T2.product_id ORDER BY T2.product_id) THEN 'Positive'
WHEN LAST_VALUE(T2.total_product_in_order) OVER(PARTITION BY T2.product_id ORDER BY T2.product_id) < FIRST_VALUE(T2.total_product_in_order) OVER(PARTITION BY T2.product_id ORDER BY T2.product_id) THEN 'Negative'
WHEN LAST_VALUE(T2.total_product_in_order) OVER(PARTITION BY T2.product_id ORDER BY T2.product_id) = FIRST_VALUE(T2.total_product_in_order) OVER(PARTITION BY T2.product_id ORDER BY T2.product_id) THEN 'Neutral' END AS Discount_Effect
FROM T1, T2
ORDER BY 1