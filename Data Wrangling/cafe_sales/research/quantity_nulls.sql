SELECT TOP (1000) [Transaction_ID]
      ,[Item]
      ,[Quantity]
      ,[Price_Per_Unit]
      ,[Total_Spent]
      ,[Cleaned_Price_Per_Unit]
  FROM [Cafe Sales].[dbo].[Cleaned_Cafe_Prices]
  ORDER BY Transaction_ID ASC;



--Counts nulls in each column.
SELECT 
    SUM(CASE WHEN Transaction_ID IS NULL THEN 1 ELSE 0 END) AS Null_Count_Transaction_ID,
    SUM(CASE WHEN Item IS NULL THEN 1 ELSE 0 END) AS Null_Count_Item,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS Null_Count_Quantity,
    SUM(CASE WHEN [Cleaned_Price_Per_Unit] IS NULL THEN 1 ELSE 0 END) AS Null_Count_Price_Per_Unit,
    SUM(CASE WHEN Total_Spent IS NULL THEN 1 ELSE 0 END) AS Null_Count_Total_Spent
FROM 
    [Cafe Sales].[dbo].[Cleaned_Cafe_Prices];



SELECT 
    Transaction_ID,
    Item,
    Quantity,
	Price_Per_Unit,
    Total_Spent,
    [Cleaned_Price_Per_Unit],
	CASE
        WHEN Quantity IS NOT NULL THEN Quantity
        WHEN Total_Spent IS NOT NULL THEN Total_Spent
		--Conservative estimate for inexact imputation
		WHEN Quantity IS NULL AND Total_Spent IS NULL THEN 1
        ELSE Total_Spent / Cleaned_Price_Per_Unit
		END AS Cleaned_Quantity
FROM 
    [Cafe Sales].[dbo].[Cleaned_Cafe_Prices]
ORDER BY Cleaned_Quantity ASC;



WITH Cleaned_Data_CTE AS (
    SELECT 
       [Transaction_ID]
      ,[Item]
      ,[Quantity]
	  ,Price_Per_Unit
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
    -- 1. Count nulls in the original raw column
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS Original_Quantity_Nulls,
    
    -- 2. Count nulls in your new calculated column
    SUM(CASE WHEN Cleaned_Price_Per_Unit IS NULL THEN 1 ELSE 0 END) AS Remaining_Quantity_Nulls,

	-- 1. Count conservative imputations your new calculated column
	SUM(Is_Conservative_Imputation) AS Is_Conservative_Imputation
FROM 
    Cleaned_Data_CTE;