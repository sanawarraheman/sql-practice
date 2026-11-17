# Day 26 - HR Employee Attrition Analysis
# Date: 18 November 2026
# Database: operator_practice

USE operator_practice;

-- 1. Create employee HR table
CREATE TABLE IF NOT EXISTS hr_employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    age INT,
    salary DECIMAL(10,2),
    joining_date DATE,
    experience_years INT,
    attrition VARCHAR(10)
);

-- 2. Insert sample employee data
INSERT INTO hr_employees
(employee_id, employee_name, department, age, salary,
 joining_date, experience_years, attrition)
VALUES
(1, 'Aman', 'IT', 25, 35000, '2022-01-10', 3, 'No'),
(2, 'Rahul', 'HR', 30, 42000, '2020-05-15', 5, 'No'),
(3, 'Sana', 'IT', 28, 50000, '2021-03-20', 4, 'Yes'),
(4, 'Arjun', 'Sales', 35, 30000, '2019-06-10', 6, 'No'),
(5, 'Priya', 'Finance', 27, 45000, '2022-08-01', 3, 'Yes'),
(6, 'Zoya', 'IT', 32, 60000, '2018-02-15', 8, 'No'),
(7, 'Karan', 'Sales', 24, 28000, '2023-01-05', 2, 'Yes'),
(8, 'Neha', 'HR', 29, 38000, '2021-11-12', 4, 'No'),
(9, 'Sameer', 'Finance', 40, 70000, '2017-04-18', 9, 'No'),
(10, 'Ayesha', 'IT', 26, 40000, '2022-06-20', 3, 'Yes')
ON DUPLICATE KEY UPDATE
employee_name = VALUES(employee_name),
department = VALUES(department),
age = VALUES(age),
salary = VALUES(salary),
joining_date = VALUES(joining_date),
experience_years = VALUES(experience_years),
attrition = VALUES(attrition);

-- 3. Display all employees
SELECT *
FROM hr_employees;

-- 4. Count total employees
SELECT
    COUNT(*) AS total_employees
FROM hr_employees;

-- 5. Calculate average salary by department
SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM hr_employees
GROUP BY department
ORDER BY average_salary DESC;

-- 6. Find highest paid employee
SELECT
    employee_name,
    department,
    salary
FROM hr_employees
ORDER BY salary DESC
LIMIT 1;

-- 7. Count employees by department
SELECT
    department,
    COUNT(*) AS total_employees
FROM hr_employees
GROUP BY department;

-- 8. Analyze employee attrition
SELECT
    attrition,
    COUNT(*) AS employee_count
FROM hr_employees
GROUP BY attrition;

-- 9. Calculate attrition percentage
SELECT
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_percentage
FROM hr_employees;

-- 10. Department-wise attrition
SELECT
    department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        AS employees_left
FROM hr_employees
GROUP BY department;

-- 11. Classify employees by salary
SELECT
    employee_name,
    salary,
    CASE
        WHEN salary >= 50000 THEN 'High Salary'
        WHEN salary >= 35000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS salary_category
FROM hr_employees;

-- 12. Rank employees by salary
SELECT
    employee_name,
    department,
    salary,
    DENSE_RANK() OVER (
        ORDER BY salary DESC
    ) AS salary_rank
FROM hr_employees;

-- 13. Rank employees within each department
SELECT
    employee_name,
    department,
    salary,
    DENSE_RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS department_salary_rank
FROM hr_employees;

-- 14. Find employees earning above company average
SELECT
    employee_name,
    salary
FROM hr_employees
WHERE salary > (
    SELECT AVG(salary)
    FROM hr_employees
);

-- 15. Find departments with average salary above 40000
SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM hr_employees
GROUP BY department
HAVING AVG(salary) > 40000;

-- 16. Final HR analytics report
SELECT
    department,
    COUNT(*) AS total_employees,
    ROUND(AVG(salary), 2) AS average_salary,
    MAX(salary) AS highest_salary,
    MIN(salary) AS lowest_salary,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        AS employees_left
FROM hr_employees
GROUP BY department
ORDER BY total_employees DESC;
