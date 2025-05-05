--Ex1
CREATE TABLE #MonthlySales (
    ProductID INT,
    ProductName VARCHAR(100),
    TotalQuantity INT,
    TotalRevenue DECIMAL(18,2)
);
INSERT INTO #MonthlySales (ProductID, ProductName, TotalQuantity, TotalRevenue)
SELECT 
    P.ProductID,
    P.ProductName,
    SUM(S.Quantity) AS TotalQuantity,
    SUM(S.Quantity * P.Price) AS TotalRevenue
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
WHERE 
    YEAR(S.SaleDate) = YEAR(GETDATE()) AND 
    MONTH(S.SaleDate) = MONTH(GETDATE())
GROUP BY 
    P.ProductID, P.ProductName;
--Ex2
CREATE VIEW vw_ProductSalesSummary AS
SELECT 
	P.ProductID,
	P.ProductName,
	P.Category,
	SUM(S.Quantity*P.Price) AS total_sales_quantity
FROM Products P JOIN Sales S ON P.ProductID=S.ProductID
GROUP BY ProductName, P.Category, P.ProductID
--Ex3
