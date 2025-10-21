/* 

	I COALESCE'd the columns for product titles to prevent a redundancy
	and fill in missing gaps (i.e., nulls).

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
	  ,COALESCE(goods_title_link_jump, goods_title_link) AS [product-name]
  INTO [us-shein].[dbo].[us-shein-electronics-4395-dirty0]
  FROM [us-shein].[dbo].[us-shein-electronics-4395-dirty]
