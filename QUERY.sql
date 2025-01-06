-- Employee Table
CREATE TABLE A_Employee (
    Employee_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Date_of_Birth DATE,
    Gender VARCHAR(10),
    Email VARCHAR(100),
    Phone_Number VARCHAR(20),
    Address VARCHAR(255),
    Nationality VARCHAR(50),
    Marital_Status VARCHAR(20),
    Hire_Date DATE,
    Employment_Type VARCHAR(50),
    Department_ID INT,
    Supervisor_ID INT,
    Salary DECIMAL(10, 2),
    Bank_Account_Details VARCHAR(255),
    Emergency_Contact_Info VARCHAR(255)
);

-- Department Table
CREATE TABLE A_Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(100),
    Description VARCHAR(255),
    Manager_ID INT
);

-- Salary Details Table
CREATE TABLE A_Salary_Details (
    Salary_ID INT PRIMARY KEY,
    Employee_ID INT,
    Base_Salary DECIMAL(10, 2),
    Bonus DECIMAL(10, 2),
    Commission DECIMAL(10, 2),
    Overtime DECIMAL(10, 2),
    Deductions DECIMAL(10, 2),
    Pay_Frequency VARCHAR(50),
    Payment_Method VARCHAR(50),
    Payment_Schedule VARCHAR(50),
    Start_Date DATE,
    End_Date DATE,
    CONSTRAINT FK_SalaryDetails_Employee FOREIGN KEY (Employee_ID) REFERENCES A_Employee(Employee_ID)
    -- Adding FOREIGN KEY constraints referencing appropriate tables
);

-- Attendance Table
CREATE TABLE A_Attendance (
    Attendance_ID INT PRIMARY KEY,
    Employee_ID INT,
    Date DATE,
    Clock_in_Time TIME,
    Clock_out_Time TIME,
    Total_Hours_Worked DECIMAL(5, 2),
    Leave_Type VARCHAR(50),
    Approval_Status VARCHAR(50),
	CONSTRAINT FK_Attendance FOREIGN KEY (Employee_ID) REFERENCES A_Employee(Employee_ID)

);

-- Leave Management Table
CREATE TABLE A_Leave_Management (
    Leave_ID INT PRIMARY KEY,
    Employee_ID INT,
    Leave_Type VARCHAR(50),
    Start_Date DATE,
    End_Date DATE,
    Reason VARCHAR(255),
    Approval_Status VARCHAR(50),
    Comments VARCHAR(255),
	CONSTRAINT FK_Leave_Management FOREIGN KEY (Employee_ID) REFERENCES A_Employee(Employee_ID)

);

-- Payroll History Table
CREATE TABLE A_Payroll_History (
    Payroll_ID INT PRIMARY KEY,
    Employee_ID INT,
    Pay_Period VARCHAR(50),
    Gross_Pay DECIMAL(10, 2),
    Net_Pay DECIMAL(10, 2),
    Taxes DECIMAL(10, 2),
    Deductions DECIMAL(10, 2),
    Payment_Date DATE,
    Payment_Method VARCHAR(50),
    Comments VARCHAR(255),
    CONSTRAINT FK_Payroll_History FOREIGN KEY (Employee_ID) REFERENCES A_Employee(Employee_ID)
);

-- Performance Review Table
CREATE TABLE A_Performance_Review (
    Review_ID INT PRIMARY KEY,
    Employee_ID INT,
    Reviewer_ID INT,
    Review_Date DATE,
    Performance_Rating INT,
    Goals_Set VARCHAR(255),
    Strengths VARCHAR(255),
    Areas_for_Improvement VARCHAR(255),
    Development_Plan VARCHAR(255),
    CONSTRAINT FK_Performance_Review FOREIGN KEY (Employee_ID) REFERENCES A_Employee(Employee_ID)

);

-- Training and Development Table
CREATE TABLE A_Training_Development (
    Training_ID INT PRIMARY KEY,
    Training_Name VARCHAR(100),
    Training_Description VARCHAR(255),
    Date DATE,
    Duration INT,
    Employee_ID INT,
    Trainer_ID INT,
    Training_Location VARCHAR(100),
    Training_Cost DECIMAL(10, 2),
    CONSTRAINT FK_Training_Development FOREIGN KEY (Employee_ID) REFERENCES A_Employee(Employee_ID)
);

CREATE TABLE Department_Employee (
    Department_ID INT,
    Employee_ID INT,
    PRIMARY KEY (Department_ID, Employee_ID),
    FOREIGN KEY (Department_ID) REFERENCES A_Department(Department_ID),
    FOREIGN KEY (Employee_ID) REFERENCES A_Employee(Employee_ID)
);


-- Insert data into employee table
INSERT INTO A_Employee (employee_id, first_name, last_name, date_of_birth, gender, email, phone_number, address, nationality, marital_status, hire_date, employment_type, department_id, supervisor_id, salary, bank_account_details, emergency_contact_info)
VALUES
    (1, 'SS', 'Rajamouli', '1990-05-15', 'Male', 'ssrrr@example.com', '+1234567890', 'Hyderabad,Telangana', 'American', 'Single', '2015-07-20', 'Full-time', 1, NULL, 60000.00, '123456789, Bank Name', 'Baahubhali - +19876543211'),
    (2, 'James', 'Cameron', '1985-12-10', 'Male', 'jamescameraman@example.com', '+1987654321', '456 Elm St, City, Country', 'Canadian', 'Married', '2018-03-10', 'Part-time', 2, 1, 45000.00, '987654321, Another Bank', 'Avatar - +1234567890')
	,(3, 'Christopher', 'Nolan', '1970-07-30', 'Male', 'cnolan@example.com', '+1122334455', '789 Broadway, City, Country', 'British', 'Married', '2010-05-25', 'Full-time', 1, 1, 70000.00, '123987654, Bank of Filmmakers', 'Emergency Contact: Producer - +1122334455'),
    (4, 'Jane', 'Doe', '1995-02-12', 'Female', 'janedoe@example.com', '+9876543210', '321 Oak Lane, City, Country', 'American', 'Single', '2020-09-15', 'Part-time', 2, 2, 40000.00, '987654321, Another Bank', 'Emergency Contact: Friend - +9876543210'),
    (5, 'Quentin', 'Tarantino', '1963-03-27', 'Male', 'q.tarantino@example.com', '+4455667788', '456 Pine St, City, Country', 'American', 'Single', '2015-12-10', 'Full-time', 1, 1, 75000.00, '654321987, Hollywood Bank', 'Emergency Contact: Producer - +4455667788'),
    (6, 'Ava', 'DuVernay', '1972-08-24', 'Female', 'ava@example.com', '+1122334455', '987 Cedar Ave, City, Country', 'American', 'Divorced', '2018-02-28', 'Full-time', 2, 2, 60000.00, '333222111, Film Bank', 'Emergency Contact: Director - +1122334455'),
    (7, 'Martin', 'Scorsese', '1942-11-17', 'Male', 'martin@example.com', '+9998887776', '654 Vine St, City, Country', 'American', 'Married', '2005-10-01', 'Full-time', 1, 1, 80000.00, '987987987, Cinema Bank', 'Emergency Contact: Agent - +9998887776');

-- Insert data into department table
INSERT INTO A_Department (department_id, department_name, description, manager_id)
VALUES
    (1, 'Sales', 'Responsible for sales activities', 1),
    (2, 'Human Resources', 'Manages HR functions', 2),
    (3, 'Marketing', 'Responsible for marketing activities', 3),
    (4, 'Finance', 'Manages financial operations', 4),
    (5, 'IT', 'Handles technology and systems', 5),
    (6, 'Operations', 'Oversees operational activities', 6),
    (7, 'Legal', 'Manages legal affairs', 7);

-- Insert data into salary_details table
INSERT INTO A_Salary_Details (salary_id, employee_id, base_salary, bonus, commission, overtime, deductions, pay_frequency, payment_method, payment_schedule, start_date, end_date)
VALUES
    (1, 1, 60000.00, 5000.00, 2000.00, 1000.00, 3000.00, 'Monthly', 'Direct Deposit', '1st and 15th of every month', '2023-01-01', '2023-12-31'),
    (2, 2, 45000.00, 3000.00, 1500.00, 500.00, 2000.00, 'Bi-weekly', 'Paper Check', '1st and 15th of every month', '2023-01-01', '2023-12-31'),
    (3, 3, 70000.00, 6000.00, 2500.00, 1500.00, 3500.00, 'Monthly', 'Direct Deposit', '1st and 15th of every month', '2023-01-01', '2023-12-31'),
    (4, 4, 40000.00, 2500.00, 1000.00, 300.00, 1500.00, 'Bi-weekly', 'Paper Check', '1st and 15th of every month', '2023-01-01', '2023-12-31'),
    (5, 5, 75000.00, 7000.00, 3000.00, 2000.00, 4000.00, 'Monthly', 'Direct Deposit', '1st and 15th of every month', '2023-01-01', '2023-12-31'),
    (6, 6, 60000.00, 5000.00, 2000.00, 1000.00, 3000.00, 'Bi-weekly', 'Direct Deposit', '1st and 15th of every month', '2023-01-01', '2023-12-31'),
    (7, 7, 80000.00, 7500.00, 3500.00, 2500.00, 5000.00, 'Monthly', 'Paper Check', '1st and 15th of every month', '2023-01-01', '2023-12-31');

-- Insert data into attendance table
INSERT INTO A_Attendance (attendance_id, employee_id, date, clock_in_time, clock_out_time, total_hours_worked, leave_type, approval_status)
VALUES
    (1, 1, '2023-11-01', '08:00:00', '17:00:00', 9.00, NULL, 'Approved'),
    (2, 2, '2023-11-01', '09:30:00', '18:00:00', 8.50, 'Vacation', 'Approved'),
    (3, 3, '2023-11-01', '08:30:00', '17:30:00', 9.00, NULL, 'Approved'),
    (4, 4, '2023-11-01', '09:00:00', '17:30:00', 8.50, 'Sick Leave', 'Approved'),
    (5, 5, '2023-11-01', '08:00:00', '18:00:00', 10.00, 'Vacation', 'Approved'),
    (6, 6, '2023-11-01', '09:30:00', '18:30:00', 9.00, NULL, 'Approved'),
    (7, 7, '2023-11-01', '08:00:00', '17:00:00', 9.00, 'Business Trip', 'Approved');

-- Insert data into leave_management table
INSERT INTO A_Leave_Management (leave_id, employee_id, leave_type, start_date, end_date, reason, approval_status, comments)
VALUES
    (1, 1, 'Sick Leave', '2023-10-05', '2023-10-07', 'Fever', 'Approved', 'Medical certificate provided'),
    (2, 2, 'Vacation', '2023-12-20', '2023-12-25', 'Holiday trip', 'Pending', NULL),
    (3, 3, 'Vacation', '2023-10-15', '2023-10-20', 'Holiday trip', 'Approved', NULL),
    (4, 4, 'Personal Leave', '2023-12-10', '2023-12-11', 'Personal reasons', 'Pending', NULL),
    (5, 5, 'Sick Leave', '2023-11-15', '2023-11-17', 'Flu', 'Approved', 'Medical certificate provided');

-- Insert data into payroll_history table
INSERT INTO A_Payroll_History (payroll_id, employee_id, pay_period, gross_pay, net_pay, taxes, deductions, payment_date, payment_method, comments)
VALUES
    (1, 1, 'Monthly - November 2023', 6000.00, 4500.00, 1000.00, 500.00, '2023-11-30', 'Direct Deposit', NULL),
    (2, 2, 'Bi-weekly - Period ending 2023-11-15', 2000.00, 1500.00, 300.00, 200.00, '2023-11-20', 'Paper Check', NULL),
    (3, 3, 'Monthly - December 2023', 7000.00, 5500.00, 1200.00, 500.00, '2023-12-31', 'Direct Deposit', NULL),
    (4, 4, 'Bi-weekly - Period ending 2023-12-15', 2500.00, 2000.00, 400.00, 100.00, '2023-12-20', 'Paper Check', NULL),
    (5, 5, 'Monthly - December 2023', 7500.00, 6000.00, 1300.00, 500.00, '2023-12-31', 'Direct Deposit', NULL),
    (6, 6, 'Bi-weekly - Period ending 2023-12-15', 5000.00, 4000.00, 800.00, 200.00, '2023-12-20', 'Direct Deposit', NULL),
    (7, 7, 'Monthly - December 2023', 8000.00, 6500.00, 1400.00, 600.00, '2023-12-31', 'Paper Check', NULL);

-- Insert data into performance_review table
INSERT INTO A_Performance_Review (review_id, employee_id, reviewer_id, review_date, performance_rating, goals_set, strengths, areas_for_improvement, development_plan)
VALUES
    (1, 1, 3, '2023-08-20', 4, 'Increase sales by 15%', 'Good communication skills', 'Time management', 'Attend sales training'),
    (2, 2, 4, '2023-09-10', 3, 'Improve team collaboration', 'Efficient problem-solving', 'Public speaking', 'Enroll in communication workshops'),
    (3, 3, 4, '2023-10-20', 5, 'Achieve marketing targets', 'Innovative thinking', 'Time management', 'Enroll in advanced marketing courses'),
    (4, 4, 5, '2023-09-05', 3, 'Improve financial reporting', 'Analytical skills', 'Public speaking', 'Attend finance seminars'),
    (5, 5, 6, '2023-11-10', 4, 'Enhance IT infrastructure', 'Problem-solving', 'Teamwork', 'Advanced IT certifications'),
    (6, 6, 7, '2023-12-02', 4, 'Optimize operational processes', 'Leadership skills', 'Communication', 'Operations management training'),
    (7, 7, 1, '2023-08-15', 5, 'Legal compliance improvements', 'Attention to detail', 'Negotiation skills', 'Advanced legal courses');

-- Insert data into training_development table
INSERT INTO A_Training_Development (training_id, training_name, Training_Description, date, duration, employee_id, trainer_id, training_location, training_cost)
VALUES
    (1, 'Sales Techniques Workshop', 'Enhance sales skills', '2023-06-15', 2, 1, 5, 'City Conference Center', 500.00),
    (2, 'Leadership Training Program', 'Develop leadership abilities', '2023-10-20', 3, 2, 6, 'Corporate Headquarters', 1000.00),
    (3, 'Digital Marketing Workshop', 'Explore digital marketing strategies', '2023-10-15', 2, 3, 8, 'City Center Hall', 700.00),
    (4, 'Finance Masterclass', 'Advanced financial principles', '2023-11-20', 3, 4, 9, 'Financial District', 1200.00),
    (5, 'Cybersecurity Training', 'Learn cybersecurity fundamentals', '2023-12-05', 4, 5, 10, 'IT Security Institute', 1500.00),
    (6, 'Operational Efficiency Seminar', 'Improving operational efficiency', '2023-12-12', 1, 6, 11, 'Operations Center', 500.00),
    (7, 'Legal Compliance Workshop', 'Understanding legal compliances', '2023-11-28', 2, 7, 12, 'Law Institute', 800.00);


