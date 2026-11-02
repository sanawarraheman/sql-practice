```sql
-- ==================================================
-- SQL PRACTICE: STRING FUNCTIONS
-- Topics: UPPER, LOWER, LENGTH, TRIM,
--         CONCAT, SUBSTRING, REPLACE, LOCATE
-- Date: 2 November 2026
-- Database: world
-- ==================================================

USE world;


-- 1. Convert country names to uppercase
SELECT
    Name,
    UPPER(Name) AS Uppercase_Name
FROM country
LIMIT 10;


-- 2. Convert country names to lowercase
SELECT
    Name,
    LOWER(Name) AS Lowercase_Name
FROM country
LIMIT 10;


-- 3. Find the length of each country name
SELECT
    Name,
    LENGTH(Name) AS Name_Length
FROM country
ORDER BY Name_Length DESC
LIMIT 10;


-- 4. Remove extra spaces from text
SELECT
    TRIM('   Data Analyst   ') AS Cleaned_Text;


-- 5. Combine country name and continent
SELECT
    CONCAT(Name, ' - ', Continent) AS Country_Details
FROM country
LIMIT 10;


-- 6. Extract the first 3 characters
-- from each country name
SELECT
    Name,
    SUBSTRING(Name, 1, 3) AS Short_Name
FROM country
LIMIT 10;


-- 7. Replace spaces with underscores
SELECT
    Name,
    REPLACE(Name, ' ', '_') AS Modified_Name
FROM country
LIMIT 10;


-- 8. Find the position of letter 'a'
-- in each country name
SELECT
    Name,
    LOCATE('a', Name) AS Letter_Position
FROM country
LIMIT 10;


-- 9. Remove leading and trailing spaces
-- from country names
SELECT
    Name,
    TRIM(Name) AS Cleaned_Country_Name
FROM country;


-- 10. Create a combined country label
SELECT
    CONCAT(
        UPPER(Name),
        ' | ',
        LOWER(Continent)
    ) AS Country_Label
FROM country
LIMIT 10;


-- 11. Find country names containing 'land'
SELECT
    Name
FROM country
WHERE LOWER(Name) LIKE '%land%';


-- 12. Display the first 5 characters
-- of country names
SELECT
    Name,
    LEFT(Name, 5) AS First_Five_Characters
FROM country
LIMIT 10;
```
