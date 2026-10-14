```sql
-- ============================================
-- SQL PRACTICE: WORLD DATABASE
-- Topics:
-- SELECT, ALTER TABLE, Calculations, Aliases,
-- WHERE, ORDER BY, LIMIT, OFFSET
-- ============================================

-- 1. Select the world database
USE world;

-- 2. Display selected columns from the city table
SELECT Name, District, Population
FROM city;

-- 3. Display all columns from the country table
SELECT *
FROM country;


-- ============================================
-- 4. Rename columns in the city table
-- ============================================

ALTER TABLE city
CHANGE COLUMN Name City_Name CHAR(35);

ALTER TABLE city
CHANGE COLUMN Population City_Pop INT;


-- ============================================
-- 5. Rename columns in the country table
-- ============================================

ALTER TABLE country
CHANGE COLUMN Name Country_Name CHAR(52);

ALTER TABLE country
CHANGE COLUMN Population Country_Pop INT;


-- 6. Display country codes and country names
SELECT Code, Country_Name
FROM country;


-- ============================================
-- 7. Calculate population in millions and GNP in
--    thousands of millions (billions)
-- ============================================

SELECT
    Country_Name,
    Region,
    SurfaceArea,
    Country_Pop,
    LifeExpectancy,
    GNP,
    Country_Pop / 1000000 AS Cou_Pop_in_mn,
    GNP / 1000 AS GNP_in_bn
FROM country;


-- ============================================
-- 8. Calculate GNP per capita
-- ============================================

SELECT
    Country_Name,
    Region,
    SurfaceArea,
    Country_Pop,
    LifeExpectancy,
    GNP,
    Country_Pop / 1000000 AS Cou_Pop_in_mn,
    GNP / 1000 AS GNP_in_bn,
    ROUND(GNP * 1000000 / Country_Pop, 0) AS Per_cap_GNP
FROM country;


-- ============================================
-- 9. Filter countries by life expectancy
-- ============================================

SELECT *
FROM country
WHERE LifeExpectancy = 77.4;


-- ============================================
-- 10. Sort countries by GNP per capita
--     Highest to lowest
-- ============================================

SELECT
    Country_Name,
    Region,
    SurfaceArea,
    Country_Pop,
    LifeExpectancy,
    GNP,
    Country_Pop / 1000000 AS Cou_Pop_in_mn,
    ROUND(GNP / 1000, 0) AS GNP_in_bn,
    ROUND(GNP * 1000000 / Country_Pop, 0) AS Per_cap_GNP
FROM country
ORDER BY Per_cap_GNP DESC;


-- ============================================
-- 11. Sort by region, then country name
-- ============================================

SELECT
    Country_Name,
    Region,
    SurfaceArea,
    Country_Pop,
    LifeExpectancy,
    GNP,
    Country_Pop / 1000000 AS Cou_Pop_in_mn,
    ROUND(GNP / 1000, 0) AS GNP_in_bn,
    ROUND(GNP * 1000000 / Country_Pop, 0) AS Per_cap_GNP
FROM country
ORDER BY Region, Country_Name DESC;


-- ============================================
-- 12. Display the top 7 countries by GNP per capita
-- ============================================

SELECT
    Country_Name,
    Region,
    SurfaceArea,
    Country_Pop,
    LifeExpectancy,
    GNP,
    Country_Pop / 1000000 AS Cou_Pop_in_mn,
    ROUND(GNP / 1000, 0) AS GNP_in_bn,
    ROUND(GNP * 1000000 / Country_Pop, 0) AS Per_cap_GNP
FROM country
ORDER BY Per_cap_GNP DESC
LIMIT 7;


-- ============================================
-- 13. Use LIMIT and OFFSET for pagination
-- Display 50 rows after skipping the first 94 rows
-- ============================================

SELECT
    Country_Name,
    Region,
    SurfaceArea,
    Country_Pop,
    LifeExpectancy,
    GNP,
    Country_Pop / 1000000 AS Cou_Pop_in_mn,
    ROUND(GNP / 1000, 0) AS GNP_in_bn,
    ROUND(GNP * 1000000 / Country_Pop, 0) AS Per_cap_GNP
FROM country
ORDER BY Per_cap_GNP DESC
LIMIT 50 OFFSET 94;
```
