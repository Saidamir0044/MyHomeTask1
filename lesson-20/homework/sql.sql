-- 1. Customers who purchased in March 2024 using EXISTS
SELECT DISTINCT CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1 FROM #Sales s2
    WHERE s1.CustomerName = s2.CustomerName
    AND SaleDate >= '2024-03-01' AND SaleDate < '2024-04-01'
);

-- 2. Product with highest total revenue
SELECT Product
FROM #Sales
GROUP BY Product
HAVING SUM(Quantity * Price) = (
    SELECT MAX(TotalRevenue)
    FROM (
        SELECT Product, SUM(Quantity * Price) AS TotalRevenue
        FROM #Sales
        GROUP BY Product
    ) AS RevenueSub
);

-- 3. Second highest sale amount
SELECT MAX(SaleAmount) AS SecondHighest
FROM (
    SELECT Quantity * Price AS SaleAmount
    FROM #Sales
    WHERE Quantity * Price < (
        SELECT MAX(Quantity * Price) FROM #Sales
    )
) AS Sub;

-- 4. Total quantity sold per month
SELECT FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth, SUM(Quantity) AS TotalQuantity
FROM #Sales
GROUP BY FORMAT(SaleDate, 'yyyy-MM');

-- 5. Customers who bought same products as others
SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1 FROM #Sales s2
    WHERE s1.Product = s2.Product
    AND s1.CustomerName <> s2.CustomerName
);

-- 6. Fruit count per person
SELECT 
    Name,
    SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
    SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
    SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;

-- 7. Older people in family tree
WITH RecursiveFamily AS (
    SELECT ParentId, ChildId FROM Family
    UNION ALL
    SELECT f.ParentId, r.ChildId
    FROM Family f
    JOIN RecursiveFamily r ON f.ParentId = r.ChildId
)
SELECT * FROM RecursiveFamily;

-- 8. Orders in TX for customers who had CA delivery
SELECT *
FROM #Orders o1
WHERE DeliveryState = 'TX'
AND EXISTS (
    SELECT 1 FROM #Orders o2
    WHERE o1.CustomerID = o2.CustomerID AND o2.DeliveryState = 'CA'
);

-- 9. Insert names into address if missing
UPDATE #residents
SET address = CONCAT(address, ' name=', fullname)
WHERE address NOT LIKE '%name=%';

-- 10. Routes from Tashkent to Khorezm
WITH RouteCTE AS (
    SELECT DepartureCity, ArrivalCity, Cost, CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(MAX)) AS Route
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'
    UNION ALL
    SELECT r.DepartureCity, c.ArrivalCity, r.Cost + c.Cost, CAST(r.Route + ' - ' + c.ArrivalCity AS VARCHAR(MAX))
    FROM RouteCTE r
    JOIN #Routes c ON r.ArrivalCity = c.DepartureCity
    WHERE r.Route NOT LIKE '%'+c.ArrivalCity
)
SELECT Route, Cost FROM RouteCTE
WHERE ArrivalCity = 'Khorezm';

-- 11. Rank product groups
WITH CTE AS (
    SELECT *, SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) OVER (ORDER BY ID) AS grp
    FROM #RankingPuzzle
)
SELECT * FROM CTE;

-- 12. Employees with above average department sales
SELECT * FROM #EmployeeSales e
WHERE SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = e.Department
);

-- 13. Employees with highest monthly sales
SELECT DISTINCT e1.EmployeeName
FROM #EmployeeSales e1
WHERE EXISTS (
    SELECT 1 FROM #EmployeeSales e2
    WHERE e2.SalesMonth = e1.SalesMonth AND e2.SalesYear = e1.SalesYear
    GROUP BY e2.SalesMonth, e2.SalesYear
    HAVING MAX(SalesAmount) = e1.SalesAmount
);

-- 14. Employees who made sales in every month
SELECT DISTINCT e1.EmployeeName
FROM #EmployeeSales e1
WHERE NOT EXISTS (
    SELECT 1 FROM (
        SELECT DISTINCT SalesMonth FROM #EmployeeSales
    ) months
    WHERE NOT EXISTS (
        SELECT 1 FROM #EmployeeSales e2
        WHERE e2.EmployeeName = e1.EmployeeName AND e2.SalesMonth = months.SalesMonth
    )
);

-- 15. Products more expensive than average
SELECT Name
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

-- 16. Products with stock lower than highest
SELECT Name
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);

-- 17. Products in same category as Laptop
SELECT Name
FROM Products
WHERE Category = (
    SELECT Category FROM Products WHERE Name = 'Laptop'
);

-- 18. Products more expensive than lowest in Electronics
SELECT Name
FROM Products
WHERE Price > (
    SELECT MIN(Price) FROM Products WHERE Category = 'Electronics'
);

-- 19. Products above category average price
SELECT Name
FROM Products p
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
    WHERE Category = p.Category
);

-- 20. Products that have been ordered at least once
SELECT DISTINCT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID;

-- 21. Products ordered more than average quantity
SELECT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
HAVING SUM(o.Quantity) > (
    SELECT AVG(TotalQty) FROM (
        SELECT SUM(Quantity) AS TotalQty FROM Orders GROUP BY ProductID
    ) q
);

-- 22. Products never ordered
SELECT Name
FROM Products
WHERE ProductID NOT IN (SELECT DISTINCT ProductID FROM Orders);

-- 23. Product with highest total quantity ordered
SELECT TOP 1 p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
ORDER BY SUM(o.Quantity) DESC;
