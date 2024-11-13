Here’s a simple README for the e-commerce database schema project:

---

# E-Commerce Database Schema

This project creates a basic database schema for an e-commerce store using MySQL. The schema tracks customers, products, orders, and the details of each order. It includes tables for storing customer information, product inventory, and order data, as well as the relationships between them.

## Tables

### 1. **Customers Table**
Stores customer information such as name, email, phone number, address, and registration date.

| Column           | Description                         |
|------------------|-------------------------------------|
| `customer_id`    | Unique identifier for each customer (auto-increment) |
| `first_name`     | Customer's first name               |
| `last_name`      | Customer's last name                |
| `email`          | Customer's email (unique)           |
| `phone_number`   | Customer's phone number             |
| `address`        | Customer's address                  |
| `city`           | Customer's city                     |
| `state`          | Customer's state                    |
| `zip_code`       | Customer's zip code                 |
| `registration_date` | The date the customer registered   |

### 2. **Products Table**
Stores information about products available in the store.

| Column           | Description                          |
|------------------|--------------------------------------|
| `product_id`     | Unique identifier for each product (auto-increment) |
| `name`           | Product name                         |
| `description`    | Detailed product description         |
| `price`          | Price of the product (up to two decimal places) |
| `stock_quantity` | Number of items in stock             |
| `date_added`     | Date the product was added to the inventory |

### 3. **Orders Table**
Tracks orders placed by customers.

| Column           | Description                           |
|------------------|---------------------------------------|
| `order_id`       | Unique identifier for each order (auto-increment) |
| `customer_id`    | Links to the `customer_id` in the `customers` table (foreign key) |
| `order_date`     | Date and time the order was placed    |
| `order_status`   | Current status of the order (Pending, Shipped, Delivered, Cancelled) |
| `total_amount`   | Total price of the order              |

### 4. **Order Details Table**
Stores the details of each product within an order.

| Column           | Description                           |
|------------------|---------------------------------------|
| `order_detail_id`| Unique identifier for each order item (auto-increment) |
| `order_id`       | Links to the `order_id` in the `orders` table (foreign key) |
| `product_id`     | Links to the `product_id` in the `products` table (foreign key) |
| `quantity`       | Number of items of the product ordered |
| `price`          | Price of the product at the time of order |

## Relationships Between Tables
- The **orders** table is linked to the **customers** table through the `customer_id` foreign key. This shows which customer placed the order.
- The **order_details** table links products in each order to the **orders** table through the `order_id` foreign key and to the **products** table through the `product_id` foreign key.

## Sample Queries

1. **Get all orders for a specific customer:**
   ```sql
   SELECT order_id, order_date
   FROM orders
   WHERE customer_id = 1;
   ```

2. **Get all details for a specific order:**
   ```sql
   SELECT p.name, od.quantity, od.price
   FROM order_details od
   JOIN products p ON od.product_id = p.product_id
   WHERE od.order_id = 1;
   ```

3. **Update stock after an order:**
   ```sql
   UPDATE products
   SET stock_quantity = stock_quantity - 1
   WHERE product_id = 1;
   ```

## Installation

1. **Create a new database**:
   ```sql
   CREATE DATABASE ecommerce_store;
   USE ecommerce_store;
   ```

2. **Create the tables** using the SQL code provided above.

3. **Insert sample data** to test the database with sample customers, products, and orders.
