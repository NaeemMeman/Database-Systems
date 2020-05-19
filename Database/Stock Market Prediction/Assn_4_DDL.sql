--
--Mohammednaeem Meman
--

\connect assn456

DROP TABLE IF EXISTS awesome_performers;

CREATE TABLE temptable AS
	SELECT
		fundamentals."SYMBOL",
		fundamentals."YEAR ENDING",
		LAG(fundamentals."YEAR ENDING", 1) OVER(
			PARTITION BY fundamentals."SYMBOL"
			ORDER BY "YEAR ENDING"
			) AS "LAST YEAR ENDING",
		fundamentals."YEAR",
		LAG(fundamentals."YEAR", 1) OVER(
			PARTITION BY fundamentals."SYMBOL"
			) AS "LAST YEAR",
		prices."CLOSE",
		LAG(prices."CLOSE", 1) OVER(
			PARTITION BY fundamentals."SYMBOL"
			) AS "LAST YEAR CLOSE",
		(prices."CLOSE"/
		LAG(prices."CLOSE", 1) OVER(
			PARTITION BY fundamentals."SYMBOL"
			)) - 1
		AS "ANNUAL RETURN"
	FROM
		fundamentals
	INNER JOIN
		prices ON fundamentals."SYMBOL"=prices."SYMBOL"
		AND fundamentals."YEAR ENDING"=prices."DATE"	
;

CREATE TABLE awesome_performers AS
SELECT 
	*
FROM
	temptable
WHERE
	"ANNUAL RETURN" IS NOT NULL
	AND ("YEAR"-"LAST YEAR")=1
ORDER BY "ANNUAL RETURN" DESC
LIMIT 60 OFFSET 16
;

DROP TABLE IF EXISTS temptable;
