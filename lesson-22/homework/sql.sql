-- Easy Questions
-- 1. Compute Running Total Sales per Customer
SELECT *,
       SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS running_total
FROM sales_data;

-- 2. Count the Number of Orders per Product Category
SELECT *,
       COUNT(*) OVER (PARTITION BY product_category) AS orders_per_category
FROM sales_data;

-- 3. Find the Maximum Total Amount per Product Category
SELECT *,
       MAX(total_amount) OVER (PARTITION BY product_category) AS max_amount_in_category
FROM sales_data;

-- 4. Find the Minimum Price of Products per Product Category
SELECT *,
       MIN(unit_price) OVER (PARTITION BY product_category) AS min_price_in_category
FROM sales_data;

-- 5. Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)
SELECT *,
       AVG(total_amount) OVER (ORDER BY order_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg_3day
FROM sales_data;

-- 6. Find the Total Sales per Region
SELECT *,
       SUM(total_amount) OVER (PARTITION BY region) AS total_sales_region
FROM sales_data;

-- 7. Compute the Rank of Customers Based On Their Total Purchase Amount
SELECT customer_id, customer_name,
       SUM(total_amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(total_amount) DESC) AS spending_rank
FROM sales_data
GROUP BY customer_id, customer_name;

-- 8. Calculate the Difference Between Current and Previous Sale Amount per Customer
SELECT *,
       total_amount - LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS amount_diff
FROM sales_data;

-- 9. Find the Top 3 Most Expensive Products in Each Category
SELECT *
FROM (
    SELECT *,
           RANK() OVER (PARTITION BY product_category ORDER BY unit_price DESC) AS rnk
    FROM sales_data
) AS ranked
WHERE rnk <= 3;

-- 10. Compute the Cumulative Sum of Sales Per Region by Order Date
SELECT *,
       SUM(total_amount) OVER (PARTITION BY region ORDER BY order_date) AS cum_sales_region
FROM sales_data;

-- Medium Questions
-- 11. Compute Cumulative Revenue per Product Category
SELECT *,
       SUM(total_amount) OVER (PARTITION BY product_category ORDER BY order_date) AS cum_revenue_category
FROM sales_data;

-- 12. Sum of Previous Values to Current Value
SELECT *,
       SUM(Value) OVER (ORDER BY (SELECT NULL) ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS [Sum of Previous]
FROM OneColumn;

-- 13. Odd Row Number per Partition
WITH Numbered AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Vals) AS rn
  FROM Row_Nums
), Adjusted AS (
  SELECT *,
         ROW_NUMBER() OVER (ORDER BY Id, rn) * 2 - 1 AS RowNumber
  FROM Numbered
)
SELECT Id, Vals, RowNumber FROM Adjusted;

-- 14. Customers who purchased from more than one category
SELECT customer_id, customer_name
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1;

-- 15. Customers with Above-Average Spending in Their Region
WITH RegionalAvg AS (
    SELECT region, AVG(total_amount) AS avg_spending
    FROM sales_data
    GROUP BY region
)
SELECT s.customer_id, s.customer_name, s.region, s.total_amount
FROM sales_data s
JOIN RegionalAvg r ON s.region = r.region
WHERE s.total_amount > r.avg_spending;

-- 16. Rank customers based on total spending per region
SELECT customer_id, customer_name, region,
       SUM(total_amount) AS total_spent,
       RANK() OVER (PARTITION BY region ORDER BY SUM(total_amount) DESC) AS regional_rank
FROM sales_data
GROUP BY customer_id, customer_name, region;

-- 17. Running total for each customer
SELECT *,
       SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS cumulative_sales
FROM sales_data;

-- 18. Sales growth rate month-over-month
WITH MonthlySales AS (
    SELECT FORMAT(order_date, 'yyyy-MM') AS sale_month,
           SUM(total_amount) AS monthly_total
    FROM sales_data
    GROUP BY FORMAT(order_date, 'yyyy-MM')
), Growth AS (
    SELECT *,
           LAG(monthly_total) OVER (ORDER BY sale_month) AS prev_month_total
    FROM MonthlySales
)
SELECT sale_month, monthly_total,
       CAST((monthly_total - prev_month_total)*100.0 / NULLIF(prev_month_total, 0) AS DECIMAL(10,2)) AS growth_rate
FROM Growth;

-- 19. Customers whose total_amount is higher than their last order's
SELECT *,
       CASE WHEN total_amount > LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date)
            THEN 1 ELSE 0 END AS is_increased
FROM sales_data;

-- Hard Questions
-- 20. Products priced above average
SELECT *
FROM sales_data
WHERE unit_price > (SELECT AVG(unit_price) FROM sales_data);

-- 21. Group-wise total only for the first row
SELECT *,
       CASE WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1 THEN
            SUM(Val1 + Val2) OVER (PARTITION BY Grp) END AS Tot
FROM MyData;

-- 22. Cost and quantity aggregation logic
SELECT ID,
       SUM(Cost) AS Cost,
       SUM(CASE WHEN ROW_NUMBER() OVER (PARTITION BY ID, Quantity ORDER BY ID) = 1 THEN Quantity ELSE 0 END) AS Quantity
FROM TheSumPuzzle
GROUP BY ID;

-- 23. Find seat gaps
WITH Numbered AS (
  SELECT SeatNumber,
         ROW_NUMBER() OVER (ORDER BY SeatNumber) AS rn
  FROM Seats
), Grouped AS (
  SELECT *, SeatNumber - rn AS grp
  FROM Numbered
)
SELECT MIN(SeatNumber) + 1 AS [Gap Start], MAX(SeatNumber) - 1 AS [Gap End]
FROM (
    SELECT * FROM Grouped
    WHERE SeatNumber NOT IN (SELECT SeatNumber FROM Seats)
) AS t
GROUP BY grp
HAVING MAX(SeatNumber) - MIN(SeatNumber) > 1;

-- 24. Even Row Numbers per Partition
WITH Numbered AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Vals) AS rn
FROM Row_Nums
), Sorted AS (
  SELECT *, ROW_NUMBER() OVER (ORDER BY Id, rn) + 1 AS Changed
  FROM Numbered
)
SELECT Id, Vals, Changed FROM Sorted;
