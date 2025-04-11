--Task 1.1: Create the database named "TechShop"
CREATE DATABASE TechShop;
USE TechShop;

--Task 1.2: Define schema for Customers, Products, Orders, OrderDetails, and Inventory tables
-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address TEXT
);

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10,2)
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Inventory Table
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT,
    QuantityInStock INT,
    LastStockUpdate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


--Insert Sample Records: Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address) VALUES
('Alice', 'Johnson', 'alice.johnson@email.com', '1234567890', '123 Maple St'),
('Bob', 'Smith', 'bob.smith@email.com', '2345678901', '456 Oak St'),
('Charlie', 'Brown', 'charlie.brown@email.com', '3456789012', '789 Pine St'),
('David', 'Clark', 'david.clark@email.com', '4567890123', '101 Elm St'),
('Eva', 'Green', 'eva.green@email.com', '5678901234', '202 Cedar St'),
('Frank', 'Wright', 'frank.wright@email.com', '6789012345', '303 Birch St'),
('Grace', 'Lee', 'grace.lee@email.com', '7890123456', '404 Spruce St'),
('Henry', 'Miller', 'henry.miller@email.com', '8901234567', '505 Walnut St'),
('Ivy', 'White', 'ivy.white@email.com', '9012345678', '606 Ash St'),
('Jake', 'Davis', 'jake.davis@email.com', '0123456789', '707 Hickory St');

--Insert Sample Records: Products
INSERT INTO Products (ProductName, Description, Price) VALUES
('Smartphone', 'Latest 5G smartphone', 699.99),
('Laptop', 'High performance laptop', 1199.50),
('Smartwatch', 'Fitness tracking smartwatch', 249.99),
('Bluetooth Speaker', 'Portable speaker with bass boost', 89.99),
('Tablet', 'Lightweight and powerful tablet', 499.00),
('Wireless Earbuds', 'Noise-canceling earbuds', 149.49),
('Monitor', '4K Ultra HD Monitor', 329.99),
('Gaming Console', 'Next-gen gaming console', 499.99),
('Keyboard', 'Mechanical keyboard with RGB', 79.99),
('Mouse', 'Ergonomic wireless mouse', 59.49);

--Insert Sample Records: Orders
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2025-03-01', 749.98),
(2, '2025-03-03', 149.49),
(3, '2025-03-05', 329.99),
(4, '2025-03-06', 1199.50),
(5, '2025-03-07', 249.99),
(6, '2025-03-08', 149.49),
(7, '2025-03-10', 559.98),
(8, '2025-03-12', 699.99),
(9, '2025-03-15', 589.98),
(10, '2025-03-18', 89.99);

--Insert Sample Records: OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 1, 1),
(1, 6, 1),
(2, 6, 1),
(3, 7, 1),
(4, 2, 1),
(5, 3, 1),
(6, 6, 1),
(7, 4, 2),
(8, 1, 1),
(9, 5, 1),
(9, 10, 1),
(10, 4, 1);

--Insert Sample Records: Inventory
INSERT INTO Inventory (ProductID, QuantityInStock, LastStockUpdate) VALUES
(1, 25, '2025-02-28'),
(2, 10, '2025-02-25'),
(3, 30, '2025-02-27'),
(4, 50, '2025-02-26'),
(5, 15, '2025-02-24'),
(6, 40, '2025-02-23'),
(7, 20, '2025-02-22'),
(8, 18, '2025-02-20'),
(9, 60, '2025-02-21'),
(10, 35, '2025-02-19');


--Task 2: SQL Queries using SELECT, WHERE, BETWEEN, LIKE, INSERT, UPDATE, DELETE.

--Retrieve names and emails of all customers
SELECT FirstName, LastName, Email FROM Customers;

--List all orders with their order dates and corresponding customer names
SELECT 
    Orders.OrderID,
    Orders.OrderDate,
    Customers.FirstName,
    Customers.LastName
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

--Insert a new customer record
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES ('Lily', 'Anderson', 'lily.anderson@email.com', '9876543210', '808 Bamboo Street');

--Increase prices of all products by 10%
UPDATE Products
SET Price = Price * 1.10;

--Delete a specific order and its order details (parameter: OrderID)
-- First delete from OrderDetails
DELETE FROM OrderDetails WHERE OrderID = 5;
--Insert a new order
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES (1, '2025-04-10', 599.99);

--Update contact info of a specific customer (parameter: CustomerID)
UPDATE Customers
SET Email = 'updated.email@email.com',
    Address = '999 New Lane Street'
WHERE CustomerID = 5;

--Recalculate and update total amount for each order
-- Recalculate and update total amount for each order (SSMS version)
UPDATE o
SET o.TotalAmount = calculated.Total
FROM Orders o
INNER JOIN (
    SELECT od.OrderID, SUM(p.Price * od.Quantity) AS Total
    FROM OrderDetails od
    INNER JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY od.OrderID
) AS calculated ON o.OrderID = calculated.OrderID;

--Delete all orders and their details for a specific customer (parameter: CustomerID)
-- First get the order IDs
DELETE FROM OrderDetails
WHERE OrderID IN (
    SELECT OrderID FROM Orders WHERE CustomerID = 5
);

-- Then delete from Orders
DELETE FROM Orders WHERE CustomerID = 5;

--Insert a new electronic gadget product
INSERT INTO Products (ProductName, Description, Price)
VALUES ('VR Headset', 'Immersive virtual reality headset', 399.00);

--Update the status of a specific order — status column not present yet
--If you want to support this, first add a Status column to Orders:
-- Add the Status column with default value 'Pending'
ALTER TABLE Orders 
ADD Status VARCHAR(20) DEFAULT 'Pending';

-- Update the status to 'Shipped' for a specific order
UPDATE Orders
SET Status = 'Shipped'
WHERE OrderID = 4;

--Then update:
UPDATE Orders
SET Status = 'Shipped'
WHERE OrderID = 4;

--Update number of orders placed by each customer
--For this, you need to add a column in the Customers table:
ALTER TABLE Customers
ADD OrderCount INT DEFAULT 0;
--Then run:
UPDATE c
SET c.OrderCount = oc.OrderCount
FROM Customers c
JOIN (
    SELECT CustomerID, COUNT(*) AS OrderCount
    FROM Orders
    GROUP BY CustomerID
) AS oc ON c.CustomerID = oc.CustomerID;


--Task 3: Aggregate Functions, HAVING, ORDER BY, GROUP BY, and JOINS.

--Retrieve a list of all orders with customer information
SELECT 
    o.OrderID,
    o.OrderDate,
    o.TotalAmount,
    c.FirstName,
    c.LastName,
    c.Email
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;

--Find total revenue generated by each product
SELECT 
    p.ProductName,
    SUM(od.Quantity * p.Price) AS TotalRevenue
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName;

--List all customers who have made at least one purchase
SELECT DISTINCT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Email,
    c.Phone
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;

--Find the most popular product (highest total quantity ordered)
SELECT TOP 1
    p.ProductName,
    SUM(od.Quantity) AS TotalQuantityOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantityOrdered DESC;


--Retrieve a list of electronic gadgets with their categories
--Note: If you need categories, you can first add a Category column to the Products table:
ALTER TABLE Products ADD Category VARCHAR(50);
--Then you can run:
SELECT ProductName, Category FROM Products;

--Calculate average order value for each customer
SELECT 
    c.FirstName,
    c.LastName,
    AVG(o.TotalAmount) AS AvgOrderValue
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

--Find the order with the highest total revenue
SELECT TOP 1
    o.OrderID,
    c.FirstName,
    c.LastName,
    o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
ORDER BY o.TotalAmount DESC;

--List electronic gadgets and number of times each has been ordered
SELECT 
    p.ProductName,
    COUNT(od.OrderDetailID) AS TimesOrdered
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName;

--Find customers who have purchased a specific product (parameter: product name)
SELECT DISTINCT 
    c.FirstName,
    c.LastName,
    c.Email
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName = 'Laptop';


--Calculate total revenue from orders placed within a date range (start, end date as parameters)
SELECT 
    SUM(o.TotalAmount) AS TotalRevenue
FROM Orders o
WHERE o.OrderDate BETWEEN '2024-01-01' AND '2024-12-31';

--Task 4: Subqueries and Their Types.

--Find customers who have not placed any orders
SELECT 
    CustomerID, FirstName, LastName, Email
FROM Customers
WHERE CustomerID NOT IN (
    SELECT DISTINCT CustomerID FROM Orders
);

--Find total number of products available for sale
SELECT COUNT(*) AS TotalProducts FROM Products;

--Calculate total revenue generated by TechShop
SELECT SUM(TotalAmount) AS TotalRevenue FROM Orders;

--Calculate average quantity ordered for products in a specific category (parameter: Category name)
SELECT AVG(od.Quantity) AS AvgQuantity
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Category = 'Smartphone';


--Calculate total revenue generated by a specific customer (parameter: CustomerID)
SELECT SUM(o.TotalAmount) AS CustomerRevenue
FROM Orders o
WHERE o.CustomerID = 8;

--Find customers who placed the most orders
SELECT TOP 1
    c.FirstName,
    c.LastName,
    COUNT(o.OrderID) AS OrderCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY OrderCount DESC;


--Find the most popular product category (highest total quantity ordered)
SELECT TOP 1
    p.Category,
    SUM(od.Quantity) AS TotalOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY TotalOrdered DESC;

--Find the customer who spent the most money on gadgets
SELECT TOP 1
    c.FirstName,
    c.LastName,
    SUM(o.TotalAmount) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalSpent DESC;


--Calculate average order value for all customers
SELECT 
    AVG(TotalAmount) AS AvgOrderValue
FROM Orders;

--Total number of orders placed by each customer with their names
SELECT 
    c.FirstName,
    c.LastName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;
