```sql
-- ============================================
-- SQL PRACTICE: WORLD DATABASE
-- Topics: Subqueries, CASE WHEN, DISTINCT
-- Date: 22 October 2026
-- ============================================

USE world;


-- 1. Find countries with population above average
SELECT
    Name,
    Continent,
    Population
FROM country
WHERE Population > (
    SELECT AVG(Population)
    FROM country
)
ORDER BY Population DESC;


-- 2. Find the country with the highest population
SELECT
    Name,
    Population
FROM country
WHERE Population = (
    SELECT MAX(Population)
    FROM country
);


-- 3. Classify countries by population
SELECT
    Name,
    Population,
    CASE
        WHEN Population >= 100000000
            THEN 'High Population'
        WHEN Population >= 10000000
            THEN 'Medium Population'
        ELSE 'Low Population'
    END AS Population_Category
FROM country
ORDER BY Population DESC;


-- 4. Count countries in each population category
SELECT
    Population_Category,
    COUNT(*) AS Total_Countries
FROM (
    SELECT
        CASE
            WHEN Population >= 100000000
                THEN 'High Population'
            WHEN Population >= 10000000
                THEN 'Medium Population'
            ELSE 'Low Population'
        END AS Population_Category
    FROM country
) AS Country_Categories
GROUP BY Population_Category
ORDER BY Total_Countries DESC;


-- 5. Display all unique continents
SELECT DISTINCT Continent
FROM country
ORDER BY Continent;


-- 6. Find countries with population above
-- the average population of Asian countries
SELECT
    Name,
    Continent,
    Population
FROM country
WHERE Continent = 'Asia'
  AND Population > (
      SELECT AVG(Population)
      FROM country
      WHERE Continent = 'Asia'
  )
ORDER BY Population DESC;
```
