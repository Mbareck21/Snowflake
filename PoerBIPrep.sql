-- This example creates a simplified data model for PowerBI reporting
-- It implements a star schema with customer and event dimensions
-- Filters for VIP customers only to support executive reporting
-- Can be used in PowerBI for visualizing high-value customer behavior

USE ROLE ACCOUNTADMIN;
USE DATABASE FIRST_DB;
USE SCHEMA FIRST_DB.FIRST_SCHEMA;

-- Dimension table for events data
CREATE OR REPLACE TABLE dim_events (
    event_id INT,
    event_name STRING,
    venue STRING,
    total_seats INT
);

-- data
INSERT INTO dim_events VALUES 
(1, 'Hamilton', 'Walton Arts Center', 1200),
(2, 'Wicked', 'Walmart AMP', 5000),
(3, 'Lion King', 'Walton Arts Center', 1200);

-- Dimension table for customer data
CREATE OR REPLACE TABLE dim_customers (
    customer_id INT,
    customer_name STRING,
    segment STRING
);
-- Data
INSERT INTO dim_customers VALUES 
(101, 'Alice', 'VIP'),
(102, 'Bob', 'General'),
(103, 'Charlie', 'General');

-- Fact table for ticket sales transactions
CREATE OR REPLACE TABLE fact_ticket_sales (
    sale_id INT,
    customer_id INT,
    event_id INT,
    sale_date DATE,
    quantity INT,
    total_amount INT
);

-- Inserting dummy data
INSERT INTO fact_ticket_sales VALUES 
(1, 101, 1, '2025-01-01', 2, 600),
(2, 102, 2, '2025-01-02', 1, 120),
(3, 101, 3, '2025-01-05', 4, 400),
(4, 103, 1, '2025-01-06', 1, 300);

-- View for PowerBI: Shows VIP customer purchases with relevant dimensions
CREATE OR REPLACE VIEW filtered AS 
SELECT
    customer_name,
    event_name,
    venue,
    sale_date,
    total_amount
FROM fact_ticket_sales
JOIN dim_events ON fact_ticket_sales.event_id = dim_events.event_id
JOIN dim_customers ON fact_ticket_sales.customer_id = dim_customers.customer_id
WHERE dim_customers.segment = 'VIP'
ORDER BY total_amount DESC;

SELECT * FROM filtered;