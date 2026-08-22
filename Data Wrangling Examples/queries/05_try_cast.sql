CREATE VIEW [dbo].[Final_Cafe_Sales_Check] AS
SELECT 
    [Transaction_ID],
    [Cleaned_Item],
    TRY_CAST([Cleaned_Quantity] AS FLOAT) AS [Cleaned_Quantity],
    TRY_CAST([Cleaned_Price_Per_Unit] AS FLOAT) AS [Cleaned_Price_Per_Unit],
    TRY_CAST([Cleaned_Total_Spent] AS FLOAT) AS [Cleaned_Total_Spent]
FROM [dbo].[Cleaned_Items];