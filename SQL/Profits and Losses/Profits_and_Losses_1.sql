

  /*
  
  My aim is to see the total amount of money made by each cookie's sale and lost by each cookie's production.

  First, I will try to relate each CookID to the quantity of cookies from every order.
  
  */

--Narrowing the selection down to each CookieID = 1;
SELECT TOP (1000) [OrderID]
      ,[CookieID]
      ,[Quantity]
  FROM [KCC].[dbo].[Order_Product]
  WHERE CookieID = 1;

  /*
  
  Now I wish to generate a sum of the quantities.
  I have faith in the answer, but for my own satisfaction,
  what happens if I exclude the where statement in the following?
  Will it be different than if I included it?
  
  */

SELECT SUM(Quantity)
  FROM [KCC].[dbo].[Order_Product]
--WHERE CookieID = 1;
SELECT SUM(Quantity)
  FROM [KCC].[dbo].[Order_Product]
  WHERE CookieID = 1;

  /*
  
  The answer is different. But what we need is the included where statement.
  And now that we have the sum of each quantity, we can see that the other quantities can be produced thereby:
  
  */

  /* SELECT SUM(Quantity)
  FROM [KCC].[dbo].[Order_Product]
  WHERE CookieID = 2;
  SELECT SUM(Quantity)
  FROM [KCC].[dbo].[Order_Product]
  WHERE CookieID = 3;
  SELECT SUM(Quantity)
  FROM [KCC].[dbo].[Order_Product]
  WHERE CookieID = 4;
  SELECT SUM(Quantity)
  FROM [KCC].[dbo].[Order_Product]
  WHERE CookieID = 5;

  --This doesn't look efficient. I'd rather write it as a loop. */

  Declare @i INT = 1;
  Declare @CookieIDcount INT

  	SELECT COUNT(CookieID)
	FROM [KCC].[dbo].[Product]
	

  WHILE (
		SELECT COUNT(CookieID)
		FROM [KCC].[dbo].[Product]
        ) >= @i
  BEGIN
	SELECT SUM(Quantity) AS 'CookieID Quantity Sum'
	FROM [KCC].[dbo].[Order_Product]
	WHERE CookieID = @i;
	SET @i += 1;

  END
