
ALTER TABLE dbo.market_fact DROP COLUMN column1

ALTER TABLE dbo.cust_dimen DROP COLUMN column1

ALTER TABLE dbo.orders_dimen DROP COLUMN column1

ALTER TABLE dbo.shipping_dimen DROP COLUMN column1

ALTER TABLE dbo.prod_dimen DROP COLUMN column1

ALTER TABLE dbo.market_fact ADD CONSTRAINT FK1 FOREIGN KEY (Ord_ID) REFERENCES dbo.orders_dimen

ALTER TABLE dbo.market_fact ADD CONSTRAINT FK2 FOREIGN KEY (Prod_ID) REFERENCES dbo.prod_dimen

ALTER TABLE dbo.market_fact ADD CONSTRAINT FK3 FOREIGN KEY (Ship_ID) REFERENCES dbo.shipping_dimen

ALTER TABLE dbo.market_fact ADD CONSTRAINT FK4 FOREIGN KEY (Cust_ID) REFERENCES dbo.cust_dimen

--1. Using the columns of “market_fact”, “cust_dimen”, “orders_dimen”, 
--“prod_dimen”, “shipping_dimen”, Create a new table, named as
--“combined_table”.


SELECT A.Sales, A.Discount, A.Order_Quantity, A.Product_Base_Margin, B.*, C.*, D.*, E.*
INTO combined_table
FROM dbo.market_fact A
FULL OUTER JOIN  dbo.cust_dimen B ON A.Cust_ID = B.Cust_ID
FULL OUTER JOIN  dbo.orders_dimen C ON A.Ord_ID = C.Ord_ID
FULL OUTER JOIN  dbo.prod_dimen D ON A.Prod_ID = D.Prod_ID
FULL OUTER JOIN dbo.shipping_dimen E ON A.Ship_ID = E.Ship_ID

SELECT *
FROM dbo.combined_table


--2. Find the top 3 customers who have the maximum count of orders.

SELECT TOP 3 Cust_ID, COUNT(DISTINCT Ord_ID) as cnt
FROM combined_table
GROUP BY Cust_ID
ORDER BY 2 DESC


--3. Create a new column at combined_table as DaysTakenForShipping that 
--contains the date difference of Order_Date and Ship_Date.
ALTER TABLE combined_table ADD DaysTakenForShipping INT
UPDATE combined_table 
SET DaysTakenForShipping = DATEDIFF(DAY, Order_Date, Ship_Date)

SELECT DaysTakenForShipping
FROM combined_table

--4. Find the customer whose order took the maximum time to get shipping.

SELECT TOP 1 Order_Date, Ship_Date, MAX(DATEDIFF(DAY, Order_Date, Ship_Date)) OVER(PARTITION BY Ord_ID, Cust_ID) AS DaysTakenForShipping
FROM combined_table
ORDER BY DaysTakenForShipping DESC


--5. Count the total number of unique customers in January and how many of them 
--came back every month over the entire year in 2011

SELECT MONTH(Order_Date) the_month_of_2011, COUNT(DISTINCT Cust_ID) cnt_cust
FROM combined_table
WHERE Cust_ID IN (SELECT DISTINCT Cust_Id
				  FROM combined_table
				  WHERE Order_Date BETWEEN '2011-01-01' AND '2011-01-31') 
				--WHERE YEAR(Order_Date) = 2011 AND MONTH(Order_Date) = 1
AND YEAR(Order_Date) = 2011
GROUP BY MONTH(Order_Date)

			   
--6. Write a query to return for each user the time elapsed between the first 
--purchasing and the third purchasing, in ascending order by Customer ID.

WITH T1 AS
(
SELECT Cust_Id, Order_Date, DENSE_RANK() OVER(PARTITION BY Cust_ID ORDER BY Order_Date, Cust_ID) AS denserank, 
	   FIRST_VALUE(Order_Date) OVER(PARTITION BY Cust_ID ORDER BY Order_Date, Cust_ID) AS first_order
FROM combined_table
)

SELECT DISTINCT Cust_ID, DATEDIFF(DAY, first_order, Order_Date) diff_order_date
FROM T1
WHERE denserank = 3
ORDER BY 1 DESC


--SELECT DISTINCT Cust_Id, Order_Date, denserank, first_order
--FROM T1
--WHERE denserank = 3



--7. Write a query that returns customers who purchased both product 11 and 
--product 14, as well as the ratio of these products to the total number of 
--products purchased by the customer.
WITH T1 AS
(

SELECT Cust_ID, COUNT(Prod_Id) AS All_product,
				SUM(CASE WHEN Prod_ID = 11 THEN 1 ELSE 0 END) AS Prod_11, 
				SUM(CASE WHEN Prod_ID = 14 THEN 1 ELSE 0 END) AS Prod_14	
FROM combined_table
WHERE Cust_ID IN
(
		SELECT Cust_ID
		FROM combined_table
		WHERE Prod_ID = 11
		INTERSECT
		SELECT Cust_ID
		FROM combined_table
		WHERE Prod_ID = 14
)
GROUP BY Cust_ID
)

SELECT Cust_ID,
ROUND(CAST (Prod_11 AS FLOAT) / CAST (All_product AS FLOAT), 2) AS Prod_11_Rate, ROUND(CAST (Prod_14 AS FLOAT) / CAST (All_product AS FLOAT), 2) AS Prod_14_Rate
FROM T1


--1. Create a “view” that keeps visit logs of customers on a monthly basis. (For 
--each log, three field is kept: Cust_id, Year, Month)

CREATE VIEW visit_logs_of_customers_monthly AS 

	SELECT Cust_ID, YEAR(order_date) years, MONTH(order_date) months
	FROM combined_table

SELECT *
FROM visit_logs_of_customers_monthly
GROUP BY Cust_ID, years, months 
ORDER BY 1,2,3 ASC

--2. Create a “view” that keeps the number of monthly visits by users. (Show 
--separately all months from the beginning business)

CREATE VIEW  monthly_visits_by_users AS

	SELECT Cust_ID, COUNT(Ord_Id) AS monthly_count, DATEPART(month, order_date) months, DATEPART(year, order_date) years
	FROM combined_table
	GROUP BY Cust_ID, DATEPART(month, order_date), DATEPART(year, Order_Date)


--3. For each visit of customers, create the next month of the visit as a separate 
--column.

---CREATE VIEW next_monthly_visits_by_users

SELECT Cust_ID, Order_Date, months, years, LEAD(Order_Date) OVER(PARTITION BY Cust_ID ORDER BY Order_Date) next_order_date
FROM monthly_visits_by_users


--4. Calculate the monthly time gap between two consecutive visits by each 
--customer.

CREATE VIEW customer_order_table AS

WITH T1 AS
(
SELECT DISTINCT Cust_ID, order_date, DATEPART(month, order_date) months, DATEPART(year, order_date) years,
		LEAD(Order_Date) OVER(PARTITION BY Cust_ID ORDER BY order_date) as next_order
FROM combined_table
)

SELECT *, DATEDIFF(month, order_date, next_order) date_of_difference
FROM T1




--5. Categorise customers using average time gaps. Choose the most fitted
--labeling model for you.
--For example: 
-- Labeled as churn if the customer hasn't made another purchase in the 
--months since they made their first purchase.
-- Labeled as regular if the customer has made a purchase every month.
--Etc.

WITH T2 AS
(
SELECT Cust_ID, AVG(date_of_difference) average_gap
FROM customer_order_table
GROUP BY Cust_ID
)

SELECT Cust_Id, 
			CASE WHEN average_gap IS NULL THEN 'churn'
			WHEN average_gap < 3 THEN 'regular'
			ELSE 'others'
			END AS labeled_customers
FROM T2



--There are many different variations in the calculation of Retention Rate. But we will 
--try to calculate the month-wise retention rate in this project.
--So, we will be interested in how many of the customers in the previous month could 
--be retained in the next month.
--Proceed step by step by creating “views”. You can use the view you got at the end of 
--the Customer Segmentation section as a source.

--1. Find the number of customers retained month-wise. (You can use time gaps)

WITH T3 AS
(

SELECT Cust_Id, DATEPART(month, order_date) months, DATEPART(year, order_date) years, 
	   SUM(CASE WHEN date_of_difference < 3 THEN 1 ELSE 0 END) total_customer_monthly
FROM customer_order_table
WHERE months IS NOT NULL
GROUP BY Cust_ID, DATEPART(month, order_date), DATEPART(year, order_date)
ORDER BY years

)



--2. Calculate the month-wise retention rate.

CREATE VIEW ONE AS 
SELECT Cust_Id, DATEPART(month, order_date) months, DATEPART(year, order_date) years, 
	   SUM(CASE WHEN date_of_difference < 3 THEN 1 ELSE 0 END) total_customer_monthly
FROM customer_order_table
WHERE months IS NOT NULL
GROUP BY Cust_ID, DATEPART(month, order_date), DATEPART(year, order_date)

CREATE VIEW TWO AS
SELECT COUNT(Cust_ID) total_customer, MONTH(order_date) months, YEAR(order_date) years
FROM combined_table
WHERE  MONTH(order_date) IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)


SELECT ONE.months, ONE.years, ROUND(CAST(total_customer_monthly AS FLOAT) / CAST(total_customer AS FLOAT), 2) month_wise_retention_rate
FROM ONE, TWO

