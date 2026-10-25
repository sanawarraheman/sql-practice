```sql
-- ==================================================
-- SQL MINI PROJECT: COUNTRY & CITY DATA ANALYSIS
-- Database: world
-- Topics: WHERE, GROUP BY, HAVING, JOIN,
--         CASE WHEN, Subquery, Aggregate Functions
-- Date: 25 October 2026
-- ==================================================

USE world;


-- 1. Count the total number of countries
SELECT
    COUNT(*) AS Total_Countries
FROM country;


-- 2. Find the total population of each continent
SELECT
    Continent,
    SUM(Population) AS Total_Population
FROM country
GROUP BY Continent
ORDER BY Total_Population DESC;


-- 3. Find continents with more than 10 countries
SELECT
    Continent,
    COUNT(*) AS Total_Countries
FROM country
GROUP BY Continent
HAVING COUNT(*) > 10
ORDER BY Total_Countries DESC;


-- 4. Find the 10 most populated countries
SELECT
    Name AS Country_Name,
    Continent,
    Population
FROM country
ORDER BY Population DESC
LIMIT 10;


-- 5. Classify countries by population
SELECT
    Name AS Country_Name,
    Population,
    CASE
        WHEN Population >= 100000000
            THEN 'High'
        WHEN Population >= 10000000
            THEN 'Medium'
        ELSE 'Low'
    END AS Population_Category
FROM country
ORDER BY Population DESC;


-- 6. Find cities with their country names
SELECT
    ci.Name AS City_Name,
    co.Name AS Country_Name,
    ci.Population AS City_Population
FROM city AS ci
INNER JOIN country AS co
    ON ci.CountryCode = co.Code
ORDER BY ci.Population DESC
LIMIT 10;


-- 7. Count cities in each country
SELECT
    co.Name AS Country_Name,
    COUNT(ci.ID) AS Total_Cities
FROM country AS co
LEFT JOIN city AS ci
    ON co.Code = ci.CountryCode
GROUP BY co.Code, co.Name
ORDER BY Total_Cities DESC
LIMIT 10;


-- 8. Find countries with above-average population
SELECT
    Name AS Country_Name,
    Population
FROM country
WHERE Population > (
    SELECT AVG(Population)
    FROM country
)
ORDER BY Population DESC;


-- 9. Calculate population density
SELECT
    Name AS Country_Name,
    ROUND(Population / SurfaceArea, 2)
        AS Population_Density
FROM country
WHERE SurfaceArea > 0
ORDER BY Population_Density DESC
LIMIT 10;


-- 10. Find countries with no recorded cities
SELECT
    co.Name AS Country_Name
FROM country AS co
LEFT JOIN city AS ci
    ON co.Code = ci.CountryCode
WHERE ci.ID IS NULL
ORDER BY co.Name;
```
