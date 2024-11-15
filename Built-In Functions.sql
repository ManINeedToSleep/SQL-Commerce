-- Calculate the average value of all orders
SELECT 
    AVG(total_amount) AS average_order_value
FROM 
    orders;

-- Count the number of orders in each status
SELECT 
    order_status AS status,
    COUNT(*) AS order_count
FROM 
    orders
GROUP BY 
    order_status;

-- Find the highest priced product
SELECT 
    product_id, 
    name, 
    MAX(price) AS highest_price
FROM 
    products;

-- Find the lowest priced product
SELECT 
    product_id, 
    name, 
    MIN(price) AS lowest_price
FROM 
    products;

-- Calculate total quantity sold per product
SELECT 
    p.product_id, 
    p.name, 
    SUM(od.quantity) AS total_quantity_sold
FROM 
    order_details od
JOIN 
    products p ON od.product_id = p.product_id
GROUP BY 
    p.product_id;

-- Calculate total revenue generated per day
SELECT 
    DATE(order_date) AS order_date,
    SUM(total_amount) AS total_revenue
FROM 
    orders
GROUP BY 
    DATE(order_date);

-- List customers with their total amount spent
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    SUM(od.quantity * od.price) AS total_spent
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
JOIN 
    order_details od ON o.order_id = od.order_id
GROUP BY 
    c.customer_id;

-- Find the top 5 customers by total spending
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    SUM(od.quantity * od.price) AS total_spent
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
JOIN 
    order_details od ON o.order_id = od.order_id
GROUP BY 
    c.customer_id
ORDER BY 
    total_spent DESC
LIMIT 5;
