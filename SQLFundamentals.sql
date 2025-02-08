-- Creates a new database named SQLFundamentals
CREATE SCHEMA SQLFundamentals;

-- Sets SQLFundamentals as the active database
USE SQLFundamentals;

-- Creates the Employees table with columns: EmployeeID, FirstName, LastName, DepartmentID, Salary, HireDate
CREATE TABLE Employees(
   EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
   FirstName VARCHAR(255) NOT NULL,
   LastName VARCHAR(255) NOT NULL,
   DepartmentID INT NOT NULL,
   Salary INT NOT NULL,
   HireDate DATE NOT NULL,
   FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);


-- Inserts sample employee records into the Employees table
INSERT INTO EMPLOYEES (FirstName, LastName, DepartmentID, Salary, HireDate) VALUES ('John', 'Doe', 1, 50000, '2020-03-15'), ('Jane','Smith',2,60000,'2019-07-01'),('Alice','Brown',1,55000,'2021-06-23'),('Bob','Johnson',3,62000,'2018-09-12'),  
	('Charlie','Wilson',2,58000,'2022-01-08');
    
-- Displays all records from the Employees table													
SELECT  * FROM Employees;

-- Creates the Departments table with columns: DepartmentID, DepartmentName
CREATE TABLE Departments(
   DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
   DepartmentName VARCHAR(255) NOT NULL,
   UNIQUE(DepartmentName)
);

-- Inserts sample department records into the Departments table
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES (1,'IT'), (2,'HR'), (3,'Finance');  

-- Displays all the records from the departments table in ascending order
SELECT * FROM Departments ORDER BY DepartmentID ASC;
-- ----------------------------------------------------------------------------------------------------------------------------------- -- 

-- 1. Retrieve all employee's first names and last names																				
SELECT FirstName, LastName FROM EMPLOYEES;                                                                                     
-- **Function and Statement Used**: None (basic SELECT statement)


-- 2. Retrieve all employees ordered by their salary in descending order
SELECT * FROM Employees ORDER BY Salary DESC;
-- **Function and Statement Used**: `ORDER BY` (sorts results in descending order using `DESC`)


-- 3. Count the number of employees in each department  
SELECT Count(e.EmployeeID) as EmployeesPerDept , d.DepartmentName 
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID 
GROUP BY d.DepartmentName ORDER BY EmployeesPerDept DESC;
-- **Functions and Statement Used**: 
-- `COUNT()` (counts the number of rows/employees)
-- `GROUP BY` (groups results by department name)
-- `ORDER BY` (sorts results by employee count in descending order)


-- 4. Find all employees whose first name starts with 'J'
SELECT * FROM Employees WHERE Firstname LIKE 'J%';
-- **Function Used**: `LIKE` (filters rows using a pattern, `%` is a wildcard)

																		
-- 5. Display employees’ first names, last names, and a new column "SalaryCategory" which shows 'High' if the salary is above 55000, otherwise 'Low'. 
SELECT FirstName, LastName, 
CASE
	WHEN Salary > 55000 THEN 'High'
	ELSE 'Low'
END AS SalaryCategory;
-- **Function and Statement Used**: `CASE` (conditional logic to categorize salaries)


-- 6. Convert the hire date into a formatted string in the format 'Month Day, Year' (e.g., 'March 15, 2020').
SELECT HireDate, DATE_FORMAT(HireDate,"%M, %d, %Y") AS ConvertedHireDate FROM Employees;
-- **Function and Statement Used**: `DATE_FORMAT()` (formats date values into a specified string format)


-- 7. Retrieve all employees along with their department names.
SELECT * FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID; 
-- **Function and Statement Used**: `JOIN` (combines rows from two tables based on a related column)


-- 8. Retrieve the employees who earn more than the average salary.
SELECT AVG(Salary) FROM Employees;
SELECT * FROM Employees WHERE Salary > (SELECT AVG(Salary) FROM Employees);
-- **Functions and Statement Used**: 
-- `AVG()` (calculates the average salary)
-- Subquery (nested query to compare salaries with the average)


-- 9. Get all employee names from the Employees table and all department names from the Departments table in a single list.
SELECT FirstName FROM Employees
UNION ALL
SELECT DepartmentName FROM Departments;
-- **Functions and Statement Used**: 
-- `UNION ALL` (combines results from two SELECT queries into a single list, including duplicates)


-- 10. Retrieve employees who were hired in the year 2020.
SELECT * FROM Employees WHERE HireDate > '2019-12-31' AND HireDate < '2021-01-01';
-- **Functions and Statement Used**: 
-- Comparison operators (`>` and `<`) to filter rows based on a date range
-- No specific MySQL function, but uses date filtering logic


-- 11. Display each employee’s full name in uppercase.
SELECT UPPER(CONCAT(FirstName, " ", LastName)) AS FullNameUpperCase FROM Employees;
-- **Functions and Statement Used**: 
-- UPPER (Converts the cocatenated text into uppercase)
-- CONCAT (Add several strings together, columns and expressions are included)


-- 12. Increase the salary of employees in the IT department by 10%, but ensure that the transaction is rolled back if something goes wrong.
-- For Retrieving Records using Basic Select Statements
SELECT EmployeeID, UPPER(CONCAT(FirstName, ' ', LastName)) AS FullName , SALARY AS OldSalary, SALARY*1.10 AS UpdatedSalary, d.DepartmentName 
FROM EMPLOYEES e 
JOIN DEPARTMENTS d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName ='IT';
-- **Functions and Statement Used**: 
-- UPPER (Converts the cocatenated text into uppercase)
-- CONCAT (Add several strings together, columns and expressions are included)


-- For Updating the records with rollback
DELIMITER $$
CREATE PROCEDURE UpdateSalaryIT()
BEGIN
    DECLARE affected_rows INT; -- Declares a variable for the number of affected rows (How many rows have been successfully changed, deleted or inserted)
    
    -- Start transaction
    START TRANSACTION;

    -- Update salaries
    UPDATE employees e 
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    SET e.salary = e.salary * 1.10
    WHERE d.DepartmentName = 'IT';

    -- Capture affected rows
    SET affected_rows = ROW_COUNT();

    -- Commit if rows were updated to save changes, else rollback to undoing the changes.
    IF affected_rows > 0 THEN
        COMMIT; -- COMMIT saves the transaction if rows were updated
    ELSE
        ROLLBACK; -- ROLLBACK undoes the transaction if no rows were updated
    END IF;
END$$
DELIMITER ;

-- Call the stored procedure
CALL UpdateSalaryIT(); 




