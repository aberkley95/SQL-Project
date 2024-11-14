SELECT *
FROM cities2;

-- Standardize

SELECT *
FROM cities2
WHERE humidity LIKE '%comfortable';

UPDATE cities2
SET humidity = 'comfortable'
WHERE humidity LIKE '%comfortable';

UPDATE cities2
SET humidity = 'dry'
WHERE humidity LIKE '%dry';

SELECT DISTINCT
humidity 
FROM cities2;

SELECT DISTINCT 
size
FROM cities2;

UPDATE cities2
SET size = 'town'
WHERE size LIKE '%town';

UPDATE cities2
SET size = 'metropolis'
WHERE size LIKE '%metropolis';

UPDATE cities2
SET size = 'large city'
WHERE size LIKE '%large city';

UPDATE cities2
SET size = 'small city'
WHERE size LIKE '%small city';

UPDATE cities2
SET size = 'rural'
WHERE size LIKE '%rural';

UPDATE cities2
SET size = 'medium city'
WHERE size LIKE '%medium city';

SELECT DISTINCT 
size
FROM cities2;

SELECT *
FROM cities2;

-- Drop Columns

ALTER TABLE cities2
DROP COLUMN City_ID;

-- Data Analysis

-- 1. Which prospective city is the cheapest to live in?

SELECT MIN(median_home_cost)
FROM cities2;

SELECT city, state
FROM cities2
WHERE median_home_cost = 
	(
	SELECT MIN(median_home_cost) 
    FROM cities2
    );
    
-- Based on the average median home cost, Springfield. Illinois is the cheapest listed city.

-- 2. Which city has the lowest crime rate?

SELECT * 
FROM cities2;

SELECT city, state
FROM cities2
WHERE crime_rate = 
	(
	SELECT MIN(crime_rate)
    FROM cities2
    );
    
-- Based on the average crime rate, Pleasant Grove, Utah is the safest city listed.
    
-- 3. Which of the medium cities is the cheapest to live in?

SELECT * 
FROM cities2;

SELECT MIN(median_home_cost) 
FROM cities2
WHERE size = 'medium city';

SELECT city, state
FROM cities2
WHERE median_home_cost = 
	(
    SELECT MIN(median_home_cost)
    FROM cities2
    WHERE size = 'medium city'
    );
    
-- Based on the average median home cost, the cheapest city to live in that is medium sized is Lacey, Washington :)
    
-- 4. Which comfortably humid city has the lowest crime rate?

SELECT city, state
FROM cities2
WHERE crime_rate = 
	(
    SELECT MIN(crime_rate)
    FROM cities2
    WHERE humidity = 'comfortable'
    );
    
-- Based on the average crime rate, the safest city with a comfortable humidity level is Bainbridge Island, Washington
    
-- 5. Which liberal leaning city has the highest average income?

SELECT *
FROM cities2;

SELECT city, state
FROM cities2
WHERE average_income = 
	(
    SELECT MAX(average_income)
    FROM cities2
    WHERE political_leaning = 'liberal'
    );
    
-- The city with the highest average income that is liberal leaning is Redmond, Washington
    
-- 6. Is there a way I can find the best city to live in out of our prospective cities in terms of all the things that are important to me? (housing costs, crime rates, humidity, air quality, liberal leaning, medium sized)

SELECT city, state
FROM cities2
WHERE median_home_cost = 
	(
    SELECT MIN(median_home_cost)
    FROM cities2
    )
	AND crime_rate = 
    (
    SELECT MIN(crime_rate)
    FROM cities2
    )
AND humidity = 'comfortable'
AND air_quality_avg < 50
AND political_leaning = 'liberal'
AND size = 'medium city'
    ;
    
    SELECT city, state
    FROM cities2
    WHERE humidity = 'comfortable'
    AND air_quality_avg < 50
    AND political_leaning = 'liberal'
    AND size = 'medium city'
    ;
    
    -- this narrows it down to two cities, Olympia, WA and Lacey, WA
    -- now I can just compare the housing costs and crime rates
    
    SELECT *
    FROM cities2;
    
    SELECT city, state, median_home_cost, crime_rate
    FROM cities2
    WHERE city = 'lacey' 
    OR city = 'olympia';
    
    -- Lacey, Washington: median home cost = 467900 crime rate = 17.6
    -- Olympia, Washington, median home cost = 472500 crime rate = 20.4
    -- Both cities are very comparable, but Lacey scores better in both categories. It has the lower crime rate and median home cost.

-- QUESTION: which of our prospective cities that meet all of my conditions is the cheapest and safest city to live in? (aka which city of the ones listed should I live in?)
-- PROCESS: first I narrowed down my cities by selecting only the ones that are medium sized, liberal leaning, has a comfortable humidity level and has an air quality average of lower than 50 (this standard I found online labeled as a 'good' level of air quality index)
-- only two cities met every one of my conditions, Olympia and Lacey Washington
-- I just compared the other stats that were important to me (housing costs and crime rate)
-- ANSWER: Lacey, Washington is the city I should live in :)





