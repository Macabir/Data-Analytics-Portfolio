

-- Creates columns for revenues, costs and profits per the history of three months of sales of each cookie product.

UPDATE [KCC].[dbo].[Product]
SET RevenuePerProduct = CookieCount * RevenuePerCookie
UPDATE [KCC].[dbo].[Product]
SET CostPerProduct = CookieCount * CostPerCookie
UPDATE [KCC].[dbo].[Product]
SET ProfitPerProduct = RevenuePerProduct - CostPerProduct

SELECT TOP (1000) [CookieID]
      ,[CookieName]
      ,[RevenuePerCookie]
      ,[CostPerCookie]
      ,[CookieCount]
      ,[RevenuePerProduct]
      ,[CostPerProduct]
      ,[ProfitPerProduct]
  FROM [KCC].[dbo].[Product]

/*
	Now that we have this data, there is a bit more that can be said about the performance of each cookie
	during the three month span associated with this business. For one thing, even though the Fortune Cookie
	is the biggest seller, it also makes the least profit by far. White Chocolate Macadamia Nut is the least seller,
	but only loses out to the Chocolate Chip in ---profit---. The difference in these last two is significant,
	but not as significant as say, the difference the Fortune Cookie and the Sugar Cookie, or even between the Sugar Cookie and the Oatmeal Raisin.

	More can be said, but we might save that for visualization.
	But by utilizing basic aggregate functions from statistics
	(not to mention the handy-dandy row operator functions),
	There is much more to glean from the data than without those features.

	My next aim will be to see profits on a more granular level -- by the month and then by the week.
	Or, I could go ahead and start learning to clean data. This database is cut and dry, and very small.

	I will not attempt it now, but I also wonder if I could simplify the CookieCount loop by using row operations...

	In any case, this might suffice for now as far as the portfolio is concerned.
*/