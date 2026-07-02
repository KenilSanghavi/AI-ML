# Library Management System - SQL Assignment

## Overview

This project is a SQL-based Library Management System developed using MySQL. It demonstrates fundamental and advanced SQL concepts including CRUD operations, filtering, sorting, grouping, aggregate functions, joins, subqueries, date and string functions, window functions, and CASE expressions.

The database maintains information about authors, books, members, and book transactions in a library.

---

## Database Tables

The project consists of the following four tables:

- **authors** – Stores author details.
- **books** – Stores book information.
- **members** – Stores library member details.
- **transactions** – Stores borrowing and returning records of books.

---

## Features Implemented

### 1. CRUD Operations
- Insert new authors, books, and members.
- Update available book copies after borrowing or returning.
- Delete members who have not borrowed books in the last year.
- Retrieve books with available copies.

### 2. SQL Clauses
- WHERE
- HAVING
- LIMIT

### 3. SQL Operators
- AND
- OR
- NOT

### 4. Sorting and Grouping
- ORDER BY
- GROUP BY

### 5. Aggregate Functions
- COUNT()
- SUM()
- AVG()
- MAX()
- MIN()

### 6. Primary and Foreign Key Relationships
- Books linked with authors.
- Members linked with transactions.

### 7. SQL Joins
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL OUTER JOIN (using UNION in MySQL)

### 8. Subqueries
- Single-row subqueries
- Multi-row subqueries

### 9. Date and Time Functions
- YEAR()
- DATEDIFF()
- DATE_FORMAT()

### 10. String Functions
- UPPER()
- TRIM()
- IFNULL()

### 11. Window Functions
- RANK()
- COUNT() OVER()
- Moving Average

### 12. CASE Expressions
- Membership status classification
- Book category classification

---

## Software Used

- MySQL Server 8.0
- MySQL Client
- Visual Studio Code

---

## SQL Concepts Covered

- Data Definition Language (DDL)
- Data Manipulation Language (DML)
- Data Query Language (DQL)
- CRUD Operations
- Filtering Records
- Sorting Records
- Grouping Data
- Aggregate Functions
- Joins
- Subqueries
- Date Functions
- String Functions
- Window Functions
- CASE Expressions

---

## Tables Used

### Authors
Stores information about book authors.

### Books
Stores book details including title, category, publication date, price, and available copies.

### Members
Stores member information such as name, email, phone number, and membership date.

### Transactions
Stores borrowing records, return dates, and fine amounts.

---

## Learning Outcomes

After completing this project, the following SQL concepts were implemented and understood:

- Creating relational database tables
- Defining primary and foreign keys
- Performing CRUD operations
- Writing filtering queries using SQL clauses
- Using logical operators
- Applying aggregate functions
- Working with different types of joins
- Writing nested subqueries
- Manipulating date and string values
- Implementing window functions
- Using CASE expressions for conditional output

---
