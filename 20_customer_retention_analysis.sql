# Day 20 - Customer Retention Analysis
# Date: 08 November 2026
# Database: operator_practice

USE operator_practice;

-- 1. Display all sales records
SELECT *
FROM sales;

-- 2. Find total orders per customer
SELECT
    customer_name,
    COUNT(sale_id) AS total_orders
FROM sales
GROUP BY customer_name
ORDER BY total_orders DESC;

-- 3. Find repeat customers
SELECT
    customer_name,
    COUNT(sale_id) AS total_orders
FROM sales
GROUP BY customer_name
HAVING COUNT(sale_id) > 1;

-- 4. Find one-time customers
SELECT
    customer_name,
    COUNT(sale_id) AS total_orders
FROM sales
GROUP BY customer_name
HAVING COUNT(sale_id) = 1;

-- 5. Find each customer's first purchase date
SELECT
    customer_name,
    MIN(sale_date) AS first_purchase
FROM sales
GROUP BY customer_name;

-- 6. Find each customer's latest purchase date
SELECT
    customer_name,
    MAX(sale_date) AS latest_purchase
FROM sales
GROUP BY customer_name;

-- 7. Calculate days between first and last purchase
SELECT
    customer_name,
    DATEDIFF(
        MAX(sale_date),
        MIN(sale_date)
    ) AS days_between_purchases
FROM sales
GROUP BY customer_name;

-- 8. Calculate customer lifetime revenue
SELECT
    customer_name,
    SUM(quantity * price) AS lifetime_revenue
FROM sales
GROUP BY customer_name
ORDER BY lifetime_revenue DESC;

-- 9. Classify customers by number of orders
SELECT
    customer_name,
    COUNT(sale_id) AS total_orders,
    CASE
        WHEN COUNT(sale_id) >= 3 THEN 'Loyal Customer'
        WHEN COUNT(sale_id) = 2 THEN 'Repeat Customer'
        ELSE 'New Customer'
    END AS customer_type
FROM sales
GROUP BY customer_name;

-- 10. Find customers with revenue above average customer revenue
WITH customer_revenue AS (
    SELECT
        customer_name,
        SUM(quantity * price) AS total_revenue
    FROM sales
    GROUP BY customer_name
)
SELECT
    customer_name,
    total_revenue
FROM customer_revenue
WHERE total_revenue > (
    SELECT AVG(total_revenue)
    FROM customer_revenue
);

-- 11. Rank customers by lifetime revenue
SELECT
    customer_name,
    SUM(quantity * price) AS lifetime_revenue,
    DENSE_RANK() OVER (
        ORDER BY SUM(quantity * price) DESC
    ) AS customer_rank
FROM sales
GROUP BY customer_name;

-- 12. Complete customer retention summary
SELECT
    customer_name,
    COUNT(sale_id) AS total_orders,
    SUM(quantity * price) AS total_spending,
    MIN(sale_date) AS first_purchase,
    MAX(sale_date) AS latest_purchase
FROM sales
GROUP BY customer_name
ORDER BY total_spending DESC;
