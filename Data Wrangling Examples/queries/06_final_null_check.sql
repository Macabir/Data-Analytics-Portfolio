
SELECT 
    SUM(CASE WHEN [Cleaned_Item] IS NULL OR [Cleaned_Item] = 'UNKNOWN' OR [Cleaned_Item] = 'ERROR' THEN 1 ELSE 0 END) AS Unresolved_Items,
    SUM(CASE WHEN [Cleaned_Quantity] IS NULL THEN 1 ELSE 0 END) AS Null_Quantities,
    SUM(CASE WHEN [Cleaned_Price_Per_Unit] IS NULL THEN 1 ELSE 0 END) AS Null_Prices,
    SUM(CASE WHEN [Cleaned_Total_Spent] IS NULL THEN 1 ELSE 0 END) AS Null_Totals
FROM [dbo].[Final_Cafe_Sales_Check];