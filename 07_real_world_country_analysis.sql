```sql
-- ==================================================
-- SQL PRACTICE: REAL-WORLD DATA ANALYSIS
-- Database: world
-- Topics: WHERE, GROUP BY, HAVING, CASE WHEN,
--         JOIN, ORDER BY, LIMIT
-- Date: 23 October 2026
-- ==================================================

USE world;


-- 1. BUSINESS QUESTION:
-- Which continents have more than 30 countries?

SELECT
    Continent,
    COUNT(*) AS Total_Countries
FROM country
GROUP BY Continent
HAVING COUNT(*) > 30
ORDER BY Total_Countries DESC;


-- 2. BUSINESS QUESTION:
-- Which countries have a population above 50 million?

SELECT
    Name AS Country_Name,
    Continent,
    Population
FROM country
WHERE Population > 50000000
ORDER BY Population DESC;


-- 3. BUSINESS QUESTION:
-- Classify countries by population size.

SELECT
    Name AS Country_Name,
    Population,
    CASE
        WHEN Population >= 100000000
            THEN 'High Population'
        WHEN Population >= 50000000
            THEN 'Medium Population'
        ELSE 'Low Population'
    END AS Population_Category
FROM country
ORDER BY Population DESC;


-- 4. BUSINESS QUESTION:
-- Which 10 cities have the highest population?
-- JOIN city and country to show country names.

SELECT
    ci.Name AS City_Name,
    co.Name AS Country_Name,
    ci.Population AS City_Population
FROM city AS ci
INNER JOIN country AS co
    ON ci.CountryCode = co.Code
ORDER BY ci.Population DESC
LIMIT 10;


-- 5. BUSINESS QUESTION:
-- How many cities are recorded for each country?

SELECT
    co.Name AS Country_Name,
    COUNT(ci.ID) AS Total_Cities
FROM country AS co
LEFT JOIN city AS ci
    ON co.Code = ci.CountryCode
GROUP BY co.Code, co.Name
ORDER BY Total_Cities DESC
LIMIT 10;


-- 6. BUSINESS QUESTION:
-- Find countries with a population above
-- the average population of all countries.

SELECT
    Name AS Country_Name,
    Population
FROM country
WHERE Population > (
    SELECT AVG(Population)
    FROM country
)
ORDER BY Population DESC;


-- 7. BUSINESS QUESTION:
-- Calculate population density for each country.
-- Density = Population / Surface Area

SELECT
    Name AS Country_Name,
    Population,
    SurfaceArea,
    ROUND(Population / SurfaceArea, 2)
        AS Population_Density
FROM country
WHERE SurfaceArea > 0
ORDER BY Population_Density DESC
LIMIT 10;
```
