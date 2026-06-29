# Data Transformer – SQL Project

## Project Overview
The **Data Transformer** project is designed to demonstrate practical knowledge of advanced SQL concepts such as Joins, Subqueries, Date Functions, String Functions, Window Functions, and CASE Expressions. The project simulates a Corporate Data Analysis System that manages customer information, sales transactions, and employee performance data.

---

## Objectives
- Perform different types of SQL Joins.
- Use Subqueries for data analysis.
- Apply Date and String Manipulation Functions.
- Utilize Window Functions for analytical queries.
- Implement CASE expressions for conditional reporting.
- Transform raw data into meaningful business insights.

---

## Database Tables

### 1. Customer
| Column |
|--------|
| CustomerID |
| FirstName |
| LastName |
| Email |
| RegistrationDate |

### 2. Orders
| Column |
|--------|
| OrderID |
| CustomerID |
| OrderDate |
| TotalAmount |

### 3. Employees
| Column |
|--------|
| EmployeeID |
| FirstName |
| LastName |
| Department |
| HireDate |
| Salary |

---

# SQL Queries

## Q1. Retrieve all customers with their corresponding orders (INNER JOIN)

```sql
SELECT *
FROM customer
JOIN orderss
ON customer.customer_id = orderss.customer_id;
```

---

## Q2. Retrieve all customers including those without orders (LEFT JOIN)

```sql
SELECT *
FROM customer
LEFT JOIN orderss
ON customer.customer_id = orderss.customer_id;
```

---

## Q3. Retrieve all orders including customers without matching records (RIGHT JOIN)

```sql
SELECT *
FROM customer
RIGHT JOIN orderss
ON customer.customer_id = orderss.customer_id;
```

---

## Q4. Retrieve all customers and all orders (FULL OUTER JOIN using UNION)

```sql
SELECT *
FROM customer
LEFT JOIN orderss
ON customer.customer_id = orderss.customer_id

UNION

SELECT *
FROM customer
RIGHT JOIN orderss
ON customer.customer_id = orderss.customer_id;
```

---

## Q5. Find customers whose order amount is greater than the average order amount

```sql
SELECT *
FROM customer
WHERE customer_id IN
(
SELECT customer_id
FROM orderss
WHERE total_amount >
(
SELECT AVG(total_amount)
FROM orderss
)
);
```

---

## Q6. Find employees earning more than the average salary

```sql
SELECT *
FROM employees
WHERE salary >
(
SELECT AVG(salary)
FROM employees
);
```

---

## Q7. Extract Year and Month from Order Date

```sql
SELECT
order_id,
YEAR(order_date),
MONTH(order_date)
FROM orderss;
```

---

## Q8. Calculate difference in days between Order Date and Current Date

```sql
SELECT
order_id,
DATEDIFF(CURDATE(),order_date)
FROM orderss;
```

---

## Q9. Format Order Date as DD-MM-YY

```sql
SELECT
order_id,
DATE_FORMAT(order_date,'%d-%m-%y')
FROM orderss;
```

---

## Q10. Concatenate First Name and Last Name

```sql
SELECT
CONCAT(firstname,' ',lastname)
FROM customer;
```

---

## Q11. Replace 'John' with 'Jonathan'

```sql
UPDATE customer
SET firstname='Jonathan'
WHERE firstname='John';
```

---

## Q12. Convert First Name to Uppercase and Last Name to Lowercase

```sql
SELECT
UPPER(firstname),
LOWER(lastname)
FROM customer;
```

---

## Q13. Remove Extra Spaces from Email

```sql
SELECT
TRIM(email)
FROM customer;
```

---

## Q14. Calculate Running Total of Order Amount

```sql
SELECT
order_id,
total_amount,
SUM(total_amount)
OVER(ORDER BY order_id)
FROM orderss;
```

---

## Q15. Rank Orders Based on Total Amount

```sql
SELECT
order_id,
total_amount,
RANK() OVER(ORDER BY total_amount DESC)
FROM orderss;
```

---

## Q16. Display Discount Category Based on Order Amount

```sql
SELECT
order_id,
total_amount,
CASE
WHEN total_amount > 1000 THEN '10% Discount'
WHEN total_amount > 500 THEN '5% Discount'
ELSE 'No Discount'
END AS discount
FROM orderss;
```

---

## Q17. Categorize Employee Salaries

```sql
SELECT
employee_id,
firstname,
salary,
CASE
WHEN salary >= 70000 THEN 'High'
WHEN salary >= 50000 THEN 'Medium'
ELSE 'Low'
END AS salary_category
FROM employees;
```

---

# SQL Concepts Used

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL OUTER JOIN (Using UNION)
- Subqueries
- Aggregate Functions
- Date Functions
  - YEAR()
  - MONTH()
  - DATEDIFF()
  - DATE_FORMAT()
- String Functions
  - CONCAT()
  - UPPER()
  - LOWER()
  - TRIM()
- Window Functions
  - SUM() OVER()
  - RANK()
- CASE Expression
- UPDATE Statement

---

# Assumptions

- `customer_id` is the primary key in the **customer** table.
- `customer_id` in **orderss** is a foreign key.
- Employee salaries are stored in the `salary` column.
- Dates are stored using the DATE datatype.
- The project is executed using **MySQL 8.0+** since Window Functions are used.

---

# Software Used

- MySQL 8.0
- MySQL Command Line Client

---

# Learning Outcomes

After completing this project, the following SQL skills were practiced:

- Joining multiple tables
- Writing nested subqueries
- Manipulating date values
- Working with string functions
- Using analytical window functions
- Applying CASE statements for business logic
- Transforming data for reporting and analysis

---

# Author

**Name:** Kenil Sanghavi

**Project:** Data Transformer – SQL Project

**Database:** MySQL

**Academic Project**
