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


--- SAMPLERETAIL DATABASE DEK� ORDER TABLOSUNDAK� ORDER DATE �LE SHIP DATE ARASINDAK� G�N FARKINI BULUNUZ.

SELECT *, DATEDIFF(DAY, order_date, shipped_date) shipped_day
FROM sale.orders

--- DATEADD
--- EOMONTH FONKS�YONLARININ KULLANIMI

SELECT DATEADD(DAY, 3, '2022-09-17') ---17 EYL�LDEN 3 G�N SONRAK� TAR�H� VERECEK

SELECT DATEADD(DAY, -3, '2022-09-17') ---17 EYL�LDEN 3 G�N �NCEK� TAR�H� VERECEK

SELECT DATEADD(YEAR, 3, '2022-09-17') ---17 EYL�LDEN 3 YIL SONRAK� TAR�H� VERECEK

SELECT EOMONTH(GETDATE(), 2) --- DEFAULT OLARAK H��B�R TAR�H YAZMASAK B�LE GETDATE() �LE 
							 --- BU G�NE A�T OLAN AYIN SON G�N� HANG� TAR�H �SE ONU D�ND�RECEKT�R. 
							 --- YANINA YAZILAN 2 �LE 2 AY SONRAK� AYIN SON G�N�N� GET�RD�.

SELECT ISDATE('2022-09-17')

SELECT ISDATE('20220917')

SELECT ISDATE('17-09-2022') ----HANG� �LKEDE HANG�  FORMATTA TAR�H �EKL� KULLANILIYORSA O FORMATA �EV�RMEYE YARIYOR.


-----QUESTION: Sipari� tarihinden iki g�n sonra kargolanan sipari�leri d�nd�ren bir sorgu yaz�n.

SELECT TOP 10 *, DATEDIFF(DAY, order_date, shipped_date) AS day_diff
FROM sale.orders

SELECT TOP 10 *, DATEDIFF(DAY, order_date, shipped_date) AS day_diff
FROM sale.orders
WHERE DATEDIFF(DAY, order_date, shipped_date) > 2


--------STRING FUNCTIONS
--LEN, CHARINDEX, PATINDEX

SELECT LEN('Clarusway')  --- Toplam karakter say�s�n� d�nd�r�yor.
SELECT LEN('Clarusway ') --- Bo�luk sonda olunca karakter say�s�na eklenmiyor.
SELECT LEN(' Clarusway')  --- Bo�lu�u ba�a koyunca karakter say�s�na dahil oluyor.

---

SELECT CHARINDEX('c', 'Clarusway') --- c ka��nc� karakter

SELECT CHARINDEX('a', 'Clarusway') --- ilk a harfi ka��nc� karakterde

SELECT CHARINDEX('a', 'Clarusway', 4) --- 4. karakterden ba�layarak a karakterini aramaya ba�la bulunca ka��nc� karakter oldu�unu d�nd�r.

---
SELECT PATINDEX('sw', 'Clarusway')

SELECT PATINDEX('%sw%', 'Clarusway')

SELECT PATINDEX('%r_sw%', 'Clarusway')


SELECT PATINDEX('r_sw%', 'Clarusway') --- Ba��na % i�areti koymazsak arad���m�z patternin ilk harfi r ile ba�l�yor diye d���nd�. Bu sebeple sonu� 0
									  --- Yani b�yle bir pattern yok.


SELECT PATINDEX('___r_sw%', 'Clarusway')


--LEFT, RIGHT, SUBSTRING

SELECT LEFT('Clarusway', 3)

SELECT RIGHT('Clarusway', 3) 

SELECT SUBSTRING('Clarusway', 3,2) --- 3. KARAKTERDEN BA�LA 2 KARAKTER GET�R
SELECT SUBSTRING('Clarusway', 0,2) --- 0. KARAKTERDEN BA�LA 2 KARAKTER D�ND�R. 0. DA KARAKTER YOK BU 1, B�R�NC� DE C VAR B�YLECE 2 KARAKTER GET�RD�.
SELECT SUBSTRING('Clarusway', -1,2) --- -1 DE YOK 0 DA YOK. BU Y�ZDEN HERHANG� B�R �EY D�ND�RMED�


------------------------------///////////////////
--- LOWER, UPPER, STRING_SPLIT
SELECT LOWER('CLARUSWAY'), UPPER('clarusway')

SELECT *
FROM STRING_SPLIT('Ezgi,Senem,Mustafa', ',')

SELECT value
FROM STRING_SPLIT('Ezgi/Senem/Mustafa', '/')

---clarusway kelimesinin sadece ilk harfini b�y�t�n.

SELECT LEFT ('clarusway', 1)
SELECT SUBSTRING('clarusway', 2, LEN('clarusway'))
SELECT UPPER(LEFT('clarusway', 1)) + LOWER(SUBSTRING('clarusway', 2, LEN('clarusway')))

SELECT *, UPPER(LEFT(email, 1)) + LOWER(SUBSTRING(email, 2, LEN(email)))
FROM sale.store


--- TRIM, LTRIM, RTRIM

SELECT TRIM('   CLARUSWAY    ')

SELECT TRIM('?' FROM '?    CLARUSWAY   ?')  --- sadece soru i�aretini k�rpt�

SELECT TRIM('?, ' FROM '?    CLARUSWAY   ?')  --- bo�luklarda gitti

SELECT LTRIM('    CLARUSWAY    ')  --- soldaki bo�luk gitti

SELECT RTRIM('    CLARUSWAY    ')  --- sa�daki bo�luk gitti


---REPLACE, STR

SELECT REPLACE('CLARUSWAY', 'C', 'A')

SELECT REPLACE('CLAR USWAY', ' ', '')

SELECT STR(1234.25, 7, 2) --7 toplam ka� krakter oldu�u, 2 noktadan sonra ka� karakter gelece�ini ifade ediyor.

SELECT STR(1234.25, 7, 1)

---CAST, CONVERT

SELECT CAST(123.56 AS VARCHAR(6))

SELECT CAST(123.56 AS INT)

SELECT CAST(123.56 AS NUMERIC(4,1))


SELECT CONVERT(NUMERIC(4, 1), 123.56)

SELECT GETDATE()

SELECT CONVERT(VARCHAR, GETDATE(), 6) ---Buradaki 6 rakam� Datetime type lar�ndan birinin numaras�d�r. Biz burada GETDATE() ile bug�n�n tarihini 6. datetime tipinde getir dedik.

SELECT CONVERT(date, '19 Sep 22', 6)

---ROUND, ISNULL

SELECT ROUND(123.56, 1) --Virg�lden sonraki rakam� yuvarla. 56 y� 60 a yuvarlar.

SELECT ROUND(123.54,1) -- 54 � 50 ye yuvarlar.

SELECT ROUND(123.54, 1, 0) --Yuvarlad�ktan sonraki rakamlar� sil

SELECT ROUND(123.56, 1, 0)

SELECT ISNULL(null, 0)
SELECT ISNULL(1, 0)

SELECT ISNULL('notnull', 0)

SELECT phone, ISNULL(phone, 0)
FROM sale.customer

----YUVARLAMA FONKS�YONLARI:--------------------------------------------------------------------------------------------------------------------------------------------
ROUND = say�y� istenilen haneye g�re yuvarlama.
(Positive number rounds on the right side of the decimal point! Negative number rounds on the left side of the decimal point!)
FLOOR = say�y� a�a��ya yuvarlama.
CEILING = say�y� yukar�ya yuvarlama.
SELECT ROUND(12.4512,2)		 --say�y� virg�lden sonra 2 haneye yuvarlar.
SELECT FLOOR(12.4512) AS deger -- say�n�n virg�lden sonraki de�erini atarak 12 olarak yuvarlar.
SELECT CEILING(12.4512) AS deger -- say�n�n virg�lden sonraki hanesini yukar� yuvarlar ve 13 elde edilir.
:clarusway: Desimal (Ondal�k) veri t�r� ve �e�itli uzunluk parametreleriyle yuvarlama:
DECLARE @value decimal(10,2)  -- de�i�ken deklare ettik.
SET @value = 11.05 -- de�i�kene de�er atad�k.
SELECT ROUND(@value, 1)  -- 11.10
SELECT ROUND(@value, -1) -- 10.00 
SELECT ROUND(@value, 2)  -- 11.05 
SELECT ROUND(@value, -2) -- 0.00 
SELECT ROUND(@value, 3)  -- 11.05
SELECT ROUND(@value, -3) -- 0.00
SELECT CEILING(@value)   -- 12 
SELECT FLOOR(@value)     -- 11 
:clarusway: Numeric (say�sal) veri t�r� ile yuvarlama :
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
:clarusway: Float veri t�r� ile yuvarlama fonksiyonlar�.
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
:clarusway: Pozitif bir tamsay� yuvarlama (1 keskinlik de�eri i�in):
DECLARE @value int
SET @value = 6
SELECT ROUND(@value, 1)  -- 6 - No rounding with no digits right of the decimal point
SELECT CEILING(@value)   -- 6 - Smallest integer value
SELECT FLOOR(@value)     -- 6 - Largest integer value 
:clarusway: Kesinlik de�eri olarak bir negatif say�n�n etkilerini de g�relim:
DECLARE @value int
SET @value = 6
SELECT ROUND(@value, -1) -- 10 - Rounding up with digits on the left of the decimal point
SELECT ROUND(@value, 2)  -- 6  - No rounding with no digits right of the decimal point 
SELECT ROUND(@value, -2) -- 0  - Insufficient number of digits
SELECT ROUND(@value, 3)  -- 6  - No rounding with no digits right of the decimal point
SELECT ROUND(@value, -3) -- 0  - Insufficient number of digits
   Bu �rnekteki rakamlar� geni�letelim ve ROUND fonksiyonu kullanarak etkilerini g�relim:
SELECT ROUND(444,  1) -- 444  - No rounding with no digits right of the decimal point
SELECT ROUND(444, -1) -- 440  - Rounding down
SELECT ROUND(444,  2) -- 444  - No rounding with no digits right of the decimal point
SELECT ROUND(444, -2) -- 400  - Rounding down
SELECT ROUND(444,  3) -- 444  - No rounding with no digits right of the decimal point
SELECT ROUND(444, -3) -- 0    - Insufficient number of digits
SELECT ROUND(444,  4) -- 444  - No rounding with no digits right of the decimal point
SELECT ROUND(444, -4) -- 0    - Insufficient number of digits
:clarusway: Negatif bir tamsay� yuvarlayal�m ve etkilerini g�relim:
SELECT ROUND(-444, -1) -- -440  - Rounding down
SELECT ROUND(-444, -2) -- -400  - Rounding down
SELECT ROUND(-555, -1) -- -560  - Rounding up
SELECT ROUND(-555, -2) -- -600  - Rounding up
SELECT ROUND(-666, -1) -- -670  - Rounding up
SELECT ROUND(-666, -2) -- -700  - Rounding up
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---COALESCE, NULLIF, ISNUMERIC

SELECT COALESCE(NULL, NULL, 'AL�', NULL) ---NULL olmayan ilk de�eri getiriyor

SELECT NULLIF(0, 0) --iki de�er birbirine e�itse Null de�er d�nd�recektir.

SELECT phone, ISNULL(PHONE, 0), null�f (ISNULL(phone, 0), '0')
FROM sale.customer


SELECT ISNUMERIC(1)

SELECT ISNUMERIC('1')

SELECT ISNUMERIC('1,5')

SELECT ISNUMERIC('1.5')

SELECT ISNUMERIC('1AL�')


---- How many customers have yahoo mail? SampleRetail Database ini kullan�n.
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
ORDER BY 3  ---Yazd���m�z kodun 3. s�tununa g�re s�rala demek.


SELECT phone,email, ISNULL(phone, email) AS contact
FROM sale.customer




--------------------------JOINS---------------------------------


SELECT *
FROM product.product

SELECT *
FROM product.category

--Yukar�daki iki tabloyu ortak s�tuna g�re join yap�yoruz

SELECT product.product.product_name, product.product.category_id,  product.category.category_id,  product.category.category_name
FROM product.product
	 INNER JOIN product.category
	 ON product.product.category_id = product.category.category_id
ORDER BY product.product.category_id

---Her iki tabloda da mevcut olan kategorileri getirdi.
---Bu kodlar� biraz k�saltarak yazal�m. Sadece JOIN, INNER JOIN demektir.
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
----Street s�tununda soldan ���nc� karakterin rakam oldu�u kay�tlar� getiriniz.

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

SELECT A.product_id, B.product_id, B.store_id, B.quantity ---B* da diyebiliriz. T�m s�tunlar�n gelmesini istiyoruz ��nk�.
FROM product.product A
	 LEFT JOIN
	 product.stock B
	 ON A.product_id = B.product_id
WHERE B.product_id > 310


------RIGHT JOIN--------

SELECT A.product_id, B* ---B* da diyebiliriz. T�m s�tunlar�n gelmesini istiyoruz ��nk�.
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
ORDER BY 2							--Default oalrak Ascending s�ralama yap�yor.

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
You have to insert all these products for every three stores with �0� quantity.
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

/*Hem staff'ler hem manager'ler ayn� sales.staffs tablosu i�indeler.
Bu tablo kendi kendine ili�ki i�erisinde. bu tabloda iki tane s�tun birbiri ile ayn� bilgiyi ta��yor.
Burda staff_id ile manager_id birbiri ile ili�ki i�inde. her staff'in bir manageri var ve bu manager ayn� zamanda bir staff..
Mesela staff_id si 2 olan Charles'�n manager_id'si 1,  yani staff_id'si 1 olan ki�i Charles'�n manageri demektir.*/
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
INTO #v_sample_summary_2 ----Ge�ici olarak bir tablo olu�turmak i�in # kullanabiliyoruz.
FROM v_sample_summary

---------------/////////////////-----------------------------
-----------------HAVING----------------------------

/*FROM, WHERE, GROUP BY, HAVING, SELECT, ORDER BEY:SQL SERVER IN KODU �ALI�TIRIRKEN BAKTI�I SIRALAMA
FROM : hangi tablolara gitmem gerekiyor?
WHERE : o tablolardan hangi verileri �ekmem gerekiyor?
GROUP BY : bu bilgileri ne �ekilde gruplayay�m?
SELECT : neleri getireyim ve hangi aggragate i�lemine tabi tutay�m.
HAVING : yukardaki sorgu sonucu ��kan tablo �zerinden nas�l bir filtreleme yapay�m (mesela list_price>1000)
Gruplama yapt���m�z ayn� sorgu i�inde bir filtreleme yapmak istiyorsak HAVING kullanaca��z
HAVING kullanmadan; HAVING'ten yukar�s�n� al�p ba�ka bir SELECT sorgusunda WHERE �art� ile de bu filtrelemeyi yapabiliriz.
ORDER BY : ��kan sonucu hangi s�ralama ile getireyim? (edited) 
Soruda average veya toplam gibi aggregate i�lemi gerektirecek bir istek varsa hemen "GROUP BY" kullanmam gerekti�ini anlamal�y�m.
Bir sayma i�lemi, bir grupland�rma bir aggregate i�lemi yap�yorsan isimle de�il ID ile yap. ID'ler her zaman birer defa ge�er (Unique�tir), isimler tekrar edebilir (�r: bir ka� product'a ayn� isim verilmi� olabilir)
SELECT sat�r�nda yazd���n s�tunlar�n hepsi GROUP BY'da olmas� gerekiyor!
HAVING ile sadece aggregate etti�imiz s�tuna ko�ul verebiliriz!
HAVING�de kulland���n s�tun, aggregate te kulland���n s�tunla ayn� olmal�.*/

---Example: Write a query that check if any product id is repeated in more than one row in the product table.
SELECT product_id, COUNT(*) AS cnt_prod_id
FROM   product.product
GROUP BY
	   product_id
HAVING 
	COUNT(*)>1

SELECT COUNT(product.product_id) AS cnt_prod_id --SELECT COUNT(*) ayn� sonucu verir.
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
-- Gruplad���m�z �ey "category_id" oldu�u i�in SELECT'te onu getiriyoruz. Group By'da Select'te yazd���n s�tunlar muhakkak olmal�.
FROM product.product
-- ana tablo i�inde herhangi bir k�s�tlamam var m� yani WHERE i�lemi var m�? yok. O zaman Group By ile devam ediyorum.
-- Ana tablo i�inde herhangi bir k�s�tlama yapmayacaksan WHERE sat�r� kullanmayacaks�n demektir.
GROUP BY
          category_id
HAVING
          MIN(list_price) < 500 
	OR 
	MAX(list_price) > 4000;
--GROUP BY ve aggregate neticesinde ��kan tabloyu yukardaki conditionlara g�re filtreleyip getirdik. HAVING�in yapt��� i� budur.
-- Dikkat! soruyu iyi okumal�s�n. soruda �veya� dedi�i i�in OR kulland�k.*/

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

--Example: Write a query that returns monthly order counts of the States. (Her bir State in ayl�k sipari� say�s� nedir?)

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
---Ayn� sorguda hem markalara ait net amount bilgisini,
---Kategorilere ait net amount bilgisini
---T�m veriye ait net amount bilgisini
---Marka ve kategori k�r�l�m�nda net amount bilgisini getiriniz.

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


