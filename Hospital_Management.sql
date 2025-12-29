-- Patients Table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    gender VARCHAR(10),
    age INT,
    city VARCHAR(50)
);

-- Doctors Table
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(50)
);

-- Appointments Table
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    fees INT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);


INSERT INTO Patients VALUES 
(1, 'Ram Kumar', 'Male', 45, 'Chennai'),
(2, 'Latha Devi', 'Female', 32, 'Bangalore'),
(3, 'Arun Kumar', 'Male', 28, 'Hyderabad'),
(4, 'Sneha', 'Female', 25, 'Chennai'),
(5, 'Vikram', 'Male', 36, 'Delhi'),
(6, 'Meera', 'Female', 40, 'Kolkata'),
(7, 'Ravi', 'Male', 50, 'Mumbai'),
(8, 'Divya', 'Female', 30, 'Pune'),
(9, 'Gopi', 'Male', 39, 'Chennai'),
(10, 'Nisha', 'Female', 27, 'Coimbatore');

INSERT INTO Doctors VALUES 
(101, 'Dr. Ravi', 'Cardiology'),
(102, 'Dr. Meena', 'Dermatology'),
(103, 'Dr. Suresh', 'Orthopedics'),
(104, 'Dr. Priya', 'Pediatrics'),
(105, 'Dr. Arjun', 'ENT'),
(106, 'Dr. Lakshmi', 'Gynecology'),
(107, 'Dr. Manoj', 'Neurology'),
(108, 'Dr. Anjali', 'General Medicine'),
(109, 'Dr. Karthik', 'Urology'),
(110, 'Dr. Reshma', 'Psychiatry');


INSERT INTO Appointments VALUES 
(1001, 1, 101, '2024-12-01', 500),
(1002, 2, 102, '2024-12-02', 400),
(1003, 3, 103, '2024-12-03', 600),
(1004, 4, 104, '2024-12-04', 300),
(1005, 5, 105, '2024-12-05', 450),
(1006, 6, 106, '2024-12-06', 550),
(1007, 7, 107, '2024-12-07', 700),
(1008, 8, 108, '2024-12-08', 350),
(1009, 9, 109, '2024-12-09', 480),
(1010, 10, 110, '2024-12-10', 520);

-- 1) JOIN – Show patient names with their doctor’s name and specialization. Show all appointments with patient and doctor details.

SELECT p.name AS patient_name, d.name AS doctor_name, d.specialization,
a.appointment_date FROM Appointments JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id;

-- 2) AGGREGATION – Total number of appointments per doctor. Count how many appointments each doctor has.

SELECT d.name AS doctor_name, COUNT(a.appointment_id) AS total_appointments
FROM Appointments JOIN Doctors d ON a.doctor_id = d.doctor_id GROUP BY d.name;

-- 3) SUBQUERY – Get patients who visited a specific doctor. Show names of patients who had appointments with 'Dr. Ravi'.

SELECT name FROM Patients 
WHERE patient_id IN (
    SELECT patient_id 
    FROM Appointments 
    WHERE doctor_id = (SELECT doctor_id FROM Doctors WHERE name = 'Dr. Ravi')
);

-- 4)  ORDER BY – List appointments in most recent order.

SELECT * FROM Appointments ORDER BY appointment_date DESC;

-- 5) LIKE & WILDCARD – Find patients whose name starts with ‘S’.

SELECT * FROM Patients WHERE name LIKE 'S%';

-- 6) UNION & UNION ALL – Combine two patient lists.

SELECT name, city FROM Patients WHERE city = 'Chennai' UNION SELECT name, city FROM Patients WHERE city = 'Bangalore';

-- Use `UNION ALL` to include duplicates.

-- 7) NULL & NOT NULL – Find appointments with no fee (NULL).

SELECT * FROM Appointments WHERE fees IS NULL;
SELECT * FROM Appointments WHERE fees IS NOT NULL;

-- 8) MIN & MAX – Find min and max fees.

SELECT MIN(fees) AS MinFee, MAX(fees) AS MaxFee FROM Appointments;

-- 9) EXISTS – Check if a patient has an appointment.

SELECT name FROM Patients WHERE EXISTS (
    SELECT 1 FROM Appointments a WHERE a.patient_id = p.patient_id
);

-- 10) ALTER TABLE – Add column to track patient blood group.

ALTER TABLE Patients ADD COLUMN blood_group VARCHAR(5);

select*from Docters;
select*from Patients;
select*from Appointments;


