-- Create Database
CREATE DATABASE HMBank;
GO

USE HMBank;
GO

-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    DOB DATE,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15),
    address VARCHAR(255)
);
GO

-- Accounts Table
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    account_type VARCHAR(20) CHECK (account_type IN ('savings', 'current', 'zero_balance')),
    balance DECIMAL(15, 2) DEFAULT 0.0,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);
GO

-- Transactions Table
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY IDENTITY(1,1),
    account_id INT,
    transaction_type VARCHAR(20) CHECK (transaction_type IN ('deposit', 'withdrawal', 'transfer')),
    amount DECIMAL(15, 2),
    transaction_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id) ON DELETE CASCADE
);
GO

-- Insert Sample Data - Customers
INSERT INTO Customers (first_name, last_name, DOB, email, phone_number, address) VALUES
('Alice', 'Smith', '1990-05-12', 'alice@example.com', '9876543210', 'New York'),
('Bob', 'Johnson', '1985-09-23', 'bob@example.com', '9876543211', 'Chicago'),
('Charlie', 'Williams', '1992-12-02', 'charlie@example.com', '9876543212', 'Houston'),
('David', 'Brown', '1978-07-17', 'david@example.com', '9876543213', 'Los Angeles'),
('Eva', 'Jones', '1996-01-05', 'eva@example.com', '9876543214', 'Phoenix'),
('Frank', 'Miller', '1988-10-30', 'frank@example.com', '9876543215', 'San Francisco'),
('Grace', 'Davis', '1993-11-15', 'grace@example.com', '9876543216', 'New York'),
('Henry', 'Wilson', '1980-03-20', 'henry@example.com', '9876543217', 'Chicago'),
('Ivy', 'Moore', '1991-06-08', 'ivy@example.com', '9876543218', 'Dallas'),
('Jack', 'Taylor', '1983-08-11', 'jack@example.com', '9876543219', 'Houston');
GO

-- Insert Sample Data - Accounts
INSERT INTO Accounts (customer_id, account_type, balance) VALUES
(1, 'savings', 5000.00),
(2, 'current', 12000.00),
(3, 'zero_balance', 0.00),
(4, 'savings', 10000.00),
(5, 'current', 3000.00),
(6, 'savings', 0.00),
(7, 'current', 2500.00),
(8, 'savings', 800.00),
(9, 'current', 9500.00),
(10, 'savings', 450.00);
GO

-- Insert Sample Data - Transactions
INSERT INTO Transactions (account_id, transaction_type, amount) VALUES
(1, 'deposit', 2000.00),
(1, 'withdrawal', 500.00),
(2, 'deposit', 5000.00),
(2, 'withdrawal', 1500.00),
(3, 'deposit', 1000.00),
(4, 'deposit', 4000.00),
(5, 'withdrawal', 500.00),
(6, 'deposit', 200.00),
(7, 'withdrawal', 100.00),
(8, 'deposit', 300.00);
GO



-- Name, account type and email of all customers
SELECT c.first_name, c.last_name, a.account_type, c.email
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id;

-- All transactions with corresponding customer
SELECT c.first_name, c.last_name, t.transaction_type, t.amount, t.transaction_date
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
JOIN Customers c ON a.customer_id = c.customer_id;

-- Increase balance of account_id = 1 by 1000
UPDATE Accounts
SET balance = balance + 1000
WHERE account_id = 1;

-- Combine first and last names as full_name
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM Customers;

-- Remove savings accounts with zero balance
DELETE FROM Accounts
WHERE balance = 0 AND account_type = 'savings';

-- Customers in Chicago
SELECT * FROM Customers
WHERE address LIKE '%Chicago%';

-- Balance for account_id = 2
SELECT balance FROM Accounts
WHERE account_id = 2;

-- Current accounts with balance > 1000
SELECT * FROM Accounts
WHERE account_type = 'current' AND balance > 1000;

-- All transactions for account_id = 1
SELECT * FROM Transactions
WHERE account_id = 1;

-- Interest on savings accounts (4%)
SELECT account_id, balance, balance * 0.04 AS interest
FROM Accounts
WHERE account_type = 'savings';

-- Accounts with balance < 500
SELECT * FROM Accounts
WHERE balance < 500;

-- Customers NOT in Houston
SELECT * FROM Customers
WHERE address NOT LIKE '%Houston%';



-- Average account balance
SELECT AVG(balance) AS average_balance FROM Accounts;

-- Top 10 highest account balances
SELECT TOP 10 * FROM Accounts
ORDER BY balance DESC;

-- Total deposits on '2025-04-01'
SELECT SUM(amount) AS total_deposits
FROM Transactions
WHERE transaction_type = 'deposit'
AND CAST(transaction_date AS DATE) = '2025-04-01';

-- Oldest customer
SELECT TOP 1 * FROM Customers
ORDER BY DOB ASC;

-- Youngest customer
SELECT TOP 1 * FROM Customers
ORDER BY DOB DESC;

-- Transactions with account type
SELECT t.*, a.account_type
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id;

-- Customers with account details
SELECT c.customer_id, c.first_name, c.last_name, a.account_id, a.account_type, a.balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id;

-- Transaction details for account_id = 2
SELECT t.*, c.first_name, c.last_name
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
JOIN Customers c ON a.customer_id = c.customer_id
WHERE a.account_id = 2;

-- Customers with more than one account
SELECT customer_id, COUNT(account_id) AS num_accounts
FROM Accounts
GROUP BY customer_id
HAVING COUNT(account_id) > 1;

-- Difference between total deposits and withdrawals
SELECT 
    (SELECT SUM(amount) FROM Transactions WHERE transaction_type = 'deposit') -
    (SELECT SUM(amount) FROM Transactions WHERE transaction_type = 'withdrawal') 
    AS transaction_difference;

-- Average balance per account
SELECT account_id, balance AS average_daily_balance
FROM Accounts;

-- Total balance by account type
SELECT account_type, SUM(balance) AS total_balance
FROM Accounts
GROUP BY account_type;

-- Accounts with most transactions
SELECT a.account_id, COUNT(t.transaction_id) AS transaction_count
FROM Accounts a
JOIN Transactions t ON a.account_id = t.account_id
GROUP BY a.account_id
ORDER BY transaction_count DESC;

-- Customers with total balance > 5000
SELECT c.customer_id, c.first_name, c.last_name, a.account_type, SUM(a.balance) AS total_balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, a.account_type
HAVING SUM(a.balance) > 5000;


-- Duplicate transactions (same amount, same day, same account)
SELECT account_id, amount, CAST(transaction_date AS DATE) AS date_only, COUNT(*) AS duplicate_count
FROM Transactions
GROUP BY account_id, amount, CAST(transaction_date AS DATE)
HAVING COUNT(*) > 1;



-- Customers with highest account balance
SELECT c.*
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
WHERE a.balance = (SELECT MAX(balance) FROM Accounts);

-- Average balance of customers with multiple accounts
SELECT AVG(balance) AS avg_balance
FROM Accounts
WHERE customer_id IN (
    SELECT customer_id
    FROM Accounts
    GROUP BY customer_id
    HAVING COUNT(account_id) > 1
);

-- Accounts with transactions above average amount
SELECT DISTINCT account_id
FROM Transactions
WHERE amount > (SELECT AVG(amount) FROM Transactions);

-- Customers with no transactions
SELECT c.*
FROM Customers c
WHERE c.customer_id NOT IN (
    SELECT a.customer_id
    FROM Accounts a
    JOIN Transactions t ON a.account_id = t.account_id
);

-- Total balance of accounts with no transactions
SELECT SUM(balance) AS total_unused_balance
FROM Accounts
WHERE account_id NOT IN (
    SELECT DISTINCT account_id FROM Transactions
);

-- Transactions for lowest balance account
SELECT * FROM Transactions
WHERE account_id IN (
    SELECT account_id
    FROM Accounts
    WHERE balance = (SELECT MIN(balance) FROM Accounts)
);

-- Customers with multiple account types
SELECT customer_id
FROM Accounts
GROUP BY customer_id
HAVING COUNT(DISTINCT account_type) > 1;

-- Percentage of each account type
SELECT account_type,
       COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Accounts) AS percentage
FROM Accounts
GROUP BY account_type;

-- All transactions for customer_id = 3
SELECT t.*
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
WHERE a.customer_id = 3;

-- Total balance for each account type using subquery
SELECT account_type,
       (SELECT SUM(balance)
        FROM Accounts a2
        WHERE a2.account_type = a1.account_type) AS total_balance
FROM Accounts a1
GROUP BY account_type;
