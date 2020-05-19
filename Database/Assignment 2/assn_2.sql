--Name: Mohammednaeem Meman

--Part I
--Is this database in Normal Form? If so which one is it?
--Note: while there is NULL data in the table, in class we were told to ignore that condition for this assignment.
--1NF:
--All columns in all tables have atomic data
--No table has any repeating columns
--2NF:
--It is in 1NF
--All of the non-key columns don't describe the primary key, like in the countrylanguage table, where isofficial column
--defines a combination of both the primary key language and the foreign key countrycode.
--Therefore, the database is in 1NF.
	

--Part II

--1. What are the top ten countries by economic activity (Gross National Product - ‘gnp’).
SELECT
	name,
	gnp
FROM 
	country
ORDER BY gnp DESC
LIMIT 10
;

--2. What are the top ten countries by GNP per capita? (watch out for division by zero here !)
SELECT
	name,
	gnp,
	population,
	gnp/population as gnp_per_capita
FROM
	country
WHERE
	population <> 0
ORDER BY gnp_per_capita DESC
LIMIT 10
;

--3. What are the ten most densely populated countries, and ten least densely populated countries?
--Ten Most Densely Populated Countries
SELECT
	name,
	population,
	surfacearea,
	population/surfacearea AS population_density
FROM
	country
WHERE
	surfacearea <> 0
ORDER BY population_density DESC
LIMIT 10
;
--Ten Least Densely Populated Countries
SELECT
	name,
	population,
	surfacearea,
	population/surfacearea AS population_density
FROM
	country
WHERE
	surfacearea <> 0
	AND population <> 0
ORDER BY population_density
LIMIT 10
;

--4a. What different forms of government are represented in this data? (‘DISTINCT’ keyword should help here.)
SELECT
	DISTINCT governmentform
FROM
	country
;

--4b. Which forms of government are most frequent? (distinct, count, group by order by)
SELECT
	DISTINCT governmentform,
	COUNT(governmentform) AS frequency
FROM
	country
GROUP BY
	governmentform
ORDER BY frequency DESC
;


--5. Which countries have the highest life expectancy? (watch for NULLs).
SELECT
	name,
	lifeexpectancy
FROM
	country
WHERE
	lifeexpectancy IS NOT NULL
ORDER BY lifeexpectancy DESC
LIMIT 10
;

--6. What are the top ten countries by total population, and what is the official language spoken there? (basic inner join)
SELECT
	country.name,
	country.population,
	countrylanguage.language,
	countrylanguage.isofficial
FROM
	country
INNER JOIN
	countrylanguage ON country.code=countrylanguage.countrycode
WHERE
	countrylanguage.isofficial='t'
ORDER BY country.population DESC
LIMIT 10
;

--7. What are the top ten most populated cities – along with which country they are in, and what continent they are on? (basic inner join)
SELECT
	city.name AS city_name,
	city.population AS city_population,
	country.name AS country_name,
	country.continent
FROM
	city
INNER JOIN
	country ON city.countrycode=country.code
ORDER BY city.population DESC
LIMIT 10
;

--8. What is the official language of the top ten cities you found in Question #7? (three-way inner join).
SELECT
	city.name AS city_name,
	city.population AS city_population,
	country.name AS country_name,
	country.continent,
	countrylanguage.language,
	countrylanguage.isofficial	
FROM
	city
INNER JOIN
	country ON city.countrycode=country.code
INNER JOIN
	countrylanguage ON city.countrycode=countrylanguage.countrycode
WHERE
	countrylanguage.isofficial='t'
ORDER BY city.population DESC
LIMIT 10
;

--9. Which of the cities from Question #7 are capitals of their country? (requires a join and a subquery).
WITH questionseven AS (
	SELECT
		city.name AS city_name,
		city.population AS city_population,
		country.name AS country_name,
		country.continent,
		country.capital=city.id AS iscapital
	FROM
		city
	INNER JOIN
		country ON city.countrycode=country.code
	ORDER BY city.population DESC
	LIMIT 10
)
SELECT
	*
FROM 
	questionseven
WHERE
	iscapital='t'
;

--10. For the cities found in Question#9, what percentage of the country’s population lives in the capital city? (watch your int’s vs floats !).
WITH questionseven AS (
	SELECT
		city.name AS city_name,
		city.population AS city_population,
		country.name AS country_name,
		country.population AS country_population,
		country.continent,
		country.capital=city.id AS iscapital
	FROM
		city
	INNER JOIN
		country ON city.countrycode=country.code
	ORDER BY city.population DESC
	LIMIT 10
)
SELECT
	city_name,
	city_population,
	country_name,
	country_population,
	CAST(city_population AS FLOAT)
	/
	CAST(country_population AS FLOAT)
	*
	100 AS percent_of_country_population_in_city
FROM 
	questionseven
WHERE
	iscapital='t'
;