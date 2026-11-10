# Day 22 - Inventory & Stock Analysis
# Date: 10 November 2026
# Database: operator_practice

USE operator_practice;

-- 1. Create inventory table
CREATE TABLE IF NOT EXISTS product_inventory (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    stock_quantity INT,
    reorder_level INT,
    unit_cost DECIMAL(10,2),
    selling_price DECIMAL(10,2)
);

-- 2. Insert sample inventory data
INSERT INTO product_inventory
(product_id, product_name, category, stock_quantity,
 reorder_level, unit_cost, selling_price)
VALUES
(1, 'Laptop', 'Electronics', 5, 10, 35000, 42000),
(2, 'Mouse', 'Accessories', 25, 10, 300, 500),
(3, 'Keyboard', 'Accessories', 8, 12, 700, 1000),
(4, 'Monitor', 'Electronics', 15, 5, 8000, 11000),
(5, 'Printer', 'Electronics', 3, 5, 9000, 12000),
(6, 'Chair', 'Furniture', 20, 8, 2500, 3500),
(7, 'Desk', 'Furniture', 7, 10, 4000, 5500),
(8, 'Headphones', 'Accessories', 30, 10, 1200, 1800)
ON DUPLICATE KEY UPDATE
product_name = VALUES(product_name),
category = VALUES(category),
stock_quantity = VALUES(stock_quantity),
reorder_level = VALUES(reorder_level),
unit_cost = VALUES(unit_cost),
selling_price = VALUES(selling_price);

-- 3. Display all inventory records
SELECT *
FROM product_inventory;

-- 4. Find products with low stock
SELECT *
FROM product_inventory
WHERE stock_quantity < reorder_level;

-- 5. Calculate total inventory quantity
SELECT
    SUM(stock_quantity) AS total_stock
FROM product_inventory;

-- 6. Calculate inventory value
SELECT
    SUM(stock_quantity * unit_cost) AS total_inventory_value
FROM product_inventory;

-- 7. Calculate potential sales value
SELECT
    SUM(stock_quantity * selling_price) AS potential_sales_value
FROM product_inventory;

-- 8. Find category-wise stock
SELECT
    category,
    SUM(stock_quantity) AS total_stock
FROM product_inventory
GROUP BY category
ORDER BY total_stock DESC;

-- 9. Classify products by stock status
SELECT
    product_name,
    stock_quantity,
    reorder_level,
    CASE
        WHEN stock_quantity < reorder_level THEN 'Reorder Required'
        WHEN stock_quantity = reorder_level THEN 'Stock Alert'
        ELSE 'Stock Available'
    END AS stock_status
FROM product_inventory;

-- 10. Find categories with total stock above 20
SELECT
    category,
    SUM(stock_quantity) AS total_stock
FROM product_inventory
GROUP BY category
HAVING SUM(stock_quantity) > 20;

-- 11. Rank products by inventory value
SELECT
    product_name,
    stock_quantity * unit_cost AS inventory_value,
    DENSE_RANK() OVER (
        ORDER BY stock_quantity * unit_cost DESC
    ) AS inventory_rank
FROM product_inventory;

-- 12. Find products that need reordering
WITH stock_analysis AS (
    SELECT
        product_name,
        stock_quantity,
        reorder_level,
        reorder_level - stock_quantity AS shortage
    FROM product_inventory
)
SELECT *
FROM stock_analysis
WHERE shortage > 0
ORDER BY shortage DESC;

-- 13. Complete inventory summary
SELECT
    category,
    COUNT(product_id) AS total_products,
    SUM(stock_quantity) AS total_stock,
    SUM(stock_quantity * unit_cost) AS inventory_value
FROM product_inventory
GROUP BY category
ORDER BY inventory_value DESC;
