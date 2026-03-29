-- =========================================
-- E-commerce Sales Data Cleaning Project
-- Author: Klára Ilyés
-- =========================================

-- -----------------------------------------
-- Dataset source: Kaggle
-- Dataset: Messy E-commerce Sales Data
-- Goal: Clean and standardize transactional sales data
-- -----------------------------------------

CREATE DATABASE ecommerce;
USE ecommerce;

-- -----------------------------------------
-- Inspect table structure
-- -----------------------------------------
DESCRIBE sales_data;
SELECT * FROM sales_data LIMIT 10; -- issue detected: 'Customer_name' column has the same values that are in column 'ID' with 'Customer_' at the beggining.
ALTER TABLE sales_data DROP COLUMN Customer_Name;

-- -----------------------------------------
-- Fix column names (remove spaces)
-- -----------------------------------------
ALTER TABLE sales_data CHANGE ID customer_id VARCHAR(100);
ALTER TABLE sales_data CHANGE Order_ID order_id VARCHAR(100);
ALTER TABLE sales_data CHANGE Order_Date order_date DATE;
-- Error Code: 1292. Incorrect date value: 'Jan 5 2023' for column 'order_date' at row 14	0.031 sec
UPDATE sales_data SET Order_Date = '2023-01-05' WHERE Order_Date = 'Jan 5 2023';
-- Error Code: 1292. Incorrect date value: '05/01/2023' for column 'order_date' at row 45	0.031 sec
UPDATE sales_data SET Order_Date = '2023-01-05' WHERE Order_Date = '05/01/2023';
ALTER TABLE sales_data CHANGE Product product VARCHAR(100);
ALTER TABLE sales_data CHANGE Category category VARCHAR(100);
ALTER TABLE sales_data CHANGE Quantity quantity INT;
SELECT * FROM sales_data WHERE Price NOT REGEXP '^-?[0-9]*\.?[0-9]+$';

-- -----------------------------------------
-- Clean price column (remove invalid values)
-- -----------------------------------------
UPDATE sales_data SET price = REPLACE(price,'$','');
UPDATE sales_data SET Price = '400' WHERE Price = 'four hundred';

SELECT product, Price FROM sales_data WHERE product = 'Smartphone';

-- -----------------------------------------
-- check rows with invalid price values
-- -----------------------------------------
UPDATE sales_data SET Price = NULL WHERE Price NOT REGEXP '^-?[0-9]*\.?[0-9]+$';
SELECT * FROM sales_data WHERE Price IS NULL;

ALTER TABLE sales_data CHANGE Price price DECIMAL(10,2);
ALTER TABLE sales_data CHANGE Payment_Method payment_method VARCHAR(100);
ALTER TABLE sales_data CHANGE Status status VARCHAR(100);

-- -----------------------------------------
-- check rows with invalid total values
-- -----------------------------------------
SELECT * FROM sales_data WHERE Total NOT REGEXP '^-?[0-9]*\.?[0-9]+$'; 

-- -----------------------------------------
-- Recalculate total
-- -----------------------------------------
UPDATE sales_data SET Total = quantity * price;
ALTER TABLE sales_data CHANGE Total total DECIMAL(10,2);
UPDATE sales_data SET quantity = ABS(quantity) WHERE quantity < 0;
UPDATE sales_data SET price = ABS(price) WHERE price < 0;
UPDATE sales_data SET total = ABS(total) WHERE total < 0;
SELECT COUNT(*) FROM sales_data;
SELECT DISTINCT(product) FROM sales_data;
SELECT DISTINCT(category) FROM sales_data;
SELECT category, product FROM sales_data WHERE category IN ('nan', '', ' ');

SELECT category, product, count(product)
FROM sales_data
GROUP BY category, product
ORDER BY category;

UPDATE sales_data
SET category =
CASE
WHEN product IN ('Biography', 'Comics', 'Fiction', 'Science') THEN 'Books'
WHEN product IN ('Jacket', 'Jeans', 'Shoes', 'T-shirt') THEN 'Clothing'
WHEN product IN ('Headphones', 'Laptop', 'Smartphone', 'Smartwatch') THEN 'Electronics'
WHEN product IN ('Blender', 'Lamp', 'Microwave', 'Vacuum') THEN 'Home'
WHEN product IN ('Basketball', 'Football', 'Tennis Racket', 'Yoga Mat') THEN 'Sports'
END;

SELECT DISTINCT(payment_method) FROM sales_data;
SELECT DISTINCT(status) FROM sales_data;

-- -----------------------------------------
-- Check for duplicate orders per customer
-- -----------------------------------------
SELECT customer_id, order_id, COUNT(*)
FROM sales_data
GROUP BY customer_id, order_id
HAVING COUNT(*) > 1;

-- -----------------------------------------
-- check if the duplicate combinations are identical
-- -----------------------------------------
SELECT *
FROM sales_data
WHERE order_id IN ('ORD-69018','ORD-32755','ORD-56651')
ORDER BY order_id;

-- -----------------------------------------
-- drop duplicate rows
-- -----------------------------------------
CREATE TABLE sales_data_clean AS
SELECT DISTINCT *
FROM sales_data;

DROP TABLE sales_data;

RENAME TABLE sales_data_clean TO sales_data;
