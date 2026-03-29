-- =========================================
-- Exploratory Data Analysis
-- =========================================

-- -----------------------------------------
-- Total revenue
-- -----------------------------------------
SELECT SUM(total) AS total_revenue
FROM sales_data;

-- -----------------------------------------
-- Total orders
-- -----------------------------------------
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM sales_data;

-- -----------------------------------------
-- Top selling products
-- -----------------------------------------
SELECT
product,
SUM(quantity) AS total_sold
FROM sales_data
GROUP BY product
ORDER BY total_sold DESC;

-- -----------------------------------------
-- Revenue by category
-- -----------------------------------------
SELECT
category,
SUM(total) AS revenue
FROM sales_data
GROUP BY category
ORDER BY revenue DESC;

-- -----------------------------------------
-- Revenue by payment method
-- -----------------------------------------
SELECT
payment_method,
SUM(total) AS revenue
FROM sales_data
GROUP BY payment_method;

-- -----------------------------------------
-- Monthly revenue
-- -----------------------------------------
SELECT
YEAR(order_date) AS year,
MONTH(order_date) AS month,
SUM(total) AS revenue
FROM sales_data
GROUP BY year, month
ORDER BY year, month;

-- -----------------------------------------
-- Average order value
-- -----------------------------------------
SELECT
AVG(total) AS avg_order_value
FROM sales_data;

-- -----------------------------------------
-- Top customers
-- -----------------------------------------
SELECT
customer_id,
SUM(total) AS customer_spending
FROM sales_data
GROUP BY customer_id
ORDER BY customer_spending DESC
LIMIT 10;

-- -----------------------------------------
-- Most popular category
-- -----------------------------------------
SELECT
category,
SUM(quantity) AS items_sold
FROM sales_data
GROUP BY category
ORDER BY items_sold DESC;

-- -----------------------------------------
-- Order status distribution
-- -----------------------------------------
SELECT
status,
COUNT(*) AS orders
FROM sales_data
GROUP BY status;