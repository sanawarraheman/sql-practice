# Day 23 - Order & Delivery Analysis
# Date: 11 November 2026
# Database: operator_practice

USE operator_practice;

-- 1. Create orders table
CREATE TABLE IF NOT EXISTS delivery_orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    order_date DATE,
    delivery_date DATE,
    order_amount DECIMAL(10,2),
    delivery_status VARCHAR(30)
);

-- 2. Insert sample order data
INSERT INTO delivery_orders
(order_id, customer_name, city, order_date,
 delivery_date, order_amount, delivery_status)
VALUES
(1, 'Aman', 'Hyderabad', '2026-10-01', '2026-10-03', 2500, 'Delivered'),
(2, 'Rahul', 'Mumbai', '2026-10-02', '2026-10-07', 4500, 'Delivered'),
(3, 'Sana', 'Pune', '2026-10-04', NULL, 1800, 'Pending'),
(4, 'Arjun', 'Hyderabad', '2026-10-05', '2026-10-06', 3200, 'Delivered'),
(5, 'Priya', 'Delhi', '2026-10-07', NULL, 5000, 'Pending'),
(6, 'Zoya', 'Mumbai', '2026-10-08', '2026-10-12', 2800, 'Delivered'),
(7, 'Karan', 'Pune', '2026-10-10', '2026-10-15', 1500, 'Delivered'),
(8, 'Ayesha', 'Delhi', '2026-10-12', NULL, 6200, 'Pending'),
(9, 'Sameer', 'Hyderabad', '2026-10-14', '2026-10-16', 3900, 'Delivered'),
(10, 'Neha', 'Mumbai', '2026-10-15', '2026-10-17', 2100, 'Delivered')
ON DUPLICATE KEY UPDATE
customer_name = VALUES(customer_name),
city = VALUES(city),
order_date = VALUES(order_date),
delivery_date = VALUES(delivery_date),
order_amount = VALUES(order_amount),
delivery_status = VALUES(delivery_status);

-- 3. Display all orders
SELECT *
FROM delivery_orders;

-- 4. Count total orders
SELECT
    COUNT(*) AS total_orders
FROM delivery_orders;

-- 5. Count orders by delivery status
SELECT
    delivery_status,
    COUNT(*) AS total_orders
FROM delivery_orders
GROUP BY delivery_status;

-- 6. Calculate total order revenue
SELECT
    SUM(order_amount) AS total_revenue
FROM delivery_orders;

-- 7. Calculate average order amount
SELECT
    ROUND(AVG(order_amount), 2) AS average_order_amount
FROM delivery_orders;

-- 8. Calculate delivery time in days
SELECT
    order_id,
    customer_name,
    DATEDIFF(delivery_date, order_date) AS delivery_days
FROM delivery_orders
WHERE delivery_status = 'Delivered';

-- 9. Find orders delivered after 3 days
SELECT
    order_id,
    customer_name,
    DATEDIFF(delivery_date, order_date) AS delivery_days
FROM delivery_orders
WHERE delivery_status = 'Delivered'
  AND DATEDIFF(delivery_date, order_date) > 3;

-- 10. Analyze city-wise orders and revenue
SELECT
    city,
    COUNT(*) AS total_orders,
    SUM(order_amount) AS total_revenue
FROM delivery_orders
GROUP BY city
ORDER BY total_revenue DESC;

-- 11. Classify delivery performance
SELECT
    order_id,
    customer_name,
    delivery_status,
    CASE
        WHEN delivery_status = 'Pending' THEN 'Not Delivered'
        WHEN DATEDIFF(delivery_date, order_date) > 3 THEN 'Late Delivery'
        ELSE 'On Time'
    END AS delivery_performance
FROM delivery_orders;

-- 12. Find cities with more than 2 orders
SELECT
    city,
    COUNT(*) AS total_orders
FROM delivery_orders
GROUP BY city
HAVING COUNT(*) > 2;

-- 13. Rank orders by order amount
SELECT
    order_id,
    customer_name,
    order_amount,
    DENSE_RANK() OVER (
        ORDER BY order_amount DESC
    ) AS order_rank
FROM delivery_orders;

-- 14. Complete delivery summary
SELECT
    delivery_status,
    COUNT(*) AS total_orders,
    SUM(order_amount) AS total_revenue,
    ROUND(AVG(order_amount), 2) AS average_order_amount
FROM delivery_orders
GROUP BY delivery_status;
