

  /*From the last file:*/

  Declare @i INT = 1;
  Declare @CookieIDcount INT

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

 /*
 
 So now we know how many of each cookie product we have sold. But how much money has each product made?
 Before I do that though, I should learn to put these aggregates into a single column with their respective CookieID values.
 
 */

