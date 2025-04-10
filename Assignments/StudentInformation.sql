-- Task 1: Create Database and Tables

-- Create Database
CREATE DATABASE SISDB;
GO

-- Use the Database
USE SISDB;
GO

-- Create Students Table
CREATE TABLE Students (
    student_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15)
);
GO

-- Create Teacher Table
CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE
);
GO

-- Create Courses Table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY IDENTITY(1,1),
    course_name VARCHAR(100),
    credits INT,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id) ON DELETE SET NULL
);
GO

-- Create Enrollments Table
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);
GO

-- Create Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT,
    amount DECIMAL(10, 2),
    payment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE
);
GO

-- Insert Sample Records: Students
INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number) VALUES
('Alice', 'Smith', '2000-01-10', 'alice.smith@example.com', '1111111111'),
('Bob', 'Johnson', '1999-03-22', 'bob.johnson@example.com', '2222222222'),
('Charlie', 'Brown', '2001-07-19', 'charlie.brown@example.com', '3333333333'),
('Diana', 'Evans', '2000-10-30', 'diana.evans@example.com', '4444444444'),
('Ethan', 'Lee', '1998-05-15', 'ethan.lee@example.com', '5555555555'),
('Fiona', 'Davis', '2002-02-08', 'fiona.davis@example.com', '6666666666'),
('George', 'Wilson', '2001-09-12', 'george.wilson@example.com', '7777777777'),
('Hannah', 'Moore', '1999-11-25', 'hannah.moore@example.com', '8888888888'),
('Ian', 'Clark', '1998-12-05', 'ian.clark@example.com', '9999999999'),
('Julia', 'Morris', '2000-06-17', 'julia.morris@example.com', '0000000000');
GO

-- Insert Sample Records: Teachers
INSERT INTO Teacher (first_name, last_name, email) VALUES
('John', 'Watson', 'john.watson@example.com'),
('Sarah', 'Connor', 'sarah.connor@example.com'),
('Mark', 'Taylor', 'mark.taylor@example.com'),
('Linda', 'Scott', 'linda.scott@example.com'),
('David', 'Miller', 'david.miller@example.com'),
('Emma', 'Thomas', 'emma.thomas@example.com'),
('James', 'Anderson', 'james.anderson@example.com'),
('Rachel', 'Adams', 'rachel.adams@example.com'),
('Paul', 'Walker', 'paul.walker@example.com'),
('Olivia', 'Green', 'olivia.green@example.com');
GO

-- Insert Sample Records: Courses
INSERT INTO Courses (course_name, credits, teacher_id) VALUES
('Mathematics', 3, 1),
('Physics', 4, 2),
('Chemistry', 3, 3),
('Biology', 3, 4),
('Computer Science', 4, 5),
('English', 2, 6),
('History', 2, 7),
('Economics', 3, 8),
('Art', 2, 9),
('Music', 2, 10);
GO

-- Insert Sample Records: Enrollments
INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-09-01'),
(2, 2, '2024-09-01'),
(3, 3, '2024-09-02'),
(4, 4, '2024-09-03'),
(5, 5, '2024-09-03'),
(6, 6, '2024-09-04'),
(7, 7, '2024-09-05'),
(8, 8, '2024-09-06'),
(9, 9, '2024-09-07'),
(10, 10, '2024-09-08');
GO

-- Insert Sample Records: Payments
INSERT INTO Payments (student_id, amount, payment_date) VALUES
(1, 500.00, '2024-09-10'),
(2, 450.00, '2024-09-11'),
(3, 480.00, '2024-09-12'),
(4, 460.00, '2024-09-13'),
(5, 490.00, '2024-09-14'),
(6, 520.00, '2024-09-15'),
(7, 470.00, '2024-09-16'),
(8, 510.00, '2024-09-17'),
(9, 530.00, '2024-09-18'),
(10, 500.00, '2024-09-19');
GO

--Task 2: SQL DML Operations (Insert, Update, Delete, Select, etc.).

--Task 2.1: Insert a new student into the Students table
INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number) VALUES
('John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');

--Task 2.2: Enroll a student in a course
--Let’s say student with student_id = 1 is enrolling in course_id = 2.
INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1, 2, '2025-04-10');

--Task 2.3: Update the email address of a specific teacher
--Let’s update teacher with teacher_id = 1.
UPDATE Teacher
SET email = 'new.john.watson@example.com'
WHERE teacher_id = 1;

--Task 2.4: Delete a specific enrollment record
--Let’s remove the enrollment of student_id = 1 in course_id = 2.
DELETE FROM Enrollments
WHERE student_id = 1 AND course_id = 2;

--Task 2.5: Assign a teacher to a course
--Let’s assign teacher_id = 3 to course_id = 5.
UPDATE Courses
SET teacher_id = 3
WHERE course_id = 5;

--Task 2.6: Delete a student and their enrollments
--Let’s remove student_id = 10.

-- First delete enrollments (to maintain referential integrity)
DELETE FROM Enrollments
WHERE student_id = 10;

-- Then delete from Students
DELETE FROM Students
WHERE student_id = 10;

--Task 2.7: Update the payment amount for a specific payment
--Let’s update payment_id = 1 to a new amount.
UPDATE Payments
SET amount = 550.00
WHERE payment_id = 1;

--Task 3: Aggregate Functions, GROUP BY, HAVING, ORDER BY, and Joins.

--Task 3.1: Total payments made by a specific student
--Let’s use student_id = 1 as an example.
SELECT s.student_id, s.first_name, s.last_name, SUM(p.amount) AS total_payments
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
WHERE s.student_id = 1
GROUP BY s.student_id, s.first_name, s.last_name;

--Task 3.2: Courses with count of students enrolled
SELECT c.course_id, c.course_name, COUNT(e.student_id) AS student_count
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

--Task 3.3: Students who have not enrolled in any course
SELECT s.student_id, s.first_name, s.last_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

--Task 3.4: Student names and courses they are enrolled in
SELECT s.first_name, s.last_name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

--Task 3.5: Teachers and courses they are assigned to
SELECT t.first_name AS teacher_first_name, t.last_name AS teacher_last_name, c.course_name
FROM Teacher t
LEFT JOIN Courses c ON t.teacher_id = c.teacher_id;

--Task 3.6: Students and enrollment dates for a specific course
--Let’s say course_id = 1 (Mathematics).
SELECT s.first_name, s.last_name, e.enrollment_date
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.course_id = 1;

--Task 3.7: Students who haven’t made any payments
SELECT s.student_id, s.first_name, s.last_name
FROM Students s
LEFT JOIN Payments p ON s.student_id = p.student_id
WHERE p.payment_id IS NULL;

--Task 3.8: Courses with no enrollments
SELECT c.course_id, c.course_name
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;

--Task 3.9: Students enrolled in more than one course
SELECT s.student_id, s.first_name, s.last_name, COUNT(e.course_id) AS course_count
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(e.course_id) > 1;

--Task 3.10: Teachers not assigned to any course
SELECT t.teacher_id, t.first_name, t.last_name
FROM Teacher t
LEFT JOIN Courses c ON t.teacher_id = c.teacher_id
WHERE c.course_id IS NULL;

--Task 4: Subqueries and Their Types

--Task 4.1: Average number of students enrolled in each course
SELECT AVG(student_count) AS avg_students_per_course
FROM (
    SELECT COUNT(*) AS student_count
    FROM Enrollments
    GROUP BY course_id
) AS sub;

--Task 4.2: Student(s) who made the highest payment
SELECT s.student_id, s.first_name, s.last_name, p.amount
FROM Payments p
JOIN Students s ON p.student_id = s.student_id
WHERE p.amount = (
    SELECT MAX(amount) FROM Payments
);

--Task 4.3: Courses with the highest number of enrollments
SELECT c.course_id, c.course_name, COUNT(e.enrollment_id) AS enrollment_count
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(e.enrollment_id) = (
    SELECT MAX(course_count)
    FROM (
        SELECT COUNT(*) AS course_count
        FROM Enrollments
        GROUP BY course_id
    ) AS sub
);

--Task 4.4: Total payments made to courses taught by each teacher
SELECT t.teacher_id, t.first_name, t.last_name,
       (SELECT SUM(p.amount)
        FROM Payments p
        JOIN Enrollments e ON p.student_id = e.student_id
        JOIN Courses c2 ON e.course_id = c2.course_id
        WHERE c2.teacher_id = t.teacher_id) AS total_payment
FROM Teacher t;

--Task 4.5: Students enrolled in all available courses
SELECT s.student_id, s.first_name, s.last_name
FROM Students s
WHERE NOT EXISTS (
    SELECT c.course_id FROM Courses c
    EXCEPT
    SELECT e.course_id FROM Enrollments e WHERE e.student_id = s.student_id
);

--Task 4.6: Teachers who have not been assigned to any courses
SELECT teacher_id, first_name, last_name
FROM Teacher
WHERE teacher_id NOT IN (
    SELECT DISTINCT teacher_id FROM Courses WHERE teacher_id IS NOT NULL
);

--Task 4.7: Average age of all students
SELECT AVG(age) AS average_age
FROM (
    SELECT 
        DATEDIFF(YEAR, date_of_birth, GETDATE()) 
        - CASE 
            WHEN MONTH(date_of_birth) > MONTH(GETDATE()) 
                 OR (MONTH(date_of_birth) = MONTH(GETDATE()) AND DAY(date_of_birth) > DAY(GETDATE()))
            THEN 1 
            ELSE 0 
          END AS age
    FROM Students
) AS sub;

--Task 4.8: Courses with no enrollments
SELECT course_id, course_name
FROM Courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id FROM Enrollments
);

--Task 4.9: Total payments made by each student for each course
SELECT e.student_id, e.course_id,
       (SELECT SUM(p.amount)
        FROM Payments p
        WHERE p.student_id = e.student_id) AS total_payment
FROM Enrollments e
GROUP BY e.student_id, e.course_id;

--Task 4.10: Students who have made more than one payment
SELECT student_id
FROM Payments
GROUP BY student_id
HAVING COUNT(payment_id) > 1;

--Task 4.11: Total payments made by each student
SELECT s.student_id, s.first_name, s.last_name, SUM(p.amount) AS total_paid
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id, s.first_name, s.last_name;

--Task 4.12: Courses and count of students enrolled
SELECT c.course_name, COUNT(e.student_id) AS student_count
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

--Task 4.13: Average payment amount made by students
SELECT s.student_id, s.first_name, s.last_name, AVG(p.amount) AS avg_payment
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id, s.first_name, s.last_name;
