SELECT TOP (50) [OrderID]
      ,[OrderDate]
      ,[CustomerID]
      ,[OrderTotal]
  FROM [KCC].[dbo].[Orders]
  WHERE OrderTotal < 2000 AND CustomerID = 5;

--This returns all orders less than $2000 from Park & Shop Convenience Stores.