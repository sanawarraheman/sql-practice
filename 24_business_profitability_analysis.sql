# Day 24 - Business Profitability Analysis
# Date: 12 November 2026
# Database: operator_practice

USE operator_practice;

-- 1. Create business sales table
CREATE TABLE IF NOT EXISTS business_sales (
    sale_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    quantity INT,
    selling_price DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    sale_date DATE
);

-- 2. Insert sample data
INSERT INTO business_sales
(sale_id, product_name, category, quantity,
 selling_price, cost_price, sale_date)
VALUES
(1, 'Laptop', 'Electronics', 2, 45000, 38000, '2026-10-01'),
(2, 'Mouse', 'Accessories', 10, 500, 300, '2026-10-02'),
(3, 'Keyboard', 'Accessories', 5, 900, 700, '2026-10-03'),
(4, 'Monitor', 'Electronics', 3, 12000, 9500, '2026-10-04'),
(5, 'Chair', 'Furniture', 4, 3500, 4000, '2026-10-05'),
(6, 'Desk', 'Furniture', 2, 5500, 4200, '2026-10-06'),
(7, 'Headphones', 'Accessories', 8, 1800, 1100, '2026-10-07'),
(8, 'Printer', 'Electronics', 2, 10000, 11500, '2026-10-08'),
(9, 'Tablet', 'Electronics', 3, 20000, 16000, '2026-10-09'),
(10, 'Sofa', 'Furniture', 1, 15000, 12000, '2026-10-10')
ON DUPLICATE KEY UPDATE
product_name = VALUES(product_name),
category = VALUES(category),
quantity = VALUES(quantity),
selling_price = VALUES(selling_price),
cost_price = VALUES(cost_price),
sale_date = VALUES(sale_date);

-- 3. Display all sales
SELECT *
FROM business_sales;

-- 4. Calculate total revenue
SELECT
    SUM(quantity * selling_price) AS total_revenue
FROM business_sales;

-- 5. Calculate total cost
SELECT
    SUM(quantity * cost_price) AS total_cost
FROM business_sales;

-- 6. Calculate total profit
SELECT
    SUM(quantity * (selling_price - cost_price)) AS total_profit
FROM business_sales;

-- 7. Calculate profit for each product
SELECT
    product_name,
    SUM(quantity * (selling_price - cost_price)) AS total_profit
FROM business_sales
GROUP BY product_name
ORDER BY total_profit DESC;

-- 8. Find products generating a loss
SELECT
    product_name,
    SUM(quantity * (selling_price - cost_price)) AS total_profit
FROM business_sales
GROUP BY product_name
HAVING SUM(quantity * (selling_price - cost_price)) < 0;

-- 9. Calculate category-wise profit
SELECT
    category,
    SUM(quantity * (selling_price - cost_price)) AS total_profit
FROM business_sales
GROUP BY category
ORDER BY total_profit DESC;

-- 10. Calculate profit margin percentage
SELECT
    product_name,
    ROUND(
        (selling_price - cost_price) / selling_price * 100,
        2
    ) AS profit_margin_percentage
FROM business_sales;

-- 11. Classify products by profitability
SELECT
    product_name,
    SUM(quantity * (selling_price - cost_price)) AS total_profit,
    CASE
        WHEN SUM(quantity * (selling_price - cost_price)) > 0
            THEN 'Profitable'
        WHEN SUM(quantity * (selling_price - cost_price)) = 0
            THEN 'Break Even'
        ELSE 'Loss'
    END AS profit_status
FROM business_sales
GROUP BY product_name;

-- 12. Rank products by profit
SELECT
    product_name,
    SUM(quantity * (selling_price - cost_price)) AS total_profit,
    DENSE_RANK() OVER (
        ORDER BY SUM(quantity * (selling_price - cost_price)) DESC
    ) AS profit_rank
FROM business_sales
GROUP BY product_name;

-- 13. Find categories with profit above 10000
SELECT
    category,
    SUM(quantity * (selling_price - cost_price)) AS total_profit
FROM business_sales
GROUP BY category
HAVING SUM(quantity * (selling_price - cost_price)) > 10000;

-- 14. Complete business profitability report
SELECT
    category,
    SUM(quantity * selling_price) AS total_revenue,
    SUM(quantity * cost_price) AS total_cost,
    SUM(quantity * (selling_price - cost_price)) AS total_profit
FROM business_sales
GROUP BY category
ORDER BY total_profit DESC;
