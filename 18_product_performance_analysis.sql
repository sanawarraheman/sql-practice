# Day 18 - Product Performance Analysis
# Date: 06 November 2026
# Database: operator_practice

USE operator_practice;

-- 1. Display all product sales
SELECT *
FROM sales;

-- 2. Total quantity sold for each product
SELECT
    product_name,
    SUM(quantity) AS total_quantity
FROM sales
GROUP BY product_name
ORDER BY total_quantity DESC;

-- 3. Total revenue for each product
SELECT
    product_name,
    SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY product_name
ORDER BY total_revenue DESC;

-- 4. Find products with revenue above 5000
SELECT
    product_name,
    SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY product_name
HAVING SUM(quantity * price) > 5000;

-- 5. Average selling price of each product
SELECT
    product_name,
    ROUND(AVG(price), 2) AS average_price
FROM sales
GROUP BY product_name;

-- 6. Classify products based on quantity sold
SELECT
    product_name,
    SUM(quantity) AS total_quantity,
    CASE
        WHEN SUM(quantity) >= 10 THEN 'High Sales'
        WHEN SUM(quantity) >= 5 THEN 'Medium Sales'
        ELSE 'Low Sales'
    END AS sales_category
FROM sales
GROUP BY product_name;

-- 7. Rank products by revenue
SELECT
    product_name,
    SUM(quantity * price) AS total_revenue,
    DENSE_RANK() OVER (
        ORDER BY SUM(quantity * price) DESC
    ) AS product_rank
FROM sales
GROUP BY product_name;

-- 8. Find the highest revenue product
SELECT
    product_name,
    SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 1;

-- 9. Category-wise product performance
SELECT
    category,
    COUNT(DISTINCT product_name) AS total_products,
    SUM(quantity) AS total_quantity,
    SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY category
ORDER BY total_revenue DESC;

-- 10. Complete product performance report
SELECT
    product_name,
    SUM(quantity) AS total_quantity,
    ROUND(AVG(price), 2) AS average_price,
    SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY product_name
ORDER BY total_revenue DESC;
