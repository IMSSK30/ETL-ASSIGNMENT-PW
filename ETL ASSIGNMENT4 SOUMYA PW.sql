# Question 1: Define Data Quality in the context of ETL pipelines. Why is it more than just data cleaning?
-- ANS-: Data Quality in ETL pipelines means ensuring that the data is accurate, complete, consistent, and 
-- reliable while it moves from source systems to the data warehouse.
-- It is more than just data cleaning because it includes validating, transforming, and monitoring data throughout the ETL process. 
-- Cleaning is only one part, but data quality focuses on maintaining trusted data at every stage.

# Question 2: Explain why poor data quality leads to misleading dashboards and incorrect decisions.
-- ANS-: Poor data quality can cause wrong values, missing records, or duplicates in the dataset. 
-- When this data is used in dashboards, it can show incorrect KPIs and trends.
-- As a result, decision-makers may take wrong actions based on incorrect insights. 
-- So, good data quality is important for accurate reporting and decision-making.

# Question 3: What is duplicate data? Explain three causes in ETL pipelines.
-- ANS-: Duplicate data means the same record appears more than once in a dataset.
-- Three common causes in ETL pipelines are:-
-- Collecting data from multiple sources without proper checks.
-- Incorrect joins during transformation.
-- Re-running ETL jobs without preventing repeated loads.
-- Duplicates can affect data accuracy and analysis results.

# Question 4: Differentiate between exact, partial, and fuzzy duplicates.
-- ANS-: Exact duplicates: Records that are completely identical.
-- Partial duplicates: Records that match in some fields but not all.
-- Fuzzy duplicates: Records that are slightly different (like spelling errors) but represent the same entity.

# Question 5: Why should data validation be performed during transformation rather than after loading?
-- ANS-: Data validation should be done during transformation to catch errors early. 
-- This prevents incorrect data from being loaded into the data warehouse and affecting reports. It also saves time and reduces rework.

# Question 6: Explain how business rules help in validating data accuracy. Give an example.
-- ANS-: Business rules are conditions that data must follow according to company standards. They help ensure data is logical and accurate.
-- For example, a rule can state that the order amount must be greater than zero. If the value is negative, it will be marked invalid.

# Question 7 : Write an SQL query on Sales_Transaction to list all duplicate keys and their counts using the business key (Customer_ID + Product_ID + Txn_Date + Txn_Amount )
-- ANS-:

CREATE DATABASE sales_db;
USE sales_db;

CREATE TABLE Sales_Transaction (
    Txn_ID INT PRIMARY KEY,
    Customer_ID VARCHAR(10),
    Customer_Name VARCHAR(100),
    Product_ID VARCHAR(10),
    Quantity INT,
    Txn_Amount DECIMAL(10,2),
    Txn_Date DATE,
    City VARCHAR(50)
);


INSERT INTO Sales_Transaction 
(Txn_ID, Customer_ID, Customer_Name, Product_ID, Quantity, Txn_Amount, Txn_Date, City)
VALUES
(201, 'C101', 'Rahul Mehta', 'P11', 2, 4000, '2025-12-01', 'Mumbai'),
(202, 'C102', 'Anjali Rao', 'P12', 1, 1500, '2025-12-01', 'Bengaluru'),
(203, 'C101', 'Rahul Mehta', 'P11', 2, 4000, '2025-12-01', 'Mumbai'),
(204, 'C103', 'Suresh Iyer', 'P13', 3, 6000, '2025-12-02', 'Chennai'),
(205, 'C104', 'Neha Singh', 'P14', NULL, 2500, '2025-12-02', 'Delhi'),
(206, 'C105', NULL, 'P15', 1, NULL, '2025-12-03', 'Pune'),
(207, 'C106', 'Amit Verma', 'P16', 1, 1800, NULL, 'Pune'),
(208, 'C101', 'Rahul Mehta', 'P11', 2, 4000, '2025-12-01', 'Mumbai');

SELECT * FROM Sales_Transaction;

SELECT 
    Customer_ID,
    Product_ID,
    Txn_Date,
    Txn_Amount,
    COUNT(*) AS duplicate_count
FROM Sales_Transaction
GROUP BY 
    Customer_ID,
    Product_ID,
    Txn_Date,
    Txn_Amount
HAVING COUNT(*) > 1;

# Question 8 : Enforcing Referential Integrity
-- Assume the following Customers_Master table: Identify Sales_Transactions.Customer_ID values that violate referential integrity when joined with 
-- Customers_Master and write a query to detect such violations. 
-- ANS-:

CREATE TABLE Customers_Master (
    CustomerID VARCHAR(10) PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50)
);

INSERT INTO Customers_Master (CustomerID, CustomerName, City)
VALUES
('C101', 'Rahul Mehta', 'Mumbai'),
('C102', 'Anjali Rao', 'Bengaluru'),
('C103', 'Suresh Iyer', 'Chennai'),
('C104', 'Neha Singh', 'Delhi');

SELECT * FROM Customers_Master;

SELECT DISTINCT st.Customer_ID
FROM Sales_Transaction st
LEFT JOIN Customers_Master cm
    ON st.Customer_ID = cm.CustomerID
WHERE cm.CustomerID IS NULL;



 








