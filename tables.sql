-- This script creates an employees table with sample data and demonstrates view creation:
-- 1. Creates employees table with basic employee information
-- 2. Creates a view for marketing employees
-- 3. Creates a view showing total salaries by department

USE ROLE ACCOUNTADMIN;
USE DATABASE FIRST_DB;
USE SCHEMA FIRST_DB.FIRST_SCHEMA;

CREATE OR REPLACE TABLE employees (
    id INTEGER,
    name VARCHAR,
    department VARCHAR,
    salary INTEGER
);

-- Insert sample employee data
INSERT INTO employees (id, name, department, salary) VALUES
(1, 'Alice Johnson', 'Engineering', 95000),
(2, 'Ravi Kumar', 'Finance', 72000),
(3, 'Maria Gonzalez', 'Human Resources', 65000),
(4, 'Chen Wei', 'Engineering', 105000),
(5, 'Fatima Al-Sayed', 'Marketing', 68000),
(6, 'James Smith', 'Sales', 75000),
(7, 'Sofia Rossi', 'Design', 70000),
(8, 'David Brown', 'Engineering', 99000),
(9, 'Akira Tanaka', 'Product Management', 88000),
(10, 'Liam O''Connor', 'Customer Support', 54000),
(11, 'Nia Mbatha', 'Legal', 97000),
(12, 'Carlos Mendes', 'Finance', 76000),
(13, 'Emily Davis', 'Marketing', 71000),
(14, 'Omar Hassan', 'Engineering', 102000),
(15, 'Hannah Müller', 'Research', 93000);

-- View all employees
SELECT * FROM employees;

-- Create view for marketing department employees
CREATE OR REPLACE VIEW marketing_employees AS
SELECT * FROM employees
WHERE department = 'Marketing';

SELECT * FROM marketing_employees;

-- Create view for department salary totals
CREATE OR REPLACE VIEW DEP_SALARIES AS
SELECT department, SUM(salary) as salaries
FROM EMPLOYEES
GROUP BY department 
ORDER BY salaries DESC;

SELECT * FROM DEP_SALARIES;