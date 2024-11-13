CREATE DATABASE ecommerce_store;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,  -- Allows 10 digits, with 2 digits after the decimal point
    stock_quantity INT NOT NULL,
    date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers (first_name, last_name, email, phone_number, address, city, state, zip_code) 
VALUES 
('John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Main St', 'Cityville', 'CA', '12345'),
('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '456 Oak Ave', 'Township', 'TX', '54321');

INSERT INTO products (name, description, price, stock_quantity) 
VALUES 
('Laptop', 'A powerful gaming laptop', 1200.99, 10),
('Smartphone', 'A new smartphone with amazing features', 799.50, 15),
('Headphones', 'Noise-cancelling wireless headphones', 150.00, 30);

INSERT INTO orders (customer_id, total_amount) 
VALUES (1, 1500.99);  -- Customer with ID 1 (John Doe) placed an order worth $1500.99

INSERT INTO order_details (order_id, product_id, quantity, price) 
VALUES 
(1, 1, 1, 1200.99),  -- 1 Laptop
(1, 3, 1, 150.00);   -- 1 Headphones

SELECT order_id, order_date 
FROM orders 
WHERE customer_id = 1;  -- Show orders for customer with ID 1 (John Doe)

CREATE TABLE customer_addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
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

