-- 1. ProductName ustuniga Name deb alias berish
SELECT ProductName AS Name FROM Products;

-- 2. Customers jadvaliga Client deb alias berish
SELECT * FROM Customers AS Client;

-- 3. UNION yordamida Products va Products_Discontinued birlashtirish
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discontinued;

-- 4. Products va Products_Discontinued kesishmasini topish
SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM Products_Discontinued;

-- 5. UNION ALL bilan Products va Orders ni birlashtirish
SELECT * FROM Products
UNION ALL
SELECT * FROM Orders;

-- 6. Takrorlanmas mijoz ismlarini va ularning mamlakatlarini tanlash
SELECT DISTINCT CustomerName, Country FROM Customers;

-- 7. Narxga qarab 'High' yoki 'Low' ko‘rsatadigan ustun yaratish
SELECT ProductName, Price, 
       CASE WHEN Price > 100 THEN 'High' ELSE 'Low' END AS PriceCategory
FROM Products;

-- 8. Xodimlarni bo‘lim bo‘yicha filtrlash va mamlakat bo‘yicha guruhlash
SELECT DepartmentID, Country, COUNT(EmployeeID) AS EmployeeCount
FROM Employees
GROUP BY DepartmentID, Country;

-- 9. Har bir kategoriya bo‘yicha mahsulotlar sonini topish
SELECT CategoryID, COUNT(ProductID) AS ProductCount
FROM Products
GROUP BY CategoryID;

-- 10. Ombordagi miqdor 100 dan ko‘p bo‘lsa 'Yes', aks holda 'No' qaytarish
SELECT ProductName, Stock,
       IIF(Stock > 100, 'Yes', 'No') AS InStock
FROM Products;

-- 11. Orders va Customers jadvalini INNER JOIN bilan bog‘lash va alias berish
SELECT o.OrderID, c.CustomerName AS ClientName
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID;

-- 12. Products va OutOfStock birlashtirish
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM OutOfStock;

-- 13. EXCEPT yordamida Products va DiscontinuedProducts farqini topish
SELECT ProductName FROM Products
EXCEPT
SELECT ProductName FROM DiscontinuedProducts;

-- 14. Buyurtma soniga qarab mijozning maqomini chiqarish
SELECT CustomerID, 
       CASE WHEN COUNT(OrderID) > 5 THEN 'Eligible' ELSE 'Not Eligible' END AS Status
FROM Orders
GROUP BY CustomerID;

-- 15. Narxga qarab 'Expensive' yoki 'Affordable' qaytarish
SELECT ProductName, Price, 
       IIF(Price > 100, 'Expensive', 'Affordable') AS PriceCategory
FROM Products;

-- 16. Har bir mijoz uchun buyurtmalar sonini sanash
SELECT CustomerID, COUNT(OrderID) AS OrderCount
FROM Orders
GROUP BY CustomerID;

-- 17. Xodimlar orasidan yoshligi 25 dan kichik yoki maoshi 6000 dan yuqori bo‘lganlarni topish
SELECT * FROM Employees
WHERE Age < 25 OR Salary > 6000;

-- 18. Sales jadvalidan mintaqa bo‘yicha jami savdolarni chiqarish
SELECT Region, SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY Region;

-- 19. Customers va Orders jadvalini LEFT JOIN bilan bog‘lash va alias berish
SELECT c.CustomerID, c.CustomerName, o.OrderDate AS Order_Date
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 20. Xodimning bo‘limiga qarab maoshini 10% oshirish
UPDATE Employees
SET Salary = Salary * 1.1
WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'HR');

-- 21. Sales va Returns jadvalini UNION ALL bilan birlashtirish va natijani hisoblash
SELECT ProductID, SUM(SalesAmount) AS TotalAmount, 'Sales' AS Type FROM Sales
GROUP BY ProductID
UNION ALL
SELECT ProductID, SUM(ReturnAmount) AS TotalAmount, 'Returns' AS Type FROM Returns
GROUP BY ProductID;

-- 22. Products va DiscontinuedProducts kesishmasini topish
SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM DiscontinuedProducts;

-- 23. Savdolarni darajalarga ajratish
SELECT CustomerID, TotalSales,
       CASE WHEN TotalSales > 10000 THEN 'Top Tier'
            WHEN TotalSales BETWEEN 5000 AND 10000 THEN 'Mid Tier'
            ELSE 'Low Tier' END AS SalesCategory
FROM (SELECT CustomerID, SUM(SalesAmount) AS TotalSales FROM Sales GROUP BY CustomerID) AS SalesData;

-- 24. Xodimlarning maoshini ma’lum kriteriyalarga ko‘ra o‘zgartirish
DECLARE @EmpID INT
DECLARE cursor_emp CURSOR FOR SELECT EmployeeID FROM Employees;
OPEN cursor_emp;
FETCH NEXT FROM cursor_emp INTO @EmpID;
WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE Employees SET Salary = Salary * 1.05 WHERE EmployeeID = @EmpID;
    FETCH NEXT FROM cursor_emp INTO @EmpID;
END;
CLOSE cursor_emp;
DEALLOCATE cursor_emp;

-- 25. Buyurtma bergan, lekin hisob-fakturasi mavjud bo‘lmagan mijozlarni topish
SELECT CustomerID FROM Orders
EXCEPT
SELECT CustomerID FROM Invoices;

-- 26. Har bir mijoz, mahsulot va mintaqa bo‘yicha jami savdolarni chiqarish
SELECT CustomerID, ProductID, Region, SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID, ProductID, Region;

-- 27. Sotib olingan miqdorga qarab chegirma belgilash
SELECT ProductID, Quantity, 
       CASE WHEN Quantity > 100 THEN '20% Discount'
            WHEN Quantity BETWEEN 50 AND 100 THEN '10% Discount'
            ELSE 'No Discount' END AS Discount
FROM Orders;

-- 28. INNER JOIN va UNION bilan mahsulotlarni birlashtirish
SELECT p.ProductID, p.ProductName, 'Available' AS Status
FROM Products p
INNER JOIN Inventory i ON p.ProductID = i.ProductID
UNION
SELECT d.ProductID, d.ProductName, 'Discontinued' AS Status
FROM DiscontinuedProducts d;

-- 29. Ombordagi mahsulotlar holatini belgilash
SELECT ProductID, Stock,
       IIF(Stock > 0, 'Available', 'Out of Stock') AS StockStatus
FROM Products;

-- 30. VIP mijozlar bo‘lmagan mijozlarni topish
SELECT CustomerID FROM Customers
EXCEPT
SELECT CustomerID FROM VIP_Customers;
