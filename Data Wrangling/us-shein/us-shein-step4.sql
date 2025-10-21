/*

	Nulling the discount similar to the color_count. There is a matter of format and value to settle, however.

*/

SELECT [product-name]
      ,[price]
      ,[discount]
      ,[selling_proposition]
      ,[color_count]
  FROM [us-shein].[dbo].[View_2]

UPDATE [us-shein].[dbo].[View_2]
SET discount = 0
WHERE discount IS NULL;