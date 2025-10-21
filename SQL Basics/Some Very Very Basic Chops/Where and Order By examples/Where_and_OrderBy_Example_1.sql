SELECT TOP (50) [OrderID]
      ,[OrderDate]
      ,[CustomerID]
      ,[OrderTotal]
  FROM [KCC].[dbo].[Orders]
  WHERE OrderDate >= '2022-02-01' AND OrderDate <= '2022-03-01'
  ORDER BY CustomerID, OrderTotal;