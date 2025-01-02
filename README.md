SQL Analysis Project - Amazon Data Insights
Project Overview
This project explores and analyzes an amazondata dataset using SQL. The queries address various business-related questions, such as identifying distinct entities, mapping relationships, and uncovering key metrics.

Features
Count Distinct Entities: Identifies unique cities and product lines.
Branch-City Mapping: Associates branches with their corresponding cities.
Aggregation and Summarization: Provides insights into data distributions and trends.

Dataset
This dataset contains sales transactions from three different branches of Amazon, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows
Column names 
invoice_id, branch, city, customer_type, gender, product_line, unit_price, quantity
VAT, total, date, time, payment_method, cogs, gross_margin_percentage, gross_income, rating

Queries Included
Distinct Cities: Counts the number of unique cities.
Branch-City Mapping: Groups data by branches and cities.
Distinct Product Lines: Counts unique product lines.
Usage
Prerequisites
A SQL database (e.g., MySQL, PostgreSQL).
A tool for executing SQL queries (e.g., MySQL Workbench, pgAdmin).
Steps
Import the amazondata dataset into your database.
Run the queries provided in the SQL Script file.
Analyze the results and adapt the queries as needed

Project Structure
├── Capstone_SQL.sql   # Contains all the SQL queries for the analysis.
├── README.md          # Project documentation (this file).

Key Insights
Distinct city count provides an overview of geographic distribution.
Branch-to-city mapping helps visualize operational coverage.
Analysis of product lines gives insights into business offerings.
Contribution
Contributions are welcome! Feel free to fork the repository and submit a pull request.

License
This project is licensed under the MIT License. See the LICENSE file for details.
