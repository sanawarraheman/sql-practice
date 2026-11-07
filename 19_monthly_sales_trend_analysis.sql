# Day 19 - Monthly Sales Trend Analysis
# Date: 07 November 2026
# Database: operator_practice

USE operator_practice;

-- 1. Display all sales records
SELECT *
FROM sales;

-- 2. Find total revenue for each month
SELECT
    YEAR(sale_date) AS sales_year,
    MONTH(sale_date) AS sales_month,
    SUM(quantity * price) AS monthly_revenue
FROM sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY sales_year, sales_month;

-- 3. Count total orders in each month
SELECT
    YEAR(sale_date) AS sales_year,
    MONTH(sale_date) AS sales_month,
    COUNT(sale_id) AS total_orders
FROM sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY sales_year, sales_month;

-- 4. Find average order value for each month
SELECT
    YEAR(sale_date) AS sales_year,
    MONTH(sale_date) AS sales_month,
    ROUND(AVG(quantity * price), 2) AS average_order_value
FROM sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY sales_year, sales_month;

-- 5. Find the highest revenue month
SELECT
    YEAR(sale_date) AS sales_year,
    MONTH(sale_date) AS sales_month,
    SUM(quantity * price) AS monthly_revenue
FROM sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY monthly_revenue DESC
LIMIT 1;

-- 6. Show monthly revenue above 10000
SELECT
    YEAR(sale_date) AS sales_year,
    MONTH(sale_date) AS sales_month,
    SUM(quantity * price) AS monthly_revenue
FROM sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
HAVING SUM(quantity * price) > 10000;

-- 7. Classify monthly sales performance
SELECT
    YEAR(sale_date) AS sales_year,
    MONTH(sale_date) AS sales_month,
    SUM(quantity * price) AS monthly_revenue,
    CASE
        WHEN SUM(quantity * price) >= 20000 THEN 'High Revenue'
        WHEN SUM(quantity * price) >= 10000 THEN 'Medium Revenue'
        ELSE 'Low Revenue'
    END AS performance
FROM sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY sales_year, sales_month;

-- 8. Rank months by revenue
SELECT
    YEAR(sale_date) AS sales_year,
    MONTH(sale_date) AS sales_month,
    SUM(quantity * price) AS monthly_revenue,
    DENSE_RANK() OVER (
        ORDER BY SUM(quantity * price) DESC
    ) AS revenue_rank
FROM sales
GROUP BY YEAR(sale_date), MONTH(sale_date);

-- 9. Find total revenue by year
SELECT
    YEAR(sale_date) AS sales_year,
    SUM(quantity * price) AS yearly_revenue
FROM sales
GROUP BY YEAR(sale_date)
ORDER BY sales_year;

-- 10. Monthly sales summary
SELECT
    DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,
    COUNT(sale_id) AS total_orders,
    SUM(quantity) AS total_quantity,
    SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY sales_month;
