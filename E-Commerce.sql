-- Step 1: Create the e-commerce database
CREATE DATABASE ecommerce_store;
USE ecommerce_store;

-- Step 2A: Create the 'customers' table to store customer information
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each customer, auto-increments with each new customer
    first_name VARCHAR(50) NOT NULL,            -- First name of the customer
    last_name VARCHAR(50) NOT NULL,             -- Last name of the customer
    email VARCHAR(100) UNIQUE NOT NULL,         -- Unique email for each customer (can't be repeated)
    phone_number VARCHAR(20) NOT NULL,          -- Customer's phone number
    address VARCHAR(255) NOT NULL,              -- Customer's address
    city VARCHAR(100) NOT NULL,                 -- City of the customer
    state VARCHAR(100) NOT NULL,                -- State of the customer
    zip_code VARCHAR(20) NOT NULL,              -- Zip code of the customer
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Date and time the customer registered (defaults to current time)
);

-- Step 2B: Create the 'products' table to store product information
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique ID for each product, auto-increments
    name VARCHAR(100) NOT NULL,                 -- Name of the product
    description TEXT,                           -- Detailed description of the product
    price DECIMAL(10, 2) NOT NULL,              -- Price of the product (up to 2 decimal places)
    stock_quantity INT NOT NULL,                -- The number of products in stock
    date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Date and time when the product was added (defaults to current time)
);

-- Step 2C: Create the 'orders' table to store customer orders
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,    -- Unique ID for each order, auto-increments
    customer_id INT,                            -- Foreign key referencing 'customer_id' from the customers table
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Date and time the order was placed (defaults to current time)
    order_status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending', -- Status of the order
    total_amount DECIMAL(10, 2),                -- Total amount for the order
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) -- Foreign key constraint linking orders to the customers table
);

-- Step 2D: Create the 'order_details' table to store each product in an order
CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each order item, auto-increments
    order_id INT,                                  -- Foreign key referencing 'order_id' from the orders table
    product_id INT,                                -- Foreign key referencing 'product_id' from the products table
    quantity INT,                                  -- Number of products ordered
    price DECIMAL(10, 2),                          -- Price of the product at the time of the order
    FOREIGN KEY (order_id) REFERENCES orders(order_id), -- Foreign key linking order details to orders
    FOREIGN KEY (product_id) REFERENCES products(product_id) -- Foreign key linking order details to products
);

-- Step 3A: Insert sample data into the 'customers' table
INSERT INTO customers (first_name, last_name, email, phone_number, address, city, state, zip_code) 
VALUES 
('John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Main St', 'Cityville', 'CA', '12345'),
('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '456 Oak Ave', 'Township', 'TX', '54321'),
('Alice', 'Johnson', 'alice.johnson@example.com', '555-123-4567', '789 Pine Rd', 'Metrocity', 'NY', '67890'),
('Bob', 'Brown', 'bob.brown@example.com', '321-654-9870', '101 Elm St', 'Suburbia', 'FL', '11223'),
('Charlie', 'White', 'charlie.white@example.com', '789-456-1230', '202 Birch Ln', 'Downtown', 'IL', '33445');


-- Step 3B: Insert sample products into the 'products' table
INSERT INTO products (name, description, price, stock_quantity) 
VALUES 
('Laptop', 'A powerful gaming laptop', 1200.99, 10),
('Smartphone', 'A new smartphone with amazing features', 799.50, 15),
('Headphones', 'Noise-cancelling wireless headphones', 150.00, 30),
('Tablet', 'Lightweight tablet with a stunning display', 499.99, 20),
('Smartwatch', 'Fitness tracking and notifications on your wrist', 199.99, 25);


-- Step 3C: Insert a sample order into the 'orders' table
INSERT INTO orders (customer_id, total_amount) 
VALUES 
(1, 1500.99),  -- John Doe's order
(2, 949.50),   -- Jane Smith's order
(3, 699.99),   -- Alice Johnson's order
(4, 199.99),   -- Bob Brown's order
(5, 899.50);   -- Charlie White's order


-- Step 3D: Insert order details into the 'order_details' table
INSERT INTO order_details (order_id, product_id, quantity, price) 
VALUES 
(1, 1, 1, 1200.99),  -- John Doe bought 1 Laptop
(1, 3, 2, 150.00),   -- John Doe bought 2 Headphones
(2, 2, 1, 799.50),   -- Jane Smith bought 1 Smartphone
(2, 5, 1, 199.99),   -- Jane Smith bought 1 Smartwatch
(3, 4, 1, 499.99),   -- Alice Johnson bought 1 Tablet
(4, 5, 1, 199.99),   -- Bob Brown bought 1 Smartwatch
(5, 1, 1, 1200.99),  -- Charlie White bought 1 Laptop
(5, 2, 1, 799.50),   -- Charlie White bought 1 Smartphone
(3, 3, 2, 150.00),   -- Alice Johnson bought 2 Headphones
(4, 4, 1, 499.99);   -- Bob Brown bought 1 Tablet

-- Step 4A: Join orders and customers to Get Order Details with Customer Info
SELECT 
    orders.order_id AS order_id, 
    customers.first_name AS customer_first_name, 
    customers.last_name AS customer_last_name, 
    orders.total_amount, 
    orders.order_date
FROM 
    orders
JOIN 
    customers 
ON 
    orders.customer_id = customers.customer_id;

-- Step 4B: Join order_items, orders, and products to Get Order Line Items
SELECT 
    orders.order_id AS order_id, 
    products.name AS product_name, 
    order_details.quantity, 
    order_details.price, 
    (order_details.quantity * order_details.price) AS line_total
FROM 
    order_details
JOIN 
    orders 
ON 
    order_details.order_id = orders.order_id
JOIN 
    products 
ON 
    order_details.product_id = products.product_id;

-- Step 4C: Use SUM() and GROUP BY to Aggregate Total Revenue per Customer

SELECT 
    customers.first_name AS customer_first_name, 
    customers.last_name AS customer_last_name, 
    SUM(orders.total_amount) AS total_revenue
FROM 
    orders
JOIN 
    customers 
ON 
    orders.customer_id = customers.customer_id
GROUP BY 
    customers.customer_id;


-- Step 4D: Calculate the Total Revenue
SELECT 
    SUM(total_amount) AS total_revenue
FROM 
    orders;

-- Step 4E: Calculate the Average Order Value
SELECT 
    AVG(total_amount) AS average_order_value
FROM 
    orders;

-- Step 4F Count the Number of Orders per Customer
SELECT 
    customers.first_name AS customer_first_name, 
    customers.last_name AS customer_last_name, 
    COUNT(orders.order_id) AS number_of_orders
FROM 
    orders
JOIN 
    customers 
ON 
    orders.customer_id = customers.customer_id
GROUP BY 
    customers.customer_id;

