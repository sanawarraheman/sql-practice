```sql
-- ==================================================
-- SQL PROJECT: CUSTOMER PURCHASE ANALYSIS
-- Database: operator_practice
-- Topics: GROUP BY, HAVING, JOIN, CTE,
--         CASE WHEN, SUBQUERY, WINDOW FUNCTIONS
-- Date: 5 November 2026
-- ==================================================

USE operator_practice;


-- 1. Display all sales records
SELECT *
FROM sales;


-- 2. Find total spending by each customer
SELECT
    customer_name,
    SUM(quantity * price) AS Total_Spending
FROM sales
GROUP BY customer_name
ORDER BY Total_Spending DESC;


-- 3. Count purchases made by each customer
SELECT
    customer_name,
    COUNT(*) AS Total_Orders
FROM sales
GROUP BY customer_name
ORDER BY Total_Orders DESC;


-- 4. Find repeat customers
SELECT
    customer_name,
    COUNT(*) AS Total_Orders
FROM sales
GROUP BY customer_name
HAVING COUNT(*) > 1
ORDER BY Total_Orders DESC;


-- 5. Calculate average order value
SELECT
    ROUND(AVG(quantity * price), 2) AS Average_Order_Value
FROM sales;


-- 6. Classify customers based on total spending
WITH Customer_Spending AS (
    SELECT
        customer_name,
        SUM(quantity * price) AS Total_Spending
    FROM sales
    GROUP BY customer_name
)
SELECT
    customer_name,
    Total_Spending,
    CASE
        WHEN Total_Spending >= 50000 THEN 'Premium Customer'
        WHEN Total_Spending >= 20000 THEN 'Regular Customer'
        ELSE 'Basic Customer'
    END AS Customer_Category
FROM Customer_Spending
ORDER BY Total_Spending DESC;


-- 7. Find customers spending above average
WITH Customer_Spending AS (
    SELECT
        customer_name,
        SUM(quantity * price) AS Total_Spending
    FROM sales
    GROUP BY customer_name
)
SELECT
    customer_name,
    Total_Spending
FROM Customer_Spending
WHERE Total_Spending > (
    SELECT AVG(Total_Spending)
    FROM Customer_Spending
)
ORDER BY Total_Spending DESC;


-- 8. Rank customers by total spending
WITH Customer_Spending AS (
    SELECT
        customer_name,
        SUM(quantity * price) AS Total_Spending
    FROM sales
    GROUP BY customer_name
)
SELECT
    customer_name,
    Total_Spending,
    DENSE_RANK() OVER (
        ORDER BY Total_Spending DESC
    ) AS Customer_Rank
FROM Customer_Spending;


-- 9. Find each customer's first purchase date
SELECT
    customer_name,
    MIN(sale_date) AS First_Purchase_Date
FROM sales
GROUP BY customer_name
ORDER BY First_Purchase_Date;


-- 10. Find each customer's latest purchase date
SELECT
    customer_name,
    MAX(sale_date) AS Latest_Purchase_Date
FROM sales
GROUP BY customer_name
ORDER BY Latest_Purchase_Date DESC;


-- 11. Calculate days since last purchase
SELECT
    customer_name,
    MAX(sale_date) AS Latest_Purchase_Date,
    DATEDIFF(
        CURDATE(),
        MAX(sale_date)
    ) AS Days_Since_Last_Purchase
FROM sales
GROUP BY customer_name
ORDER BY Days_Since_Last_Purchase DESC;


-- 12. Find customers who purchased Electronics
SELECT DISTINCT
    customer_name
FROM sales
WHERE category = 'Electronics'
ORDER BY customer_name;


-- 13. Calculate customer revenue by category
SELECT
    customer_name,
    category,
    SUM(quantity * price) AS Category_Revenue
FROM sales
GROUP BY customer_name, category
ORDER BY customer_name, Category_Revenue DESC;


-- 14. Create a customer purchase summary
SELECT
    customer_name,
    COUNT(*) AS Total_Orders,
    SUM(quantity) AS Total_Quantity,
    SUM(quantity * price) AS Total_Spending,
    ROUND(AVG(quantity * price), 2) AS Average_Order_Value
FROM sales
GROUP BY customer_name
ORDER BY Total_Spending DESC;
```
