-- Retrieve orders placed by customers with 'Delivered' status
SELECT 
    c.customer_id,       -- Customer ID
    c.first_name,        -- Customer's first name
    c.last_name,         -- Customer's last name
    o.order_id,          -- Order ID
    o.order_date         -- Order date
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id   -- Join orders with customers based on customer_id
WHERE 
    o.order_status = 'Delivered';               -- Only show orders with 'Delivered' status

Get detailed product information for a specific order
SELECT 
    o.order_id,               -- Order ID
    od.product_id,            -- Product ID
    p.name,                   -- Product name
    od.quantity,              -- Quantity of product ordered
    od.price                  -- Price of the product at the time of order
FROM 
    orders o
JOIN 
    order_details od ON o.order_id = od.order_id   -- Join order_details with orders based on order_id
JOIN 
    products p ON od.product_id = p.product_id     -- Join products with order_details based on product_id
WHERE 
    o.order_id = 1                                  -- Filter by specific order ID
ORDER BY 
    od.product_id ASC;                             -- Sort by product_id in ascending order

-- List all pending orders along with customer details
SELECT 
    o.order_id,           -- Order ID
    o.order_date,         -- Order date
    o.order_status,       -- Order status
    c.first_name,         -- Customer's first name
    c.last_name,          -- Customer's last name
    c.email               -- Customer's email
FROM 
    orders o
JOIN 
    customers c ON o.customer_id = c.customer_id   -- Join orders with customers based on customer_id
WHERE 
    o.order_status = 'Pending';                    -- Only show orders with 'Pending' status

-- Calculate total sales for each customer
SELECT 
    c.customer_id,                 -- Customer ID
    c.first_name,                  -- Customer's first name
    c.last_name,                   -- Customer's last name
    SUM(od.quantity * od.price) AS total_sales  -- Calculate total sales (quantity * price)
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id    -- Join customers with orders based on customer_id
JOIN 
    order_details od ON o.order_id = od.order_id  -- Join orders with order_details based on order_id
GROUP BY 
    c.customer_id;                    -- Group by customer to get total sales per customer

-- Find products ordered by more than one customer
SELECT 
    od.product_id,                 -- Product ID
    p.name,                        -- Product name
    COUNT(DISTINCT o.customer_id) AS customer_count  -- Count distinct customers who ordered the product
FROM 
    order_details od
JOIN 
    products p ON od.product_id = p.product_id  -- Join order_details with products based on product_id
JOIN 
    orders o ON od.order_id = o.order_id       -- Join orders with order_details based on order_id
GROUP BY 
    od.product_id                        -- Group by product_id to count unique customers for each product
HAVING 
    customer_count > 1;                  -- Only show products ordered by more than one customer

-- Display each product sold along with the quantity sold and customer details
SELECT 
    p.product_id,            -- Product ID
    p.name,                  -- Product name
    od.quantity,             -- Quantity of the product ordered
    o.customer_id,           -- Customer ID
    c.first_name             -- Customer's first name
FROM 
    products p
JOIN 
    order_details od ON p.product_id = od.product_id   -- Join products with order_details based on product_id
JOIN 
    orders o ON od.order_id = o.order_id               -- Join orders with order_details based on order_id
JOIN 
    customers c ON o.customer_id = c.customer_id       -- Join customers with orders based on customer_id
ORDER BY 
    p.product_id ASC, o.customer_id ASC;               -- Sort by product_id and customer_id in ascending order
