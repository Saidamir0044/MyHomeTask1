--Ex1
;WITH CTE AS(
SELECT Product, Quantity, 1 AS Unit
    FROM Grouped
    WHERE Quantity >= 1
UNION ALL
SELECT Product, Quantity, Unit + 1
    FROM CTE
    WHERE Unit + 1 <= Quantity
)
SELECT Product, 1 AS Quantity
FROM CTE
ORDER BY Product;
--Ex2
;WITH CTE AS (
SELECT DISTINCT r.Region, d.Distributor
FROM 
    (SELECT DISTINCT Region FROM #RegionSales) r
CROSS JOIN
    (SELECT DISTINCT Distributor FROM #RegionSales) d
)
SELECT CTE.Region, CTE.Distributor, ISNULL(R.Sales,0) FROM CTE LEFT JOIN #RegionSales R
ON CTE.Distributor=R.Distributor AND CTE.Region=R.Region
--Ex3
;WITH CTE AS(
SELECT  E2.name AS [NAME] , COUNT(E1.id) AS DirectReports
FROM Employee E1
LEFT JOIN Employee E2 ON E1.managerId = E2.id
GROUP BY E1.managerId, E2.name
HAVING COUNT(E1.id) >= 5
)
SELECT NAME FROM CTE
--Ex4
SELECT  
    P.product_name, 
    SUM(O.Unit) AS total_units
FROM Orders O 
JOIN Products P ON O.product_id = P.product_id
WHERE 
    O.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY 
    P.product_name
HAVING 
    SUM(O.Unit) >= 100;
--Ex5
SELECT 
    CustomerID,
    Vendor,
    COUNT(*) AS OrderCount,
    ROW_NUMBER() OVER (
      PARTITION BY CustomerID 
      ORDER BY COUNT(*) DESC
    ) AS rn
  FROM Orders1
  GROUP BY CustomerID, Vendor
)
SELECT 
  CustomerID,
  Vendor,
  OrderCount
FROM OrderCounts
WHERE rn = 1;
--Ex7
;WITH LocationCounts AS (
    SELECT 
        Device_id,
        Locations,
        COUNT(*) AS SIG_COUNT,
        ROW_NUMBER() OVER (
            PARTITION BY Device_id 
            ORDER BY COUNT(*) DESC
        ) AS RN
    FROM Device
    GROUP BY Device_id, Locations
),
DeviceSummary AS (
    SELECT 
        Device_id,
        COUNT(Locations) AS no_of_location,
        SUM(SIG_COUNT) AS no_of_signals
    FROM LocationCounts
    GROUP BY Device_id
),
TopLocations AS (
    SELECT 
        Device_id,
        Locations AS max_signal_location
    FROM LocationCounts
    WHERE RN = 1
)
SELECT 
    D.Device_id,
    D.no_of_location,
    T.max_signal_location,
    D.no_of_signals
FROM DeviceSummary D
JOIN TopLocations T ON D.Device_id = T.Device_id
ORDER BY D.Device_id;
--Ex8
;WITH CTE AS(
SELECT EmpID,EmpName, Salary,AVG(SALARY) OVER (PARTITION BY DEPTID) AS AVG_SALARY FROM Employee
)
SELECT EmpID,EmpName, Salary FROM CTE
WHERE AVG_SALARY<=Salary
ORDER BY EmpID
--Ex10
WITH PlatformData AS (
    SELECT 
        Spend_date,
        Platform,
        SUM(Amount) AS Total_Amount,
        COUNT(DISTINCT User_id) AS Total_users
    FROM Spending
    GROUP BY Spend_date, Platform
),
BothPlatforms AS (
    SELECT 
        Spend_date,
        'Both' AS Platform,
        SUM(Amount) AS Total_Amount,
        COUNT(DISTINCT CASE WHEN Platform = 'Mobile' AND EXISTS 
                            (SELECT 1 FROM Spending 
                             WHERE Spend_date = pd.Spend_date AND Platform = 'Desktop' 
                             AND User_id = pd.User_id) 
                            THEN pd.User_id END) AS Total_users
    FROM Spending pd
    GROUP BY Spend_date
)
SELECT Spend_date, 
       Platform, 
       Total_Amount, 
       Total_users
FROM PlatformData
UNION ALL
SELECT Spend_date, 
       Platform, 
       Total_Amount, 
       Total_users
FROM BothPlatforms
ORDER BY Spend_date, 
         FIELD(Platform, 'Mobile', 'Desktop', 'Both');














