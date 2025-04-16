--Ex1
WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM Numbers
    WHERE n < 1000
)
SELECT * FROM Numbers
OPTION (MAXRECURSION 1000);

--Ex2
WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n *2
	FROM Numbers
    WHERE n < 1000
)
SELECT * FROM Numbers
OPTION (MAXRECURSION 1000);

--Ex3
SELECT E.FirstName, E.LastName, S.Totalsale FROM Employees E
JOIN (
	SELECT EmployeeID, SUM(SalesAmount) AS Totalsale
	FROM Sales
	GROUP BY EmployeeID
) AS S ON E.EmployeeID=S.EmployeeID

--Ex4 SELECT * FROM EMPLOYEES
WITH AvgSalaryCTE AS (
    SELECT AVG(Salary) AS AvgSalary
    FROM Employees
	
)
SELECT  AvgSalary
FROM AvgSalaryCTE;

--Ex5 SELECT * FROM SALES SELECT * FROM PRODUCTS
SELECT P.ProductName, S.Max_Sale FROM Products P 
JOIN (
	SELECT ProductID, MAX(SALESAMOUNT) AS Max_Sale 
	FROM Sales
	GROUP BY ProductID
) AS S ON P.ProductID=S.ProductID

--Ex6 SELECT * FROM SALES SELECT * FROM EMPLOYEES
;WITH CTE6 AS (
    SELECT EmployeeID, COUNT(SalesAmount) AS NUM_SALE
    FROM Sales
    GROUP BY EmployeeID
)
SELECT E.FirstName, E.LastName, CTE6.NUM_SALE
FROM CTE6
JOIN Employees E ON CTE6.EmployeeID = E.EmployeeID
WHERE CTE6.NUM_SALE > 5;

--Ex7  SELECT * FROM SALES SELECT * FROM PRODUCTS
;WITH CTE7 AS(
	SELECT ProductID, SUM(SalesAmount) AS SUM_SALE
	FROM Sales
	GROUP BY ProductID
)
SELECT P.ProductName, CTE7.ProductID, CTE7.SUM_SALE FROM CTE7
JOIN Products P ON P.ProductID=CTE7.ProductID
WHERE SUM_SALE > 500

--Ex8 SELECT * FROM EMPLOYEES
;WITH CTE8 AS (
    SELECT AVG(Salary) AS AvgSalary
    FROM Employees
)
SELECT E.*, CTE8.AvgSalary
FROM Employees E
CROSS JOIN CTE8
WHERE E.Salary > CTE8.AvgSalary;

--Ex9 SELECT * FROM SALES SELECT * FROM PRODUCTS
SELECT SUM(SalesCount) AS TotalProductsSold
FROM (
    SELECT ProductID, COUNT(*) AS SalesCount
    FROM Sales
    GROUP BY ProductID
) AS DerivedTable;

--Ex10
;WITH CTE6 AS (
    SELECT EmployeeID, COUNT(SalesAmount) AS NUM_SALE
    FROM Sales
    GROUP BY EmployeeID
)
SELECT E.FirstName, E.LastName, CTE6.NUM_SALE
FROM CTE6
LEFT JOIN Employees E ON CTE6.EmployeeID = E.EmployeeID
WHERE CTE6.EmployeeID IS NULL

-- 1. Recursive CTE to calculate factorials
DECLARE @n INT = 5;
WITH FactorialCTE AS (
    SELECT 1 AS Num, 1 AS Factorial
    UNION ALL
    SELECT Num + 1, Factorial * (Num + 1)
    FROM FactorialCTE
    WHERE Num + 1 <= @n
)
SELECT * FROM FactorialCTE;

-- 2. Recursive CTE to generate Fibonacci sequence
WITH FibonacciCTE AS (
    SELECT 1 AS Position, 0 AS Fib
    UNION ALL
    SELECT 2, 1
    UNION ALL
    SELECT Position + 1, Prev.Fib + Curr.Fib
    FROM FibonacciCTE AS Curr
    JOIN FibonacciCTE AS Prev ON Curr.Position = Prev.Position + 1
    WHERE Position + 1 <= 10
)
SELECT * FROM FibonacciCTE;

-- 3. Recursive CTE to split string into characters
DECLARE @str VARCHAR(100) = 'HELLO';
WITH StringSplit AS (
    SELECT 1 AS Pos, SUBSTRING(@str, 1, 1) AS Ch
    UNION ALL
    SELECT Pos + 1, SUBSTRING(@str, Pos + 1, 1)
    FROM StringSplit
    WHERE Pos + 1 <= LEN(@str)
)
SELECT * FROM StringSplit;

-- 4. Rank employees based on total sales
WITH SalesPerEmployee AS (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
), RankedEmployees AS (
    SELECT E.FirstName, E.LastName, S.TotalSales, RANK() OVER (ORDER BY S.TotalSales DESC) AS RankPos
    FROM SalesPerEmployee S
    JOIN Employees E ON S.EmployeeID = E.EmployeeID
)
SELECT * FROM RankedEmployees;

-- 5. Top 5 employees by number of orders using derived table
SELECT TOP 5 E.FirstName, E.LastName, S.NumOrders
FROM Employees E
JOIN (
    SELECT EmployeeID, COUNT(*) AS NumOrders
    FROM Sales
    GROUP BY EmployeeID
) S ON E.EmployeeID = S.EmployeeID
ORDER BY S.NumOrders DESC;

-- 6. Sales difference between current and previous month
WITH MonthlySales AS (
    SELECT FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY FORMAT(SaleDate, 'yyyy-MM')
), SalesDiff AS (
    SELECT SaleMonth, TotalSales,
           LAG(TotalSales) OVER (ORDER BY SaleMonth) AS PrevMonthSales
    FROM MonthlySales
)
SELECT *, TotalSales - PrevMonthSales AS Diff FROM SalesDiff;

-- 7. Sales per product category using derived table
SELECT PR.Category, SUM(S.SalesAmount) AS TotalSales
FROM (
    SELECT ProductID, SalesAmount
    FROM Sales
) S
JOIN Products PR ON PR.ProductID = S.ProductID
GROUP BY PR.Category;

-- 8. Rank products based on total sales in last year
WITH LastYearSales AS (
    SELECT ProductID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(YEAR, -1, GETDATE())
    GROUP BY ProductID
)
SELECT P.ProductName, LYS.TotalSales,
       RANK() OVER (ORDER BY LYS.TotalSales DESC) AS ProductRank
FROM LastYearSales LYS
JOIN Products P ON LYS.ProductID = P.ProductID;

-- 9. Employees with sales over $5000 per quarter
SELECT E.FirstName, E.LastName, Q.Quarter, Q.TotalSales
FROM (
    SELECT EmployeeID,
           DATEPART(QUARTER, SaleDate) AS Quarter,
           SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
) Q
JOIN Employees E ON Q.EmployeeID = E.EmployeeID
WHERE Q.TotalSales > 5000;

-- 10. Top 3 employees by sales in the last month using derived table
SELECT TOP 3 E.FirstName, E.LastName, S.TotalSales
FROM Employees E
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -1, GETDATE())
    GROUP BY EmployeeID
) S ON E.EmployeeID = S.EmployeeID
ORDER BY S.TotalSales DESC;

-- Difficult 1: Numbers 1 through n in increasing sequence (1, 12, 123...)
DECLARE @max INT = 5;
WITH NumCTE AS (
    SELECT 1 AS Num, CAST('1' AS VARCHAR(MAX)) AS Sequence
    UNION ALL
    SELECT Num + 1, Sequence + CAST(Num + 1 AS VARCHAR)
    FROM NumCTE
    WHERE Num + 1 <= @max
)
SELECT * FROM NumCTE;

-- Difficult 2: Top employees by sales in last 6 months
SELECT E.FirstName, E.LastName, S.TotalSales
FROM Employees E
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
) S ON E.EmployeeID = S.EmployeeID
ORDER BY S.TotalSales DESC;

-- Difficult 3: Running total not exceeding 10 or dropping below 0
WITH RunningTotalCTE AS (
    SELECT 1 AS Step, 5 AS Value
    UNION ALL
    SELECT Step + 1, CASE
        WHEN Value + 2 <= 10 THEN Value + 2
        ELSE Value - 3
    END
    FROM RunningTotalCTE
    WHERE Step < 10 AND Value BETWEEN 0 AND 10
)
SELECT * FROM RunningTotalCTE;

-- Difficult 4: Merge Schedule and Activity, fill missing with 'Work'
SELECT S.EmployeeID, S.TimeSlot,
       COALESCE(A.Activity, 'Work') AS Task
FROM Schedule S
LEFT JOIN Activity A ON S.EmployeeID = A.EmployeeID AND S.TimeSlot = A.TimeSlot;

-- Difficult 5: Complex query using both CTE and derived table
WITH DepartmentSales AS (
    SELECT E.DepartmentID, S.ProductID, SUM(S.SalesAmount) AS DeptTotal
    FROM Employees E
    JOIN Sales S ON E.EmployeeID = S.EmployeeID
    GROUP BY E.DepartmentID, S.ProductID
)
SELECT D.DepartmentName, P.ProductName, DS.DeptTotal
FROM DepartmentSales DS
JOIN Departments D ON D.DepartmentID = DS.DepartmentID
JOIN Products P ON P.ProductID = DS.ProductID;




 


