SELECT TOP (1000) [OrderID]
      ,[OrderDate]
      ,[CustomerID]
      ,[OrderTotal]
  FROM [KCC].[dbo].[Orders]

SELECT MIN(OrderTotal) AS "Minimum", MAX(OrderTotal) AS "Maximum", COUNT(OrderTotal) AS "Count", SUM(OrderTotal) AS "Sum", AVG(OrderTotal) AS "Mean"
  FROM [KCC].[dbo].[Orders]
