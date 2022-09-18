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