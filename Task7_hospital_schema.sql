-- Task 7: Creating Views
-- Database: HospitalDB
-- Objective: Learn to create and use views for abstraction and security

USE HospitalDB;

-- ----------------------------------------------------------
-- 1. Create a Simple View
-- View to show basic doctor information
-- ----------------------------------------------------------

CREATE VIEW DoctorInfo AS
SELECT 
    DoctorID,
    DoctorName,
    Specialty,
    Phone,
    Email
FROM Doctors;

-- ----------------------------------------------------------
-- 2. Create a View using JOIN (Complex SELECT)
-- Combines doctor and department information for easy access
-- ----------------------------------------------------------

CREATE VIEW DoctorDepartmentView AS
SELECT 
    d.DoctorName,
    d.Specialty,
    dept.DeptName AS Department,
    dept.Location
FROM Doctors d
INNER JOIN Departments dept
ON d.DepartmentID = dept.DepartmentID;

-- ----------------------------------------------------------
-- 3. Create a View for Patient Billing Details
-- Combines Patients, Appointments, and Bills tables
-- ----------------------------------------------------------

CREATE VIEW PatientBillingView AS
SELECT 
    p.PatientName,
    p.Address,
    b.BillID,
    b.BillDate,
    b.Amount,
    b.PaymentStatus
FROM Bills b
INNER JOIN Appointments a ON b.AppointmentID = a.AppointmentID
INNER JOIN Patients p ON a.PatientID = p.PatientID;

-- ----------------------------------------------------------
-- 4. Create a View with Filter Condition
-- Shows only unpaid bills
-- ----------------------------------------------------------

CREATE VIEW UnpaidBillsView AS
SELECT 
    b.BillID,
    p.PatientName,
    b.Amount,
    b.PaymentStatus
FROM Bills b
INNER JOIN Appointments a ON b.AppointmentID = a.AppointmentID
INNER JOIN Patients p ON a.PatientID = p.PatientID
WHERE b.PaymentStatus = 'Pending';

-- ----------------------------------------------------------
-- 5. Create a View for Department Doctor Count (Aggregated View)
-- Shows number of doctors in each department
-- ----------------------------------------------------------

CREATE VIEW DepartmentDoctorCount AS
SELECT 
    dept.DeptName,
    COUNT(d.DoctorID) AS TotalDoctors
FROM Departments dept
LEFT JOIN Doctors d
ON dept.DepartmentID = d.DepartmentID
GROUP BY dept.DeptName;

-- ----------------------------------------------------------
-- 6. Using the Views
-- Run these to view the results
-- ----------------------------------------------------------

SELECT * FROM DoctorInfo;
SELECT * FROM DoctorDepartmentView;
SELECT * FROM PatientBillingView;
SELECT * FROM UnpaidBillsView;
SELECT * FROM DepartmentDoctorCount;

-- ----------------------------------------------------------
-- 7. Updating Data Using a View (if permitted)
-- Updates phone number of a doctor through the view
-- ----------------------------------------------------------

UPDATE DoctorInfo
SET Phone = '9876543210'
WHERE DoctorID = 1;

-- ----------------------------------------------------------
-- 8. Dropping Views (Cleanup)
-- ----------------------------------------------------------

DROP VIEW IF EXISTS DoctorInfo;
DROP VIEW IF EXISTS DoctorDepartmentView;
DROP VIEW IF EXISTS PatientBillingView;
DROP VIEW IF EXISTS UnpaidBillsView;
DROP VIEW IF EXISTS DepartmentDoctorCount;
