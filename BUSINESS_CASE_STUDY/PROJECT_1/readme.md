# Sales Insights Dashboard using SQL

**Lab Work #2.1** | SQL + Power BI | Author: Kenil

An end-to-end sales analysis of a fictional retail company. I used SQL (MySQL) to explore the data and answer business questions, then built a 3-page dark-themed Power BI dashboard to show the results.

---

## Project Objective

Analyze the performance of a retail company, find trends and KPIs, and turn them into insights that help decision-makers improve their sales strategy.

## Dataset

**RetailSalesDB** with 5 tables:

| Table | Columns |
|---|---|
| `customers` | customer_id, first_name, last_name, gender, email, city, state, registration_date |
| `products` | product_id, product_name, category, brand, unit_price, cost_price |
| `orders` | order_id, order_date, customer_id, order_status, payment_method |
| `order_items` | order_item_id, order_id, product_id, quantity, discount |
| `shipping` | shipping_id, order_id, shipping_date, shipping_cost, shipping_status, shipping_method |

**Key rules used in the analysis**
- Revenue = `quantity * unit_price * (1 - discount)`
- Cancelled orders are excluded from sales numbers
- Profit = revenue - (`quantity * cost_price`)
- Churned customer = no order in the 90 days before the latest order in the data

## Tools Used

- MySQL 8 (MySQL Workbench) for the SQL analysis
- Power BI Desktop for the dashboard (DAX measures, relationships, dark theme)

## Project Structure

```
.
├── sales_insights_lowercase.sql   # all SQL queries with comments
├── SalesInsights.pbix             # Power BI dashboard
├── screenshots/                   # dashboard page images
│   ├── overview.png
│   ├── customers_products.png
│   └── shipping.png
└── README.md
```

## Tasks Completed

### 1. Data Exploration
- Total orders, customers and products
- Most frequently ordered products
- Average order value (AOV)
- Revenue over time (monthly and yearly)
- Top 5 states by revenue

### 2. Customer Analysis
- New vs returning customers per month
- Top 10 customers by lifetime value
- Gender-wise spending distribution
- Churn analysis using the last order date

### 3. Product Analysis
- Best-selling products by quantity and revenue
- Revenue by product category
- Profit margin analysis (unit price - cost price)
- Underperforming products (low sales)

### 4. Shipping and Fulfilment
- Average shipping time
- Shipping cost analysis by method
- Delayed vs on-time delivery patterns

### 5. Advanced SQL
- Window functions: `rank`, `row_number`, `lag` / `lead`
- `case when` for custom customer segments
- Joins across multiple tables

### Bonus
- KPI dashboard in Power BI
- Customer personas based on spending patterns

---

## Dashboard

The Power BI report has 3 pages with a shared Year slicer, plus state and category filters.

### Page 1: Overview
KPI cards for total revenue, total orders, total customers, AOV, profit margin and churn rate, with monthly revenue, top 5 states and revenue by category.

![Overview]<img width="1477" height="811" alt="image" src="https://github.com/user-attachments/assets/3a26b1dc-db26-42a7-ae67-76e4dcd81e21" />


### Page 2: Customers and Products
Top 10 customers, spending by gender, active vs churned customers, new vs returning customers, top 10 products and profit margin by product.

![Customers and Products]<img width="1387" height="802" alt="image" src="https://github.com/user-attachments/assets/6b8b7e9a-0212-4ea7-b5a5-67bbba8900d6" />


### Page 3: Shipping and Fulfilment
Average shipping days, delayed %, total shipping cost, cost by method, delayed vs on-time by method and delay rate by method.

![Shipping]<img width="1372" height="802" alt="image" src="https://github.com/user-attachments/assets/59c684ca-4d99-41ff-bf39-5320985f0251" />


---

## Key Findings

| KPI | Value |
|---|---|
| Total revenue | about $75.9M |
| Total orders | about 45K |
| Total customers | about 10K |
| Average order value | about $1.69K |
| Profit margin | 25.73% |
| Churn rate | 53.83% |
| Delayed shipments | 24.97% |
| Total shipping cost | about $550K |

- **Top state:** Colorado leads revenue at about $1.73M, with Illinois, Louisiana, Kansas and North Carolina close behind. State revenue is spread fairly evenly.
- **Top category:** Electronics brings the most revenue (about $18.5M, 24%), followed by Toys and Clothing.
- **Revenue trend:** monthly revenue stays steady at around $3M after the first partial month.
- **Customers:** spending is split almost equally across the three gender groups. The top customer has a lifetime value of about $32K.
- **Churn:** more than half of customers (53.83%) had no order in the last 90 days, which is high.
- **Shipping:** about 1 in 4 shipments is delayed, and delay rates are similar across all shipping methods.
- **Data note:** average shipping time shows about 187 days and is almost the same for every method, which suggests the shipping dates in this dataset are randomly generated.

## Business Recommendations

1. **Reduce churn:** run win-back offers (discounts or reminder emails) for customers who have been inactive for more than 90 days, starting with the highest lifetime value ones.
2. **Protect top customers:** build a loyalty programme for the high-value segment, since a small group of customers brings a large share of revenue.
3. **Fix delivery delays:** with 25% of shipments delayed, review carrier performance and set delivery targets for each shipping method.
4. **Push high-margin products:** promote products with margins above 45% and review the low-margin and low-selling products for price changes or removal.
5. **Grow with Electronics:** keep stock and marketing focused on the top category, and look at bundles with Toys and Clothing.
6. **Balance regions:** since states perform evenly, target new marketing at states with lower revenue to find growth.

## How to Run

1. Install MySQL and create the database: `create database retailsalesdb;`
2. Import the 5 tables (from the provided dump or CSV files).
3. Open `sales_insights_lowercase.sql` in MySQL Workbench and run the queries section by section.
4. Open `SalesInsights.pbix` in Power BI Desktop. If asked, update the data source to your MySQL server and refresh.

## Limitations

- The `products` table has no stock column, so "low sales, high stock" was approximated using low units sold only.
- The churn cut-off (90 days) and customer segment thresholds are my own choices and can be changed.

## Author

**Kenil**, Computer Science student
GitHub: [KenilSanghavi](https://github.com/KenilSanghavi)
