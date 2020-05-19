--
--Mohammednaeem Meman
--

--Commands to make and load the backup
--pg_dump -U postgres -d assn456 > backup.sql
--psql -U postgres -f backup.sql

\connect assn456

--Test of a view query which works under the assumption that the year is 2016
SELECT
	a."SYMBOL",
	c."DATE",
	c."OPEN" AS "OPENING PRICE",
	((b."TOTAL REVENUE"-a."TOTAL REVENUE")/b."TOTAL REVENUE") AS "CURRENT TOTAL REVENUE GROWTH",
	(a."CASH AND CASH EQUIVALENTS"/a."TOTAL LIABILITIES") AS "CURRENT CASH VS LIABILITIES",
	d."SECTOR"
FROM
	fundamentals a
INNER JOIN
	fundamentals b ON a."SYMBOL"=b."SYMBOL"
	AND a."YEAR"-1=b."YEAR"
INNER JOIN 
	prices c ON a."SYMBOL"=c."SYMBOL"
	AND '2016-12-30'=c."DATE"
INNER JOIN
	securities d ON a."SYMBOL"=d."SYMBOL"
WHERE
	(a."YEAR"=2016)
	AND 
	(a."SYMBOL"='NVDA' 
	OR a."SYMBOL"='V'
	OR a."SYMBOL"='DRI'
	OR a."SYMBOL"='TJX'
	OR a."SYMBOL"='EL'
	OR a."SYMBOL"='COST'
	OR a."SYMBOL"='HOLX'
	OR a."SYMBOL"='MCK'
	OR a."SYMBOL"='FDX'
	OR a."SYMBOL"='CTAS')
ORDER BY d."SECTOR"
;

--Creating a view, this shouldn't output anything since we don't have the data.
CREATE VIEW portfolio AS
SELECT
	a."SYMBOL",
	c."DATE",
	c."OPEN" AS "OPENING PRICE",
	((b."TOTAL REVENUE"-a."TOTAL REVENUE")/b."TOTAL REVENUE") AS "CURRENT TOTAL REVENUE GROWTH",
	(a."CASH AND CASH EQUIVALENTS"/a."TOTAL LIABILITIES") AS "CURRENT CASH VS LIABILITIES",
	d."SECTOR"
FROM
	fundamentals a
INNER JOIN
	fundamentals b ON a."SYMBOL"=b."SYMBOL"
	AND a."YEAR"-1=b."YEAR"
INNER JOIN 
	prices c ON a."SYMBOL"=c."SYMBOL"
	AND CURRENT_DATE=c."DATE"
INNER JOIN
	securities d ON a."SYMBOL"=d."SYMBOL"
WHERE
	(a."YEAR"=EXTRACT(YEAR FROM CURRENT_DATE))
	AND 
	(a."SYMBOL"='NVDA' 
	OR a."SYMBOL"='V'
	OR a."SYMBOL"='DRI'
	OR a."SYMBOL"='TJX'
	OR a."SYMBOL"='EL'
	OR a."SYMBOL"='COST'
	OR a."SYMBOL"='HOLX'
	OR a."SYMBOL"='MCK'
	OR a."SYMBOL"='FDX'
	OR a."SYMBOL"='CTAS')
ORDER BY d."SECTOR"
;

--Commmand to create and store the results of the view in a .csv file
--psql -U postgres -tAF, -f Assn_6.sql > output_file.csv

--Investment Results from 12/30/2016 OPEN - ~12/29/2017 CLOSE
--|SYMBOL|STARTING PRICE|ENDING PRICE|
--|TJX   |75.94         |76.46       |*Stock split in 2 in 2018 so now price is shown as 37.97 for 12/30/2016 and 38.23 for 12/29/2017
--|DRI   |73.57         |96.02       |
--|COST  |160.89        |186.12      |
--|EL    |77.31         |127.24      |
--|HOLX  |40.21         |42.75       |
--|MCK   |141.47        |155.95      |
--|CTAS  |116.58        |155.83      |
--|FDX   |187.8         |249.54      |
--|V     |78.43         |114.02      |
--|NVDA  |111.35        |193.50      |

--Returns
--TJX: 1%
--DRI: 31%
--COST: 15%
--EL: 65%
--HOLX: 6%
--MCK: 10%
--CTAS: 34%
--FDX: 33%
--V: 45%
--NVDA: 74%
--Portfolio: 31%

