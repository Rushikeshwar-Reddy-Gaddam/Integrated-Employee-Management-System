-- Retrieve specific columns from Employee and Department tables, joining them on Department_ID
SELECT e.Employee_ID, e.First_Name, e.Last_Name, d.Department_Name
FROM A_Employee e
INNER JOIN A_Department d ON e.Department_ID = d.Department_ID;

-- Create a view combining Employee and Department details
CREATE VIEW Employee_Department_View AS
SELECT e.Employee_ID, e.First_Name, e.Last_Name, d.Department_Name
FROM A_Employee e
INNER JOIN A_Department d ON e.Department_ID = d.Department_ID;

-- Insert a new employee record into the Employee table
INSERT INTO A_Employee (Employee_ID, First_Name, Last_Name, Date_of_Birth, Gender, Email, Phone_Number, Address, Nationality, Marital_Status, Hire_Date, Employment_Type, Department_ID, Supervisor_ID, Salary, Bank_Account_Details, Emergency_Contact_Info)
VALUES (101, 'Ram Gopal', 'Varma', '1990-05-20', 'Male', 'rgv@example.com', '1234567890', '123 Main St', 'USA', 'Single', '2023-01-15', 'Full-Time', 1, 100, 50000.00, 'Bank XYZ', 'Emergency Contact: Icecream, +9899452684');

-- Update an employee's salary in the Employee table
UPDATE A_Employee
SET Salary = 55000.00
WHERE Employee_ID = 101;

-- Delete an employee record from the Employee table
DELETE FROM A_Employee
WHERE Employee_ID = 101;

-- Retrieve training costs per employee
SELECT e.Employee_ID, e.First_Name, e.Last_Name, td.Training_Cost
FROM A_Employee e
INNER JOIN A_Training_Development td ON e.Employee_ID = td.Employee_ID;

##Report: Employee Salary Details

-- Retrieve employee ID, name, base salary, bonus, and total salary
SELECT e.Employee_ID, CONCAT(e.First_Name, ' ', e.Last_Name) AS Employee_Name,
       sd.Base_Salary, sd.Bonus, (sd.Base_Salary + sd.Bonus) AS Total_Salary
FROM A_Employee e
INNER JOIN A_Salary_Details sd ON e.Employee_ID = sd.Employee_ID;

##Report: Employee Leave Summary

-- Retrieve employee name, leave type, and count of leaves taken
SELECT CONCAT(e.First_Name, ' ', e.Last_Name) AS Employee_Name,
       lm.Leave_Type, COUNT(lm.Leave_ID) AS Leave_Count
FROM A_Employee e
LEFT JOIN A_Leave_Management lm ON e.Employee_ID = lm.Employee_ID
GROUP BY Employee_Name, lm.Leave_Type;

##Report: Employee Attendance Report

-- Retrieve employee name, date, and total hours worked
SELECT CONCAT(e.First_Name, ' ', e.Last_Name) AS Employee_Name,
       a.Date, a.Total_Hours_Worked
FROM A_Employee e
LEFT JOIN A_Attendance a ON e.Employee_ID = a.Employee_ID;

##Calculate the remaining leave balance for each employee:

SELECT lm.Employee_ID, CONCAT(e.First_Name, ' ', e.Last_Name) AS Employee_Name,
       COUNT(lm.Leave_ID) AS Leave_Used, 
       (CASE 
            WHEN COUNT(lm.Leave_ID) < 10 THEN 10 - COUNT(lm.Leave_ID) 
            ELSE 0 
       END) AS Leave_Balance
FROM A_Leave_Management lm
INNER JOIN A_Employee e ON lm.Employee_ID = e.Employee_ID
GROUP BY lm.Employee_ID, Employee_Name;

SELECT e.Employee_ID, CONCAT(e.First_Name, ' ', e.Last_Name) AS Employee_Name,
       SUM(a.Total_Hours_Worked) AS Total_Overtime_Hours
FROM A_Employee e
LEFT JOIN A_Attendance a ON e.Employee_ID = a.Employee_ID
WHERE MONTH(a.Date) = 11  -- Specify the month (November)
GROUP BY e.Employee_ID, Employee_Name;


-- Create a log table to track employee status changes
CREATE TABLE Employee_Status_Log (
    Log_ID INT PRIMARY KEY AUTO_INCREMENT,
    Employee_ID INT,
    Old_Status VARCHAR(50),
    New_Status VARCHAR(50),
    Date_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create a trigger to log employee status changes
DELIMITER //
CREATE TRIGGER Employee_Status_Trigger AFTER UPDATE ON A_Employee
FOR EACH ROW
BEGIN
    IF OLD.Employment_Type != NEW.Employment_Type THEN
        INSERT INTO Employee_Status_Log (Employee_ID, Old_Status, New_Status)
        VALUES (NEW.Employee_ID, OLD.Employment_Type, NEW.Employment_Type);
    END IF;
END;
//
DELIMITER ;






