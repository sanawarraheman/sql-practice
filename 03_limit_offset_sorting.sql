```sql
-- ============================================
-- SQL PRACTICE: WORLD DATABASE
-- Topics: LIMIT, OFFSET, ORDER BY, ROUND()
-- Date: 18 October 2026
-- ============================================

-- 1. Select the database
USE world;

-- 2. Display the first 10 countries
SELECT *
FROM country
LIMIT 10;

-- 3. Fetch rows 22 to 31
-- Skip the first 21 rows and fetch the next 10
SELECT *
FROM country
ORDER BY Code
LIMIT 10 OFFSET 21;

-- 4. Display the top 2 countries by population
-- Check your actual population column name first
SELECT
    Code,
    Name,
    Continent,
    Population
FROM country
ORDER BY Population DESC
LIMIT 2;

-- 5. Display all columns from the country table
SELECT *
FROM country;

-- 6. Calculate population density
-- Formula: Population / Surface Area
-- ROUND(..., 2) returns 2 decimal places
SELECT
    Name,
    Continent,
    ROUND(Population / SurfaceArea, 2) AS Pop_Density
FROM country
WHERE SurfaceArea > 0
ORDER BY Pop_Density DESC
LIMIT 6 OFFSET 12;
```
