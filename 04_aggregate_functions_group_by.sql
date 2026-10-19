```sql
-- ============================================
-- SQL PRACTICE: WORLD DATABASE
-- Topics: COUNT, SUM, AVG, MIN, MAX,
--         GROUP BY, HAVING
-- Date: 19 October 2026
-- ============================================

USE world;

-- 1. Count total countries
SELECT COUNT(*) AS Total_Countries
FROM country;

-- 2. Find the total population of all countries
SELECT SUM(Population) AS Total_Population
FROM country;

-- 3. Find the average country population
SELECT ROUND(AVG(Population), 2) AS Average_Population
FROM country;

-- 4. Find the minimum country population
SELECT MIN(Population) AS Minimum_Population
FROM country;

-- 5. Find the maximum country population
SELECT MAX(Population) AS Maximum_Population
FROM country;

-- 6. Count countries in each continent
SELECT
    Continent,
    COUNT(*) AS Total_Countries
FROM country
GROUP BY Continent
ORDER BY Total_Countries DESC;

-- 7. Calculate average population for each continent
SELECT
    Continent,
    ROUND(AVG(Population), 2) AS Average_Population
FROM country
GROUP BY Continent
ORDER BY Average_Population DESC;

-- 8. Show continents with more than 10 countries
SELECT
    Continent,
    COUNT(*) AS Total_Countries
FROM country
GROUP BY Continent
HAVING COUNT(*) > 10
ORDER BY Total_Countries DESC;
```
