SELECT TOP (50) [OrderID]
      ,[OrderDate]
      ,[CustomerID]
      ,[OrderTotal]
	  ,[OrderDate]
  FROM [KCC].[dbo].[Orders]
  WHERE OrderTotal < 2000 AND CustomerID = 5 AND OrderDate < '2022-03-01';


--This returns all orders less than $2000 from Park & Shop Convenience Stores in January and February.