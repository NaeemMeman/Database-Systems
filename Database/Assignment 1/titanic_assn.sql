/*  DBase Assn 1:
Name: Mohammednaeem Meman

    Passengers on the Titanic:
        1,503 people died on the Titanic.
        - around 900 were passengers, 
        - the rest were crew members.

    This is a list of what we know about the passengers.
    Some lists show 1,317 passengers, 
        some show 1,313 - so these numbers are not exact, 
        but they will be close enough that we can spot trends and correlations.

    Lets' answer some questions about the passengers' survival data: 
 */

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- DELETE OR COMMENT-OUT the statements in section below after running them ONCE !!
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


/*  Create the table and get data into it: */
/*
DROP TABLE IF EXISTS passengers;

CREATE TABLE passengers (
    id INTEGER NOT NULL,
    lname TEXT,
    title TEXT,
    class TEXT, 
    age FLOAT,
    sex TEXT,
    survived INTEGER,
    code INTEGER
);

-- Now get the data into the database:
\COPY passengers FROM './titanic.csv' WITH (FORMAT csv);
*/
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- DELETE OR COMMENT-OUT the statements in the above section after running them ONCE !!
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


/* Some queries to get you started:  */


-- How many total passengers?:
SELECT COUNT(*) AS total_passengers FROM passengers;


-- How many survived?
SELECT COUNT(*) AS survived FROM passengers WHERE survived=1;


-- How many died?
SELECT COUNT(*) AS did_not_survive FROM passengers WHERE survived=0;


-- How many were female? Male?
SELECT COUNT(*) AS total_females FROM passengers WHERE sex='female';
SELECT COUNT(*) AS total_males FROM passengers WHERE sex='male';


-- How many total females died?  Males?
SELECT COUNT(*) AS no_survived_females FROM passengers WHERE sex='female' AND survived=0;
SELECT COUNT(*) AS no_survived_males FROM passengers WHERE sex='male' AND survived=0;


-- Percentage of females of the total?
SELECT 
    SUM(CASE WHEN sex='female' THEN 1.0 ELSE 0.0 END) / 
        CAST(COUNT(*) AS FLOAT)*100 
            AS tot_pct_female 
FROM passengers;


-- Percentage of males of the total?
SELECT 
    SUM(CASE WHEN sex='male' THEN 1.0 ELSE 0.0 END) / 
        CAST(COUNT(*) AS FLOAT)*100 
            AS tot_pct_male 
FROM passengers;


-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- %%%%%%%%%% Write queries that will answer the following questions:  %%%%%%%%%%%
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


-- 1.  What percent of passengers survived? (total)
SELECT 
    SUM(CASE WHEN survived=1 THEN 1.0 ELSE 0.0 END) / 
        CAST(COUNT(*) AS FLOAT)*100 
            AS tot_pct_survived 
FROM passengers;

-- 2.  What percentage of females survived?     (female_survivors / tot_females)
SELECT 
    SUM(CASE WHEN survived=1 AND sex='female' THEN 1.0 ELSE 0.0 END) / 
        SUM(CASE WHEN sex='female' THEN 1.0 ELSE 0.0 END) *100 
            AS pct_female_survived 
FROM passengers;

-- 3.  What percentage of males that survived?      (male_survivors / tot_males)
SELECT 
    SUM(CASE WHEN survived=1 AND sex='male' THEN 1.0 ELSE 0.0 END) / 
        SUM(CASE WHEN sex='male' THEN 1.0 ELSE 0.0 END) *100 
            AS pct_male_survived 
FROM passengers;

-- 4.  How many people total were in First class, Second class, Third class, or of class unknown ?
--1st Class
SELECT COUNT(*) AS tot_1st_class FROM passengers WHERE class='1st';

--2nd Class
SELECT COUNT(*) AS tot_2nd_class FROM passengers WHERE class='2nd';

--3rd Class
SELECT COUNT(*) AS tot_3rd_class FROM passengers WHERE class='3rd';

--Unknown Class
SELECT COUNT(*) AS tot_unknown_class FROM passengers WHERE class IS NULL;

-- 5.  What is the total number of people in First and Second class ?
SELECT COUNT(*) AS tot_1st_and_2nd_class FROM passengers WHERE class='1st' OR class='2nd';

-- 6.  What are the survival percentages of the different classes? (3).
--1st class
SELECT 
    SUM(CASE WHEN survived=1 AND class='1st' THEN 1.0 ELSE 0.0 END) / 
        SUM(CASE WHEN class='1st' THEN 1.0 ELSE 0.0 END) *100 
            AS pct_1st_class_survived 
FROM passengers;

--2nd class
SELECT 
    SUM(CASE WHEN survived=1 AND class='2nd' THEN 1.0 ELSE 0.0 END) / 
        SUM(CASE WHEN class='2nd' THEN 1.0 ELSE 0.0 END) *100 
            AS pct_2nd_class_survived 
FROM passengers;

--3rd class
SELECT 
    SUM(CASE WHEN survived=1 AND class='3rd' THEN 1.0 ELSE 0.0 END) / 
        SUM(CASE WHEN class='3rd' THEN 1.0 ELSE 0.0 END) *100 
            AS pct_3rd_class_survived 
FROM passengers;


-- 7.  Can you think of other interesting questions about this dataset?
--      I.e., is there anything interesting we can learn from it?  
--      Try to come up with at least two new questions we could ask.

--      Example:
--      Can we calcualte the odds of survival if you are a female in Second Class?

--      Could we compare this to the odds of survival if you are a female in First Class?
--      If we can answer this question, is it meaningful?  Or just a coincidence ... ?

--Question 1: What are the odds of survival if you are a male in 3rd class? 
--(male survived in 3rd class/total males in 3rd class)

--Question 2: What are the odds of survival if you are a female in 3rd class?
--(female survived in 3rd class/total females in 3rd class)

--If we can answer these two question we will be able to learn whether males or females
--were prioritized more for survival in the 3rd class.


-- 8.  Can you answer the questions you thought of above?
--      Are you able to write the query to find the answer now?  

--      If so, try to answer the question you proposed.
--      If you aren't able to answer it, try to answer the following:
--      Can we calcualte the odds of survival if you are a female in Second Class?

--Chance of survival if you were a male in 3rd class
SELECT 
    SUM(CASE WHEN survived=1 AND class='3rd' AND sex='male' THEN 1.0 ELSE 0.0 END) / 
        SUM(CASE WHEN class='3rd' AND sex='male' THEN 1.0 ELSE 0.0 END) *100 
            AS pct_3rd_class_males_survived 
FROM passengers;

--Chance of survival if you were a female in 3rd class
SELECT 
    SUM(CASE WHEN survived=1 AND class='3rd' AND sex='female' THEN 1.0 ELSE 0.0 END) / 
        SUM(CASE WHEN class='3rd' AND sex='female' THEN 1.0 ELSE 0.0 END) *100 
            AS pct_3rd_class_females_survived 
FROM passengers;

-- 9.  If someone asserted that your results for Question #8 were incorrect,
--     how could you defend your results, and verify that they are indeed correct?

--My results are correct because I am looking for the chance a male/female has to survive
--in 3rd class. To do that I would need to divide the number of males/females in 3rd class
--who survived with total number of males/females in 3rd class. I can't just divide the
--number of males/females who survived with just just total number of passengers in 3rd class
--because the number of males and females is different so it would give the wrong answer if I were
--to not take the sex of the person into account. I also can't divivde by passengers from all classes
--because every class has different number of people and it would give the wrong picture if I didn't
--exclude the other classes.

--My SQL queries are also written correctly because I use the sum of 3rd class male/female survivors
--and divivde it by the total number of 3rd class male/female passengers and then multiplied by 100
--which converts it to a percent. That gives me the correct answer I want.

/*
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    Email me ONLY this document - as an attachment.  You may just fill in your answers above.

    Do NOT send any other format except for one single .sql file.

    ZIP folders, word documents, and any other format (other than .sql) will receive zero credit.

    Do NOT copy and paste your queries into the body of the email.

    Your sql should run without errors - please test it beforehand.

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
*/


