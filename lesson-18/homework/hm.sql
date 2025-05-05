-- 1. Create Temporary Table: MonthlySales
SELECT 
    p.ProductID,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(s.Quantity * p.Price) AS TotalRevenue
INTO #MonthlySales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE FORMAT(s.SaleDate, 'yyyy-MM') = FORMAT(GETDATE(), 'yyyy-MM')
GROUP BY p.ProductID;

-- 2. Create View: vw_ProductSalesSummary
IF OBJECT_ID('vw_ProductSalesSummary', 'V') IS NOT NULL DROP VIEW vw_ProductSalesSummary;
GO
CREATE VIEW vw_ProductSalesSummary AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    SUM(s.Quantity) AS TotalQuantitySold
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category;

-- 3. Scalar Function: fn_GetTotalRevenueForProduct
IF OBJECT_ID('fn_GetTotalRevenueForProduct') IS
