 create database lesson_11hw
--## Basic Level

--### Task 1: Basic INNER JOIN
--Question: Retrieve all employee names along with their corresponding department names.

--#### Table Schema:
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    DepartmentID INT
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);
#### Sample Data:
INSERT INTO Employees VALUES
(1, 'Alice', 101),
(2, 'Bob', 102),
(3, 'Charlie', NULL);

INSERT INTO Departments VALUES
(101, 'HR'),
(102, 'IT'),
(103, 'Finance');
--Task 1
select emp.*, dept.Departmentname from Employees emp
join Departments dept on dept.DepartmentID=emp.DepartmentID

### Task 2: LEFT JOIN
Question: List all students along with their class names, including students who are not assigned to any class.

#### Table Schema:
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    ClassID INT
);

CREATE TABLE Classes (
    ClassID INT PRIMARY KEY,
    ClassName VARCHAR(50)
);
#### Sample Data:
INSERT INTO Students VALUES
(1, 'John', 201),
(2, 'Emma', NULL),
(3, 'Liam', 202);

INSERT INTO Classes VALUES
(201, 'Math'),
(202, 'Science');
--Task2 
select stu.*, cla.classname from Students stu
left join Classes cla on cla.ClassID=stu.ClassID

### Task 3: RIGHT JOIN
Question: List all customers and their orders, including customers who haven’t placed any orders.

#### Table Schema:
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50)
);
#### Sample Data:
INSERT INTO Orders VALUES
(1, 301, '2024-11-01'),
(2, 302, '2024-11-05');

INSERT INTO Customers VALUES
(301, 'Alice'),
(302, 'Bob'),
(303, 'Charlie');
--Task3
select cus.*, ord.orderid, ord.orderdate from Orders ord
right join Customers cus on ord.CustomerID=cus.CustomerID


### Task 4: FULL OUTER JOIN
Question: Retrieve a list of all products and their sales, including products with no sales and sales with invalid product references.

#### Table Schema:
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT
);
#### Sample Data:
INSERT INTO Products VALUES
(1, 'Laptop'),
(2, 'Tablet'),
(3, 'Phone');

INSERT INTO Sales VALUES
(100, 1, 10),
(101, 2, 5),
(102, NULL, 8);
--Task4
select * from Sales s
full join Products p on p.ProductID=s.ProductID

### Task 5: SELF JOIN
Question: Find the names of employees along with the names of their managers.

#### Table Schema:
CREATE TABLE Employees1 (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    ManagerID INT
);
#### Sample Data:
INSERT INTO Employees1 VALUES
(1, 'Alice', NULL),
(2, 'Bob', 1),
(3, 'Charlie', 1),
(4, 'Diana', 2);
--Task5
select emp.EmployeeID, emp.Name, man.Name as Manager_Name from Employees1 emp
left join Employees1 man on emp.manageriD=man.EmployeeID

### Task 6: CROSS JOIN
Question: Generate all possible combinations of colors and sizes.

#### Table Schema:
CREATE TABLE Colors (
    ColorID INT PRIMARY KEY,
    ColorName VARCHAR(50)
);

CREATE TABLE Sizes (
    SizeID INT PRIMARY KEY,
    SizeName VARCHAR(50)
);
#### Sample Data:
INSERT INTO Colors VALUES
(1, 'Red'),
(2, 'Blue');

INSERT INTO Sizes VALUES
(1, 'Small'),
(2, 'Medium');
--Task6
select * from Colors 
cross join Sizes 

### Task 7: Join with WHERE Clause
Question: Find all movies released after 2015 and their associated actors.

#### Table Schema:
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(50),
    ReleaseYear INT
);

CREATE TABLE Actors (
    ActorID INT PRIMARY KEY,
    Name VARCHAR(50),
    MovieID INT
);
#### Sample Data:
INSERT INTO Movies VALUES
(1, 'Inception', 2010),
(2, 'Interstellar', 2014),
(3, 'Dune', 2021);

INSERT INTO Actors VALUES
(101, 'Leonardo DiCaprio', 1),
(102, 'Matthew McConaughey', 2),
(103, 'Timothée Chalamet', 3);
--Task7
select mov.*, act.name from Movies mov
join Actors act on act.MovieID=mov.MovieID
where ReleaseYear >2015

### Task 8: MULTIPLE JOINS
Question: Retrieve the order date, customer name, and the product ID for all orders.
select * from Orders1
select * from Customers1
select * from OrderDetails
#### Table Schema:
CREATE TABLE Orders1 (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE Customers1 (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT
);
#### Sample Data:
INSERT INTO Orders1 VALUES
(1, 401, '2024-11-01'),
(2, 402, '2024-11-05');

INSERT INTO Customers1 VALUES
(401, 'Alice'),
(402, 'Bob');

INSERT INTO OrderDetails VALUES
(1001, 1, 501),
(1002, 2, 502);
--Task8
select orde.orderdate, cust.customername, ord_d.productid from Orders1 orde
join Customers1 cust on cust.CustomerID=orde.CustomerID
join OrderDetails ord_d on ord_d.OrderID=orde.OrderID

### Task 9: JOIN with Aggregation
Question: Calculate the total revenue generated for each product.
select * from sales2
select * from Products2
#### Table Schema:
CREATE TABLE Sales2 (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT
);

CREATE TABLE Products2 (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10, 2)
);
#### Sample Data:
INSERT INTO Sales2 VALUES
(1, 601, 3),
(2, 602, 5),
(3, 601, 2);

INSERT INTO Products2 VALUES
(601, 'TV', 500.00),
(602, 'Speaker', 150.00);
--Task9
SELECT 
    p.ProductID, 
    p.ProductName, 
    SUM(s.Quantity * p.Price) AS TotalRevenue
FROM Sales2 s
JOIN Products2 p ON s.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName;
