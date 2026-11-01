```sql
-- ==================================================
-- SQL PRACTICE: DATE & TIME FUNCTIONS
-- Topics: CURDATE, NOW, YEAR, MONTH, DAY,
--         DATEDIFF, DATE_FORMAT
-- Date: 1 November 2026
-- ==================================================

-- 1. Display current date
SELECT CURDATE() AS Current_Date;


-- 2. Display current date and time
SELECT NOW() AS Current_Date_Time;


-- 3. Extract year, month and day
SELECT
    YEAR(CURDATE()) AS Current_Year,
    MONTH(CURDATE()) AS Current_Month,
    DAY(CURDATE()) AS Current_Day;


-- 4. Display current month name
SELECT
    MONTHNAME(CURDATE()) AS Month_Name;


-- 5. Calculate difference between two dates
SELECT
    DATEDIFF('2026-11-01', '2026-01-01')
    AS Total_Days;


-- 6. Format a date
SELECT
    DATE_FORMAT(
        CURDATE(),
        '%d-%m-%Y'
    ) AS Formatted_Date;


-- 7. Extract weekday name
SELECT
    DAYNAME(CURDATE()) AS Weekday_Name;


-- 8. Add 30 days to current date
SELECT
    DATE_ADD(CURDATE(), INTERVAL 30 DAY)
    AS Date_After_30_Days;


-- 9. Subtract 1 month from current date
SELECT
    DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
    AS Previous_Month_Date;


-- 10. Create a sample employee joining-date table
CREATE TABLE IF NOT EXISTS employee_dates (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    joining_date DATE
);


-- 11. Insert sample records
INSERT INTO employee_dates
    (emp_id, emp_name, joining_date)
VALUES
    (1, 'Aamir', '2024-01-15'),
    (2, 'Sana', '2023-06-10'),
    (3, 'Ravi', '2025-03-20'),
    (4, 'Arshan', '2022-11-05')
ON DUPLICATE KEY UPDATE
    emp_name = VALUES(emp_name),
    joining_date = VALUES(joining_date);


-- 12. Calculate employee experience in days
SELECT
    emp_name,
    joining_date,
    DATEDIFF(CURDATE(), joining_date)
        AS Experience_In_Days
FROM employee_dates
ORDER BY Experience_In_Days DESC;


-- 13. Find employees who joined in 2024
SELECT
    emp_name,
    joining_date
FROM employee_dates
WHERE YEAR(joining_date) = 2024;
```
