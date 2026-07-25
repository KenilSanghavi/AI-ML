## Overview

This Excel workbook is a multi-sheet practice/demo project covering common Excel functions and data analysis techniques across three real-world-style datasets: **Student Records**, **Sales Transactions**, and **Employee Data**.

---

## Sheets

### 1. STUDENT

**Purpose:** Tracks academic performance of 20 students across three subjects.

**Columns:**

| Column | Description |
|---|---|
| Student ID | Unique identifier (1001–1020) |
| Name | Student name |
| Math | Score out of 100 |
| Science | Score out of 100 |
| English | Score out of 100 |
| Enrollment Date | Date of enrollment (Excel serial date) |
| Total Marks | Sum of all three subject scores |
| Average | Average of the three subject scores |
| Grade | Letter grade (A / B / C / D) |
| Qualified | Whether the student is qualified (threshold-based) |

**Excel Functions Demonstrated:**

- `COUNTIF` — counts students with a score above 60
- `AVERAGEIF` — average of students with average > 60
- `VLOOKUP` — looks up a student name by ID
- `FILTER` — filters students who are "qualified"
- `INDIRECT` — dynamic cell/range references

**Key Observations:**
- Only 3 out of 20 students are marked as "qualified" (Students 12, 13, and 20)
- Grade A students: Student 12 (avg 84.3) and Student 13 (avg 95)
- Student 13 has the highest average: **95**

---

### 2. SALES

**Purpose:** Tracks 20 sales transactions across products, regions, and salespersons.

**Columns:**

| Column | Description |
|---|---|
| Sales ID | Unique transaction ID (2001–2020) |
| Product | Product sold (Keyboard, Mouse, Printer, Monitor, Laptop) |
| Region | Sales region (North, South, East, West) |
| Salesperson | Person who made the sale |
| Amount | Sale amount (in currency units) |
| Date | Transaction date (Excel serial date) |
| Discount | Discount rate applied (5%, 10%, or 15%) |
| Eligible | Whether the salesperson is discount-eligible |

**Excel Functions Demonstrated:**

- `VLOOKUP` / `INDEX-MATCH` — retrieves price by Sales ID
- `SUMIF` — totals by region (`specific region`) and by product (`specific product`)
- `XMATCH` — finds position of a salesperson in the list
- `INDIRECT` — dynamic range reference (e.g., `A2:A4`)
- `OFFSET` — returns a range offset from a reference point

**Key Observations:**
- Highest single sale: **Person 8** — Keyboard, East region — ₹46,429
- Eligibility rule: sales amounts above ~10,000 appear to qualify for higher discounts
- Products covered: Keyboard, Mouse, Printer, Monitor, Laptop

---

### 3. EMPLOYEE

**Purpose:** Manages HR data for 20 employees across departments.

**Columns:**

| Column | Description |
|---|---|
| Employee ID | Unique ID (3001–3020) |
| Name | Employee name |
| Department | Department (Finance, HR, IT, Marketing) |
| Salary | Annual salary |
| Joining Date | Date of joining (Excel serial date) |

**Excel Functions Demonstrated:**

- `XLOOKUP` — retrieves full employee details (department, salary) by name
- `YEAR()` / `MONTH()` — extracts year and month from joining date
- `TODAY()` / Date arithmetic — calculates years of service till today
- `LEFT()` / `UPPER()` — text functions to extract first name and convert to uppercase
- `INDIRECT` — dynamic reference for employee lookup

**Key Observations:**
- Departments: Finance (6), HR (6), IT (5), Marketing (3)
- Highest salary: **Employee 18** — IT — ₹1,16,284
- Lowest salary: **Employee 2** — Finance — ₹31,943
- Some employees have future joining dates (Employees 18–20), causing `#NUM!` errors in years-of-service calculations

---

## Excel Concepts Covered

| Concept | Sheet(s) Used |
|---|---|
| `VLOOKUP` | STUDENT, SALES |
| `XLOOKUP` | EMPLOYEE |
| `COUNTIF` / `SUMIF` / `AVERAGEIF` | STUDENT, SALES |
| `FILTER` | STUDENT |
| `XMATCH` | SALES |
| `INDIRECT` | STUDENT, SALES, EMPLOYEE |
| `OFFSET` | SALES |
| `YEAR()`, `MONTH()`, `TODAY()` | EMPLOYEE |
| `LEFT()`, `UPPER()` | EMPLOYEE |
| Discount & eligibility logic | SALES |
| Grading logic | STUDENT |

---

## Notes

- Dates are stored as Excel serial numbers (e.g., `43101` = January 6, 2018). Format the date columns as `Date` in Excel to display them correctly.
- Some employees have future joining dates, which causes `#NUM!` errors in the "Years Till Today" column — this is expected behavior when subtracting a future date from today.
- The "qualified" threshold in the STUDENT sheet appears to require an average above approximately 80 or a grade of A.
