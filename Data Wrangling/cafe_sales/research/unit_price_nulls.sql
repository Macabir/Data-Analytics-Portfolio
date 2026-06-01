SELECT TOP (1000) [Transaction_ID]
      ,[Item]
      ,[Quantity]
      ,[Price_Per_Unit]
      ,[Total_Spent]
      ,[Payment_Method]
      ,[Location]
      ,[Transaction_Date]
  FROM [Cafe Sales].[dbo].[cafe_sales]




--Counts nulls in each column.
SELECT 
    SUM(CASE WHEN Transaction_ID IS NULL THEN 1 ELSE 0 END) AS Null_Count_Transaction_ID,
    SUM(CASE WHEN Item IS NULL THEN 1 ELSE 0 END) AS Null_Count_Item,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS Null_Count_Quantity,
    SUM(CASE WHEN Price_Per_Unit IS NULL THEN 1 ELSE 0 END) AS Null_Count_Price,
    SUM(CASE WHEN Total_Spent IS NULL THEN 1 ELSE 0 END) AS Null_Count_Total_Spent,
	SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Null_Count_Payment_Method,
    SUM(CASE WHEN [Location] IS NULL THEN 1 ELSE 0 END) AS Null_Count_Location,
    SUM(CASE WHEN Transaction_Date IS NULL THEN 1 ELSE 0 END) AS Null_Count_Transaction_Date
FROM 
    [Cafe Sales].[dbo].[cafe_sales];



--Handles Price_Per_Unit nulls and returns the original amount of them and the remainder.
WITH Cleaned_Data_CTE AS (
    SELECT 
       [Transaction_ID]
      ,[Item]
      ,[Quantity]
      ,[Price_Per_Unit]
      ,[Total_Spent]
      ,[Payment_Method]
      ,[Location]
      ,[Transaction_Date]
        
        ,CASE 
            WHEN Price_Per_Unit IS NOT NULL THEN Price_Per_Unit
            WHEN COALESCE(Quantity, 0) = 0 THEN 0.00
            ELSE Total_Spent / Quantity 
        END AS Cleaned_Price_Per_Unit
    FROM 
        [Cafe Sales].[dbo].[cafe_sales]
)
SELECT 
    -- 1. Count nulls in the original raw column
    SUM(CASE WHEN Price_Per_Unit IS NULL THEN 1 ELSE 0 END) AS Original_Price_Nulls,
    
    -- 2. Count nulls in your new calculated column
    SUM(CASE WHEN Cleaned_Price_Per_Unit IS NULL THEN 1 ELSE 0 END) AS Remaining_Price_Nulls
FROM 
    Cleaned_Data_CTE;




--Shows the remaining lines.
WITH Cleaned_Data_CTE AS (
    SELECT 
        Transaction_ID,
        Item,
        Quantity,
        Price_Per_Unit,
        Total_Spent,
        
        -- Our safe derivation math
        CASE 
            WHEN Price_Per_Unit IS NOT NULL THEN Price_Per_Unit
            WHEN COALESCE(Quantity, 0) = 0 THEN 0.00
            ELSE Total_Spent / Quantity 
        END AS Cleaned_Price_Per_Unit
    FROM 
        [Cafe Sales].[dbo].[cafe_sales]
)
SELECT 
    Transaction_ID,
    Item,
    Quantity,
    Price_Per_Unit,
    Total_Spent,
    Cleaned_Price_Per_Unit
FROM 
    Cleaned_Data_CTE
WHERE 
    Cleaned_Price_Per_Unit IS NULL; -- This filters down to just the stubborn 20 rows


--Calculates a menu price and assigns a unit price to the missing transaction values.
WITH Menu_Prices AS (
    SELECT 
        Transaction_ID,
        Item,
        Quantity,
        Price_Per_Unit,
        Total_Spent,
        -- Calculate the standard menu price (median) for every item across the dataset
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Price_Per_Unit) OVER(PARTITION BY Item) AS Standard_Menu_Price
    FROM 
        [Cafe Sales].[dbo].[cafe_sales]
)
SELECT 
    Transaction_ID,
    Item,
    Quantity,
    Price_Per_Unit AS Raw_Price,
    Total_Spent AS Raw_Total,
    
    -- Focus entirely on Price cleaning
    CASE 
        -- Rule 1: If price is already there, keep it
        WHEN Price_Per_Unit IS NOT NULL THEN Price_Per_Unit
        
        -- Rule 2: If we have total spent, derive it mathematically
        WHEN Total_Spent IS NOT NULL AND COALESCE(Quantity, 0) > 0 THEN Total_Spent / Quantity
        
        -- Rule 3: For the bare minimum rows, fall back to the standard menu price
        ELSE Standard_Menu_Price
    END AS Cleaned_Price_Per_Unit

FROM 
    Menu_Prices;



--As before, but gives a final null check.
WITH Menu_Prices AS (
    SELECT 
        Transaction_ID,
        Item,
        Quantity,
        Price_Per_Unit,
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
        Price_Per_Unit,
        Total_Spent,
        CASE 
            WHEN Price_Per_Unit IS NOT NULL THEN Price_Per_Unit
            WHEN Total_Spent IS NOT NULL AND COALESCE(Quantity, 0) > 0 THEN Total_Spent / Quantity
            ELSE Standard_Menu_Price
        END AS Cleaned_Price_Per_Unit
    FROM 
        Menu_Prices
)
SELECT 
    -- Count the remaining nulls in your finalized column
    SUM(CASE WHEN Cleaned_Price_Per_Unit IS NULL THEN 1 ELSE 0 END) AS Remaining_Price_Nulls
FROM 
    Cleaned_Price_Output;
