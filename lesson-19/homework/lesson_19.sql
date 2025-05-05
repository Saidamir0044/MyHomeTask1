-- 🔵 PART 1: STORED PROCEDURES

-- 📄 Task 1: Bonus hisoblovchi procedure
CREATE OR ALTER PROCEDURE GetEmployeeBonus
AS
BEGIN
    CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(100),
        Department NVARCHAR(50),
        Salary DECIMAL(10,2),
        BonusAmount DECIMAL(10,2)
    );

    INSERT INTO #EmployeeBonus
    SELECT 
        e.EmployeeID,
        CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
        e.Department,
        e.Salary,
        e.Salary * db.BonusPercentage / 100 AS BonusAmount
    FROM Employees e
    JOIN DepartmentBonus db ON e.Department = db.Department;

    SELECT * FROM #EmployeeBonus;
END;

-- 📄 Task 2: Department bo‘yicha oylik oshiruvchi procedure
CREATE OR ALTER PROCEDURE UpdateDepartmentSalary
    @Dept NVARCHAR(50),
    @Increase DECIMAL(5,2)
AS
BEGIN
    UPDATE Employees
    SET Salary = Salary * (1 + @Increase / 100)
    WHERE Department = @Dept;

    SELECT * FROM Employees WHERE Department = @Dept;
END;


-- 🔵 PART 2: MERGE & Other Tasks

-- 📄 Task 3: MERGE Products_Current with Products_New
MERGE Products_Current AS target
USING Products_New AS source
ON target.ProductID = source.ProductID
WHEN MATCHED THEN 
    UPDATE SET 
        target.ProductName = source.ProductName,
        target.Price = source.Price
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (source.ProductID, source.ProductName, source.Price)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

-- Show final state
SELECT * FROM Products_Current;

-- 📄 Task 4: Tree Node Type
SELECT 
    id,
    CASE 
        WHEN p_id IS NULL THEN 'Root'
        WHEN id IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM Tree;

-- 📄 Task 5: Confirmation Rate
SELECT 
    s.user_id,
    ROUND(
        COALESCE(SUM(CASE WHEN c.action = 'confirmed' THEN 1.0 ELSE 0 END), 0)
        / NULLIF(COUNT(c.user_id), 0), 2
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id;

-- 📄 Task 6: Employees with the lowest salary
SELECT * 
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

-- 📄 Task 7: GetProductSalesSummary procedure
CREATE OR ALTER PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantitySold,
        SUM(s.Quantity * p.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName;
END;
