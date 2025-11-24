USE DATABASE FIRST_DB
USE SCHEMA FIRST_DB.FIRST_SCHEMA

CREATE OR REPLACE TABLE raw_ticket_sales (json_data variant)

INSERT INTO RAW_TICKET_SALES SELECT PARSE_JSON('
{
  "transaction_id": "TXN-998877",
  "items": [
    {"event": "Hamilton", "price": 300},
    {"event": "Parking Pass", "price": 20}
  ]
}
')
SELECT 
    json_data:transaction_id::STRING as txn_id,
    value:event::STRING as event_name,
    value:price::INT as price
FROM raw_ticket_sales,
LATERAL FLATTEN( input => json_data:items);