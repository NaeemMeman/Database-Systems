--
--Name: Mohammedneem Meman
--

BEGIN;

DROP TABLE IF EXISTS boats CASCADE;
DROP TABLE IF EXISTS buyers CASCADE;
DROP TABLE IF EXISTS transactions;



CREATE TABLE boats (
	prod_id integer NOT NULL,
	brand text NOT NULL,
	category text,
	cost numeric(15,2) NOT NULL,
	price numeric(15,2) NOT NULL
);

CREATE TABLE buyers (
	cust_id integer NOT NULL,
	fname text NOT NULL,
	lname text NOT NULL,
	city text NOT NULL,
	"state" char(2) NOT NULL,
	referrer text NOT NULL
);

CREATE TABLE transactions (
	trans_id integer NOT NULL,
	cust_id integer NOT NULL,
	prod_id integer NOT NULL,
	qty integer NOT NULL,
	price numeric(15,2) NOT NULL
);

\COPY boats FROM './boats.csv' DELIMITER ',' CSV HEADER;

\COPY buyers FROM './buyers.csv' DELIMITER ',' CSV HEADER;

\COPY transactions FROM './transactions.csv' DELIMITER ',' CSV HEADER;

ALTER TABLE ONLY boats
    ADD CONSTRAINT boats_pkey PRIMARY KEY (prod_id);

ALTER TABLE ONLY buyers
    ADD CONSTRAINT buyers_pkey PRIMARY KEY (cust_id);
	
ALTER TABLE ONLY transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (trans_id);
	
ALTER TABLE ONLY transactions
    ADD CONSTRAINT transactions_buyers_fkey FOREIGN KEY (cust_id) REFERENCES buyers(cust_id);

ALTER TABLE ONLY transactions
    ADD CONSTRAINT transactions_boats_fkey FOREIGN KEY (prod_id) REFERENCES boats(prod_id);

COMMIT;

ANALYZE boats;
ANALYZE buyers;
ANALYZE transactions;

