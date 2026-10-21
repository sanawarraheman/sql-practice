```sql
-- ============================================
-- SQL PRACTICE: WORLD DATABASE
-- Topic: SQL JOINS
-- Date: 21 October 2026
-- ============================================

USE world;

-- 1. INNER JOIN
-- Show cities with their country names
SELECT
    city.Name AS City_Name,
    country.Name AS Country_Name,
    country.Continent
FROM city
INNER JOIN country
    ON city.CountryCode = country.Code
LIMIT 10;


-- 2. INNER JOIN with WHERE
-- Show cities belonging to India
SELECT
    city.Name AS City_Name,
    country.Name AS Country_Name
FROM city
INNER JOIN country
    ON city.CountryCode = country.Code
WHERE country.Name = 'India';


-- 3. JOIN with ORDER BY
-- Show the 10 most populated cities
SELECT
    city.Name AS City_Name,
    country.Name AS Country_Name,
    city.Population AS City_Population
FROM city
INNER JOIN country
    ON city.CountryCode = country.Code
ORDER BY city.Population DESC
LIMIT 10;


-- 4. JOIN with GROUP BY
-- Count cities in each country
SELECT
    country.Name AS Country_Name,
    COUNT(city.ID) AS Total_Cities
FROM country
INNER JOIN city
    ON country.Code = city.CountryCode
GROUP BY country.Code, country.Name
ORDER BY Total_Cities DESC
LIMIT 10;


-- 5. LEFT JOIN
-- Show all countries, including countries
-- that do not have a matching city
SELECT
    country.Name AS Country_Name,
    city.Name AS City_Name
FROM country
LEFT JOIN city
    ON country.Code = city.CountryCode
LIMIT 20;


-- 6. LEFT JOIN with COUNT
-- Count cities for every country
SELECT
    country.Name AS Country_Name,
    COUNT(city.ID) AS Total_Cities
FROM country
LEFT JOIN city
    ON country.Code = city.CountryCode
GROUP BY country.Code, country.Name
ORDER BY Total_Cities DESC
LIMIT 10;
```
