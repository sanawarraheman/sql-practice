# Day 25 - E-commerce Customer & Sales Analysis
# Date: 13 November 2026
# Database: operator_practice

USE operator_practice;

-- 1. Display all customer sales
SELECT *
FROM sales;

-- 2. Find total spending of each customer
SELECT
    customer_name,
    SUM(quantity * price) AS total_spending
FROM sales
GROUP BY customer_name
ORDER BY total_spending DESC;

-- 3. Find top 5 customers by spending
SELECT
    customer_name,
    SUM(quantity * price) AS total_spending
FROM sales
GROUP BY customer_name
ORDER BY total_spending DESC
LIMIT 5;

-- 4. Count orders per customer
SELECT
    customer_name,
    COUNT(sale_id) AS total_orders
FROM sales
GROUP BY customer_name
ORDER BY total_orders DESC;

-- 5. Find repeat customers
SELECT
    customer_name,
    COUNT(sale_id) AS total_orders
FROM sales
GROUP BY customer_name
HAVING COUNT(sale_id) > 1;

-- 6. Find one-time customers
SELECT
    customer_name,
    COUNT(sale_id) AS total_orders
FROM sales
GROUP BY customer_name
HAVING COUNT(sale_id) = 1;

-- 7. Calculate average order value per customer
SELECT
    customer_name,
    ROUND(AVG(quantity * price), 2) AS average_order_value
FROM sales
GROUP BY customer_name;

-- 8. Classify customers by spending
SELECT
    customer_name,
    SUM(quantity * price) AS total_spending,
    CASE
        WHEN SUM(quantity * price) >= 10000 THEN 'Premium Customer'
        WHEN SUM(quantity * price) >= 5000 THEN 'Regular Customer'
        ELSE 'Basic Customer'
    END AS customer_segment
FROM sales
GROUP BY customer_name;

-- 9. Rank customers by spending
SELECT
    customer_name,
    SUM(quantity * price) AS total_spending,
    DENSE_RANK() OVER (
        ORDER BY SUM(quantity * price) DESC
    ) AS customer_rank
FROM sales
GROUP BY customer_name;

-- 10. Find customers spending above average
WITH customer_spending AS (
    SELECT
        customer_name,
        SUM(quantity * price) AS total_spending
    FROM sales
    GROUP BY customer_name
)
SELECT
    customer_name,
    total_spending
FROM customer_spending
WHERE total_spending > (
    SELECT AVG(total_spending)
    FROM customer_spending
);

-- 11. Find first and latest purchase
SELECT
    customer_name,
    MIN(sale_date) AS first_purchase,
    MAX(sale_date) AS latest_purchase
FROM sales
GROUP BY customer_name;

-- 12. Find customer-wise category spending
SELECT
    customer_name,
    category,
    SUM(quantity * price) AS category_spending
FROM sales
GROUP BY customer_name, category
ORDER BY customer_name, category_spending DESC;

-- 13. Find customers who purchased Electronics
SELECT DISTINCT
    customer_name
FROM sales
WHERE category = 'Electronics';

-- 14. Final customer analysis report
SELECT
    customer_name,
    COUNT(sale_id) AS total_orders,
    SUM(quantity) AS total_quantity,
    SUM(quantity * price) AS total_spending,
    ROUND(AVG(quantity * price), 2) AS average_order_value
FROM sales
GROUP BY customer_name
ORDER BY total_spending DESC;
