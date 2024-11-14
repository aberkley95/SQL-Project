-- Create table

USE project2;

CREATE TABLE cities2
LIKE cities;

SELECT *
FROM cities2;

INSERT cities2
SELECT * 
FROM cities;

SELECT *
FROM cities2;

SET sql_safe_updates = 0;

-- Standardize

ALTER TABLE cities2
RENAME COLUMN ï»¿State TO State;

ALTER TABLE cities2
RENAME COLUMN City_name TO City;

ALTER TABLE cities2
RENAME COLUMN City_Type TO Size;

SELECT *
FROM cities2;

UPDATE cities2
SET city = TRIM(city);

UPDATE cities2
SET State = TRIM(state);

SELECT DISTINCT state
FROM cities2
ORDER BY 1;

SELECT *
FROM cities2
WHERE state LIKE 'California%';

UPDATE cities2
SET state = 'California'
WHERE state LIKE 'California%';

SELECT DISTINCT city
FROM cities2;

UPDATE cities2
SET city = 'Salem'
WHERE city LIKE 'Salem%';

-- Remove Null or Blank Values

SELECT * 
FROM cities2
WHERE State IS NULL
AND City IS NULL;

SELECT *
FROM cities2
WHERE city IS NULL
OR city = ' ';

DELETE 
FROM cities2
WHERE state IS NULL
AND city IS NULL;

DELETE 
FROM cities2
WHERE state = ' '
AND city = ' ';

-- Remove Duplicates

ALTER TABLE cities2
INSERT COLUMN row_num
WHERE 
	ROW_NUMBER() OVER (
			PARTITION BY State, City) 
            AS row_num
	FROM 
		cities2;

	WITH duplicate_cte AS 
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY State, City) AS row_num
FROM cities2 
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

ALTER TABLE cities2
ADD City_ID INT NOT NULL AUTO_INCREMENT KEY;
    
DELETE t1
FROM cities2 t1
INNER JOIN cities2 t2
WHERE 
	t1.City_ID < t2.City_ID
    AND
    t1.City = t2.City;

SELECT *
FROM cities2;























