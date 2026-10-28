```sql
-- ==================================================
-- SQL PRACTICE: CTE, LAG & LEAD
-- Topics: WITH, CTE, LAG(), LEAD(), ROW_NUMBER()
-- Date: 28 October 2026
-- Database: world
-- ==================================================

USE world;


-- 1. CTE: Find countries with population above
-- 50 million
WITH Large_Countries AS (
    SELECT
        Name,
        Continent,
        Population
    FROM country
    WHERE Population > 50000000
)
SELECT
    Name AS Country_Name,
    Continent,
    Population
FROM Large_Countries
ORDER BY Population DESC;


-- 2. CTE: Count countries in each continent
WITH Continent_Count AS (
    SELECT
        Continent,
        COUNT(*) AS Total_Countries
    FROM country
    GROUP BY Continent
)
SELECT
    Continent,
    Total_Countries
FROM Continent_Count
WHERE Total_Countries > 10
ORDER BY Total_Countries DESC;


-- 3. LAG(): Compare each country's population
-- with the previous row in population order
SELECT
    Name AS Country_Name,
    Population,
    LAG(Population) OVER (
        ORDER BY Population DESC
    ) AS Previous_Row_Population
FROM country
ORDER BY Population DESC
LIMIT 15;


-- 4. LEAD(): See the next row's population
SELECT
    Name AS Country_Name,
    Population,
    LEAD(Population) OVER (
        ORDER BY Population DESC
    ) AS Next_Row_Population
FROM country
ORDER BY Population DESC
LIMIT 15;


-- 5. Calculate the difference from the previous row
WITH Population_Comparison AS (
    SELECT
        Name,
        Population,
        LAG(Population) OVER (
            ORDER BY Population DESC
        ) AS Previous_Population
    FROM country
)
SELECT
    Name AS Country_Name,
    Population,
    Previous_Population,
    Population - Previous_Population
        AS Population_Difference
FROM Population_Comparison
ORDER BY Population DESC
LIMIT 15;


-- 6. ROW_NUMBER(): Number countries within
-- each continent by population
SELECT
    Name AS Country_Name,
    Continent,
    Population,
    ROW_NUMBER() OVER (
        PARTITION BY Continent
        ORDER BY Population DESC
    ) AS Country_Rank
FROM country
ORDER BY Continent, Country_Rank;
```
