-- 1. Assign a row number to each sale based on the SaleDate
SELECT *, ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM ProductSales;

-- 2. Rank products based on total quantity sold (no skipping ranks)
SELECT ProductName, SUM(Quantity) AS TotalQty,
       RANK() OVER (ORDER BY SUM(Quantity) DESC) AS ProductRank
FROM ProductSales
GROUP BY ProductName;

-- 3. Identify top sale for each customer based on SaleAmount
SELECT *
FROM (
    SELECT *,
           RANK() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rnk
    FROM ProductSales
) AS ranked
WHERE rnk = 1;

-- 4. Each sale's amount with the next sale amount
SELECT SaleID, SaleAmount,
       LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM ProductSales;

-- 5. Each sale's amount with the previous sale amount
SELECT SaleID, SaleAmount,
       LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSaleAmount
FROM ProductSales;

-- 6. Sales amounts greater than the previous sale's amount
SELECT *
FROM (
    SELECT *, LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevAmount
    FROM ProductSales
) AS t
WHERE SaleAmount > PrevAmount;

-- 7. Difference in sale amount from previous sale for every product
SELECT *,
       SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromPrev
FROM ProductSales;

-- 8. Percentage change between current and next sale
SELECT *,
       (1.0 * (LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount) / SaleAmount) * 100 AS PctChange
FROM ProductSales;

-- 9. Ratio of current to previous sale amount within same product
SELECT *,
       (1.0 * SaleAmount) / LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS RatioToPrev
FROM ProductSales;

-- 10. Difference from the first sale amount of that product
SELECT *,
       SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromFirst
FROM ProductSales;

-- 11. Sales increasing continuously per product
SELECT *
FROM (
    SELECT *,
           LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevAmount
    FROM ProductSales
) AS t
WHERE SaleAmount > PrevAmount;

-- 12. Running total (closing balance) of sales amounts
SELECT *,
       SUM(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM ProductSales;

-- 13. Moving average over last 3 sales
SELECT *,
       AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg3
FROM ProductSales;

-- 14. Difference between each sale and average sale amount
SELECT *,
       SaleAmount - AVG(SaleAmount) OVER () AS DiffFromAvg
FROM ProductSales;

-- EMPLOYEES1 TASKS
-- 1. Employees with same salary rank
SELECT *,
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees1;

-- 2. Top 2 highest salaries in each department
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS rnk
    FROM Employees1
) AS ranked
WHERE rnk <= 2;

-- 3. Lowest-paid employee in each department
SELECT *
FROM (
    SELECT *,
           RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS rnk
    FROM Employees1
) AS ranked
WHERE rnk = 1;

-- 4. Running total of salaries in each department
SELECT *,
       SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS DeptRunningTotal
FROM Employees1;

-- 5. Total salary per department without GROUP BY
SELECT *,
       SUM(Salary) OVER (PARTITION BY Department) AS DeptTotal
FROM Employees1;

-- 6. Average salary per department without GROUP BY
SELECT *,
       AVG(Salary) OVER (PARTITION BY Department) AS DeptAvg
FROM Employees1;

-- 7. Salary difference from department average
SELECT *,
       Salary - AVG(Salary) OVER (PARTITION BY Department) AS DiffFromDeptAvg
FROM Employees1;

-- 8. Moving average salary over 3 employees
SELECT *,
       AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvg3
FROM Employees1;

-- 9. Sum of salaries for last 3 hired employees
SELECT *
FROM (
    SELECT *,
           SUM(Salary) OVER (ORDER BY HireDate DESC ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS Last3Sum
    FROM Employees1
) AS t;
