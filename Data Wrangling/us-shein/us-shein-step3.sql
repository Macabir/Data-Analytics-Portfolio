/*

	So, by various Views, I cut down on the visible columns, though they are still in the tables. 
	This query handles nulls for the color_count, them being zeros for the integer value column.

*/

SELECT [product-name]
      ,[price]
      ,[discount]
      ,[selling_proposition]
      ,[color_count]
  FROM [us-shein].[dbo].[View_2]

UPDATE [us-shein].[dbo].[View_2]
SET color_count = 0
WHERE color_count IS NULL;