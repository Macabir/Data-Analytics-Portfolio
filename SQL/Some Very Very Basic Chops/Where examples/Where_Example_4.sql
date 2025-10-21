

SELECT COUNT(OrderID)
  FROM [KCC].[dbo].[Orders]
  WHERE OrderDate >= '2022-02-01' AND OrderDate < '2022-03-01' AND CustomerID = 4;

--This returns a count of orders from anytime in March.