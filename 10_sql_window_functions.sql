```sql
-- ==================================================
-- SQL PRACTICE: WINDOW FUNCTIONS
-- Topics: ROW_NUMBER, RANK, DENSE_RANK,
--         PARTITION BY, ORDER BY
-- Date: 27 October 2026
-- ==================================================

USE operator_practice;


-- 1. Assign a row number to each employee
SELECT
    emp_id,
    emp_name,
    salary,
    ROW_NUMBER() OVER (
        ORDER BY salary DESC
    ) AS Row_Number
FROM employees;


-- 2. Rank employees by salary
-- Equal salaries receive the same rank
-- Rank numbers may contain gaps
SELECT
    emp_id,
    emp_name,
    salary,
    RANK() OVER (
        ORDER BY salary DESC
    ) AS Salary_Rank
FROM employees;


-- 3. Rank employees without gaps
-- Equal salaries receive the same rank
SELECT
    emp_id,
    emp_name,
    salary,
    DENSE_RANK() OVER (
        ORDER BY salary DESC
    ) AS Dense_Salary_Rank
FROM employees;


-- 4. Rank employees within each department
SELECT
    emp_id,
    emp_name,
    department,
    salary,
    RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS Department_Rank
FROM employees;


-- 5. Find the highest-paid employee in each department
SELECT *
FROM (
    SELECT
        emp_id,
        emp_name,
        department,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY salary DESC, emp_id
        ) AS Row_Number
    FROM employees
) AS Ranked_Employees
WHERE Row_Number = 1;


-- 6. Calculate each employee's salary difference
-- from the overall average salary
SELECT
    emp_id,
    emp_name,
    salary,
    ROUND(AVG(salary) OVER (), 2) AS Average_Salary,
    ROUND(salary - AVG(salary) OVER (), 2)
        AS Difference_From_Average
FROM employees;


-- 7. Show each employee's salary and the
-- highest salary in their department
SELECT
    emp_id,
    emp_name,
    department,
    salary,
    MAX(salary) OVER (
        PARTITION BY department
    ) AS Department_Max_Salary
FROM employees;
```
