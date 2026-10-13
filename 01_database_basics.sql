```sql
-- ============================================
-- SQL PRACTICE: MYSHOP DATABASE
-- Topics: CREATE, INSERT, SELECT, ALTER, UPDATE
-- ============================================

-- 1. Create database
CREATE DATABASE myshop;

-- 2. Select database
USE myshop;

-- 3. Create table
CREATE TABLE shop_item (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price INT
);

-- 4. Display table structure data
SELECT * FROM shop_item;

-- 5. Insert products into the table
INSERT INTO shop_item (product_id, product_name, price)
VALUES
(101, 'peti', 1400),
(102, 'kothi', 1600),
(103, 'miter_peti', 1600),
(104, 'shadi_peti', 2200),
(105, 'pinjra', 350),
(106, 'sigdhi', 350),
(107, 'moter_cover', 350),
(108, 'doc_peti', 300),
(109, 'chalni', 70),
(110, 'cololer_tap', 750);

-- 6. Display all products
SELECT * FROM shop_item;

-- ============================================
-- ALTER TABLE: Add a new column
-- ADD: Used to add a new column to a table
-- ============================================

ALTER TABLE shop_item
ADD stock INT;

-- 7. Update stock for each product
UPDATE shop_item SET stock = 10   WHERE product_id = 101;
UPDATE shop_item SET stock = 144  WHERE product_id = 102;
UPDATE shop_item SET stock = 77   WHERE product_id = 103;
UPDATE shop_item SET stock = 22   WHERE product_id = 104;
UPDATE shop_item SET stock = 200  WHERE product_id = 105;
UPDATE shop_item SET stock = 400  WHERE product_id = 106;
UPDATE shop_item SET stock = 390  WHERE product_id = 107;
UPDATE shop_item SET stock = 900  WHERE product_id = 108;
UPDATE shop_item SET stock = 90   WHERE product_id = 109;
UPDATE shop_item SET stock = 4000 WHERE product_id = 110;

-- UPDATE: Changes existing data in a table.
-- SET: Specifies the column and its new value.
-- WHERE: Specifies which record should be updated.

-- 8. Display final table data
SELECT * FROM shop_item;

-- ============================================
-- ALTER TABLE PRACTICE EXAMPLES
-- These are examples for learning.
-- Run separately when needed.
-- Do not execute all examples blindly.
-- ============================================

-- A. Add a new column
-- ALTER TABLE shop_item ADD category VARCHAR(50);

-- B. Change the size of a column
-- ALTER TABLE shop_item MODIFY product_name VARCHAR(100);

-- C. Rename a column
-- ALTER TABLE shop_item RENAME COLUMN price TO product_price;

-- D. Delete a column
-- ALTER TABLE shop_item DROP COLUMN stock;

-- E. Rename a table
-- ALTER TABLE shop_item RENAME TO shop_products;
```
