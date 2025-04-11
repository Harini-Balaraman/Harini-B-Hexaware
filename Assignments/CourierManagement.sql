--Task 1.1: Create the database named "CourierManagementSystem"
CREATE DATABASE CourierManagementSystem;
USE CourierManagementSystem;

--Task 1.2: Database Design - Courier Management System
-- User Table
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    Password VARCHAR(255),
    ContactNumber VARCHAR(20),
    Address TEXT
);

-- Courier Table
CREATE TABLE Couriers (
    CourierID INT PRIMARY KEY,
    SenderName VARCHAR(255),
    SenderAddress TEXT,
    ReceiverName VARCHAR(255),
    ReceiverAddress TEXT,
    Weight DECIMAL(5, 2),
    Status VARCHAR(50),
    TrackingNumber VARCHAR(20) UNIQUE,
    DeliveryDate DATE
);

-- CourierServices Table
CREATE TABLE CourierServices (
    ServiceID INT PRIMARY KEY,
    ServiceName VARCHAR(100),
    Cost DECIMAL(8, 2)
);

-- Employee Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    ContactNumber VARCHAR(20),
    Role VARCHAR(50),
    Salary DECIMAL(10, 2)
);

-- Location Table
CREATE TABLE Locations (
    LocationID INT PRIMARY KEY,
    LocationName VARCHAR(100),
    Address TEXT
);

-- Payment Table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    CourierID INT,
    LocationID INT,
    Amount DECIMAL(10, 2),
    PaymentDate DATE,
    FOREIGN KEY (CourierID) REFERENCES Couriers(CourierID),
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

--Insert Sample Records: Users
INSERT INTO Users (UserID, Name, Email, Password, ContactNumber, Address) VALUES
(1, 'Alice Johnson', 'alice@example.com', 'alice123', '9876543210', '123 Maple Street'),
(2, 'Bob Smith', 'bob@example.com', 'bobpass', '9876501234', '456 Oak Avenue'),
(3, 'Charlie Brown', 'charlie@example.com', 'charliepw', '9123456789', '789 Pine Road');

--Insert Sample Records: Couriers
INSERT INTO Couriers (CourierID, SenderName, SenderAddress, ReceiverName, ReceiverAddress, Weight, Status, TrackingNumber, DeliveryDate) VALUES
(101, 'Alice Johnson', '123 Maple Street', 'Eve Watson', '999 River Road', 2.5, 'Delivered', 'TRK001', '2025-04-09'),
(102, 'Bob Smith', '456 Oak Avenue', 'Sam Green', '888 Ocean Drive', 1.2, 'In Transit', 'TRK002', NULL),
(103, 'Charlie Brown', '789 Pine Road', 'Tom Lane', '777 Mountain Blvd', 3.4, 'Pending', 'TRK003', NULL);

--Insert Sample Records: CourierServices
INSERT INTO CourierServices (ServiceID, ServiceName, Cost) VALUES
(1, 'Standard Delivery', 50.00),
(2, 'Express Delivery', 100.00),
(3, 'Overnight Delivery', 150.00);

--Insert Sample Records: Employees
INSERT INTO Employees (EmployeeID, Name, Email, ContactNumber, Role, Salary) VALUES
(1, 'John Doe', 'john.doe@example.com', '9998887777', 'Delivery Executive', 30000.00),
(2, 'Jane Smith', 'jane.smith@example.com', '8887776666', 'Admin', 45000.00),
(3, 'Mark Lee', 'mark.lee@example.com', '7776665555', 'Delivery Executive', 32000.00);

--Insert Sample Records: Locations
INSERT INTO Locations (LocationID, LocationName, Address) VALUES
(1, 'Central Hub', '11 Main St, Metro City'),
(2, 'North Branch', '22 Hill St, North Town'),
(3, 'South Depot', '33 Lake Rd, South Ville');

--Insert Sample Records: Payments
INSERT INTO Payments (PaymentID, CourierID, LocationID, Amount, PaymentDate) VALUES
(1, 101, 1, 120.00, '2025-04-09'),
(2, 102, 2, 90.00, '2025-04-10'),
(3, 103, 3, 130.00, '2025-04-10');

--Task 2: SQL Queries (Select + Where)

--List all customers (Users)
SELECT * FROM Users;

--List all orders for a specific customer
SELECT * FROM Couriers
WHERE SenderName = 'Bob Smith';

--List all couriers
SELECT * FROM Couriers;

--List all packages for a specific order
SELECT * FROM Couriers
WHERE CourierID = 101; -- Example

--List all deliveries for a specific courier
SELECT * FROM Couriers
WHERE TrackingNumber = 'TRK001';

--List all undelivered packages
SELECT * FROM Couriers
WHERE Status != 'Delivered';

--List all packages scheduled for delivery today
SELECT * FROM Couriers
WHERE DeliveryDate = CAST(GETDATE() AS DATE);


--List all packages with a specific status (e.g., 'Pending')
SELECT * FROM Couriers
WHERE Status = 'Pending';

--Calculate the total number of packages for each courier (Grouped by SenderName)
SELECT SenderName, COUNT(*) AS TotalPackages
FROM Couriers
GROUP BY SenderName;

--Find the average delivery time for each courier
--This would require a column like PickupDate, which we don’t currently have. Would you like to add that column to support this query?
--step 1: add PickupDate to the Couriers table:
ALTER TABLE Couriers
ADD PickupDate DATE;
--Step 2: Update Existing Records with Sample PickupDate
UPDATE Couriers
SET PickupDate = '2025-04-07'
WHERE CourierID = 101;

UPDATE Couriers
SET PickupDate = '2025-04-09'
WHERE CourierID = 102;

UPDATE Couriers
SET PickupDate = '2025-04-08'
WHERE CourierID = 103;
-- step 3: Find the average delivery time for each courier
SELECT 
    SenderName,
    AVG(DATEDIFF(DAY, PickupDate, DeliveryDate)) AS AvgDeliveryDays
FROM Couriers
WHERE DeliveryDate IS NOT NULL AND PickupDate IS NOT NULL
GROUP BY SenderName;

--List all packages within a specific weight range 
SELECT * FROM Couriers
WHERE Weight BETWEEN 1.0 AND 3.0;

--Retrieve employees whose names contain 'John'
SELECT * FROM Employees
WHERE Name LIKE '%John%';

--Retrieve all courier records with payments greater than $50
SELECT c.*
FROM Couriers c
JOIN Payments p ON c.CourierID = p.CourierID
WHERE p.Amount > 50;


--Task 3: GroupBy, Aggregate Functions, Having, Order By, where

--Find the total number of couriers handled by each employee
--Since there's no direct link between Couriers and Employees, we need a junction table like EmployeeCourierAssignment.
--EmployeeCourier Table (Junction Table)
CREATE TABLE EmployeeCourier (
    AssignmentID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT,
    CourierID INT,
    AssignmentDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (CourierID) REFERENCES Couriers(CourierID)
);
--Sample Data Insertion
INSERT INTO EmployeeCourier (EmployeeID, CourierID, AssignmentDate)
VALUES
(1, 101, '2025-04-07'),
(2, 102, '2025-04-08'),
(1, 103, '2025-04-09');
--Now we can run Query 14 accurately
SELECT e.Name, COUNT(ec.CourierID) AS TotalCouriersHandled
FROM Employees e
JOIN EmployeeCourier ec ON e.EmployeeID = ec.EmployeeID
GROUP BY e.Name;

--Calculate the total revenue generated by each location
SELECT l.LocationName, SUM(p.Amount) AS TotalRevenue
FROM Payments p
JOIN Locations l ON p.LocationID = l.LocationID
GROUP BY l.LocationName;

--Find the total number of couriers delivered to each location
SELECT l.LocationName, COUNT(p.CourierID) AS TotalCouriers
FROM Payments p
JOIN Locations l ON p.LocationID = l.LocationID
GROUP BY l.LocationName;

--Find the courier with the highest average delivery time
SELECT TOP 1 
    CourierID, 
    DATEDIFF(DAY, PickupDate, DeliveryDate) AS DeliveryDays
FROM Couriers
WHERE DeliveryDate IS NOT NULL AND PickupDate IS NOT NULL
ORDER BY DeliveryDays DESC;


--Find locations with total payments less than a certain amount 
SELECT l.LocationName, SUM(p.Amount) AS TotalPayments
FROM Payments p
JOIN Locations l ON p.LocationID = l.LocationID
GROUP BY l.LocationName
HAVING SUM(p.Amount) < 200;


--Calculate total payments per location
SELECT l.LocationName, SUM(p.Amount) AS TotalPayments
FROM Payments p
JOIN Locations l ON p.LocationID = l.LocationID
GROUP BY l.LocationName;

--Couriers with payments > $1000 in a specific location (LocationID = 2)
SELECT c.CourierID, p.Amount
FROM Payments p
JOIN Couriers c ON p.CourierID = c.CourierID
WHERE p.LocationID = 2
GROUP BY c.CourierID, p.Amount
HAVING SUM(p.Amount) > 1000;

--Couriers with payments > $1000 after a certain date (e.g., '2025-04-01')
SELECT c.CourierID, SUM(p.Amount) AS TotalAmount
FROM Payments p
JOIN Couriers c ON p.CourierID = c.CourierID
WHERE p.PaymentDate > '2025-04-01'
GROUP BY c.CourierID
HAVING SUM(p.Amount) > 1000;


--Locations where total received > $5000 before a date (e.g., before '2025-05-01')
SELECT l.LocationName, SUM(p.Amount) AS TotalReceived
FROM Payments p
JOIN Locations l ON p.LocationID = l.LocationID
WHERE p.PaymentDate < '2025-05-01'
GROUP BY l.LocationName
HAVING SUM(p.Amount) > 5000;


-- Task 4: Joins (Inner Join, Full Outer Join, Cross Join, Left/Right Outer Join) 

--Retrieve Payments with Courier Information
SELECT p.PaymentID, p.Amount, p.PaymentDate, c.TrackingNumber, c.SenderName, c.ReceiverName
FROM Payments p
JOIN Couriers c ON p.CourierID = c.CourierID;

--Retrieve Payments with Location Information
SELECT p.PaymentID, p.Amount, p.PaymentDate, l.LocationName, l.Address
FROM Payments p
JOIN Locations l ON p.LocationID = l.LocationID;

--Retrieve Payments with Courier and Location Information
SELECT p.PaymentID, p.Amount, p.PaymentDate, 
       c.TrackingNumber, c.SenderName, c.ReceiverName,
       l.LocationName
FROM Payments p
JOIN Couriers c ON p.CourierID = c.CourierID
JOIN Locations l ON p.LocationID = l.LocationID;

--List all payments with courier details
SELECT p.PaymentID, p.Amount, p.PaymentDate, c.TrackingNumber, c.SenderName, c.ReceiverName
FROM Payments p
JOIN Couriers c ON p.CourierID = c.CourierID;

--Total payments received for each courier
SELECT c.CourierID, c.TrackingNumber, SUM(p.Amount) AS TotalPaid
FROM Payments p
JOIN Couriers c ON p.CourierID = c.CourierID
GROUP BY c.CourierID, c.TrackingNumber;

--List payments made on a specific date
SELECT * FROM Payments
WHERE PaymentDate = '2025-04-08';

--Get Courier Information for Each 
SELECT p.PaymentID, p.Amount, c.CourierID, c.TrackingNumber, c.Status
FROM Payments p
JOIN Couriers c ON p.CourierID = c.CourierID;

--Get Payment Details with Location
SELECT p.PaymentID, p.Amount, p.PaymentDate, l.LocationName
FROM Payments p
JOIN Locations l ON p.LocationID = l.LocationID;

--Calculating Total Payments for Each Courier
SELECT c.CourierID, c.TrackingNumber, SUM(p.Amount) AS TotalPayments
FROM Payments p
JOIN Couriers c ON p.CourierID = c.CourierID
GROUP BY c.CourierID, c.TrackingNumber;

--List Payments Within a Date Range
SELECT * FROM Payments
WHERE PaymentDate BETWEEN '2025-04-01' AND '2025-04-10';

--Users and their corresponding courier records 
-- Left join
SELECT u.UserID, u.Name AS UserName, c.CourierID, c.TrackingNumber
FROM Users u
LEFT JOIN Couriers c ON u.Name = c.SenderName
-- Right join
SELECT u.UserID, u.Name AS UserName, c.CourierID, c.TrackingNumber
FROM Users u
RIGHT JOIN Couriers c ON u.Name = c.SenderName;

--Employees and their corresponding payments (including unmatched)
SELECT e.Name, p.Amount, p.PaymentDate
FROM Employees e
LEFT JOIN EmployeeCourier ec ON e.EmployeeID = ec.EmployeeID
LEFT JOIN Payments p ON ec.CourierID = p.CourierID;

--All users and all courier services (CROSS JOIN)
SELECT u.Name AS UserName, cs.ServiceName
FROM Users u
CROSS JOIN CourierServices cs;

--All employees and all locations (CROSS JOIN)
SELECT e.Name AS EmployeeName, l.LocationName
FROM Employees e
CROSS JOIN Locations l;

--Couriers and their sender information
SELECT c.CourierID, c.SenderName, u.Email
FROM Couriers c
LEFT JOIN Users u ON c.SenderName = u.Name;

--Couriers and their receiver information
SELECT c.CourierID, c.ReceiverName, u.Email
FROM Couriers c
LEFT JOIN Users u ON c.ReceiverName = u.Name;

--Employees and number of couriers assigned
SELECT e.Name, COUNT(ec.CourierID) AS TotalAssigned
FROM Employees e
LEFT JOIN EmployeeCourier ec ON e.EmployeeID = ec.EmployeeID
GROUP BY e.Name;

--Locations and total payment amount received
SELECT l.LocationName, SUM(p.Amount) AS TotalAmount
FROM Payments p
JOIN Locations l ON p.LocationID = l.LocationID
GROUP BY l.LocationName;

--All couriers sent by the same sender
SELECT SenderName, COUNT(*) AS TotalSent
FROM Couriers
GROUP BY SenderName
HAVING COUNT(*) > 1;

--Employees who share the same role
SELECT Role, STRING_AGG(Name, ', ') AS Employees
FROM Employees
GROUP BY Role
HAVING COUNT(*) > 1;


--Payments for couriers from the same location (SenderAddress)
SELECT 
    CAST(c.SenderAddress AS NVARCHAR(MAX)) AS SenderAddress,
    SUM(p.Amount) AS TotalPaid
FROM Couriers c
JOIN Payments p ON c.CourierID = p.CourierID
GROUP BY CAST(c.SenderAddress AS NVARCHAR(MAX));


--Couriers sent from the same location (SenderAddress)
SELECT 
    CAST(SenderAddress AS NVARCHAR(MAX)) AS SenderAddress,
    COUNT(*) AS TotalCouriers
FROM Couriers
GROUP BY CAST(SenderAddress AS NVARCHAR(MAX))
HAVING COUNT(*) > 1;


--Employees and number of couriers delivered
SELECT e.Name, COUNT(ec.CourierID) AS DeliveredCount
FROM Employees e
JOIN EmployeeCourier ec ON e.EmployeeID = ec.EmployeeID
JOIN Couriers c ON ec.CourierID = c.CourierID
WHERE c.Status = 'Delivered'
GROUP BY e.Name;

