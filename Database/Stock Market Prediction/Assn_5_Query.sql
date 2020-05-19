--
--Mohammednaeem Meman
--

\connect assn456

--NET WORTH GROWTH
SELECT
	var_pop((((c."TOTAL ASSETS"-c."TOTAL LIABILITIES")
	-(b."TOTAL ASSETS"-b."TOTAL LIABILITIES"))
	/(c."TOTAL ASSETS"-c."TOTAL LIABILITIES"))) AS "VARIATION FOR NET WORTH GROWTH",
	avg((((c."TOTAL ASSETS"-c."TOTAL LIABILITIES")
	-(b."TOTAL ASSETS"-b."TOTAL LIABILITIES"))
	/(c."TOTAL ASSETS"-c."TOTAL LIABILITIES"))) AS "AVERAGE FOR NET WORTH GROWTH",
	var_pop((((c."TOTAL ASSETS"-c."TOTAL LIABILITIES")
	-(b."TOTAL ASSETS"-b."TOTAL LIABILITIES"))
	/(c."TOTAL ASSETS"-c."TOTAL LIABILITIES")))
	/
	avg((((c."TOTAL ASSETS"-c."TOTAL LIABILITIES")
	-(b."TOTAL ASSETS"-b."TOTAL LIABILITIES"))
	/(c."TOTAL ASSETS"-c."TOTAL LIABILITIES"))) AS "SCORE"
FROM
	awesome_performers a
INNER JOIN
	fundamentals b ON a."SYMBOL"=b."SYMBOL"
	AND a."YEAR ENDING"=b."YEAR ENDING"
INNER JOIN 
	fundamentals c ON a."SYMBOL"=c."SYMBOL"
	AND a."LAST YEAR ENDING"=c."YEAR ENDING"
;


--NET INCOME GROWTH
SELECT
	var_pop(((c."NET INCOME"-b."NET INCOME")/c."NET INCOME")) AS "VARIANCE FOR NET INCOME GROWTH",
	avg(((c."NET INCOME"-b."NET INCOME")/c."NET INCOME")) AS "AVERAGE FOR NET INCOME GROWTH",
	var_pop(((c."NET INCOME"-b."NET INCOME")/c."NET INCOME"))
	/
	avg(((c."NET INCOME"-b."NET INCOME")/c."NET INCOME")) AS "SCORE"
FROM
	awesome_performers a
INNER JOIN
	fundamentals b ON a."SYMBOL"=b."SYMBOL"
	AND a."YEAR ENDING"=b."YEAR ENDING"
INNER JOIN 
	fundamentals c ON a."SYMBOL"=c."SYMBOL"
	AND a."LAST YEAR ENDING"=c."YEAR ENDING"
;

--REVENUE GROWTH
SELECT
	var_pop(((c."TOTAL REVENUE"-b."TOTAL REVENUE")/c."TOTAL REVENUE")) AS "VARIANCE REVENUE GROWTH",
	avg(((c."TOTAL REVENUE"-b."TOTAL REVENUE")/c."TOTAL REVENUE")) AS "AVERAGE REVENUE GROWTH",
	var_pop(((c."TOTAL REVENUE"-b."TOTAL REVENUE")/c."TOTAL REVENUE"))
	/
	avg(((c."TOTAL REVENUE"-b."TOTAL REVENUE")/c."TOTAL REVENUE")) AS "SCORE"
FROM
	awesome_performers a
INNER JOIN
	fundamentals b ON a."SYMBOL"=b."SYMBOL"
	AND a."YEAR ENDING"=b."YEAR ENDING"
INNER JOIN 
	fundamentals c ON a."SYMBOL"=c."SYMBOL"
	AND a."LAST YEAR ENDING"=c."YEAR ENDING"
;

--EARNINGS-PER-SHARE
SELECT
	var_pop(b."EARNINGS PER SHARE") AS "VARIANCE FOR EARNINGS-PER-SHARE",
	avg(b."EARNINGS PER SHARE") AS "AVERAGE FOR EARNINGS-PER-SHARE",
	var_pop(b."EARNINGS PER SHARE")
	/
	avg(b."EARNINGS PER SHARE") AS "SCORE"
FROM
	awesome_performers a
INNER JOIN
	fundamentals b ON a."SYMBOL"=b."SYMBOL"
	AND a."YEAR ENDING"=b."YEAR ENDING"
;
	
--EARNINGS-PER-SHARE GROWTH
SELECT
	var_pop(((c."EARNINGS PER SHARE"-b."EARNINGS PER SHARE")/c."EARNINGS PER SHARE")) AS "VARIANCE FOR EARNINGS-PER-SHARE GROWTH",
	avg(((c."EARNINGS PER SHARE"-b."EARNINGS PER SHARE")/c."EARNINGS PER SHARE")) AS "AVERAGE FOR EARNINGS-PER-SHARE GROWTH",
	var_pop(((c."EARNINGS PER SHARE"-b."EARNINGS PER SHARE")/c."EARNINGS PER SHARE"))
	/
	avg(((c."EARNINGS PER SHARE"-b."EARNINGS PER SHARE")/c."EARNINGS PER SHARE")) AS "SCORE"
FROM
	awesome_performers a
INNER JOIN
	fundamentals b ON a."SYMBOL"=b."SYMBOL"
	AND a."YEAR ENDING"=b."YEAR ENDING"
INNER JOIN 
	fundamentals c ON a."SYMBOL"=c."SYMBOL"
	AND a."LAST YEAR ENDING"=c."YEAR ENDING"
;

--PRICE-TO-EARNINGS RATIO
SELECT
	var_pop((a."LAST YEAR CLOSE"/b."EARNINGS PER SHARE")) AS "VARIANCE FOR PRICE-TO-EARNINGS RATIO",
	avg((a."LAST YEAR CLOSE"/b."EARNINGS PER SHARE")) AS "AVERAGE FOR PRICE-TO-EARNINGS RATIO",
	var_pop((a."LAST YEAR CLOSE"/b."EARNINGS PER SHARE"))
	/
	avg((a."LAST YEAR CLOSE"/b."EARNINGS PER SHARE")) AS "SCORE"
FROM
	awesome_performers a
INNER JOIN
	fundamentals b ON a."SYMBOL"=b."SYMBOL"
	AND a."YEAR ENDING"=b."YEAR ENDING"
;

--CASH VS LIABILITIES
SELECT
	var_pop((b."CASH AND CASH EQUIVALENTS"/b."TOTAL LIABILITIES")) AS "VARIANCE FOR CASH VS LIABILITIES",
	avg((b."CASH AND CASH EQUIVALENTS"/b."TOTAL LIABILITIES")) AS "AVERAGE FOR CASH VS LIABILITIES",
	var_pop((b."CASH AND CASH EQUIVALENTS"/b."TOTAL LIABILITIES"))
	/
	avg((b."CASH AND CASH EQUIVALENTS"/b."TOTAL LIABILITIES")) AS "SCORE"
FROM
	awesome_performers a
INNER JOIN
	fundamentals b ON a."SYMBOL"=b."SYMBOL"
	AND a."YEAR ENDING"=b."YEAR ENDING"
;

--Looking at the scores leads me to believe cash vs liabilities and revenue growth are the best indicators for picking a company

--Original List
SELECT
	a."SYMBOL",
	a."YEAR",
	(a."CASH AND CASH EQUIVALENTS"/a."TOTAL LIABILITIES") AS "CASH VS LIABILITIES",
	((c."TOTAL REVENUE"-a."TOTAL REVENUE")/c."TOTAL REVENUE") AS "REVENUE GROWTH",
	b."SECTOR",
	b."SUB-INDUSTRY",
	b."COMPANY"
FROM
	fundamentals a
INNER JOIN
	securities b ON a."SYMBOL"=b."SYMBOL"
INNER JOIN
	fundamentals c ON a."SYMBOL"=c."SYMBOL"
	AND c."YEAR"=2015
WHERE
	a."YEAR"=2016
	AND (a."CASH AND CASH EQUIVALENTS"/a."TOTAL LIABILITIES") >= 0.1
	AND (a."CASH AND CASH EQUIVALENTS"/a."TOTAL LIABILITIES") <= 0.3
	AND ((c."TOTAL REVENUE"-a."TOTAL REVENUE")/c."TOTAL REVENUE") >= -0.1
	AND ((c."TOTAL REVENUE"-a."TOTAL REVENUE")/c."TOTAL REVENUE") <= 0.0
ORDER BY b."SECTOR"
;

--Extended List
SELECT
	a."SYMBOL",
	a."YEAR",
	(a."CASH AND CASH EQUIVALENTS"/a."TOTAL LIABILITIES") AS "CASH VS LIABILITIES",
	((c."TOTAL REVENUE"-a."TOTAL REVENUE")/c."TOTAL REVENUE") AS "REVENUE GROWTH",
	b."SECTOR",
	b."SUB-INDUSTRY",
	b."COMPANY"
FROM
	fundamentals a
INNER JOIN
	securities b ON a."SYMBOL"=b."SYMBOL"
INNER JOIN
	fundamentals c ON a."SYMBOL"=c."SYMBOL"
	AND c."YEAR"=2015
WHERE
	a."YEAR"=2016
	AND (a."CASH AND CASH EQUIVALENTS"/a."TOTAL LIABILITIES") >= 0.06
	AND (a."CASH AND CASH EQUIVALENTS"/a."TOTAL LIABILITIES") <= 0.34
	AND ((c."TOTAL REVENUE"-a."TOTAL REVENUE")/c."TOTAL REVENUE") >= -0.14
	AND ((c."TOTAL REVENUE"-a."TOTAL REVENUE")/c."TOTAL REVENUE") <= 0.04
ORDER BY b."SECTOR"
;


--Information Technology: NVDA, V.
--Consumer Discretionary: DRI, TJX.
--Consumer Staples: EL, COST.
--Health Care: HOLX, MCK.
--Industrials: FDX, CTAS.


--What I found from my analysis was that there was a low variance for cash vs liabilities 
--and revenue growth in the top performers. So as a general rule I found out that the top
--performers had five times more liabilities than cash and their revenue growth was -5%.
--I used the variance to find out that the range was between 0.1 to 0.3 for cash to liabilities
--ratio and the range for total revenue growth was -0.1 to 0.0 and I used to those to create a list
--of companies and used the list to pick most of my stocks, but there weren't enough stocks in
--the list to pick two from each sector so I created a new list and extended the range by 0.8 and
--picked the remaining stocks from that list and came up with my list of stocks to invest in.

--For Information Technology I picked NVDA and V because they were in my original list and were closest to the
--center of the range.
--For Consumer Discretionary I picked DRI and TJX which were the only two companies in that sector in my original
--list.
--For Consumer Staples I picked EL and COST as they were in my original list and they were the closest to the center
--of the range.
--For Health Care I picked HOLX from my original list as it was the only company in that sector and MCK from the extended
--list since it was closest to the center of the range.
--For Industrials I picked FDX from the my original list as it was the only company in that sector and CTAS from the extended
--list since it was the closest to the range.