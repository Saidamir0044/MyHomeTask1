-- 1. Combine Two Tables
SELECT p.firstName, p.lastName, a.city, a.state
FROM Person p
LEFT JOIN Address a ON p.personId = a.personId;

-- 2. Employees Earning More Than Their Managers
SELECT e.name AS Employee
FROM Employee e
JOIN Employee m ON e.managerId = m.id
WHERE e.salary > m.salary;

-- 3. Duplicate Emails
SELECT email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;

-- 4. Delete Duplicate Emails (faqat birinchi yozuvni qoldiradi)
DELETE FROM Person
WHERE id NOT IN (
  SELECT MIN(id)
  FROM Person
  GROUP BY email
);

-- 5. Parents Who Have Only Girls
SELECT DISTINCT g.ParentName
FROM girls g
WHERE g.ParentName NOT IN (
  SELECT DISTINCT ParentName FROM boys
);

-- 6. Total over 50 and Least (Sales.Orders table)
SELECT customerid,
       SUM(salesamount) AS TotalSales,
       MIN(orderweight) AS LeastWeight
FROM Sales.Orders
WHERE orderweight > 50
GROUP BY customerid;

-- 7. Carts Comparison
SELECT 
  c1.Item AS [Item Cart 1],
  c2.Item AS [Item Cart 2]
FROM Cart1 c1
FULL OUTER JOIN Cart2 c2
ON c1.Item = c2.Item;

-- 8. Matches - Winner or Draw
SELECT MatchID, Match, Score,
       CASE 
         WHEN CAST(LEFT(Score, CHARINDEX(':', Score)-1) AS INT) >
              CAST(SUBSTRING(Score, CHARINDEX(':', Score)+1, LEN(Score)) AS INT)
           THEN LEFT(Match, CHARINDEX('-', Match)-1)
         WHEN CAST(LEFT(Score, CHARINDEX(':', Score)-1) AS INT) <
              CAST(SUBSTRING(Score, CHARINDEX(':', Score)+1, LEN(Score)) AS INT)
           THEN SUBSTRING(Match, CHARINDEX('-', Match)+1, LEN(Match))
         ELSE 'Draw'
       END AS ScoreResult
FROM match1;

-- 9. Customers Who Never Order
SELECT name AS Customers
FROM Customers
WHERE id NOT IN (
  SELECT customerId FROM Orders
);

-- 10. Students and Examinations
SELECT s.student_id, s.student_name, sub.subject_name,
       COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
  ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
