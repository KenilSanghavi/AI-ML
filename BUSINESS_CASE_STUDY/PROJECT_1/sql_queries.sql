-- Total orders, customers, products
SELECT
  (SELECT COUNT(*) FROM Orders)    AS total_orders,
  (SELECT COUNT(*) FROM Customers) AS total_customers,
  (SELECT COUNT(*) FROM Products)  AS total_products;

-- Most frequently ordered products
SELECT p.product_name, COUNT(*) AS times_ordered
FROM OrderItems oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY times_ordered DESC
LIMIT 10;

-- Average order value
SELECT SUM(oi.quantity * p.unit_price * (1 - oi.discount)) / COUNT(DISTINCT o.order_id) AS aov
FROM Orders o
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
WHERE o.order_status <> 'Cancelled';

-- Monthly revenue
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month,
       SUM(oi.quantity * p.unit_price * (1 - oi.discount)) AS revenue
FROM Orders o
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
WHERE o.order_status <> 'Cancelled'
GROUP BY month
ORDER BY month;

-- Yearly revenue
SELECT YEAR(o.order_date) AS year,
       SUM(oi.quantity * p.unit_price * (1 - oi.discount)) AS revenue
FROM Orders o
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
WHERE o.order_status <> 'Cancelled'
GROUP BY year
ORDER BY year;

-- Top 5 states by revenue
SELECT c.state,
       SUM(oi.quantity * p.unit_price * (1 - oi.discount)) AS revenue
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.state
ORDER BY revenue DESC
LIMIT 5;


-- New vs returning customers per month
-- (new = the month of the customer's first order)
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month,
       COUNT(DISTINCT CASE WHEN DATE_FORMAT(o.order_date, '%Y-%m') = DATE_FORMAT(f.first_date, '%Y-%m')
                           THEN o.customer_id END) AS new_customers,
       COUNT(DISTINCT CASE WHEN DATE_FORMAT(o.order_date, '%Y-%m') > DATE_FORMAT(f.first_date, '%Y-%m')
                           THEN o.customer_id END) AS returning_customers
FROM Orders o
JOIN (SELECT customer_id, MIN(order_date) AS first_date
      FROM Orders GROUP BY customer_id) f
  ON o.customer_id = f.customer_id
GROUP BY month
ORDER BY month;

-- Top 10 customers by lifetime value
SELECT c.customer_id, c.first_name, c.last_name,
       SUM(oi.quantity * p.unit_price * (1 - oi.discount)) AS lifetime_value
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY lifetime_value DESC
LIMIT 10;

-- Gender-wise spending
SELECT c.gender,
       SUM(oi.quantity * p.unit_price * (1 - oi.discount)) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.gender;

-- Churn using last order date
-- (churned = no order in the 90 days before the latest order in the data)
SELECT customer_id,
       MAX(order_date) AS last_order_date,
       DATEDIFF((SELECT MAX(order_date) FROM Orders), MAX(order_date)) AS days_since_last_order,
       CASE
         WHEN DATEDIFF((SELECT MAX(order_date) FROM Orders), MAX(order_date)) > 90
         THEN 'Churned' ELSE 'Active'
       END AS status
FROM Orders
GROUP BY customer_id;

-- Best-selling products by quantity and revenue
SELECT p.product_name,
       SUM(oi.quantity) AS units_sold,
       SUM(oi.quantity * p.unit_price * (1 - oi.discount)) AS revenue
FROM OrderItems oi
JOIN Orders o ON oi.order_id = o.order_id
JOIN Products p ON oi.product_id = p.product_id
WHERE o.order_status <> 'Cancelled'
GROUP BY p.product_name
ORDER BY units_sold DESC
LIMIT 10;

-- Category-wise revenue
SELECT p.category,
       SUM(oi.quantity * p.unit_price * (1 - oi.discount)) AS revenue
FROM OrderItems oi
JOIN Orders o ON oi.order_id = o.order_id
JOIN Products p ON oi.product_id = p.product_id
WHERE o.order_status <> 'Cancelled'
GROUP BY p.category
ORDER BY revenue DESC;

-- Profit margin per product
SELECT product_name, unit_price, cost_price,
       unit_price - cost_price AS profit,
       ROUND((unit_price - cost_price) / unit_price * 100, 2) AS margin_percent
FROM Products
ORDER BY margin_percent DESC;

-- Underperforming products (low sales)
-- The Products table has no stock column, so I use low units sold instead
SELECT p.product_name, COALESCE(SUM(oi.quantity), 0) AS units_sold
FROM Products p
LEFT JOIN OrderItems oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY units_sold ASC
LIMIT 10;



-- Average shipping time (days)
SELECT AVG(DATEDIFF(s.shipping_date, o.order_date)) AS avg_shipping_days
FROM Shipping s
JOIN Orders o ON s.order_id = o.order_id;

-- Shipping cost by method
SELECT shipping_method,
       COUNT(*) AS shipments,
       AVG(shipping_cost) AS avg_cost,
       SUM(shipping_cost) AS total_cost
FROM Shipping
GROUP BY shipping_method;

-- Delayed vs on-time
SELECT shipping_status, COUNT(*) AS shipments
FROM Shipping
GROUP BY shipping_status;

-- Delayed vs on-time by shipping method
SELECT shipping_method, shipping_status, COUNT(*) AS shipments
FROM Shipping
GROUP BY shipping_method, shipping_status
ORDER BY shipping_method;


-- RANK: rank products by revenue inside each category
SELECT category, product_name, revenue,
       RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rank_in_category
FROM (
  SELECT p.category, p.product_name,
         SUM(oi.quantity * p.unit_price * (1 - oi.discount)) AS revenue
  FROM OrderItems oi
  JOIN Products p ON oi.product_id = p.product_id
  GROUP BY p.category, p.product_name
) t;

-- ROW_NUMBER: latest order of each customer
SELECT customer_id, order_id, order_date
FROM (
  SELECT customer_id, order_id, order_date,
         ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn
  FROM Orders
) t
WHERE rn = 1;

-- LAG / LEAD: previous and next month revenue
SELECT month, revenue,
       LAG(revenue)  OVER (ORDER BY month) AS prev_month,
       LEAD(revenue) OVER (ORDER BY month) AS next_month
FROM (
  SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month,
         SUM(oi.quantity * p.unit_price * (1 - oi.discount)) AS revenue
  FROM Orders o
  JOIN OrderItems oi ON o.order_id = oi.order_id
  JOIN Products p ON oi.product_id = p.product_id
  GROUP BY month
) t;

-- CASE WHEN: customer segments by spending
SELECT customer_id, total_spent,
       CASE
         WHEN total_spent >= 5000 THEN 'High'
         WHEN total_spent >= 1000 THEN 'Medium'
         ELSE 'Low'
       END AS segment
FROM (
  SELECT o.customer_id,
         SUM(oi.quantity * p.unit_price * (1 - oi.discount)) AS total_spent
  FROM Orders o
  JOIN OrderItems oi ON o.order_id = oi.order_id
  JOIN Products p ON oi.product_id = p.product_id
  GROUP BY o.customer_id
) t;

-- Joins across tables: revenue by state and category
SELECT c.state, p.category,
       SUM(oi.quantity * p.unit_price * (1 - oi.discount)) AS revenue
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.state, p.category
ORDER BY revenue DESC;
