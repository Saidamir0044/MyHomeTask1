-------------------------
-- EASY TASKS
-------------------------

-- 1. Show matching and non-matching items
SELECT a.Item AS Cart1_Item, b.Item AS Cart2_Item
FROM #Cart1 a
FULL JOIN #Cart2 b ON a.Item = b.Item;

-- 2. Average number of days between executions for each workflow
SELECT 
    WorkFlow,
    AVG(DATEDIFF(DAY, LAG(ExecutionDate) OVER (PARTITION BY WorkFlow ORDER BY ExecutionDate), ExecutionDate)) AS AvgDaysBetween
FROM #ProcessLog
GROUP BY WorkFlow;

-- 3. Movies where Amitabh & Vinod acted together as Actor
SELECT DISTINCT m1.MName
FROM Movie m1
JOIN Movie m2 ON m1.MName = m2.MName
WHERE m1.AName = 'Amitabh' AND m1.Roles = 'Actor'
  AND m2.AName = 'Vinod' AND m2.Roles = 'Actor';

-- 4. Pivot customer phone numbers
SELECT 
    CustomerID,
    MAX(CASE WHEN [Type] = 'Cellular' THEN PhoneNumber END) AS Cellular,
    MAX(CASE WHEN [Type] = 'Work' THEN PhoneNumber END) AS Work,
    MAX(CASE WHEN [Type] = 'Home' THEN PhoneNumber END) AS Home
FROM #PhoneDirectory
GROUP BY CustomerID;

-- 5. Numbers divisible by 9 up to n
DECLARE @n INT = 100;
WITH Numbers AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num + 1 FROM Numbers WHERE num + 1 <= @n
)
SELECT num FROM Numbers
WHERE num % 9 = 0
OPTION (MAXRECURSION 0);

-- 6. Batch starts and end (line containing GO)
SELECT 
    bs.Batch, 
    bs.BatchStart, 
    MIN(bl.Line) AS BatchEnd
FROM #BatchStarts bs
JOIN #BatchLines bl ON bs.Batch = bl.Batch AND bl.Line >= bs.BatchStart
WHERE bl.Syntax = 'GO'
GROUP BY bs.Batch, bs.BatchStart;

-- 7. Running inventory balance
SELECT 
    InventoryDate,
    QuantityAdjustment,
    SUM(QuantityAdjustment) OVER (ORDER BY InventoryDate) AS RunningBalance
FROM #Inventory;

-- 8. 2nd highest salary
SELECT MIN(Salary) AS SecondHighest
FROM (
    SELECT DISTINCT Salary
    FROM NthHighest
    ORDER BY Salary DESC
    OFFSET 1 ROW FETCH NEXT 1 ROWS ONLY
) AS Ranked;

-- 9. Current and previous 2 years’ sales
SELECT 
    s1.[Year] AS CurrentYear,
    s1.Amount AS CurrentSales,
    (
        SELECT SUM(Amount) FROM #Sales s2 WHERE s2.[Year] = s1.[Year] - 1
    ) AS PreviousYearSales,
    (
        SELECT SUM(Amount) FROM #Sales s3 WHERE s3.[Year] = s1.[Year] - 2
    ) AS TwoYearsAgoSales
FROM (
    SELECT [Year], SUM(Amount) AS Amount FROM #Sales GROUP BY [Year]
) s1;

-------------------------
-- MEDIUM TASKS
-------------------------

-- 1. Boxes with same dimensions
SELECT b1.Box, b2.Box
FROM #Boxes b1
JOIN #Boxes b2 ON b1.Box < b2.Box
WHERE b
