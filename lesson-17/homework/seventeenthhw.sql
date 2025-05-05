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
-- 1. Report of all distributors and their sales by region
DROP TABLE IF EXISTS #RegionSales;
CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);

SELECT r.Region, rs.Distributor, 
       COALESCE(rs.Sales, 0) AS Sales
FROM (SELECT DISTINCT Region FROM #RegionSales) r
CROSS JOIN (SELECT DISTINCT Distributor FROM #RegionSales) rs
LEFT JOIN #RegionSales s ON r.Region = s.Region AND rs.Distributor = s.Distributor
ORDER BY r.Region, rs.Distributor;

-- 2. Managers with at least five direct reports
CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);

SELECT e.name
FROM Employee e
JOIN (
    SELECT managerId
    FROM Employee
    GROUP BY managerId
    HAVING COUNT(*) >= 5
) m ON e.id = m.managerId;

-- 3. Products with at least 100 units ordered in February 2020 and their total amount
CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;

-- 4. Vendor from which each customer has placed the most orders
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');

SELECT o.CustomerID, 
       (SELECT TOP 1 Vendor FROM Orders WHERE CustomerID = o.CustomerID GROUP BY Vendor ORDER BY SUM([Count]) DESC) AS Vendor
FROM Orders o
GROUP BY o.CustomerID;

-- 5. Check if a number is prime
DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @isPrime BIT = 1;

WHILE @i <= SQRT(@Check_Prime)
BEGIN
    IF @Check_Prime % @i = 0
    BEGIN
        SET @isPrime = 0;
        BREAK;
    END
    SET @i = @i + 1;
END

IF @isPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';

-- 6. Number of locations, location with most signals, and total signals for each device
CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');

SELECT Device_id, 
       COUNT(DISTINCT Locations) AS no_of_location,
       TOP 1 Locations AS max_signal_location,
       COUNT(*) AS no_of_signals
FROM Device
GROUP BY Device_id
ORDER BY no_of_signals DESC;

-- 7. Employees who earn more than the average salary in their department
CREATE TABLE Employee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);

SELECT EmpID, EmpName, Salary
FROM Employee e
WHERE e.Salary > (
    SELECT AVG(Salary) FROM Employee WHERE DeptID = e.DeptID
);

-- 8. Total winnings for the lottery drawing
WITH WinningTickets AS (
    SELECT TicketID, COUNT(DISTINCT Number) AS WinningCount
    FROM Tickets
    WHERE Number IN (25, 45, 78)
    GROUP BY TicketID
)
SELECT SUM(
           CASE 
               WHEN WinningCount = 3 THEN 100
               WHEN WinningCount > 0 THEN 10
               ELSE 0
           END
       ) AS TotalWinnings
FROM WinningTickets;

-- 9. Total number of users and total amount spent using mobile only, desktop only, and both
CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);

SELECT Spend_date, Platform, 
       SUM(Amount) AS Total_Amount, 
       COUNT(DISTINCT User_id) AS Total_users
FROM (
    SELECT User_id, Spend_date, Platform, Amount
    FROM Spending
    WHERE Platform = 'Mobile'
    UNION ALL
    SELECT User_id, Spend_date, Platform, Amount
    FROM Spending
    WHERE Platform = 'Desktop'
) AS combined
GROUP BY Spend_date, Platform
ORDER BY Spend_date;

-- 10. De-group the following data
DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);

SELECT Product, 1 AS Quantity
FROM Grouped
CROSS APPLY (SELECT TOP (Quantity) 1) AS n
ORDER BY Product;
