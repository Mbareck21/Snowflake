# Snowflake

# Snowflake Data Engineering Mini Projects ❄️

This repository contains a collection of SQL scripts demonstrating end-to-end Data Engineering workflows in Snowflake. These scripts simulate real-world scenarios involving event ticketing data, aimed at solving business problems through **ELT Pipelines**, **Automation**, **Data Modeling**, and **Optimization**.

## 🎯 Project Overview

The goal of this repository is to demonstrate proficiency in the modern Data Engineering stack, specifically focusing on:
*   **Ingesting data** from external stages (AWS S3 context).
*   **Parsing semi-structured data** (JSON) using `VARIANT` and `FLATTEN`.
*   **Automating workflows** using Snowflake Streams and Tasks (CDC).
*   **Modeling data** into Star Schemas for Power BI reporting.
*   **Optimizing query performance** via partition pruning.

## 🛠️ Tech Stack
*   **Data Warehouse:** Snowflake
*   **Language:** SQL (Snowflake Dialect)
*   **Concepts:** ETL/ELT, CDC, Star Schema, Data Governance, Query Tuning

## 📂 Repository Structure

| File | Description | Key Skills |
| :--- | :--- | :--- |
| `CDCPipeline.sql` | Automated pipeline using Streams & Tasks. | **Automation, CDC, Real-time Ingestion** |
| `JSONParsing.sql` | Handling semi-structured data (Variant/Flatten). | **JSON Parsing, Array Handling, Schema Drift** |
| `PowerBIPrep.sql` | Star Schema modeling for BI Dashboards. | **Data Modeling, Views, joins, VIP Filtering** |
| `Optimization.sql` | Query performance tuning demonstration. | **Query Optimization, Micro-partitions, Pruning** |
| `SnowflakeStage.sql` | Loading CSV data from internal/external stages. | **Data Loading, COPY INTO, File Formats** |

---

## 🚀 Key Features & Explanations

### 1. Automated CDC Pipeline (`CDCPipeline.sql`)
Implements a **Change Data Capture (CDC)** architecture.
*   **Stream:** Monitors a raw JSON table (`raw_user_events`) for new inserts.
*   **Task:** A serverless task runs every 1 minute to transform new raw data and load it into the final analytics table.
*   **Why:** Ensures the analytics team has near real-time data without reloading the entire database.

### 2. Advanced JSON Parsing (`JSONParsing.sql`)
Demonstrates how to handle complex, nested application logs (like Ticketmaster feeds).
*   Uses `PARSE_JSON` and the `VARIANT` data type to store unstructured data.
*   Uses `LATERAL FLATTEN` to explode nested arrays (e.g., multiple items in one transaction) into analytical rows.
*   Includes examples of fixing "Schema Drift" (handling changing JSON keys).

### 3. Data Modeling for Power BI (`PowerBIPrep.sql`)
Prepares raw sales data for visualization tools.
*   **Star Schema:** Transformation of raw data into Fact tables (`fact_ticket_sales`) and Dimension tables (`dim_events`, `dim_customers`).
*   **Security:** Creates a specific View (`filtered`) to isolate VIP Customer data for executive reporting.

### 4. Cost & Query Optimization (`Optimization.sql`)
A demonstration of writing efficient SQL to save compute credits.
*   Compares a "Bad Query" (using functions on columns like `YEAR()`) vs. a "Good Query" (using range comparisons).
*   **Result:** The good query utilizes **Partition Pruning**, causing Snowflake to scan significantly fewer micro-partitions.

---

## 💻 How to Run
These scripts are designed to be run in a **Snowflake Worksheet**.
1.  Ensure you have a standard Snowflake account (Standard Edition or higher).
2.  Run the setup script at the top of each file (`USE DATABASE...`) to establish the environment.
3.  Execute blocks sequentially to observe the transformations.

## 👤 Author
**Mohamed Lemine Mbareck**
*   [LinkedIn Profile](https://www.linkedin.com/in/lemine-mbareck/)
*   [Portfolio Website](https://portfolio-drab-nine-66.vercel.app/)
