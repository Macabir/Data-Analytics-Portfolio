/*
	There is one null price here. It's a high-end gaming computer. A clear outlier, given that our maximum price value is for a gaming phone.
	I'm going to assume in this case that it's $800, based on a similar one I've seen online.
	I also mean to suggest that the discount isn't included in the price.

*/

SELECT [goods_title_link_jump]
      ,[goods_title_link_jump_href]
      ,[rank_title]
      ,[rank_sub]
      ,[price]
      ,[discount]
      ,[selling_proposition]
      ,[color_count]
      ,[goods_title_link]
  FROM [us-shein].[dbo].[us-shein-electronics-4395-dirty]
  ORDER BY
   [price] DESC;

SELECT [goods_title_link_jump]
      ,[goods_title_link_jump_href]
      ,[rank_title]
      ,[rank_sub]
      ,[price]
      ,[discount]
      ,[selling_proposition]
      ,[color_count]
      ,[goods_title_link]
FROM [us-shein].[dbo].[us-shein-electronics-4395-dirty]
WHERE [price] IS NULL;

UPDATE [us-shein].[dbo].[us-shein-electronics-4395-dirty]
SET [price] = 800
WHERE [price] IS NULL;