# Day 21 - Employee Performance Analysis
# Date: 09 November 2026
# Database: operator_practice

USE operator_practice;

-- 1. Display all employees with department names
SELECT
    e.id_emp,
    e.emp_name,
    e.salary,
    d.dep_name
FROM employees e
INNER JOIN department d
    ON e.id = d.id;

-- 2. Find highest salary
SELECT
    MAX(salary) AS highest_salary
FROM employees;

-- 3. Find lowest salary
SELECT
    MIN(salary) AS lowest_salary
FROM employees;

-- 4. Calculate average salary
SELECT
    ROUND(AVG(salary), 2) AS average_salary
FROM employees;

-- 5. Find department-wise average salary
SELECT
    d.dep_name,
    ROUND(AVG(e.salary), 2) AS average_salary
FROM employees e
INNER JOIN department d
    ON e.id = d.id
GROUP BY d.dep_name;

-- 6. Find department-wise employee count
SELECT
    d.dep_name,
    COUNT(e.id_emp) AS total_employees
FROM department d
LEFT JOIN employees e
    ON d.id = e.id
GROUP BY d.dep_name;

-- 7. Find employees earning above average salary
SELECT
    id_emp,
    emp_name,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

-- 8. Classify employees based on salary
SELECT
    emp_name,
    salary,
    CASE
        WHEN salary >= 50000 THEN 'High Salary'
        WHEN salary >= 30000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS salary_category
FROM employees;

-- 9. Rank employees by salary
SELECT
    id_emp,
    emp_name,
    salary,
    DENSE_RANK() OVER (
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;

-- 10. Rank employees within each department
SELECT
    e.emp_name,
    d.dep_name,
    e.salary,
    DENSE_RANK() OVER (
        PARTITION BY d.dep_name
        ORDER BY e.salary DESC
    ) AS department_rank
FROM employees e
INNER JOIN department d
    ON e.id = d.id;

-- 11. Find departments with average salary above 30000
SELECT
    d.dep_name,
    ROUND(AVG(e.salary), 2) AS average_salary
FROM employees e
INNER JOIN department d
    ON e.id = d.id
GROUP BY d.dep_name
HAVING AVG(e.salary) > 30000;

-- 12. Complete employee performance report
SELECT
    d.dep_name,
    COUNT(e.id_emp) AS total_employees,
    ROUND(AVG(e.salary), 2) AS average_salary,
    MAX(e.salary) AS highest_salary,
    MIN(e.salary) AS lowest_salary
FROM employees e
INNER JOIN department d
    ON e.id = d.id
GROUP BY d.dep_name
ORDER BY average_salary DESC;
