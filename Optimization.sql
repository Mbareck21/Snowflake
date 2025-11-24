-- This example demonstrate data pruning by comparing two equivalent date filtering approaches
-- It creates sample data and shows inefficient vs efficient date filtering

USE ROLE ACCOUNTADMIN;
USE DATABASE FIRST_DB;
USE SCHEMA FIRST_DB.FIRST_SCHEMA;

-- Generate 100k rows of sample data with random dates in 2024
CREATE OR REPLACE TABLE expensive_table AS
SELECT 
    SEQ4() as id,  -- Sequential ID generation
    DATEADD(day, UNIFORM(1, 365, RANDOM()), '2024-01-01') as sale_date,  -- Random dates in 2024
    'Event_' || UNIFORM(1, 5, RANDOM()) as event_name  -- Random event names
FROM TABLE(GENERATOR(ROWCOUNT => 100000));

-- Inefficient approach: Function-based filtering reduces partition pruning
SELECT * FROM EXPENSIVE_TABLE
WHERE YEAR(sale_date) = 2024;

-- Efficient approach: Direct date comparison enables partition pruning
SELECT * FROM EXPENSIVE_TABLE
WHERE sale_date >= '2024-01-01' AND SALE_DATE <= '2024-12-31';