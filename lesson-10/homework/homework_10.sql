--Tables
--1. Write a query to perform an INNER JOIN between Orders and Customers
--using AND in the ON clause to filter orders placed after 2022.
select * from Orders o
join Customers c on o.customerid=c.customerid and year(o.orderdate)>2022

--2. Write a query to join Employees and Departments using OR in the ON 
--clause to show employees in either the 'Sales' or 'Marketing' department.
select * from employees e
join departments d on e.departmentid=d.departmentid and (d.departmentname = 'sales' or d.departmentname = 'marketing')

--3. Write a query to demonstrate a CROSS APPLY between Departments and 
--a derived table that shows their Employees, top-performing employee 
--(e.g., top 1 Employee who gets the most salary).
select * from departments d
cross apply 
(select top 1 
name,
salary
from employees
where departmentid=d.departmentid
order by salary asc) a

--4. Write a query to join Customers and Orders using AND in the ON clause 
--to filter customers who have placed orders in 2023 and who lives in the USA.
select * from customers c
join orders o on c.customerid=o.customerid
and(year(orderdate)=2023 and c.country= 'usa')
--5. Write a query to join a derived table (SELECT CustomerID, COUNT(*) FROM Orders GROUP BY 
--CustomerID) with the Customers table to show the number of orders per customer.
SELECT 
    c.CustomerID, 
    c.firstName, 
    o.OrderCount
FROM Customers c
LEFT JOIN (
    SELECT CustomerID, COUNT(*) AS OrderCount
    FROM Orders
    GROUP BY CustomerID
) o ON c.CustomerID = o.CustomerID;

--6. Write a query to join Products and Suppliers using OR in the ON clause to show 
--products supplied by either 'Gadget Supplies' or 'Clothing Mart'.
select p.Productid, p.productname, s.suppliername from products p
join suppliers s on s.supplierid=p.supplierid
and(s.suppliername = 'Gadget Supplies' or s.suppliername ='Clothing Mart')

--7. Write a query to demonstrate the use of OUTER APPLY between Customers and 
--a derived table that returns each Customers''s most recent order.
select c.customerid, c.firstname, a.orderdate from customers c
outer apply 
(select top 1
customerid,
orderdate from orders
where customerid = c.customerid
order by orderdate asc) a

--8. Write a query that uses the AND logical operator in the ON clause to join Orders
--and Customers, and filter customers who placed an order with a total amount greater than 500.
select c.customerid, c.firstname, o.totalamount from customers c
join orders o on o.customerid=c.customerid 
and o.totalamount > 500

--9. Write a query that uses the OR logical operator in the ON clause to join Products
--and Sales to filter products that were either sold in 2022 or the SaleAmount is more than 400.
select p.productid, p.productname, s.saledate, s.saleamount from products p
join sales s on s.productid=p.productid
and(year (s.saledate)=2022 or s.saleamount > 400)

--10. Write a query to join a derived table that calculates the total sales (SELECT ProductID, SUM(Amount)
--FROM Sales GROUP BY ProductID) with the Products table to show total sales for each product.
select p.productid, p.productname, a.totalsale from products p
cross apply
(select s.ProductID, SUM(s.saleAmount) as totalsale
from sales s
where s.productid=p.productid
group by s.productid) a 

--11. Write a query to join Employees and Departments using AND in the ON clause to filter
--employees who belong to the 'HR' department and whose salary is greater than 50000.
SELECT 
    e.EmployeeID, 
    e.EmployeeName, 
    e.Salary, 
    d.DepartmentName
FROM Employees e
JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID 
    AND (d.DepartmentName = 'HR' 
    AND e.Salary > 50000);

--12. Write a query to use OUTER APPLY to return all customers along with their most 
--recent orders, including customers who have not placed any orders.
select c.customerid, c.firstname, a.orderdate from customers c
outer apply 
(select top 1 
o.orderdate 
from orders o
where o.customerid=c.customerid
order by orderdate asc) a

--13. Write a query to join Products and Sales using AND in the ON clause to filter
--products that were sold in 2023 and StockQuantity is more than 50.
SELECT 
    p.ProductID, 
    p.ProductName, 
    p.StockQuantity, 
    s.SaleDate, 
    s.SaleAmount
FROM Products p
JOIN Sales s 
    ON p.ProductID = s.ProductID 
    AND (YEAR(s.SaleDate) = 2023 
    AND p.StockQuantity > 50);

--14. Write a query to join Employees and Departments using OR in the ON clause to 
--show employees who either belong to the 'Sales' department or hired after 2020.
SELECT 
    e.EmployeeID, 
    e.EmployeeName, 
    e.HireDate, 
    d.DepartmentName
FROM Employees e
JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID 
    OR d.DepartmentName = 'Sales' 
    OR YEAR(e.HireDate) > 2020;

--15. Write a query to demonstrate the use of the AND logical operator in the ON 
--clause between Orders and Customers, and filter orders made by customers who are 
--located in 'USA' and lives in an address that starts with 4 digits.
select * from customers c
join orders o on c.customerid=o.customerid
and(c.country= 'usa' and c.address like '[0-9][0-9][0-9][0-9]%')

--16. Write a query to demonstrate the use of OR in the ON clause when joining
--Products and Sales to show products that are either part of the 'Electronics' 
--category or Sale amount is greater than 350.
select p.productname, c.categoryname, s.saleamount from products p
join categories c on c.categoryid=p.category
join sales s on s.productid=p.productid
and(c.categoryname= 'Electronics' or s.saleamount>350)

--17. Write a query to join a derived table that returns a count of products per category 
--(SELECT CategoryID, COUNT(*) FROM Products GROUP BY CategoryID) with the Categories 
--table to show the count of products in each category.
SELECT 
    c.CategoryID, 
    c.CategoryName, 
    p.ProductCount
FROM Categories c
JOIN (
    SELECT CategoryID, COUNT(*) AS ProductCount 
    FROM Products 
    GROUP BY CategoryID
) p ON c.CategoryID = p.CategoryID;

--18. Write a query to join Orders and Customers using AND in the ON clause to show orders 
--where the customer is from 'Los Angeles' and the order amount is greater than 300.
SELECT 
    o.OrderID, o.OrderAmount, c.CustomerID, c.CustomerName, 
    c.City
FROM Orders o
JOIN Customers c 
    ON o.CustomerID = c.CustomerID 
    AND c.City = 'Los Angeles' 
    AND o.OrderAmount > 300;


--19. Write a query to join Employees and Departments using a complex OR condition in the 
--ON clause to show employees who are in the 'HR' or 'Finance' department, or have at 
--least 4 wowels in their name.
i can not
--20. Write a query to join Sales and Products using AND in the ON clause to filter products that have
--both a sales quantity greater than 100 and a price above 500.
select * from sales s
join products p on p.productid=s.productid
and(p.price> 500 and p.stockquantity>100)

--21. Write a query to join Employees and Departments using OR in the ON clause to show employees
--in either the 'Sales' or 'Marketing' department, and with a salary greater than 60000.
SELECT 
    e.EmployeeID, 
    e.Name, 
    e.Salary, 
    d.DepartmentName
FROM Employees e
JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID 
    and(d.DepartmentName ='Sales'or d.DepartmentName = 'Marketing' or  e.Salary > 60000);



