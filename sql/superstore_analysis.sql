/* =====================================================
SUPERSTORE SALES ANALYSIS
Author : Rio Tegar Syahutra
Tools  : PostgreSQL
Description : Sales analysis using SQL
===================================================== */


/* =====================================================
1. DATA CLEANING
Convert raw text data into proper data types
===================================================== */

DROP TABLE IF EXISTS superstore_clean;

CREATE TABLE superstore_clean AS
SELECT
row_id::INT AS row_id,
order_id,
TO_DATE(order_date,'MM/DD/YYYY') AS order_date,
TO_DATE(ship_date,'MM/DD/YYYY') AS ship_date,
ship_mode,
customer_id,
segment,
country,
city,
state,
region,
product_id,
category,
sub_category,
product_name,
sales::NUMERIC AS sales,
quantity::INT AS quantity,
discount::NUMERIC AS discount,
profit::NUMERIC AS profit
FROM superstore_sales;



/* =====================================================
2. BASIC DATA EXPLORATION
Understand dataset overview
===================================================== */

-- Total records
SELECT COUNT(*) AS total_orders
FROM superstore_clean;

-- Date range
SELECT
MIN(order_date) AS first_order,
MAX(order_date) AS last_order
FROM superstore_clean;



/* =====================================================
3. KEY PERFORMANCE METRICS
===================================================== */

-- Total Sales
SELECT
ROUND(SUM(sales),2) AS total_sales
FROM superstore_clean;

-- Total Profit
SELECT
ROUND(SUM(profit),2) AS total_profit
FROM superstore_clean;

-- Total Quantity Sold
SELECT
SUM(quantity) AS total_quantity
FROM superstore_clean;

-- Profit Margin
SELECT
ROUND(SUM(profit)/SUM(sales)*100,2) AS profit_margin_percent
FROM superstore_clean;



/* =====================================================
4. SALES ANALYSIS
===================================================== */

-- Sales by Category
SELECT
category,
ROUND(SUM(sales),2) AS total_sales
FROM superstore_clean
GROUP BY category
ORDER BY total_sales DESC;


-- Sales by Sub Category
SELECT
sub_category,
ROUND(SUM(sales),2) AS total_sales
FROM superstore_clean
GROUP BY sub_category
ORDER BY total_sales DESC;



/* =====================================================
5. TIME SERIES ANALYSIS
===================================================== */

-- Monthly Sales Trend
SELECT
DATE_TRUNC('month',order_date) AS month,
ROUND(SUM(sales),2) AS total_sales
FROM superstore_clean
GROUP BY month
ORDER BY month;


-- Monthly Quantity Sold
SELECT
DATE_TRUNC('month',order_date) AS month,
SUM(quantity) AS total_quantity
FROM superstore_clean
GROUP BY month
ORDER BY month;



/* =====================================================
6. PROFITABILITY ANALYSIS
===================================================== */

-- Profit by Category
SELECT
category,
ROUND(SUM(profit),2) AS total_profit
FROM superstore_clean
GROUP BY category
ORDER BY total_profit DESC;


-- Top 10 Most Profitable Products
SELECT
product_name,
ROUND(SUM(profit),2) AS total_profit
FROM superstore_clean
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;



/* =====================================================
7. REGIONAL ANALYSIS
===================================================== */

-- Sales by Region
SELECT
region,
ROUND(SUM(sales),2) AS total_sales
FROM superstore_clean
GROUP BY region
ORDER BY total_sales DESC;


-- Sales by State
SELECT
state,
ROUND(SUM(sales),2) AS total_sales
FROM superstore_clean
GROUP BY state
ORDER BY total_sales DESC;



/* =====================================================
END OF ANALYSIS
===================================================== */