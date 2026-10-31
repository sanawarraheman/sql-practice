```sql
-- ==================================================
-- SQL MINI PROJECT: EMPLOYEE SALARY ANALYSIS
-- Database: operator_practice
-- Topics: CTE, CASE, GROUP BY, HAVING,
--         SUBQUERY, WINDOW FUNCTIONS
-- Date: 31 October 2026
-- ==================================================

USE operator_practice;


-- 1. Display all employees
SELECT *
FROM employees;


-- 2. Find the total number of employees
SELECT
    COUNT(*) AS Total_Employees
FROM employees;


-- 3. Calculate salary statistics
SELECT
    ROUND(AVG(salary), 2) AS Average_Salary,
    MAX(salary) AS Highest_Salary,
    MIN(salary) AS Lowest_Salary,
    SUM(salary) AS Total_Salary
FROM employees;


-- 4. Classify employees by salary
SELECT
    emp_name,
    salary,
    CASE
        WHEN salary >= 50000 THEN 'High Salary'
        WHEN salary >= 30000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS Salary_Category
FROM employees
ORDER BY salary DESC;


-- 5. Find employees earning above average salary
SELECT
    emp_name,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
ORDER BY salary DESC;


-- 6. Rank employees by salary
SELECT
    emp_id,
    emp_name,
    salary,
    DENSE_RANK() OVER (
        ORDER BY salary DESC
    ) AS Salary_Rank
FROM employees;


-- 7. Calculate average salary by department
SELECT
    department,
    ROUND(AVG(salary), 2) AS Average_Salary,
    COUNT(*) AS Total_Employees
FROM employees
GROUP BY department
ORDER BY Average_Salary DESC;


-- 8. Find employees earning more than
-- the average salary of their department
WITH Department_Average AS (
    SELECT
        department,
        AVG(salary) AS Average_Salary
    FROM employees
    GROUP BY department
)
SELECT
    e.emp_name,
    e.department,
    e.salary,
    ROUND(d.Average_Salary, 2) AS Department_Average
FROM employees AS e
INNER JOIN Department_Average AS d
    ON e.department = d.department
WHERE e.salary > d.Average_Salary
ORDER BY e.salary DESC;


-- 9. Find the highest-paid employee
SELECT
    emp_name,
    salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);


-- 10. Count employees in each salary category
WITH Salary_Categories AS (
    SELECT
        CASE
            WHEN salary >= 50000 THEN 'High Salary'
            WHEN salary >= 30000 THEN 'Medium Salary'
            ELSE 'Low Salary'
        END AS Salary_Category
    FROM employees
)
SELECT
    Salary_Category,
    COUNT(*) AS Total_Employees
FROM Salary_Categories
GROUP BY Salary_Category
ORDER BY Total_Employees DESC;
```
