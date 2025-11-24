-- Example of a Change Data Capture (CDC) pipeline using Snowflake Streams and Tasks
-- This pipeline continuously monitors a source table for new JSON events and 
-- automatically transforms and loads them into a structured analytics table

USE ROLE ACCOUNTADMIN;
USE DATABASE first_db;
USE SCHEMA first_db.first_schema;

-- Create source table for raw JSON events
CREATE OR REPLACE TABLE raw_user_events (
    json_data VARIANT
);

-- Create destination table for transformed events
CREATE OR REPLACE TABLE final_event_analytics (
    event_name STRING,
    price INT,
    inserted_at TIMESTAMP
);

-- Create stream to track changes on source table
CREATE OR REPLACE STREAM event_stream ON TABLE raw_user_events;

-- Create task to transform data from JSON to structured format
CREATE OR REPLACE TASK transform_data_task
    WAREHOUSE = COMPUTE_WH
    SCHEDULE = '1 MINUTE'
    WHEN SYSTEM$STREAM_HAS_DATA('event_stream')
AS
    INSERT INTO final_event_analytics
    SELECT 
        event_stream.json_data:event::STRING,
        event_stream.json_data:price::INT,
        CURRENT_TIMESTAMP()
    FROM event_stream 
    WHERE metadata$action = 'INSERT';

-- Suspend task for maintenance
ALTER TASK transform_data_task SUSPEND;

-- Reset source table
CREATE OR REPLACE TABLE raw_user_events (json_data VARIANT);

-- Recreate stream
CREATE OR REPLACE STREAM event_stream ON TABLE raw_user_events;

-- Resume task
ALTER TASK transform_data_task RESUME;

-- Insert sample data
INSERT INTO raw_user_events SELECT PARSE_JSON('{"event": "Lion King", "price": 150}');
INSERT INTO raw_user_events SELECT PARSE_JSON('{"event": "Wicked", "price": 120}');

-- Execute task immediately for testing
EXECUTE TASK transform_data_task;

-- View results
SELECT * FROM final_event_analytics;