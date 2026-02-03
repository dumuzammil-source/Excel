-- =============================================
-- AGGREGATION IN SQL - ASSIGNMENT SOLUTIONS
-- Database Used: WORLD (MySQL Sample Database)
-- =============================================

USE world;

-- =============================================
-- Q1: Count how many cities are there in each country
-- =============================================
SELECT co.Name AS Country, COUNT(ci.ID) AS NumberOfCities
FROM country co
LEFT JOIN city ci ON co.Code = ci.CountryCode
GROUP BY co.Name;

-- =============================================
-- Q2: Display all continents having more than 30 countries
-- =============================================
SELECT Continent, COUNT(Code) AS CountryCount
FROM country
GROUP BY Continent
HAVING COUNT(Code) > 30;

-- =============================================
-- Q3: List regions whose total population exceeds 200 million
-- =============================================
SELECT Region, SUM(Population) AS TotalPopulation
FROM country
GROUP BY Region
HAVING SUM(Population) > 200000000;

-- =============================================
-- Q4: Top 5 continents by average GNP per country
-- =============================================
SELECT Continent, AVG(GNP) AS AvgGNP
FROM country
GROUP BY Continent
ORDER BY AvgGNP DESC
LIMIT 5;

-- =============================================
-- Q5: Total number of official languages spoken in each continent
-- =============================================
SELECT co.Continent, COUNT(cl.Language) AS OfficialLanguages
FROM country co
JOIN countrylanguage cl ON co.Code = cl.CountryCode
WHERE cl.IsOfficial = 'T'
GROUP BY co.Continent;

-- =============================================
-- Q6: Maximum and minimum GNP for each continent
-- =============================================
SELECT Continent, MAX(GNP) AS MaxGNP, MIN(GNP) AS MinGNP
FROM country
GROUP BY Continent;

-- =============================================
-- Q7: Country with the highest average city population
-- =============================================
SELECT co.Name AS Country, AVG(ci.Population) AS AvgCityPopulation
FROM country co
JOIN city ci ON co.Code = ci.CountryCode
GROUP BY co.Name
ORDER BY AvgCityPopulation DESC
LIMIT 1;

-- =============================================
-- Q8: Continents where the average city population is greater than 200,000
-- =============================================
SELECT co.Continent, AVG(ci.Population) AS AvgCityPopulation
FROM country co
JOIN city ci ON co.Code = ci.CountryCode
GROUP BY co.Continent
HAVING AVG(ci.Population) > 200000;

-- =============================================
-- Q9: Total population and average life expectancy for each continent
--     Ordered by average life expectancy descending
-- =============================================
SELECT Continent,
       SUM(Population) AS TotalPopulation,
       AVG(LifeExpectancy) AS AvgLifeExpectancy
FROM country
GROUP BY Continent
ORDER BY AvgLifeExpectancy DESC;

-- =============================================
-- Q10: Top 3 continents with highest average life expectancy
--      Only where total population > 200 million
-- =============================================
SELECT Continent,
       SUM(Population) AS TotalPopulation,
       AVG(LifeExpectancy) AS AvgLifeExpectancy
FROM country
GROUP BY Continent
HAVING SUM(Population) > 200000000
ORDER BY AvgLifeExpectancy DESC
LIMIT 3;

-- =============================================
-- END OF ASSIGNMENT
-- =============================================
