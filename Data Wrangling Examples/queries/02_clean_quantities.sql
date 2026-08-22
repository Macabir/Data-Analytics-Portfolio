CREATE VIEW [dbo].[Cleaned_Quantities] AS
WITH Cleaned_Data_CTE AS (
    SELECT 
       [Transaction_ID]
      ,[Item]
      ,[Quantity]
      ,[Total_Spent]
      ,[Cleaned_Price_Per_Unit]
	,CASE
		WHEN Quantity IS NOT NULL THEN Quantity
		WHEN Total_Spent IS NOT NULL THEN Total_Spent
		--Conservative estimate for inexact imputation
		WHEN Quantity IS NULL AND Total_Spent IS NULL THEN 1
		ELSE Total_Spent / Cleaned_Price_Per_Unit
	END AS Cleaned_Quantity

	,CASE 
        WHEN Quantity IS NOT NULL THEN 0 -- Real data, no imputation
        WHEN Total_Spent IS NOT NULL THEN 0 -- Calculated data, no conservative fallback used
        ELSE 1     -- 1 means "Yes, we had to use the conservative default of 1"
    END AS Is_Conservative_Imputation
	FROM 
		[Cafe Sales].[dbo].[Cleaned_Cafe_Prices]
)
SELECT 
       [Transaction_ID]
      ,[Item]
      ,[Quantity]
      ,[Total_Spent]
	  ,[Cleaned_Quantity]
	  ,[Cleaned_Price_Per_Unit]
FROM 
    Cleaned_Data_CTE;


