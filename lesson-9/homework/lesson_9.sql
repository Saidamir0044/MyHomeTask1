--Easy leve
--Ex1

select e.name, e.Salary from Employees e
join Departments d on e.DepartmentID=d.DepartmentID
where e.Salary > 5000;

--Ex2

select c.firstname, o.OrderDate from Customers c
join Orders o on c.CustomerID=o.CustomerID
where year(o.OrderDate) = 2023;

--Ex3

select e.name, d.departmentname from Employees e
left join Departments d on e.DepartmentID=d.DepartmentID;

--Ex4

select s.*, p.productname from Suppliers s
right join Products p on s.SupplierID=p.SupplierID;

--Ex5

select * from Orders o
full join Payments p on o.OrderID=p.OrderID

--Ex6

select a.Name, b.Name from Employees a
join Employees b on a.DepartmentID=b.ManagerID

--Ex7

select s.name, c.coursename from Enrollments e
join Students s on e.StudentID=s.StudentID
join Courses c on e.courseid=c.CourseID
where c.CourseName = 'math 101'

--Ex8

select c.firstname, c.lastname, o.quantity from Customers c
join Orders o on c.CustomerID=o.CustomerID
where [Quantity] >=3

--Ex9

select e.*, d.departmentname from Employees e
left join Departments d on e.DepartmentID=d.DepartmentID
where d.DepartmentName ='human resources'


--Medium level
--Ex10
SELECT d.DepartmentID, d.DepartmentName, COUNT(e.EmployeeID) AS EmployeeCount FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentID, d.DepartmentName
HAVING COUNT(e.EmployeeID) > 10;

--Ex11  
SELECT p.*
FROM Products p
LEFT OUTER JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.SaleID IS NULL;

--Ex12  
SELECT c.CustomerID, c.CustomerName, COUNT(o.OrderID) AS OrderCount
FROM Customers c
RIGHT OUTER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(o.OrderID) > 0;

--Ex13  
SELECT e.*, d.*
FROM Employees e
FULL OUTER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentID IS NOT NULL;

--Ex14
SELECT e1.EmployeeID AS EmployeeID, e1.EmployeeName AS Employee, 
       e2.EmployeeID AS ManagerID, e2.EmployeeName AS Manager
FROM Employees e1
JOIN Employees e2 ON e1.ManagerID = e2.EmployeeID;

--Ex15  
SELECT o.*, c.*
FROM Orders o
LEFT OUTER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 2022;

--Ex16  
SELECT e.*
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID AND d.DepartmentName = 'Sales'
WHERE e.Salary > 5000;

--Ex17  
SELECT e.*
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'IT';

--Ex18  
SELECT o.*, p.*
FROM Orders o
FULL OUTER JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NOT NULL;

--Ex19 
SELECT p.*
FROM Products p
LEFT OUTER JOIN Orders o ON p.ProductID = o.ProductID
WHERE o.OrderID IS NULL;


--Hard level
--Ex20

select * from Employees e
join Departments d on e.DepartmentID=d.DepartmentID
where e.Salary > ( select AVG(salary) from Employees)

--Ex21

select * from Orders o
left join Payments p on o.OrderID=p.OrderID
where year(o.OrderDate)<2020
and p.PaymentDate is null;

--Ex22

select * from Products p
full join Categories c on p.Category=c.CategoryID
where c.CategoryID is null

--Ex23

select a.Name, b.Name, a.Salary from Employees a
join Employees b on a.DepartmentID=b.ManagerID
where a.Salary>5000

--Ex24

SELECT e.*, d.*
FROM Employees e
RIGHT OUTER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName LIKE 'M%';

--Ex25

SELECT p.*, s.*
FROM Products p
INNER JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.SaleAmount > 1000;

--Ex26

SELECT s.*
FROM Students s
LEFT OUTER JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT OUTER JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName IS NULL OR c.CourseName <> 'Math 101';

--Ex27

SELECT o.*, p.*
FROM Orders o
FULL OUTER JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NOT NULL;

--Ex28

SELECT p.*, c.*
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture');
