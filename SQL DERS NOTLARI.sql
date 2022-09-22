--- SQL Server Built-in Functions


-- Date

CREATE TABLE t_date_time (
	A_time time,
	A_date date,
	A_smalldatetime smalldatetime,
	A_datetime datetime,
	A_datetime2 datetime2,
	A_datetimeoffset datetimeoffset
	)

SELECT * FROM t_date_time

SELECT GETDATE() AS TIME

INSERT t_date_time
VALUES (GETDATE(), GETDATE(), GETDATE(), GETDATE(), GETDATE(), GETDATE())

SELECT * FROM t_date_time

INSERT t_date_time
VALUES ('12:20:00', '2022-09-17','2022-09-17', '2022-09-17', '2022-09-17', '2022-09-17')


SELECT * FROM t_date_time


------------------------------///////////////////

---

SELECT DATENAME (DW, GETDATE())

SELECT DATEPART (SECOND, GETDATE())

SELECT DATEPART (MONTH, GETDATE())

SELECT DAY (GETDATE())

SELECT MONTH (GETDATE())

SELECT YEAR (GETDATE())


------------------------------///////////////////

---
SELECT DATEDIFF(DAY, '2021-12-21', GETDATE())

SELECT DATEDIFF(SECOND, '2021-12-21', GETDATE())


--- SAMPLERETAIL DATABASE DEKÝ ORDER TABLOSUNDAKÝ ORDER DATE ÝLE SHIP DATE ARASINDAKÝ GÜN FARKINI BULUNUZ.

SELECT *, DATEDIFF(DAY, order_date, shipped_date) shipped_day
FROM sale.orders

--- DATEADD
--- EOMONTH FONKSÝYONLARININ KULLANIMI

SELECT DATEADD(DAY, 3, '2022-09-17') ---17 EYLÜLDEN 3 GÜN SONRAKÝ TARÝHÝ VERECEK

SELECT DATEADD(DAY, -3, '2022-09-17') ---17 EYLÜLDEN 3 GÜN ÖNCEKÝ TARÝHÝ VERECEK

SELECT DATEADD(YEAR, 3, '2022-09-17') ---17 EYLÜLDEN 3 YIL SONRAKÝ TARÝHÝ VERECEK

SELECT EOMONTH(GETDATE(), 2) --- DEFAULT OLARAK HÝÇBÝR TARÝH YAZMASAK BÝLE GETDATE() ÝLE 
							 --- BU GÜNE AÝT OLAN AYIN SON GÜNÜ HANGÝ TARÝH ÝSE ONU DÖNDÜRECEKTÝR. 
							 --- YANINA YAZILAN 2 ÝLE 2 AY SONRAKÝ AYIN SON GÜNÜNÜ GETÝRDÝ.

SELECT ISDATE('2022-09-17')

SELECT ISDATE('20220917')

SELECT ISDATE('17-09-2022') ----HANGÝ ÜLKEDE HANGÝ  FORMATTA TARÝH ÞEKLÝ KULLANILIYORSA O FORMATA ÇEVÝRMEYE YARIYOR.


-----QUESTION: Sipariþ tarihinden iki gün sonra kargolanan sipariþleri döndüren bir sorgu yazýn.

SELECT TOP 10 *, DATEDIFF(DAY, order_date, shipped_date) AS day_diff
FROM sale.orders

SELECT TOP 10 *, DATEDIFF(DAY, order_date, shipped_date) AS day_diff
FROM sale.orders
WHERE DATEDIFF(DAY, order_date, shipped_date) > 2


--------STRING FUNCTIONS
--LEN, CHARINDEX, PATINDEX

SELECT LEN('Clarusway')  --- Toplam karakter sayýsýný döndürüyor.
SELECT LEN('Clarusway ') --- Boþluk sonda olunca karakter sayýsýna eklenmiyor.
SELECT LEN(' Clarusway')  --- Boþluðu baþa koyunca karakter sayýsýna dahil oluyor.

---

SELECT CHARINDEX('c', 'Clarusway') --- c kaçýncý karakter

SELECT CHARINDEX('a', 'Clarusway') --- ilk a harfi kaçýncý karakterde

SELECT CHARINDEX('a', 'Clarusway', 4) --- 4. karakterden baþlayarak a karakterini aramaya baþla bulunca kaçýncý karakter olduðunu döndür.

---
SELECT PATINDEX('sw', 'Clarusway')

SELECT PATINDEX('%sw%', 'Clarusway')

SELECT PATINDEX('%r_sw%', 'Clarusway')


SELECT PATINDEX('r_sw%', 'Clarusway') --- Baþýna % iþareti koymazsak aradýðýmýz patternin ilk harfi r ile baþlýyor diye düþündü. Bu sebeple sonuç 0
									  --- Yani böyle bir pattern yok.


SELECT PATINDEX('___r_sw%', 'Clarusway')


--LEFT, RIGHT, SUBSTRING

SELECT LEFT('Clarusway', 3)

SELECT RIGHT('Clarusway', 3) 

SELECT SUBSTRING('Clarusway', 3,2) --- 3. KARAKTERDEN BAÞLA 2 KARAKTER GETÝR
SELECT SUBSTRING('Clarusway', 0,2) --- 0. KARAKTERDEN BAÞLA 2 KARAKTER DÖNDÜR. 0. DA KARAKTER YOK BU 1, BÝRÝNCÝ DE C VAR BÖYLECE 2 KARAKTER GETÝRDÝ.
SELECT SUBSTRING('Clarusway', -1,2) --- -1 DE YOK 0 DA YOK. BU YÜZDEN HERHANGÝ BÝR ÞEY DÖNDÜRMEDÝ


------------------------------///////////////////
--- LOWER, UPPER, STRING_SPLIT
SELECT LOWER('CLARUSWAY'), UPPER('clarusway')

SELECT *
FROM STRING_SPLIT('Ezgi,Senem,Mustafa', ',')

SELECT value
FROM STRING_SPLIT('Ezgi/Senem/Mustafa', '/')

---clarusway kelimesinin sadece ilk harfini büyütün.

SELECT LEFT ('clarusway', 1)
SELECT SUBSTRING('clarusway', 2, LEN('clarusway'))
SELECT UPPER(LEFT('clarusway', 1)) + LOWER(SUBSTRING('clarusway', 2, LEN('clarusway')))

SELECT *, UPPER(LEFT(email, 1)) + LOWER(SUBSTRING(email, 2, LEN(email)))
FROM sale.store


--- TRIM, LTRIM, RTRIM

SELECT TRIM('   CLARUSWAY    ')

SELECT TRIM('?' FROM '?    CLARUSWAY   ?')  --- sadece soru iþaretini kýrptý

SELECT TRIM('?, ' FROM '?    CLARUSWAY   ?')  --- boþluklarda gitti

SELECT LTRIM('    CLARUSWAY    ')  --- soldaki boþluk gitti

SELECT RTRIM('    CLARUSWAY    ')  --- saðdaki boþluk gitti


---REPLACE, STR

SELECT REPLACE('CLARUSWAY', 'C', 'A')

SELECT REPLACE('CLAR USWAY', ' ', '')

SELECT STR(1234.25, 7, 2) --7 toplam kaç krakter olduðu, 2 noktadan sonra kaç karakter geleceðini ifade ediyor.

SELECT STR(1234.25, 7, 1)

---CAST, CONVERT

SELECT CAST(123.56 AS VARCHAR(6))

SELECT CAST(123.56 AS INT)

SELECT CAST(123.56 AS NUMERIC(4,1))


SELECT CONVERT(NUMERIC(4, 1), 123.56)

SELECT GETDATE()

SELECT CONVERT(VARCHAR, GETDATE(), 6) ---Buradaki 6 rakamý Datetime type larýndan birinin numarasýdýr. Biz burada GETDATE() ile bugünün tarihini 6. datetime tipinde getir dedik.

SELECT CONVERT(date, '19 Sep 22', 6)

---ROUND, ISNULL

SELECT ROUND(123.56, 1) --Virgülden sonraki rakamý yuvarla. 56 yý 60 a yuvarlar.

SELECT ROUND(123.54,1) -- 54 ü 50 ye yuvarlar.

SELECT ROUND(123.54, 1, 0) --Yuvarladýktan sonraki rakamlarý sil

SELECT ROUND(123.56, 1, 0)

SELECT ISNULL(null, 0)
SELECT ISNULL(1, 0)

SELECT ISNULL('notnull', 0)

SELECT phone, ISNULL(phone, 0)
FROM sale.customer

----YUVARLAMA FONKSÝYONLARI:--------------------------------------------------------------------------------------------------------------------------------------------
ROUND = sayýyý istenilen haneye göre yuvarlama.
(Positive number rounds on the right side of the decimal point! Negative number rounds on the left side of the decimal point!)
FLOOR = sayýyý aþaðýya yuvarlama.
CEILING = sayýyý yukarýya yuvarlama.
SELECT ROUND(12.4512,2)		 --sayýyý virgülden sonra 2 haneye yuvarlar.
SELECT FLOOR(12.4512) AS deger -- sayýnýn virgülden sonraki deðerini atarak 12 olarak yuvarlar.
SELECT CEILING(12.4512) AS deger -- sayýnýn virgülden sonraki hanesini yukarý yuvarlar ve 13 elde edilir.
:clarusway: Desimal (Ondalýk) veri türü ve çeþitli uzunluk parametreleriyle yuvarlama:
DECLARE @value decimal(10,2)  -- deðiþken deklare ettik.
SET @value = 11.05 -- deðiþkene deðer atadýk.
SELECT ROUND(@value, 1)  -- 11.10
SELECT ROUND(@value, -1) -- 10.00 
SELECT ROUND(@value, 2)  -- 11.05 
SELECT ROUND(@value, -2) -- 0.00 
SELECT ROUND(@value, 3)  -- 11.05
SELECT ROUND(@value, -3) -- 0.00
SELECT CEILING(@value)   -- 12 
SELECT FLOOR(@value)     -- 11 
:clarusway: Numeric (sayýsal) veri türü ile yuvarlama :
DECLARE @value numeric(10,10)
SET @value = .5432167890
SELECT ROUND(@value, 1)  -- 0.5000000000 
SELECT ROUND(@value, 2)  -- 0.5400000000
SELECT ROUND(@value, 3)  -- 0.5430000000
SELECT ROUND(@value, 4)  -- 0.5432000000
SELECT ROUND(@value, 5)  -- 0.5432200000
SELECT ROUND(@value, 6)  -- 0.5432170000
SELECT ROUND(@value, 7)  -- 0.5432168000
SELECT ROUND(@value, 8)  -- 0.5432167900
SELECT ROUND(@value, 9)  -- 0.5432167890
SELECT ROUND(@value, 10) -- 0.5432167890
SELECT CEILING(@value)   -- 1
SELECT FLOOR(@value)     -- 0
:clarusway: Float veri türü ile yuvarlama fonksiyonlarý.
DECLARE @value float(10)
SET @value = .1234567890
SELECT ROUND(@value, 1)  -- 0.1
SELECT ROUND(@value, 2)  -- 0.12
SELECT ROUND(@value, 3)  -- 0.123
SELECT ROUND(@value, 4)  -- 0.1235
SELECT ROUND(@value, 5)  -- 0.12346
SELECT ROUND(@value, 6)  -- 0.123457
SELECT ROUND(@value, 7)  -- 0.1234568
SELECT ROUND(@value, 8)  -- 0.12345679
SELECT ROUND(@value, 9)  -- 0.123456791
SELECT ROUND(@value, 10) -- 0.123456791
SELECT CEILING(@value)   -- 1
SELECT FLOOR(@value)     -- 0
:clarusway: Pozitif bir tamsayý yuvarlama (1 keskinlik deðeri için):
DECLARE @value int
SET @value = 6
SELECT ROUND(@value, 1)  -- 6 - No rounding with no digits right of the decimal point
SELECT CEILING(@value)   -- 6 - Smallest integer value
SELECT FLOOR(@value)     -- 6 - Largest integer value 
:clarusway: Kesinlik deðeri olarak bir negatif sayýnýn etkilerini de görelim:
DECLARE @value int
SET @value = 6
SELECT ROUND(@value, -1) -- 10 - Rounding up with digits on the left of the decimal point
SELECT ROUND(@value, 2)  -- 6  - No rounding with no digits right of the decimal point 
SELECT ROUND(@value, -2) -- 0  - Insufficient number of digits
SELECT ROUND(@value, 3)  -- 6  - No rounding with no digits right of the decimal point
SELECT ROUND(@value, -3) -- 0  - Insufficient number of digits
   Bu örnekteki rakamlarý geniþletelim ve ROUND fonksiyonu kullanarak etkilerini görelim:
SELECT ROUND(444,  1) -- 444  - No rounding with no digits right of the decimal point
SELECT ROUND(444, -1) -- 440  - Rounding down
SELECT ROUND(444,  2) -- 444  - No rounding with no digits right of the decimal point
SELECT ROUND(444, -2) -- 400  - Rounding down
SELECT ROUND(444,  3) -- 444  - No rounding with no digits right of the decimal point
SELECT ROUND(444, -3) -- 0    - Insufficient number of digits
SELECT ROUND(444,  4) -- 444  - No rounding with no digits right of the decimal point
SELECT ROUND(444, -4) -- 0    - Insufficient number of digits
:clarusway: Negatif bir tamsayý yuvarlayalým ve etkilerini görelim:
SELECT ROUND(-444, -1) -- -440  - Rounding down
SELECT ROUND(-444, -2) -- -400  - Rounding down
SELECT ROUND(-555, -1) -- -560  - Rounding up
SELECT ROUND(-555, -2) -- -600  - Rounding up
SELECT ROUND(-666, -1) -- -670  - Rounding up
SELECT ROUND(-666, -2) -- -700  - Rounding up
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---COALESCE, NULLIF, ISNUMERIC

SELECT COALESCE(NULL, NULL, 'ALÝ', NULL) ---NULL olmayan ilk deðeri getiriyor

SELECT NULLIF(0, 0) --iki deðer birbirine eþitse Null deðer döndürecektir.

SELECT phone, ISNULL(PHONE, 0), nullýf (ISNULL(phone, 0), '0')
FROM sale.customer


SELECT ISNUMERIC(1)

SELECT ISNUMERIC('1')

SELECT ISNUMERIC('1,5')

SELECT ISNUMERIC('1.5')

SELECT ISNUMERIC('1ALÝ')


---- How many customers have yahoo mail? SampleRetail Database ini kullanýn.
SELECT * FROM sale.customer
WHERE email
LIKE '%@yahoo.com'

SELECT count(*) as cnt_cust
FROM sale.cutomer
WHERE email
LIKE '%yahoo%'

SELECT COUNT (*)
FROM sale.customer
WHERE PATINDEX('%yahoo%', email) > 0


---Write a query that returns the characters before the '@' character in the email column.

SELECT email, LEFT(email, CHARINDEX('@', email) -1) AS chars
FROM sale.customer

---Add a new column to the customers table that contains the customer's contact information. If the phone is not null, the phone information will be printed, if not, 
---the email information will be printed

SELECT phone, email, COALESCE(phone, email, 'no contact') AS contact
FROM sale.customer
ORDER BY 3  ---Yazdýðýmýz kodun 3. sütununa göre sýrala demek.


SELECT phone,email, ISNULL(phone, email) AS contact
FROM sale.customer




--------------------------JOINS---------------------------------


SELECT *
FROM product.product

SELECT *
FROM product.category

--Yukarýdaki iki tabloyu ortak sütuna göre join yapýyoruz

SELECT product.product.product_name, product.product.category_id,  product.category.category_id,  product.category.category_name
FROM product.product
	 INNER JOIN product.category
	 ON product.product.category_id = product.category.category_id
ORDER BY product.product.category_id

---Her iki tabloda da mevcut olan kategorileri getirdi.
---Bu kodlarý biraz kýsaltarak yazalým. Sadece JOIN, INNER JOIN demektir.
SELECT A.product_name, A.category_id,  B.category_id,  B.category_name
FROM product.product as A
	 JOIN product.category as B
	 ON A.category_id = B.category_id
ORDER BY A.category_id

SELECT A.product_name, A.category_id,  B.category_id,  B.category_name
FROM product.product A , product.category B
WHERE A.category_id = B.category_id
ORDER BY A.category_id

----List employees of stores with their store information. Select employee name, surname, store names.

SELECT first_name, last_name, store_name
FROM sale.staff
INNER JOIN sale.store
ON sale.staff.store_id = sale.store.store_id
ORDER BY sale.staff.store_id

----Wirte a query that returns streets. The third character of the streets is numerical.
----Street sütununda soldan üçüncü karakterin rakam olduðu kayýtlarý getiriniz.

SELECT street
FROM sale.customer
WHERE ISNUMERIC(SUBSTRING(street, 3,1)) = 1


SELECT	street, SUBSTRING(street, 3,1) third_char, ISNUMERIC (SUBSTRING(street, 3,1)) isnumerical
FROM	SALE.customer

SELECT	street, SUBSTRING(street, 3,1) third_char, ISNUMERIC (SUBSTRING(street, 3,1)) isnumerical
FROM	SALE.customer
WHERE	ISNUMERIC (SUBSTRING(street, 3,1)) = 1


------LEFT JOIN--------
--Write a query that returns products that have never been ordered
--Select pduct ID, product name, order ID

SELECT *
FROM product.product

SELECT *
FROM sale.orders

SELECT *
FROM sale.order_item

SELECT A.product_id, B.order_id, B.product_id
FROM   product.product A
	   LEFT JOIN
	   sale.order_item B
	   ON A.product_id = B.product_id
WHERE order_id IS NULL
ORDER BY B.product_id

---Example: report the stock status of the products that product id greater than 310 in the stores.
---Expected columns: product_id, product_name, store_id, product_id, quantity.

SELECT COUNT(DISTINCT product_id)
FROM product.stock
WHERE product_id>310

SELECT COUNT(DISTINCT product_id)
FROM product.product
WHERE product_id>310

SELECT A.product_id, B.product_id, B.store_id, B.quantity ---B* da diyebiliriz. Tüm sütunlarýn gelmesini istiyoruz çünkü.
FROM product.product A
	 LEFT JOIN
	 product.stock B
	 ON A.product_id = B.product_id
WHERE B.product_id > 310


------RIGHT JOIN--------

SELECT A.product_id, B* ---B* da diyebiliriz. Tüm sütunlarýn gelmesini istiyoruz çünkü.
FROM product.stock A
	 RIGHT JOIN
	 product.product A
	 ON A.product_id = B.product_id
WHERE A.product_id > 310

---Example: Report the order information made by all staffs.
---Expected columns: staff_id, first_name, last_name, all information about orders


SELECT *
FROM sale.staff

SELECT COUNT (DISTINCT staff_id)
FROM sale.orders

SELECT A.staff_id, B.order_id
FROM   sale.staff A
	   LEFT JOIN
	   sale.orders B
	   ON A.staff_id = B.staff_id
ORDER BY 2							--Default oalrak Ascending sýralama yapýyor.

SELECT COUNT (DISTINCT product_id)
FROM product.product


SELECT COUNT (DISTINCT product_id)
FROM product.stock


SELECT COUNT (DISTINCT product_id)
FROM sale.order_item

SELECT DISTINCT A.product_id, A.product_name, B.*, C.order_id
FROM product.product A
	FULL OUTER JOIN
	product.stock B
	ON A.product_id = B.product_id
	FULL OUTER JOIN
	sale.order_item C
	ON A.product_id = C.product_id
ORDER BY B.product_id, C.order_id

-----------CROSS JOIN-----------

/*Example: In the stocks table, there are not all products held on the product table and you
want to insert these products into the stock table.
You have to insert all these products for every three stores with “0” quantity.
Write a query to prepare this data.

1 443
2 443
3 443
1 444
2 444
3 444

*/

SELECT DISTINCT A.store_id, B.product_id, 0 as quantity
FROM   product.stock A
	   CROSS JOIN
	   product.product B
WHERE  B.product_id NOT IN (SELECT product_id FROM product.stock) 

SELECT COUNT(DISTINCT product_id)
FROM product.stock


-------SELF JOIN-----------
---Example: Write a query that returns the staffs with their managers.
---Expected columns: staff first name, staff last name, manager name

SELECT A.*, B.staff_id, B.first_name, B.last_name
FROM   sale.staff A, sale.staff B
WHERE A.manager_id = B.staff_id

SELECT A.*, B.staff_id, B.first_name, B.last_name
FROM   sale.staff A
	   LEFT JOIN
	   sale.staff B
	   ON A.manager_id = B.staff_id

/*Hem staff'ler hem manager'ler ayný sales.staffs tablosu içindeler.
Bu tablo kendi kendine iliþki içerisinde. bu tabloda iki tane sütun birbiri ile ayný bilgiyi taþýyor.
Burda staff_id ile manager_id birbiri ile iliþki içinde. her staff'in bir manageri var ve bu manager ayný zamanda bir staff..
Mesela staff_id si 2 olan Charles'ýn manager_id'si 1,  yani staff_id'si 1 olan kiþi Charles'ýn manageri demektir.*/
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----//////////VIEWS/////////----------------------------


CREATE VIEW v_sample_summary AS
SELECT A.customer_id, COUNT(B.order_id) cnt_order
FROM  sale.customer A, sale.orders B
WHERE A.customer_id = B.customer_id
AND   A.city = 'Charleston'
GROUP BY A.customer_id

SELECT *
FROM v_sample_summary


SELECT *
INTO #v_sample_summary_2 ----Geçici olarak bir tablo oluþturmak için # kullanabiliyoruz.
FROM v_sample_summary

---------------/////////////////-----------------------------
-----------------HAVING----------------------------

/*FROM, WHERE, GROUP BY, HAVING, SELECT, ORDER BEY:SQL SERVER IN KODU ÇALIÞTIRIRKEN BAKTIÐI SIRALAMA
FROM : hangi tablolara gitmem gerekiyor?
WHERE : o tablolardan hangi verileri çekmem gerekiyor?
GROUP BY : bu bilgileri ne þekilde gruplayayým?
SELECT : neleri getireyim ve hangi aggragate iþlemine tabi tutayým.
HAVING : yukardaki sorgu sonucu çýkan tablo üzerinden nasýl bir filtreleme yapayým (mesela list_price>1000)
Gruplama yaptýðýmýz ayný sorgu içinde bir filtreleme yapmak istiyorsak HAVING kullanacaðýz
HAVING kullanmadan; HAVING'ten yukarýsýný alýp baþka bir SELECT sorgusunda WHERE þartý ile de bu filtrelemeyi yapabiliriz.
ORDER BY : Çýkan sonucu hangi sýralama ile getireyim? (edited) 
Soruda average veya toplam gibi aggregate iþlemi gerektirecek bir istek varsa hemen "GROUP BY" kullanmam gerektiðini anlamalýyým.
Bir sayma iþlemi, bir gruplandýrma bir aggregate iþlemi yapýyorsan isimle deðil ID ile yap. ID'ler her zaman birer defa geçer (Unique’tir), isimler tekrar edebilir (ör: bir kaç product'a ayný isim verilmiþ olabilir)
SELECT satýrýnda yazdýðýn sütunlarýn hepsi GROUP BY'da olmasý gerekiyor!
HAVING ile sadece aggregate ettiðimiz sütuna koþul verebiliriz!
HAVING’de kullandýðýn sütun, aggregate te kullandýðýn sütunla ayný olmalý.*/

---Example: Write a query that check if any product id is repeated in more than one row in the product table.
SELECT product_id, COUNT(*) AS cnt_prod_id
FROM   product.product
GROUP BY
	   product_id
HAVING 
	COUNT(*)>1

SELECT COUNT(product.product_id) AS cnt_prod_id --SELECT COUNT(*) ayný sonucu verir.
FROM product.product


SELECT product_name, COUNT(*) AS cnt_prod_name
FROM product.product
GROUP BY
	product_name
HAVING 
	COUNT(*) > 1

--Example: Write a query that returns category ids with conditions max list price above 4000 or a min list price below 500.

SELECT category_id, MAX(list_price) AS  max_price, MIN(list_price) AS min_price
FROM product.product
GROUP BY category_id
HAVING MAX(list_price) > 4000 OR MIN(list_price) < 500

/*SELECT category_id, MIN(list_price) AS min_price, MAX(list_price) AS max_price 
-- Grupladýðýmýz þey "category_id" olduðu için SELECT'te onu getiriyoruz. Group By'da Select'te yazdýðýn sütunlar muhakkak olmalý.
FROM product.product
-- ana tablo içinde herhangi bir kýsýtlamam var mý yani WHERE iþlemi var mý? yok. O zaman Group By ile devam ediyorum.
-- Ana tablo içinde herhangi bir kýsýtlama yapmayacaksan WHERE satýrý kullanmayacaksýn demektir.
GROUP BY
          category_id
HAVING
          MIN(list_price) < 500 
	OR 
	MAX(list_price) > 4000;
--GROUP BY ve aggregate neticesinde çýkan tabloyu yukardaki conditionlara göre filtreleyip getirdik. HAVING’in yaptýðý iþ budur.
-- Dikkat! soruyu iyi okumalýsýn. soruda “veya” dediði için OR kullandýk.*/

--Example: Find the average product prices of the brands. Display brand name and average prices in descending order.

SELECT B.brand_name, AVG(A.list_price) AS avg_list_price
FROM product.product A
LEFT JOIN product.brand B
ON A.brand_id = B.brand_id
GROUP BY B.brand_name
ORDER BY 2 DESC

SELECT B.brand_name, AVG(list_price) AVG_PRC_BY_BRND
FROM product.product A, product.brand B
WHERE A.brand_id = B.brand_id
GROUP BY
	B.brand_name
ORDER BY 
	AVG_PRC_BY_BRND DESC


--Example: Write a query that returns the list of each order id and that order's total net amount(please take into consideration of discounts and quantities)

SELECT order_id, SUM(quantity*list_price*(1-discount)) AS net_amount
FROM sale.order_item
GROUP BY order_id

--Example: Write a query that returns monthly order counts of the States. (Her bir State in aylýk sipariþ sayýsý nedir?)

SELECT [state], 
	    YEAR(B.order_date) AS ORD_YEAR, 
		MONTH(B.order_date) AS ORD_MONTH,
		COUNT(*) CNT_ORDER
FROM sale.customer A, sale.orders B
WHERE A.customer_id = B.customer_id
GROUP BY [state], YEAR(B.order_date), MONTH(B.order_date)
ORDER BY 
	  [state], ORD_YEAR, ORD_MONTH



---------------//////////////GROUPING SETS///////////////////----------------------------
---Ayný sorguda hem markalara ait net amount bilgisini,
---Kategorilere ait net amount bilgisini
---Tüm veriye ait net amount bilgisini
---Marka ve kategori kýrýlýmýnda net amount bilgisini getiriniz.

SELECT	C.brand_name as Brand, D.category_name AS Category, B.model_year AS Model_Year,
		ROUND (SUM (A.quantity * A.list_price * (1 - A.discount)), 0) total_sales_price
INTO	sale.sales_summary
FROM	sale.order_item A, product.product B, product.brand C, product.category D
WHERE	A.product_id = B.product_id
AND		B.brand_id = C.brand_id
AND		B.category_id = D.category_id
GROUP BY
		C.brand_name, D.category_name, B.model_year


SELECT Brand, Category, SUM(total_sales_price) AS net_amount
FROM   sale.sales_summary
GROUP BY 
	   GROUPING SETS (
					   (Brand),
					   (Category),
					   (),
					   (Brand, Category)
					 )
ORDER BY 1

-----------/////////////ROLLUP////////////////////------------------------
SELECT	Brand, Category, SUM(total_sales_price) net_amount
FROM	sale.sales_summary
GROUP BY
		ROLLUP(Brand, Category)
ORDER BY 2


-----------///////////////CUBE//////////////////////------------------------
SELECT	Brand, Category, SUM(total_sales_price) net_amount
FROM	sale.sales_summary
GROUP BY
		CUBE(Brand, Category)
ORDER BY 2


