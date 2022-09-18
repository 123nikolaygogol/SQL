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