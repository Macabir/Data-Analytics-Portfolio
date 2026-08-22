--Creating a view to display the cleaned cafe unit price column.
CREATE VIEW Cleaned_Cafe_Prices AS
WITH Menu_Prices AS (
        SELECT 
        Transaction_ID,
		Price_Per_Unit,
        Item,
        Quantity,
        Total_Spent,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Price_Per_Unit) OVER(PARTITION BY Item) AS Standard_Menu_Price
    FROM 
		[Cafe Sales].[dbo].[cafe_sales]
),
Cleaned_Price_Output AS (
    SELECT 
        Transaction_ID,
        Item,
        Quantity,
        Total_Spent,
        CASE 
            WHEN Price_Per_Unit IS NOT NULL THEN Price_Per_Unit
            WHEN Total_Spent IS NOT NULL AND COALESCE(Quantity, 0) > 0 THEN Total_Spent / Quantity
            ELSE Standard_Menu_Price
        END AS Cleaned_Price_Per_Unit
    FROM 
        Menu_Prices
)
SELECT * FROM Cleaned_Price_Output;
