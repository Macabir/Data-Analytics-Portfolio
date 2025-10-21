

  /*Essentially the last file turned into an updater for a new column:*/

  DECLARE @i INT = 1;
  DECLARE @CookieIDcount INT;


  WHILE (
		SELECT COUNT(CookieID)
		FROM [KCC].[dbo].[Product]
        ) >= @i
  BEGIN
	UPDATE [KCC].[dbo].[Product] SET CookieCount = (
	  SELECT SUM(Quantity) AS 'CookieID Quantity Sum'
	  FROM [KCC].[dbo].[Order_Product]
	  WHERE CookieID = @i
	    )
	  WHERE CookieID = @i;
	SET @i += 1;
  END

 /*
 
 So now we know how many of each cookie product we have sold. But how much money has each product made?
 Before I do that though, I should learn to put these aggregates into a single column with their respective CookieID values.
 I have added a column to dbo.Product. It can and will be updated, or even removed later as this project evolves.
 
 */


