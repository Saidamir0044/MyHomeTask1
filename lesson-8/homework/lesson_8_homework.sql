-- 1. INNER JOIN Customers and Orders to get CustomerName and OrderDate
SELECT Customers.CustomerName, Orders.OrderDate
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 2. One-to-One relationship between EmployeeDetails and Employees
SELECT Employees.EmployeeID, Employees.Name, EmployeeDetails.Address
FROM Employees
INNER JOIN EmployeeDetails ON Employees.EmployeeID = EmployeeDetails.EmployeeID;

-- 3. INNER JOIN Products and Categories to show ProductName and CategoryName
SELECT Products.ProductName, Categories.CategoryName
FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID;

-- 4. LEFT JOIN Customers and Orders to show all Customers and their OrderDate
SELECT Customers.CustomerName, Orders.OrderDate
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 5. Many-to-Many relationship between Orders and Products via OrderDetails
SELECT Orders.OrderID, Products.ProductName, OrderDetails.Quantity
FROM Orders
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID;

-- 6. CROSS JOIN between Products and Categories
SELECT Products.ProductName, Categories.CategoryName
FROM Products
CROSS JOIN Categories;

-- 7. One-to-Many relationship between Customers and Orders
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 8. Filter CROSS JOIN result where OrderAmount > 500
SELECT Products.ProductName, Orders.OrderAmount
FROM Products
CROSS JOIN Orders
WHERE Orders.OrderAmount > 500;

-- 9. INNER JOIN Employees and Departments
SELECT Employees.Name, Departments.DepartmentName
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;

-- 10. ON clause with <> to join two tables where values are not equal
SELECT A.Column1, B.Column2
FROM TableA A
INNER JOIN TableB B ON A.Column1 <> B.Column2;

-- 11. One-to-Many relationship showing total orders per customer
SELECT Customers.CustomerName, COUNT(Orders.OrderID) AS TotalOrders
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName;

-- 12. Many-to-Many between Students and Courses via StudentCourses
SELECT Students.StudentName, Courses.CourseName
FROM Students
INNER JOIN StudentCourses ON Students.StudentID = StudentCourses.StudentID
INNER JOIN Courses ON StudentCourses.CourseID = Courses.CourseID;

-- 13. CROSS JOIN Employees and Departments, filter Salary > 5000
SELECT Employees.Name, Departments.DepartmentName
FROM Employees
CROSS JOIN Departments
WHERE Employees.Salary > 5000;

-- 14. One-to-One Employee and EmployeeDetails
SELECT Employees.Name, EmployeeDetails.Details
FROM Employees
INNER JOIN EmployeeDetails ON Employees.EmployeeID = EmployeeDetails.EmployeeID;

-- 15. INNER JOIN Products and Suppliers, filter Supplier 'A'
SELECT Products.ProductName
FROM Products
INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE Suppliers.SupplierName = 'Supplier A';

-- 16. LEFT JOIN Products and Sales, show products with no sales
SELECT Products.ProductName, Sales.Quantity
FROM Products
LEFT JOIN Sales ON Products.ProductID = Sales.ProductID;

-- 17. Employees with salary > 4000 in 'HR' department
SELECT Employees.Name
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
WHERE Employees.Salary > 4000 AND Departments.DepartmentName = 'HR';

-- 18. Use >= in ON clause
SELECT A.Column1, B.Column2
FROM TableA A
INNER JOIN TableB B ON A.Value >= B.Value;

-- 19. INNER JOIN Products and Suppliers, filter price >= 50
SELECT Products.ProductName, Suppliers.SupplierName
FROM Products
INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE Products.Price >= 50;

-- 20. CROSS JOIN Sales and Regions, filter Sales > 1000
SELECT Sales.SaleID, Regions.RegionName
FROM Sales
CROSS JOIN Regions
WHERE Sales.Amount > 1000;

-- 21. Many-to-Many Authors and Books via AuthorBooks
SELECT Authors.AuthorName, Books.BookTitle
FROM Authors
INNER JOIN AuthorBooks ON Authors.AuthorID = AuthorBooks.AuthorID
INNER JOIN Books ON AuthorBooks.BookID = Books.BookID;

-- 22. INNER JOIN Products and Categories, filter CategoryName != 'Electronics'
SELECT Products.ProductName
FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Categories.CategoryName != 'Electronics';

-- 23. CROSS JOIN Orders and Products, filter quantity > 100
SELECT Orders.OrderID, Products.ProductName
FROM Orders
CROSS JOIN Products
WHERE Products.Quantity > 100;

-- 24. Employees who worked for over 5 years
SELECT Employees.Name
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
WHERE Employees.YearsOfService > 5;

-- 25. Difference between INNER JOIN and LEFT JOIN
SELECT Employees.Name, Departments.DepartmentName
FROM Employees
LEFT JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;

-- 26. CROSS JOIN Products and Suppliers, filter Category 'A'
SELECT Products.ProductName, Suppliers.SupplierName
FROM Products
CROSS JOIN Suppliers
WHERE Products.Category = 'Category A';

-- 27. One-to-Many Orders and Customers, filter customers with >= 10 orders
SELECT Customers.CustomerName, COUNT(Orders.OrderID) AS TotalOrders
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName
HAVING COUNT(Orders.OrderID) >= 10;

-- 28. Many-to-Many Courses and Students with COUNT
SELECT Courses.CourseName, COUNT(StudentCourses.StudentID) AS TotalStudents
FROM Courses
INNER JOIN StudentCourses ON Courses.CourseID = StudentCourses.CourseID
GROUP BY Courses.CourseName;

-- 29. LEFT JOIN Employees and Departments, filter 'Marketing' department
SELECT Employees.Name
FROM Employees
LEFT JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
WHERE Departments.DepartmentName = 'Marketing';

-- 30. Use <= in ON clause
SELECT A.Column1, B.Column2
FROM TableA A
INNER JOIN TableB B ON A.Value <= B.Value;
