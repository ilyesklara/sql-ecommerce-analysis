**🛒 E-Commerce Sales Data Cleaning & Analysis (SQL)**

Author: Klára Ilyés
Tools: MySQL, MySQL Workbench
Skills demonstrated: Data cleaning, data validation, SQL analysis, data quality checks


**📌 Project Overview**

This project focuses on cleaning and analyzing a messy e-commerce sales dataset using SQL.

The dataset intentionally contained multiple real-world data quality issues such as inconsistent formats, invalid values, duplicate rows, and incorrect categories.
The goal of this project was to simulate a typical workflow of a data analyst, including:

inspecting raw data
cleaning and standardizing fields
validating numeric and categorical values
fixing inconsistencies
performing exploratory data analysis

The final cleaned dataset was then used to generate basic business insights.


**📂 Dataset**

The dataset contains simulated e-commerce sales transactions with the following fields:

Customer ID
Order ID
Order Date
Product
Category
Quantity
Price
Total
Payment Method
Order Status

The raw dataset contained multiple issues including:

inconsistent date formats
text values in numeric columns
currency symbols in price fields
missing and incorrect category labels
duplicate rows
negative values in quantity and price


**🧹 Data Cleaning Process**

The following steps were performed using SQL in MySQL Workbench:


**1️⃣ Initial Data Inspection**

Reviewed table structure using DESCRIBE
Examined raw data samples using SELECT
Identified problematic columns and inconsistent formats


**2️⃣ Column Standardization**

Column names were standardized to follow a consistent naming convention:

removed spaces
converted names to lowercase
renamed columns such as:
ID → customer_id
Order_ID → order_id
Order_Date → order_date


**3️⃣ Removing Redundant Columns**

The Customer_Name column contained duplicated information derived from customer_id and was removed.


**4️⃣ Cleaning Date Formats**

The dataset contained inconsistent date formats such as:

Jan 5 2023
05/01/2023
2023-01-05

Dates were standardized and converted to a proper DATE data type.


**5️⃣ Cleaning Numeric Columns**

The price column contained invalid values such as:

300$
four hundred

Cleaning steps included:

removing currency symbols
converting text values into numeric values
identifying invalid values using regular expressions
replacing non-numeric values with NULL
converting the column to DECIMAL

Example validation:

SELECT *
FROM sales_data
WHERE price NOT REGEXP '^-?[0-9]*\.?[0-9]+$';


**6️⃣ Recalculating Totals**

To ensure accuracy, the total column was recalculated:

total = quantity * price


**7️⃣ Fixing Negative Values**

Negative values were corrected using:

ABS()

Applied to:

quantity
price
total


**8️⃣ Standardizing Product Categories**

Some rows contained missing or incorrect categories.

Categories were reassigned based on product type using a CASE statement.

Example:

Electronics
Clothing
Books
Home
Sports


**9️⃣ Duplicate Detection**

Potential duplicate transactions were identified using:

SELECT customer_id, order_id, COUNT(*)
FROM sales_data
GROUP BY customer_id, order_id
HAVING COUNT(*) > 1;


**📊 Exploratory Data Analysis**

After cleaning the dataset, several SQL queries were used to generate insights.

Examples include:

Total Revenue
SELECT SUM(total)
FROM sales_data;
Top Selling Products
SELECT product, SUM(quantity)
FROM sales_data
GROUP BY product
ORDER BY SUM(quantity) DESC;
Revenue by Category
SELECT category, SUM(total)
FROM sales_data
GROUP BY category
ORDER BY SUM(total) DESC;
Monthly Sales Trend
SELECT
YEAR(order_date),
MONTH(order_date),
SUM(total)
FROM sales_data
GROUP BY YEAR(order_date), MONTH(order_date);


**📈 Key Skills Demonstrated**

This project demonstrates practical SQL skills commonly required for data analyst roles:

Data cleaning with SQL
Handling messy real-world data
Regular expression validation
Data type conversions
Removing duplicates
Data quality checks
Exploratory data analysis


**🧠 What I Learned**

Through this project I practiced handling messy datasets and learned how to systematically approach data cleaning tasks using SQL.

It reinforced the importance of validating data, standardizing formats, and ensuring numerical accuracy before performing analysis.


**🚀 Future Improvements**

Possible extensions for this project:

building dashboards in Power BI or Tableau
creating sales trend visualizations
customer segmentation analysis
cohort analysis


**📬 Contact**

If you'd like to connect or discuss data analytics projects:

LinkedIn: www.linkedin.com/in/klára-ilyés-398402317
Email: demeterklara88@gmail.com
