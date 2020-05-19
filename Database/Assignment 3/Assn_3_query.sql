--
--Name: Mohammednaeem Meman
--

--1. We want to spend some advertising money - where should we spend it? I.e., What is the best referral source of our buyers?
--The referral source which has had the most transactions
SELECT
	buyers.referrer,
	COUNT(transactions.trans_id) AS frequency
FROM
	buyers
INNER JOIN 
	transactions ON buyers.cust_id=transactions.cust_id
GROUP BY 
	buyers.referrer
ORDER BY frequency DESC
LIMIT 1
;

--2. Which of our customers has not bought a boat yet?
SELECT
	buyers.cust_id,
	buyers.fname,
	buyers.lname
FROM
	buyers
LEFT JOIN
	transactions ON buyers.cust_id=transactions.cust_id
WHERE
	transactions.trans_id IS NULL
;

--3. Which boats do we have in inventory - i.e., have not sold?
SELECT
	boats.prod_id,
	boats.brand,
	boats.category
FROM
	boats
LEFT JOIN
	transactions ON boats.prod_id=transactions.prod_id
WHERE
	transactions.trans_id IS NULL
;

--4. What boat did Alan Weston buy?
SELECT
	buyers.cust_id,
	buyers.fname,
	buyers.lname,
	boats.prod_id,
	boats.brand,
	boats.category
FROM
	buyers
INNER JOIN
	transactions ON buyers.cust_id=transactions.cust_id
INNER JOIN
	boats ON transactions.prod_id=boats.prod_id
WHERE
	fname='Alan'AND lname='Weston'
;

--5. Who are our VIP customers? I.e., Has anyone bought more than one boat?
--Hint:  Think 'WITH' clause, subquery, or UNION.
--It's probably adviseable to do a subquery first, to get customer id's that
--appear in the 'transactions' table more than once.
--Then, after we have those, we can join them with the 'buyers' table
--to get the first and last names.

WITH temptable AS (
	SELECT
		cust_id,
		COUNT(cust_id) AS num_of_transactions
	FROM
		transactions
	GROUP BY cust_id
	HAVING 
		COUNT(cust_id) > 1
	ORDER BY cust_id
)

SELECT
	temptable.cust_id,
	buyers.fname,
	buyers.lname,
	temptable.num_of_transactions
FROM
	temptable
INNER JOIN
	buyers ON temptable.cust_id=buyers.cust_id
;
	

