CREATE DATABASE EcommerceDB;
GO

USE EcommerceDB;
GO


CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    password VARCHAR(50)
);

CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(100),
    price DECIMAL(10,2),
    stockQuantity INT
);

CREATE TABLE cart (
    cart_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price DECIMAL(10,2),
    shipping_address VARCHAR(100),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    item_amount DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers (name, email, password) VALUES
('John Doe', 'johndoe@example.com', '123 Main St, City'),
('Jane Smith', 'janesmith@example.com', '456 Elm St, Town'),
('Robert Johnson', 'robert@example.com', '789 Oak St, Village'),
('Sarah Brown', 'sarah@example.com', '101 Pine St, Suburb'),
('David Lee', 'david@example.com', '234 Cedar St, District'),
('Laura Hall', 'laura@example.com', '567 Birch St, County'),
('Michael Davis', 'michael@example.com', '890 Maple St, State'),
('Emma Wilson', 'emma@example.com', '321 Redwood St, Country'),
('William Taylor', 'william@example.com', '432 Spruce St, Province'),
('Olivia Adams', 'olivia@example.com', '765 Fir St, Territory');


INSERT INTO products (name, description, price, stockQuantity) VALUES
('Laptop', 'High-performance laptop', 800.00, 10),
('Smartphone', 'Latest smartphone', 600.00, 15),
('Tablet', 'Portable tablet', 300.00, 20),
('Headphones', 'Noise-canceling', 150.00, 30),
('TV', '4K Smart TV', 900.00, 5),
('Coffee Maker', 'Automatic coffee maker', 50.00, 25),
('Refrigerator', 'Energy-efficient', 700.00, 10),
('Microwave Oven', 'Countertop microwave', 80.00, 15),
('Blender', 'High-speed blender', 70.00, 20),
('Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);


INSERT INTO cart (customer_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 3),
(3, 4, 4),
(3, 5, 2),
(4, 6, 1),
(5, 1, 1),
(6, 10, 2),
(6, 9, 3),
(7, 7, 2);

INSERT INTO orders (customer_id, order_date, total_price, shipping_address) VALUES
(1, '2023-01-05', 1200.00, '123 Main St, City'),
(2, '2023-02-10', 900.00, '456 Elm St, Town'),
(3, '2023-03-15', 300.00, '789 Oak St, Village'),
(4, '2023-04-20', 150.00, '101 Pine St, Suburb'),
(5, '2023-05-25', 1800.00, '234 Cedar St, District'),
(6, '2023-06-30', 400.00, '567 Birch St, County'),
(7, '2023-07-05', 700.00, '890 Maple St, State'),
(8, '2023-08-10', 160.00, '321 Redwood St, Country'),
(9, '2023-09-15', 140.00, '432 Spruce St, Province'),
(10, '2023-10-20', 1400.00, '765 Fir St, Territory');


INSERT INTO order_items (order_id, product_id, quantity, item_amount) VALUES
(1, 1, 2, 1600.00),
(1, 3, 1, 300.00),
(2, 2, 3, 1800.00),
(3, 5, 2, 1800.00),
(4, 4, 4, 600.00),
(4, 6, 1, 50.00),
(5, 1, 1, 800.00),
(5, 2, 2, 1200.00),
(6, 10, 2, 240.00),
(6, 9, 3, 210.00);

-- 1. Update refrigerator product price to 800
UPDATE products
SET price = 800
WHERE name = 'Refrigerator';


-- 2. Remove all cart items for a specific customer
DELETE FROM cart
WHERE customer_id = 1;


-- 3. Retrieve Products Priced Below $100
SELECT * FROM products
WHERE price < 100;

-- 4. Find Products with Stock Quantity Greater Than 5
SELECT * FROM products
WHERE stockQuantity > 5;


-- 5. Retrieve Orders with Total Amount Between $500 and $1000
SELECT * FROM orders
WHERE total_price BETWEEN 500 AND 1000;


-- 6. Find Products which name end with letter ‘r’
SELECT * FROM products
WHERE name LIKE '%r';


-- 7. Retrieve Cart Items for Customer 5
SELECT * FROM cart
WHERE customer_id = 5;


-- 8. Find Customers Who Placed Orders in 2023
SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE YEAR(o.order_date) = 2023;

--9. Use Min
SELECT MIN(total_price) FROM orders;

-- 10. Calculate the Total Amount Spent by Each Customer
SELECT c.customer_id, c.name, SUM(o.total_price) AS TotalSpent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- 11. Find the Average Order Amount for Each Customer
SELECT c.customer_id, c.name, AVG(o.total_price) AS AverageOrderAmount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- 12. Count the Number of Orders Placed by Each Customer
SELECT c.customer_id, c.name, COUNT(o.order_id) AS OrderCount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- 13. Find the Maximum Order Amount for Each Customer
SELECT c.customer_id, c.name, MAX(o.total_price) AS MaxOrder
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- 14. Get Customers Who Placed Orders Totaling Over $1000
SELECT c.customer_id, c.name, SUM(o.total_price) AS TotalSpent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING SUM(o.total_price) > 1000;

-- 15. Subquery to Find Products Not in the Cart
SELECT * FROM products
WHERE product_id NOT IN (SELECT product_id FROM cart);

-- 16. Subquery to Find Customers Who Haven't Placed Orders
SELECT * FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM orders);

-- 17. Subquery to Calculate the Percentage of Total Revenue for a Product
-- Revenue percentage= (product revenue/total revenue )*100
--example 1. laptop, total is 2400 
-- total revenue is 8600
--revenue= (2400/8600)*100 --> 27.906976
SELECT p.product_id, p.name,
(SELECT SUM(oi.item_amount) FROM order_items oi WHERE oi.product_id = p.product_id) * 100.0 /
(SELECT SUM(item_amount) FROM order_items) AS RevenuePercentage
FROM products p;

-- 18. Subquery to Find Products with Low Stock (less than 5)
SELECT * FROM products
WHERE stockQuantity < 5;

-- 19. Subquery to Find Customers Who Placed High-Value Orders 
SELECT * FROM customers c
WHERE c.customer_id IN (
    SELECT customer_id FROM orders WHERE total_price > 1000
);
