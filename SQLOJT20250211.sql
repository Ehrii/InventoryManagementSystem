-- Creation of the database name
CREATE SCHEMA SQLOJT_20250211;

-- Using the created db
USE SQLOJT_20250211;

-- Creation of the employees table
CREATE TABLE employees (
 id INT AUTO_INCREMENT PRIMARY KEY,
 `name` VARCHAR(100),
 department VARCHAR(50),
 salary DECIMAL(10,2),
 hire_date DATE
);

-- Describing the employees table
DESCRIBE employees;

-- Inserting the corresponding values in the employees table
INSERT INTO Employees (`name`, department, salary, hire_date) VALUES ('John Doe', 'IT', 50000, '2020-03-15'), ('Jane Smith','HR',60000,'2019-07-01'),('Alice Brown','IT',55000,'2021-06-23'),('Bob Johnson',
'Finance',62000,'2018-09-12'),  ('Charlie Wilson','HR',58000,'2022-01-08'), ('Emily Davis', 'Finance', 53000, '2022-05-20'), ('David Lee', 'HR', 32000, '2023-02-14'), ('Sarah Miller', 
'IT', 2000, '2021-11-30'), ('Michael Clark', 'Finance', 31000, '2022-08-10'),
('Laura Taylor', 'HR', 59000, '2023-04-05');


SELECT * FROM Employees;
-- 1. Create a temporary table to store the employees who earn more than 50,000.
CREATE TEMPORARY TABLE temp_high_salaries (
 EmployeeId INT AUTO_INCREMENT PRIMARY KEY,
 FullName VARCHAR(100),
 DepartmentName VARCHAR(50),
 Salary DECIMAL(10,2),
 Hire_Date DATE
);

-- 2. Insert employees from the employees table who meet this condition.
INSERT INTO temp_high_salaries
SELECT * FROM employees WHERE SALARY > 50000;

-- 3. Retrieves the data from the temporary table.
SELECT * FROM temp_high_salaries;

-- 4. Create a view called recent_hires that displays employees who were hored om the last 6 months.
CREATE VIEW recent_hires as SELECT * FROM Employees WHERE Hire_Date > DATE_SUB('2020-12-1',INTERVAL 6 MONTH);
SELECT * FROM recent_hires;

-- 5. Create a stored procedure GetEmployeesByDepartment that takes a department name as input and returns all employees in that department.
DELIMITER $$ 
 CREATE PROCEDURE GetEmployeesByDepartment(
		IN DepartmentName VARCHAR(50)
 )
 BEGIN 
 SELECT * 
 FROM Employees 
 WHERE department = DepartmentName; 
 END$$
DELIMITER ;

-- Calling the stored procedure function
CALL GetEmployeesByDepartment('IT');

-- Creation of the customers table
CREATE TABLE Customers (
 customer_id INT AUTO_INCREMENT PRIMARY KEY,
 `name` VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  city VARCHAR(50),
  signup_date DATE
);

-- Inserting the corresponding values for the customers db
INSERT INTO Customers (name, email, city, signup_date) VALUES
('John Doe', 'john.doe@example.com', 'New York', '2023-01-15'),
('Jane Smith', 'jane.smith@example.com', 'Los Angeles', '2023-02-20'),
('Alice Johnson', 'alice.johnson@example.com', 'Chicago', '2023-03-10'),
('Bob Brown', 'bob.brown@example.com', 'Houston', '2023-04-05'),
('Charlie Davis', 'charlie.davis@example.com', 'Phoenix', '2023-05-12'),
('Dana Wilson', 'dana.wilson@example.com', 'Philadelphia', '2023-06-18'),
('Evan Martinez', 'evan.martinez@example.com', 'San Antonio', '2023-07-22'),
('Fiona Clark', 'fiona.clark@example.com', 'San Diego', '2023-08-30'),
('George Lewis', 'george.lewis@example.com', 'Dallas', '2023-09-05'),
('Hannah Walker', 'hannah.walker@example.com', 'San Jose', '2023-10-15');

-- Describing the table customers
DESCRIBE Customers;
-- Identifying which columns should be indexed for better search performance
-- (Based on what I've learned, the Name, City, and Signup_Date are the columns that should be indexed since they are the most common columns for data retrieval and queries.)

-- Create an appropriate index
CREATE INDEX idx_name
ON Customers (name);

CREATE INDEX idx_city 
ON Customers (city);

CREATE INDEX idx_signupdate
ON Customers (signup_date);

EXPLAIN SELECT * from Customers WHERE City ="New York";
EXPLAIN SELECT * from Customers WHERE NAME ="John Doe";
EXPLAIN SELECT * from Customers WHERE Signup_Date like "2023-04%";


