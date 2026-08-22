CREATE VIEW [dbo].[Cleaned_Items] AS
SELECT 
    [Transaction_ID],

    CASE 
        WHEN (Item IS NULL OR Item = 'ERROR' OR Item = 'UNKNOWN') AND [dbo].[Cleaned_Total_Spent].[Cleaned_Price_Per_Unit] = 1 THEN 'Cookie'
        WHEN (Item IS NULL OR Item = 'ERROR' OR Item = 'UNKNOWN') AND [dbo].[Cleaned_Total_Spent].[Cleaned_Price_Per_Unit] = 1.5 THEN 'Tea'
        WHEN (Item IS NULL OR Item = 'ERROR' OR Item = 'UNKNOWN') AND [dbo].[Cleaned_Total_Spent].[Cleaned_Price_Per_Unit] = 2 THEN 'Coffee'
        WHEN (Item IS NULL OR Item = 'ERROR' OR Item = 'UNKNOWN') AND [dbo].[Cleaned_Total_Spent].[Cleaned_Price_Per_Unit] = 5 THEN 'Salad'
        ELSE Item
    END AS [Cleaned_Item],
  
      [Cleaned_Quantity],
      [Cleaned_Price_Per_Unit],
      [Cleaned_Total_Spent]
FROM [dbo].[Cleaned_Total_Spent];