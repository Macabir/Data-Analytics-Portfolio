CREATE VIEW [dbo].[Cleaned_Items] AS
SELECT 
    [Transaction_ID],

	-- Map known prices, preserve valid items, and default the rest to 'UNKNOWN'
		COALESCE(
			CASE 
				WHEN TRY_CAST([Cleaned_Price_Per_Unit] AS FLOAT) = 1 THEN 'Cookie'
				WHEN TRY_CAST([Cleaned_Price_Per_Unit] AS FLOAT) = 1.5 THEN 'Tea'
				WHEN TRY_CAST([Cleaned_Price_Per_Unit] AS FLOAT) = 2 THEN 'Coffee'
				WHEN TRY_CAST([Cleaned_Price_Per_Unit] AS FLOAT) = 5 THEN 'Salad'
				WHEN Item NOT IN ('ERROR', 'UNKNOWN') AND Item IS NOT NULL THEN Item
				ELSE NULL
			END, 
			'UNKNOWN'
		) AS [Cleaned_Item],
  
      [Cleaned_Quantity],
      [Cleaned_Price_Per_Unit],
      [Cleaned_Total_Spent]
FROM [dbo].[Cleaned_Total_Spent];