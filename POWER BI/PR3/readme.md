# 🛒 Olist E-Commerce Analytics — Power BI Dashboard

An interactive Power BI report analysing Brazilian e-commerce data from **Olist**. It covers sales performance, geographic distribution of customers and sellers, payment behaviour, and customer satisfaction.

---

## 📌 Project Overview

| Item | Details |
|---|---|
| **Tool** | Microsoft Power BI Desktop |
| **Domain** | E-commerce / Retail Analytics |
| **Dataset** | Olist Brazilian E-Commerce (Kaggle) |
| **Currency** | Brazilian Real (R$) |
| **Report file** | `PR3_kenil.pbix` |

---

## 📊 Report Pages

### 1. Sales Overview
- KPI cards: **Total Orders**, **Total Revenue (R$)**, **Average Order Value (R$)**, **Average Customer Rating**
- Top 10 product categories by revenue
- Order trend over time (Year → Quarter → Month drill-down)
- Slicers: Year, Order Status, Product Category

### 2. Geographic Analysis
- Map of order distribution across Brazilian states
- Seller revenue by state and city
- Year slicer for time-based filtering

### 3. Payments and Reviews
- Payment value by payment type (donut chart)
- Payment value by type and year (matrix)
- Top 10 product categories by review score

---

## 🗂️ Data Model

Star schema with fact tables at the centre and dimension tables around them.

**Fact tables**
- `FactOrderItems` — items sold, price, freight
- `FactPayments` — payment type and value
- `FactReviews` — customer review scores

**Dimension tables**
- `DimOrders`, `DimCustomer`, `DimSellers`, `DimProduct`, `DimGeolocation`, `DimDate`

![Data Model](screenshots/04_data_model.png)

---

## 🧮 Key Measures

| Measure | Description |
|---|---|
| Total Orders | Count of unique orders |
| Total Revenue | Sum of item price |
| Avg Order Value | Revenue divided by number of orders |
| Avg Customer Rating | Average review score |

---

## 🚀 How to Use

1. Download `PR3_kenil.pbix` (see **Download** below).
2. Open it with [Power BI Desktop](https://powerbi.microsoft.com/desktop/) (free, Windows only).
3. Use the slicers on each page to filter by year, category, or order status.


---

## 💡 Key Insights

*(Fill these in from your own findings, for example:)*
- Which product categories generate the most revenue?
- Which states have the most orders?
- Which payment method is most used?
- How has order volume changed over time?

---

## 🛠️ Skills Demonstrated

- Data modelling (star schema, relationships)
- DAX measures
- Data cleaning and transformation in Power Query
- Interactive dashboard design (slicers, drill-down, maps)

---

## 👤 Author

**Kenil Sanghavi**
GitHub: [@KenilSanghavi]

---

## 📄 Data Source

Olist Brazilian E-Commerce Public Dataset, available on Kaggle. Used here for educational purposes.
