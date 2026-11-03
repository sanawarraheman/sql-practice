```sql
-- ==================================================
-- SQL PRACTICE: DATA CLEANING & DATA QUALITY
-- Topics: NULL, TRIM, LOWER, DISTINCT,
--         CASE WHEN, COALESCE, GROUP BY
-- Date: 3 November 2026
-- Database: operator_practice
-- ==================================================

USE operator_practice;


-- 1. Create a sample customer table
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    age INT
);


-- 2. Insert sample data
INSERT INTO customers
    (customer_id, customer_name, email, city, age)
VALUES
    (1, ' Aamir Khan ', 'AAMIR@GMAIL.COM', 'Hyderabad', 25),
    (2, 'Sana', 'sana@gmail.com', 'Mumbai', 23),
    (3, 'Ravi', NULL, 'Delhi', 28),
    (4, 'Arshan', 'arshan@gmail.com', NULL, 22),
    (5, 'Mahin', 'mahin@gmail.com', 'Hyderabad', NULL),
    (6, 'Sohel', 'sohel@gmail.com', 'Mumbai', 30),
    (7, 'Aamir Khan', 'AAMIR@GMAIL.COM', 'Hyderabad', 25)
ON DUPLICATE KEY UPDATE
    customer_name = VALUES(customer_name);


-- 3. Display all customer records
SELECT *
FROM customers;


-- 4. Find duplicate customer records
SELECT
    customer_name,
    email,
    COUNT(*) AS Duplicate_Count
FROM customers
GROUP BY customer_name, email
HAVING COUNT(*) > 1;


-- 5. Find missing values
SELECT
    COUNT(*) AS Total_Rows,
    SUM(customer_name IS NULL) AS Missing_Names,
    SUM(email IS NULL) AS Missing_Emails,
    SUM(city IS NULL) AS Missing_Cities,
    SUM(age IS NULL) AS Missing_Ages
FROM customers;


-- 6. Remove unwanted spaces
SELECT
    customer_id,
    customer_name,
    TRIM(customer_name) AS Cleaned_Name
FROM customers;


-- 7. Standardize email addresses
SELECT
    customer_id,
    LOWER(TRIM(email)) AS Cleaned_Email
FROM customers
WHERE email IS NOT NULL;


-- 8. Replace missing city with Unknown
SELECT
    customer_name,
    COALESCE(city, 'Unknown') AS Cleaned_City
FROM customers;


-- 9. Categorize customers by age
SELECT
    customer_name,
    age,
    CASE
        WHEN age IS NULL THEN 'Missing Age'
        WHEN age < 25 THEN 'Young'
        WHEN age <= 30 THEN 'Adult'
        ELSE 'Senior'
    END AS Age_Category
FROM customers;


-- 10. Find unique cities
SELECT DISTINCT city
FROM customers
WHERE city IS NOT NULL;


-- 11. Find records with missing information
SELECT *
FROM customers
WHERE customer_name IS NULL
   OR email IS NULL
   OR city IS NULL
   OR age IS NULL;


-- 12. Count customers by city
SELECT
    COALESCE(city, 'Unknown') AS Customer_City,
    COUNT(*) AS Total_Customers
FROM customers
GROUP BY COALESCE(city, 'Unknown')
ORDER BY Total_Customers DESC;
```
