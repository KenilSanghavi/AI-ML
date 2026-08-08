Customer Transaction Analysis & Reporting – Excel Project
📊 Project Overview

This project is an Excel-based Customer Transaction Analysis and Reporting solution created to analyze customer purchases, sales performance, discounts, profits, and monthly trends.

The dataset contains 200 customer transaction records with information such as Customer ID, Customer Name, Region, Product Category, Sales, Quantity, Discount, Order Date, and Profit.

The project uses Excel features such as:

Conditional Formatting
What-If Analysis
Data Tables
Data Analysis ToolPak
Linear Regression
Descriptive Statistics
INDEX & MATCH
FILTER
Pivot Tables
Charts
Dashboard creation
🎯 Project Objectives

The main objectives of this project are:

Identify the top 10 customers based on total purchases.
Analyze the impact of changing discounts on total profit.
Perform Linear Regression between Sales and Profit.
Generate descriptive statistics for the dataset.
Analyze monthly sales growth using up/down arrows.
Create a timestamp using the NOW() function.
Identify high-value customers using INDEX(), MATCH(), and filters.
Create Pivot Tables for sales by region and product category.
Create visualizations using bar, line, and pie charts.
Build a dashboard to summarize important business insights.
📁 Dataset

The dataset contains the following columns:

Column	Description
Customer_ID	Unique customer identifier
Customer_Name	Name of the customer
Region	Customer's geographical region
Product_Category	Category of purchased product
Sales	Sales amount
Quantity	Quantity purchased
Discount	Discount applied
Order_Date	Date of the transaction
Profit	Profit generated from transaction

The original dataset contains records from April 2024 to April 2025.

🛠️ Excel Features Used
1. Conditional Formatting – Top 10 Customers

A Pivot Table is used to calculate total sales for each customer.

Pivot Table Configuration

Rows:

Customer_Name

Values:

Sum of Sales

Conditional Formatting is then applied to highlight the Top 10 customers based on total purchase amount.

Excel Steps
Home
→ Conditional Formatting
→ Top/Bottom Rules
→ Top 10 Items
2. What-If Analysis – Discount vs Profit

The What-If Analysis is used to understand how changing the discount can affect total profit.

Because the original dataset contains fixed Profit values, a separate New Profit calculation is created for the What-If Analysis. The original dataset contains both Discount and Profit as transaction fields.

Input Cell

For example:

L1 = New Discount
L2 = 10%
New Profit

A new column called:

New Profit

is created.

Example formula:

=E2*(1-$L$2)

where:

E2 = Sales
L2 = Discount input

The formula is copied down for all transactions.

Total Profit
=SUM(J2:J201)

Different discount values can then be tested:

0%
5%
10%
15%
20%
25%

A one-variable Data Table is used to automatically calculate the resulting total for each discount.

Purpose

The analysis answers:

"What happens to the calculated profit when the discount percentage changes?"

3. Linear Regression – Profit vs Sales

Excel's Data Analysis ToolPak is used to perform Linear Regression.

Variables

Independent Variable (X):

Sales

Dependent Variable (Y):

Profit
Steps
Data
→ Data Analysis
→ Regression

Set:

Input Y Range = Profit
Input X Range = Sales

Select:

Labels
Summary Statistics

The regression output can be used to study the relationship between Sales and Profit.

4. Descriptive Statistics

Descriptive Statistics are generated using the Excel Data Analysis ToolPak.

Steps
Data
→ Data Analysis
→ Descriptive Statistics

The Sales or Profit column can be selected as the input range.

Select:

Summary Statistics

The output includes statistical measures such as:

Mean
Median
Mode
Standard Deviation
Variance
Minimum
Maximum
Range
Important Note About Mode

If Excel shows #N/A or no value for Mode, it means there is no repeated value in the selected numeric data. This can happen because many Sales and Profit values in this dataset are unique decimal values.

5. Monthly Sales Growth

The project analyzes whether monthly sales are increasing or decreasing.

Month Column

A new column can be created using:

=TEXT(H2,"mmm")

where H2 contains the Order Date.

This converts:

4/10/2024 → Apr
5/06/2024 → May
6/25/2024 → Jun
Pivot Table

Create a Pivot Table with:

Rows:

Month

Values:

Sum of Sales
Growth Calculation

If monthly sales are in column B:

=B3-B2

Positive result:

Sales increased

Negative result:

Sales decreased
Conditional Formatting

Apply:

Home
→ Conditional Formatting
→ Icon Sets
→ 3 Arrows

This displays:

⬆ Increase
→ Little/no change
⬇ Decrease
6. Timestamp Using NOW()

A timestamp column can be created using:

=NOW()

This returns the current date and time.

For date only:

=TODAY()
Purpose

The timestamp can be used to record when the analysis/report was generated.

7. Identifying High-Value Customers

INDEX() and MATCH() are used to dynamically retrieve customer information.

For example, if the customer name to search is in K2:

Customer ID
=INDEX(A:A,MATCH(K2,B:B,0))
Sales
=INDEX(E:E,MATCH(K2,B:B,0))
Profit
=INDEX(I:I,MATCH(K2,B:B,0))
Explanation

MATCH() finds the position of the customer, while INDEX() returns the corresponding value.

The combination allows information to be retrieved dynamically.

8. Pivot Table – Sales by Region and Product

A Pivot Table is created to analyze sales across regions and product categories.

Configuration

Rows:

Region

Columns:

Product_Category

Values:

Sum of Sales

An additional value can be added:

Sum of Profit

This allows comparison of sales performance across different regions and product categories.

9. Charts and Visualizations

Three main chart types are used.

📊 Bar Chart

Used to visualize:

Sales by Region

Purpose:

Compare sales performance between different regions.

📈 Line Chart

Used to visualize:

Monthly Sales

Purpose:

Identify sales trends and growth/decline over time.

🥧 Pie Chart

Used to visualize:

Sales by Product Category

Purpose:

Show the contribution of each product category to total sales.
