create database Library;
Use Library;

CREATE TABLE Branch (
Branch_no INT PRIMARY KEY,
Manager_Id INT,
Branch_address VARCHAR(255),
Contact_no VARCHAR(20)
);

CREATE TABLE Employee (
Emp_Id INT PRIMARY KEY,
Emp_name VARCHAR(100),
Position VARCHAR(50),
Salary DECIMAL(10, 2),
Branch_no INT,
FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

CREATE TABLE Books (
ISBN VARCHAR(50) PRIMARY KEY,
Book_title VARCHAR(255),
Category VARCHAR(100),
Rental_Price DECIMAL(10, 2),
Status ENUM('yes', 'no'),
Author VARCHAR(100),
Publisher VARCHAR(100)
);

CREATE TABLE Customer (
Customer_Id INT PRIMARY KEY,
Customer_name VARCHAR(100),
Customer_address VARCHAR(255),
Reg_date DATE
);

CREATE TABLE IssueStatus (
Issue_Id INT PRIMARY KEY,
Issued_cust INT,
Issued_book_name VARCHAR(255),
Issue_date DATE,
Isbn_book VARCHAR(50),
FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

CREATE TABLE ReturnStatus (
Return_Id INT PRIMARY KEY,
Return_cust INT,
Return_book_name VARCHAR(255),
Return_date DATE,
Isbn_book2 VARCHAR(50),
FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

-- 1)Retrieve the book title, category, and rental price of all available books
SELECT Book_title, Category, Rental_Price FROM Books 
WHERE Status = 'yes';

-- 2)List the employee names and their respective salaries in descending order of salary.
SELECT Emp_Name, Salary FROM Employee 
ORDER BY Salary DESC;

-- 3)Retrieve the book titles and the corresponding customers who have issued those books. 
SELECT b.Book_title, c.Customer_name FROM IssueStatus a 
JOIN Books b  ON a.Isbn_book = b.ISBN 
JOIN Customer c ON a.Issued_cust = c.Customer_Id;

-- 4)Display the total count of books in each category. 
SELECT Category, COUNT(*) AS Total_Books FROM Books 
GROUP BY Category;

-- 5)Retrieve the employee names and their positions for the employees whose salaries are above Rs.5000.
SELECT Emp_name, Position FROM Employee 
WHERE Salary > 5000;
-- ========================================NO_OUTPUT============================================================
-- 6)List the customer names who registered before 2022-01-01 and have not issued any books yet
SELECT Customer_name FROM Customer 
WHERE Reg_date < '2022-01-01' AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);
-- ========================================NO_OUTPUT=======================================================================
-- 7)Display the branch numbers and the total count of employees in each branch.
SELECT Branch_no, COUNT(*) AS Total_Employees FROM Employee 
GROUP BY Branch_no;

-- 8. Display the names of customers who have issued books in the month of June 2023.
SELECT b.Customer_name FROM IssueStatus a
JOIN Customer b ON a.Issued_cust = b.Customer_Id 
WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

-- 9)Retrieve book_title from book table containing history.
SELECT Book_title FROM Books 
WHERE Book_title LIKE '%history%';

-- 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees 
SELECT Branch_no, COUNT(*) AS Total_Employees FROM Employee 
GROUP BY Branch_no HAVING COUNT(*) > 5;

-- 11)Retrieve the names of employees who manage branches and their respective branch addresses.
SELECT a.Emp_name, b.Branch_address FROM Employee a
JOIN Branch b ON a.Branch_no = b.Branch_no;

-- 12)Display the names of customers who have issued books with a rental price higher than Rs. 25. 
SELECT c.Customer_name FROM IssueStatus a
JOIN Books b ON a.Isbn_book = b.ISBN 
JOIN Customer c ON a.Issued_cust = c.Customer_Id 
WHERE b.Rental_Price > 25;

