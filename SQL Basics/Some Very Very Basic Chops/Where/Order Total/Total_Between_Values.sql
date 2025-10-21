SELECT TOP (50) [OrderID]
      ,[OrderDate]
      ,[CustomerID]
      ,[OrderTotal]
  FROM [KCC].[dbo].[Orders]
  WHERE OrderTotal < 1383 AND OrderTotal > 800;