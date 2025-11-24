-- This script demonstrates the ETL process using Snowflake Stages:
-- 1. Creates a student table
-- 2. Creates an internal named stage for data loading
-- 3. Lists stage contents
-- 4. Loads data from stage into the table

USE ROLE ACCOUNTADMIN;
USE DATABASE FIRST_DB;
USE SCHEMA FIRST_DB.FIRST_SCHEMA;

-- Create table structure
CREATE OR REPLACE TABLE STUDENT(
    id INTEGER,
    name VARCHAR(50),
    age INTEGER,
    mark INTEGER
);

-- Stage setup and data loading
CREATE OR REPLACE STAGE STUDENT_STAGE;

-- Verify the data (student.csv) was laoded into the stage 
LIST @STUDENT_STAGE;

-- Copy laoded data into the table
COPY INTO STUDENT
FROM @STUDENT_STAGE 
FILE_FORMAT = (TYPE = 'CSV', SKIP_HEADER = 1);

-- Data verification
SELECT * 
FROM STUDENT
