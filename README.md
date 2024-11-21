# **E-Commerce Database Schema**

This project defines a basic database schema for an e-commerce store using MySQL. The schema is designed to track customers, products, orders, and order details. It includes tables for storing customer information, product inventory, and order data, as well as the relationships between them.

---

## **Schema Overview**

The schema contains the following tables:
1. **Customers**: Stores customer information.
2. **Products**: Stores product details and inventory.
3. **Orders**: Tracks customer orders.
4. **Order Details**: Stores the specifics of products within each order.

---

## **Tables**

### **1. Customers Table**
Stores customer details such as name, contact information, and registration date.

| Column              | Description                                      |
|---------------------|--------------------------------------------------|
| `customer_id`       | Unique identifier for each customer (auto-increment). |
| `first_name`        | Customer's first name.                           |
| `last_name`         | Customer's last name.                            |
| `email`             | Customer's email address (unique).               |
| `phone_number`      | Customer's phone number.                         |
| `address`           | Customer's address.                              |
| `city`              | City of residence.                               |
| `state`             | State of residence.                              |
| `zip_code`          | Customer's zip code.                             |
| `registration_date` | Date and time the customer registered (defaults to current timestamp). |

---

### **2. Products Table**
Stores product details including pricing and stock quantity.

| Column              | Description                                      |
|---------------------|--------------------------------------------------|
| `product_id`        | Unique identifier for each product (auto-increment). |
| `name`              | Name of the product.                             |
| `description`       | Detailed product description.                    |
| `price`             | Price of the product (up to two decimal places). |
| `stock_quantity`    | Quantity of the product in stock.                |
| `date_added`        | Date the product was added to the inventory.     |

---

### **3. Orders Table**
Tracks orders placed by customers, including their status and total amount.

| Column              | Description                                      |
|---------------------|--------------------------------------------------|
| `order_id`          | Unique identifier for each order (auto-increment). |
| `customer_id`       | Links to the `customer_id` in the `customers` table (foreign key). |
| `order_date`        | Date and time the order was placed.              |
| `order_status`      | Current status of the order (`Pending`, `Shipped`, `Delivered`, `Cancelled`). |
| `total_amount`      | Total price of the order.                        |

---

### **4. Order Details Table**
Stores the specifics of each product included in an order.

| Column              | Description                                      |
|---------------------|--------------------------------------------------|
| `order_detail_id`   | Unique identifier for each order item (auto-increment). |
| `order_id`          | Links to the `order_id` in the `orders` table (foreign key). |
| `product_id`        | Links to the `product_id` in the `products` table (foreign key). |
| `quantity`          | Quantity of the product ordered.                 |
| `price`             | Price of the product at the time of the order.   |

---

## **Relationships**

1. The **Orders** table is linked to the **Customers** table via the `customer_id` foreign key.  
   - **Purpose:** Tracks which customer placed each order.

2. The **Order Details** table links:
   - **Orders** via the `order_id` foreign key.
   - **Products** via the `product_id` foreign key.  
   - **Purpose:** Tracks which products were included in each order and their respective quantities.

---

## **Sample Queries**

### 1. **Get All Orders for a Specific Customer**
Fetch all orders placed by a customer with `customer_id = 1`:
```sql
SELECT order_id, order_date, total_amount, order_status
FROM orders
WHERE customer_id = 1;
```

---

### 2. **Get All Details for a Specific Order**
Fetch product details for a specific order with `order_id = 1`:
```sql
SELECT 
    p.name AS product_name, 
    od.quantity, 
    od.price AS unit_price, 
    (od.quantity * od.price) AS total_price
FROM 
    order_details od
JOIN 
    products p ON od.product_id = p.product_id
WHERE 
    od.order_id = 1;
```

---

### 3. **Update Stock After an Order**
Reduce the stock of a product after an order is placed:
```sql
UPDATE products
SET stock_quantity = stock_quantity - 1
WHERE product_id = 1;
```

---

## **Future Enhancements**
This schema can be extended to support additional features:
- Add a **Categories** table for product categorization.
- Include a **Reviews** table for customer feedback on products.
- Implement discount or coupon functionality using a **Coupons** table.
- Add shipment tracking with a **Shipments** table.

---

# **Installation Guide for E-Commerce Application**

This guide will walk you through the steps to set up your e-commerce database and application, from installing the required tools to cloning the GitHub repository and running the app.

---

## **1. Install Required Tools**

### **a. Install SQL Server**
1. **Download and Install SQL Server**:
   - Go to the [SQL Server Downloads page](https://www.microsoft.com/en-us/sql-server/sql-server-downloads).
   - Choose **SQL Server Community Edition** (free for development).
   - Run the installer and select **Full Installation**.

---

### **b. Install Node.js and npm**
1. **Download and Install Node.js**:
   - Go to the [Node.js Downloads page](https://nodejs.org/).
   - Install the **LTS version** (which includes npm).

2. **Verify Installation**:
   - Open a terminal or command prompt and run:
     ```bash
     node -v
     npm -v
     ```
     These commands should show the installed versions.

---

### **c. Install Git**
1. **Download and Install Git** from [Git's official page](https://git-scm.com/downloads).
2. Set up Git on your machine:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "youremail@example.com"
   ```

---

## **2. Clone the GitHub Repository**
1. **Clone the Repository**:
   - Open your terminal or command prompt.
   - Run the following command to clone the project repository to your local machine:
     ```bash
     git clone <repository_url>
     cd <repository_name>
     ```

---

## **3. Set Up the Application**
1. **Install Dependencies**:
   - In the project directory, run:
     ```bash
     npm install
     ```

2. **Configure the `.env` File**:
   - Create a `.env` file in the root of the project with the following variables:
     ```plaintext
        DB_HOST=localhost
        DB_PORT=3306
        DB_NAME=ecommerce_store
        DB_USER=root
        DB_PASSWORD=ManECommerceNeedOSHA
        PORT=3000
     ```

---

## **4. Run the Application**
1. **Start the Application**:
   - Run the application in development mode:
     ```bash
     npm run dev
     ```

2. **Test the App**:
   - Open your browser and go to `http://localhost:3000` to see the app in action.

---

## **5. Verify Everything Works**
1. **Verify SQL Server Database**:
   - In SSMS, run a query like:
     ```sql
     SELECT * FROM customers;
     ```
     to ensure your data is properly inserted.
   
2. **Verify Application**:
   - Ensure the app is running correctly and connecting to your SQL Server database by checking the app's logs.

---

With this setup, you now have the e-commerce application running with a local SQL Server database and the ability to manage everything via SSMS and the Node.js application.

---

### Reflection

1. How do primary and foreign keys help maintain data integrity?
   A : Primary keys are like the unique ID cards for each record, so there are no duplicates. Foreign keys connect tables and make sure the data matches up properly, like linking an order to a specific customer. It keeps everything tidy and consistent.

2. What insights can be gained by joining multiple tables?
   A : Joins let you mix and match data from different tables to see the bigger picture.

3. How can aggregate functions summarize data?
   A : Aggregate functions are the shortcuts for getting the big numbers, like total sales (SUM), average order size (AVG), or the number of customers (COUNT).

4. What types of analyses are enabled by date functions?
   A : With date functions, you can look at trends over time. Stuff like “When are we busiest?” and “What’s the monthly revenue?”.

5. How might you extend this database for additional e-commerce features?
   A : Maybe add a categories table to organize products better or a reviews table so customers can leave feedback.

   ![NodeIMG](NodeIMG.png)