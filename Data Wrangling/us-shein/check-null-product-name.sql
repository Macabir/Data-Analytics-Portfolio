--Every row has a product name, so I can depend upon each one as an identifier.

SELECT [price]
	  ,[product-name]
FROM [us-shein].[dbo].[us-shein-electronics-4395-dirty0]
WHERE [product-name] IS NULL;
