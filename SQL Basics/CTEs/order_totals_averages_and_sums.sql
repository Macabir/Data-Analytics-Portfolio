SELECT TOP (1000) [OrderID]
      ,[OrderDate]
      ,[CustomerID]
      ,[OrderTotal]
  FROM [KCC].[dbo].[Orders];


/*

This was created as a little "Fun with CTEs" experiment. More importantly, we'll figure out how much each customer has spent on their average order.

The following is a common table expression which shows OrderID with a respective OrderTotal and,
CustomerID with a respective *average* order total, i.e.,
the average amount that a particular customer has spent per order.

CustomerID number 4 has the lowest average total while 2 has the highest.

*/

WITH temp_table1 AS (SELECT CustomerID, AVG(OrderTotal) AS average_order_total
   FROM [KCC].[dbo].[Orders]
   GROUP BY CustomerID)
SELECT o.OrderID, o.CustomerID, o.OrderTotal, avg.average_order_total
FROM [KCC].[dbo].[Orders] o
JOIN temp_table1 avg
ON o.CustomerID = avg.CustomerID;

-- Lists above-average OrderTotals, as well as their respective OrderIDs and CustomerIDs.

WITH TemporaryTable (AverageValue) AS (
  SELECT AVG(OrderTotal)
  FROM [KCC].[dbo].[Orders]
  )
SELECT OrderID, CustomerID, OrderTotal
FROM [KCC].[dbo].[Orders], TemporaryTable
WHERE Orders.OrderTotal > TemporaryTable.AverageValue;

/* 

  And in case you were wondering what the average OrderTotal was,
  the previous code above will not list orders with totals at or below this amount:

*/

SELECT AVG(OrderTotal)
  FROM [KCC].[dbo].[Orders];

/*

  But how much has each customer spent overall?

*/

WITH temp_table1 AS (SELECT CustomerID, SUM(OrderTotal) AS sum_order_total
   FROM [KCC].[dbo].[Orders]
   GROUP BY CustomerID)
SELECT o.OrderID, o.CustomerID, o.OrderTotal, sum.sum_order_total
FROM [KCC].[dbo].[Orders] o
JOIN temp_table1 sum
ON o.CustomerID = sum.CustomerID;

/*

  Looks like Park and Shop Convenience Stores spends the most -- over twice the amount Tres Delicious does.
  It succeeds ABC Groceries by about $2500. Meanwhile, ABC Groceries overtakes ACME Bites by less than $200.
  This difference clearly deviates from the others, which range in the thousands at smallest.

*/