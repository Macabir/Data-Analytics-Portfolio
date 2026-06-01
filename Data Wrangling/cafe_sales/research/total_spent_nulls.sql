SELECT TOP (1000) [Transaction_ID]
      ,[Item]
      ,[Quantity]
      ,[Price_Per_Unit]
      ,[Total_Spent]
      ,[Cleaned_Quantity]
      ,[Cleaned_Price_Per_Unit]
  FROM [Cafe Sales].[dbo].[Cleaned_Quantities]
  ORDER BY Cleaned_Quantity ASC;

SELECT TOP (1000) [Transaction_ID]
      ,[Item]
      ,[Quantity]
      ,[Price_Per_Unit]
      ,[Total_Spent]
      ,[Cleaned_Quantity]
      ,[Cleaned_Price_Per_Unit]
  FROM [Cafe Sales].[dbo].[Cleaned_Quantities]
  ORDER BY Cleaned_Price_Per_Unit ASC;

 SELECT 
    SUM(CASE WHEN Transaction_ID IS NULL THEN 1 ELSE 0 END) AS Null_Count_Transaction_ID,
    SUM(CASE WHEN Item IS NULL THEN 1 ELSE 0 END) AS Null_Count_Item,
    SUM(CASE WHEN [Cleaned_Quantity] IS NULL THEN 1 ELSE 0 END) AS Null_Count_Cleaned_Quantity,
    SUM(CASE WHEN Cleaned_Price_Per_Unit IS NULL THEN 1 ELSE 0 END) AS Null_Count_Cleaned_Price_Per_Unit,
    SUM(CASE WHEN Total_Spent IS NULL THEN 1 ELSE 0 END) AS Null_Count_Total_Spent
FROM 
    [Cafe Sales].[dbo].[Cleaned_Quantities];





--Handles Total_Spent nulls and returns the original amount of them and the remainder.
WITH Cleaned_Data_CTE AS (
    SELECT 
       [Transaction_ID]
      ,[Item]
      ,[Quantity]
      ,[Price_Per_Unit]
      ,[Total_Spent]
      ,(Cleaned_Quantity * Cleaned_Price_Per_Unit) AS Cleaned_Total_Spent
    FROM 
        [Cafe Sales].[dbo].[Cleaned_Quantities]
)
SELECT 
    -- 1. Count nulls in the original raw column
    SUM(CASE WHEN Total_Spent IS NULL THEN 1 ELSE 0 END) AS Original_Total_Nulls,
    
    -- 2. Count nulls in your new calculated column
    SUM(CASE WHEN Cleaned_Total_Spent IS NULL THEN 1 ELSE 0 END) AS Remaining_Total_Nulls
FROM 
    Cleaned_Data_CTE;

--From here, there would naturally be no remaining Total_Spent nulls.