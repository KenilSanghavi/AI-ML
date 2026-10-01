# Olist Brazilian E-Commerce – Power BI Data Modelling & Dashboard (PR3)

A Power BI project that builds a star-schema data model and a 3-page interactive report on the Olist Brazilian E-Commerce dataset.

**Author:** Kenil · [GitHub](https://github.com/KenilSanghavi)

---

## Project Links

| Item | Link |
|------|------|
| Dataset (Kaggle) | https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce |
| Demo video + `.pbix` file (Google Drive) | PASTE_YOUR_DRIVE_LINK_HERE |

> The Drive folder is set to "Anyone with the link – Viewer". The `.pbix` is about 66 MB, so it is hosted on Drive instead of GitHub.

---

## Tools Used

- Power BI Desktop
- Power Query (M language)
- DAX

---

## Dataset

The Olist dataset has 9 CSV files covering orders, items, customers, sellers, products, payments, reviews, geolocation and category translation. All 9 files were loaded into Power BI Desktop and renamed to clean table names:

`FactOrderItems`, `DimOrders`, `DimCustomers`, `DimProducts`, `DimSellers`, `FactPayments`, `FactReviews`, `DimGeolocation`, `CategoryTranslation`

`product_category_name_translation` was merged into `DimProducts` as the **Product_Category_EN** column.

---

## Data Model (Star Schema)

<img width="1166" height="732" alt="image" src="https://github.com/user-attachments/assets/6270eee2-8f70-4e4b-bf03-5badab44cb75" />


<img width="1033" height="727" alt="image" src="https://github.com/user-attachments/assets/d1a16e9a-878f-4e0d-91b4-79f88ed06587" />


### Fact Table

**FactOrderItems** – holds the numeric values `price` and `freight_value` (used as measures) and the foreign keys `order_id`, `product_id` and `seller_id`.

### Dimension Tables

| Table | Purpose |
|-------|---------|
| DimOrders | Order details: status, purchase date, delivery date |
| DimCustomers | Customer city and state |
| DimProducts | Product details and English category name |
| DimSellers | Seller city and state |
| DimDate | Calendar table for time analysis |

`FactPayments` and `FactReviews` are additional fact tables linked to `DimOrders`.

### DimDate

Built in Power Query with M code. Columns: `Date`, `Year`, `Quarter`, `Month_Num`, `Month_Name`, `Weekday`, `Year_Quarter`.
It is marked as the Date Table (Table Tools → Mark as Date Table), and `Month_Name` is sorted by `Month_Num`.

---

## Relationships

### 7 Active Relationships (Many-to-One, Single direction)

| # | From (Many) | To (One) |
|---|-------------|----------|
| 1 | FactOrderItems[order_id] | DimOrders[order_id] |
| 2 | FactOrderItems[product_id] | DimProducts[product_id] |
| 3 | FactOrderItems[seller_id] | DimSellers[seller_id] |
| 4 | FactPayments[order_id] | DimOrders[order_id] |
| 5 | FactReviews[order_id] | DimOrders[order_id] |
| 6 | DimOrders[customer_id] | DimCustomers[customer_id] |
| 7 | DimOrders[order_purchase_date] | DimDate[Date] |

### 1 Inactive Relationship

| From (Many) | To (One) | Why inactive |
|-------------|----------|--------------|
| DimOrders[order_delivered_customer_date] | DimDate[Date] | Only one relationship between two tables can be active. It is activated in a measure with `USERELATIONSHIP()` when delivery-date analysis is needed. |

### Date column note

`order_purchase_timestamp` contains date and time, while `DimDate[Date]` contains date only, so most rows did not match and 2016 showed blank. A date-only column was added in Power Query, `Date.From([order_purchase_timestamp])`, and the relationship uses that column.

### Bi-directional filtering

Cross-filter direction decides which way a filter flows between tables. With **Single**, the filter flows from the "one" side to the "many" side only. With **Both**, it flows in both directions.

Risks of Both:
- Ambiguous filter paths when several routes exist between tables
- Slower performance on large models
- Totals that change unexpectedly depending on which slicers are used
- Circular dependencies

For this reason Single direction is used by default, and Both is used only where it is needed, as shown in the video.

---

## Model Settings

- Technical fields hidden from Report View: zip code prefixes, product length/width/height, `order_item_id`
- Currency format **R$ (Brazilian Real)** applied to `price`, `freight_value` and `payment_value`
- Geography data categories set for `customer_city`, `customer_state`, `seller_city`, `seller_state`

### Hierarchies (4)

| Hierarchy | Levels |
|-----------|--------|
| Date Hierarchy | Year → Quarter → Month_Name |
| Product Hierarchy | Product_Category_EN → product_id |
| Seller Location | seller_state → seller_city |
| Customer Location | customer_state → customer_city |

### Measures

```DAX
Total Orders = DISTINCTCOUNT(DimOrders[order_id])
Revenue      = SUM(FactOrderItems[price])
Avg Review Score = AVERAGE(FactReviews[review_score])
```

---

## Report Pages

A built-in theme is applied consistently across all 3 pages. A **report-level filter** (`order_status = delivered`) applies to every page.

### Page 1 – Sales Overview

KPI cards, line chart of orders by year (with drill-down through the Date Hierarchy), bar chart, map, matrix and slicers. A text box describes the model.

### Page 2 – Payments & Reviews

Header: *Payment Methods · Customer Satisfaction*

- Matrix of payment type × year with conditional formatting
- Donut chart of payment type mix (% of total `payment_value`)
- Bar chart of average review score by product category
- Year slicer

### Page 3 – Geographic Analysis

Header: *Geographic Distribution — Customers & Sellers*

- Map of orders by customer state (Customer Location hierarchy)
- Clustered bar chart of the top 10 seller cities by revenue (Seller Location hierarchy)
- Clustered column chart of revenue by seller state
- Year slicer

Screenshots:

| Sales Overview |
|<img width="1336" height="697" alt="image" src="https://github.com/user-attachments/assets/dfe81c9e-2f92-437f-9849-74a8444fe3f9" />|
| Payments & Reviews |
 |<img width="1322" height="682" alt="image" src="https://github.com/user-attachments/assets/e55c06c4-24f3-49ea-bb6d-00d001928b8f" />|
 | Geographic Analysis |
 |<img width="1332" height="655" alt="image" src="https://github.com/user-attachments/assets/d9e852fa-2c6b-455a-a1d6-c921d05221e2" />|
 

---

## Demo Video

Watch it here: PASTE_YOUR_VIDEO_LINK_HERE

The video (about 5–10 minutes, face and screen) covers:
- Model View walkthrough
- Bi-directional filter demonstration and its risks
- Filter flow from a slicer through a dimension to the fact table
- Drill-down on the line chart using the Date Hierarchy

---

## Repository Structure

```
├── README.md
├── images/
│   ├── star_schema.png
│   ├── model_view.png
│   ├── page1.png
│   ├── page2.png
│   └── page3.png
└── (PR3_kenil.pbix and video hosted on Google Drive)
```
