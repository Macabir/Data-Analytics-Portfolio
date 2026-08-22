CREATE VIEW [dbo].[Cleaned_Total_Spent] AS
SELECT 
       [Transaction_ID]
      ,[Item]
	  ,Cleaned_Quantity
	  ,Cleaned_Price_Per_Unit
      ,(Cleaned_Quantity * Cleaned_Price_Per_Unit) AS Cleaned_Total_Spent
FROM 
    Cleaned_Quantities;



