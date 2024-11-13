-- Step 1: Create the e-commerce database
CREATE DATABASE ecommerce_store;

-- Step 2: Select the database to work with
USE ecommerce_store;

-- Step 3: Create the 'customers' table to store customer information
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

-- Step 4: Create the 'products' table to store product information
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique ID for each product, auto-increments
    name VARCHAR(100) NOT NULL,                 -- Name of the product
    description TEXT,                           -- Detailed description of the product
    price DECIMAL(10, 2) NOT NULL,              -- Price of the product (up to 2 decimal places)
    stock_quantity INT NOT NULL,                -- The number of products in stock
    date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Date and time when the product was added (defaults to current time)
);

-- Step 5: Create the 'orders' table to store customer orders
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,    -- Unique ID for each order, auto-increments
    customer_id INT,                            -- Foreign key referencing 'customer_id' from the customers table
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Date and time the order was placed (defaults to current time)
    order_status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending', -- Status of the order
    total_amount DECIMAL(10, 2),                -- Total amount for the order
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) -- Foreign key constraint linking orders to the customers table
);

-- Step 6: Create the 'order_details' table to store each product in an order
CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each order item, auto-increments
    order_id INT,                                  -- Foreign key referencing 'order_id' from the orders table
    product_id INT,                                -- Foreign key referencing 'product_id' from the products table
    quantity INT,                                  -- Number of products ordered
    price DECIMAL(10, 2),                          -- Price of the product at the time of the order
    FOREIGN KEY (order_id) REFERENCES orders(order_id), -- Foreign key linking order details to orders
    FOREIGN KEY (product_id) REFERENCES products(product_id) -- Foreign key linking order details to products
);

-- Step 7: Insert sample data into the 'customers' table
INSERT INTO customers (first_name, last_name, email, phone_number, address, city, state, zip_code) 
VALUES 
('John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Main St', 'Cityville', 'CA', '12345'),
('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '456 Oak Ave', 'Township', 'TX', '54321');

-- Step 8: Insert sample products into the 'products' table
INSERT INTO products (name, description, price, stock_quantity) 
VALUES 
('Laptop', 'A powerful gaming laptop', 1200.99, 10),
('Smartphone', 'A new smartphone with amazing features', 799.50, 15),
('Headphones', 'Noise-cancelling wireless headphones', 150.00, 30);

-- Step 9: Insert a sample order into the 'orders' table
INSERT INTO orders (customer_id, total_amount) 
VALUES (1, 1500.99);  -- Customer with ID 1 (John Doe) placed an order worth $1500.99

-- Step 10: Insert order details into the 'order_details' table
INSERT INTO order_details (order_id, product_id, quantity, price) 
VALUES 
(1, 1, 1, 1200.99),  -- 1 Laptop
(1, 3, 1, 150.00);   -- 1 Headphones

-- Step 11: Query to retrieve all orders placed by a specific customer (Customer with ID 1)
SELECT order_id, order_date 
FROM orders 
WHERE customer_id = 1;  -- Show orders for customer with ID 1 (John Doe)

-- Step 12: Create a table to store customer addresses (for customers with multiple addresses)
CREATE TABLE customer_addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each address, auto-increments
    customer_id INT,                             -- Foreign key referencing 'customer_id' from the customers table
    address VARCHAR(255) NOT NULL,               -- Address of the customer
    city VARCHAR(100) NOT NULL,                  -- City of the customer's address
    state VARCHAR(100) NOT NULL,                 -- State of the customer's address
    zip_code VARCHAR(20) NOT NULL,               -- Zip code of the customer's address
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) -- Foreign key linking addresses to customers
);


-- Reflection
-- How do the tables work together to create a full picture of customers and orders?

-- The customers table holds information about each customer. The orders table keeps track 
-- of the orders customers make. The order_details table links the products in each order, 
-- and the products table tracks the items available for sale.

-- Why are foreign keys essential in linking different tables in a relational database?

-- Foreign keys make sure that the data in one table matches valid data in another table. 
-- They help connect the tables properly, so the information stays accurate and organized.

-- What challenges did you face in designing this schema?

-- It was very confusing at first. What to add, to insert, to create. But after I got that
-- sorted out, it was a lot smoother since it was just rinse and repeat.

