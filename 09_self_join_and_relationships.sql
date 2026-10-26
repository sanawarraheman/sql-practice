```sql
-- ==================================================
-- SQL PRACTICE: SELF JOIN & TABLE RELATIONSHIPS
-- Database: operator_practice
-- Topics: SELF JOIN, LEFT JOIN, NULL, COALESCE
-- Date: 26 October 2026
-- ==================================================

-- NOTE:
-- This script uses a sample employees table.
-- Required columns:
-- emp_id, emp_name, manager_id, salary, department

-- 1. Select the practice database
USE operator_practice;


-- 2. SELF JOIN
-- Display each employee with their manager
SELECT
    e.emp_name AS Employee_Name,
    m.emp_name AS Manager_Name
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.emp_id;


-- 3. SELF JOIN with WHERE
-- Find employees who have a manager
SELECT
    e.emp_name AS Employee_Name,
    m.emp_name AS Manager_Name
FROM employees AS e
INNER JOIN employees AS m
    ON e.manager_id = m.emp_id;


-- 4. Find employees who do not have a manager
SELECT
    emp_id,
    emp_name
FROM employees
WHERE manager_id IS NULL;


-- 5. Display employees and their managers,
-- replacing missing manager names with 'No Manager'
SELECT
    e.emp_name AS Employee_Name,
    COALESCE(m.emp_name, 'No Manager') AS Manager_Name
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.emp_id;


-- 6. Find employees earning more than their managers
SELECT
    e.emp_name AS Employee_Name,
    e.salary AS Employee_Salary,
    m.emp_name AS Manager_Name,
    m.salary AS Manager_Salary
FROM employees AS e
INNER JOIN employees AS m
    ON e.manager_id = m.emp_id
WHERE e.salary > m.salary;


-- 7. Count direct reports for each manager
SELECT
    m.emp_id AS Manager_ID,
    m.emp_name AS Manager_Name,
    COUNT(e.emp_id) AS Total_Direct_Reports
FROM employees AS m
LEFT JOIN employees AS e
    ON e.manager_id = m.emp_id
GROUP BY m.emp_id, m.emp_name
ORDER BY Total_Direct_Reports DESC;
```
