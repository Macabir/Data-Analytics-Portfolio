CREATE VIEW [dbo].[Cleaned_Total_Spent] AS
SELECT 
       [Transaction_ID]
      ,[Item]
      ,[Quantity]
      ,[Price_Per_Unit]
      ,[Total_Spent]
	  ,Cleaned_Quantity
	  ,Cleaned_Price_Per_Unit
      ,(Cleaned_Quantity * Cleaned_Price_Per_Unit) AS Cleaned_Total_Spent
FROM 
    Cleaned_Quantities;



