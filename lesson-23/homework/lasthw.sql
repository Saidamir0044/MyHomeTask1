-- Total revenue generated from all sales
SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue FROM Sales;

-- Average unit price of products
SELECT AVG(UnitPrice) AS AverageUnitPrice FROM Sales;

-- Number of sales transactions recorded
SELECT COUNT(*) AS TotalTransactions FROM Sales;

-- Highest number of units sold in a single transaction
SELECT MAX(QuantitySold) AS MaxUnitsSold FROM Sales;

-- Number of products sold in each category
SELECT Category, SUM(QuantitySold) AS TotalSold FROM Sales GROUP BY Category;

-- Total revenue for each region
SELECT Region, SUM(QuantitySold * UnitPrice) AS TotalRevenuePerRegion FROM Sales GROUP BY Region;

-- Product that generated the highest total revenue
SELECT TOP 1 Product, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;

-- Running total of revenue ordered by sale date
SELECT SaleDate, 
       SUM(QuantitySold * UnitPrice) OVER (ORDER BY SaleDate) AS RunningTotalRevenue
FROM Sales
ORDER BY SaleDate;

-- Contribution of each category to total sales revenue
SELECT Category, 
       SUM(QuantitySold * UnitPrice) AS TotalRevenuePerCategory,
       (SUM(QuantitySold * UnitPrice) * 100.0 / (SELECT SUM(QuantitySold * UnitPrice) FROM Sales)) AS ContributionPercentage
FROM Sales
GROUP BY Category;

-- Sales with corresponding customer names
SELECT s.SaleID, s.Product, s.QuantitySold, s.UnitPrice, s.SaleDate, s.Region, c.CustomerName
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID;

-- Customers who have not made any purchases
SELECT c.CustomerID, c.CustomerName
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
WHERE s.SaleID IS NULL;

-- Total revenue generated from each customer
SELECT s.CustomerID, c.CustomerName, SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenueFromCustomer
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY s.CustomerID, c.CustomerName;

-- Customer who has contributed the most revenue
SELECT TOP 1 s.CustomerID, c.CustomerName, SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenueFromCustomer
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY s.CustomerID, c.CustomerName
ORDER BY TotalRevenueFromCustomer DESC;

-- Total sales per customer
SELECT s.CustomerID, c.CustomerName, COUNT(*) AS TotalSalesPerCustomer
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY s.CustomerID, c.CustomerName;

-- List all products that have been sold at least once
SELECT DISTINCT p.ProductName
FROM Products p
JOIN Sales s ON p.ProductName = s.Product
WHERE s.QuantitySold > 0;

-- Most expensive product in the Products table
SELECT TOP 1 ProductName, SellingPrice
FROM Products
ORDER BY SellingPrice DESC;

-- Products where the selling price is higher than the average selling price in their category
SELECT p.ProductName, p.SellingPrice, p.Category
FROM Products p
WHERE p.SellingPrice > (
    SELECT AVG(SellingPrice) FROM Products WHERE Category = p.Category
);
