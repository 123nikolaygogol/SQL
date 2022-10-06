
----Factorial Function

----Create a scalar-valued function that returns the factorial of a number you gave it.



CREATE FUNCTION Factorial(@Number int)
RETURNS INT
AS 
BEGIN 
DECLARE @value int
 IF @Number <= 1 
SET @value = 1 
ELSE 
SET @value = @Number * dbo.Factorial(@Number - 1) 
RETURN (@value) 
END