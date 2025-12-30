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
    Doctors_name VARCHAR(100),
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

-- 1) JOIN – Show patient names with their doctor’s name and specialization. Show all appointments with patient and doctor details

SELECT p.name AS patient_name, d.name AS doctor_name, d.specialization,
a.appointment_date FROM Appointments JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id;

-- 2) AGGREGATION – Total number of appointments per doctor. Count how many appointments each doctor has

SELECT d.name AS doctor_name, COUNT(a.appointment_id) AS total_appointments
FROM Appointments JOIN Doctors d ON a.doctor_id = d.doctor_id GROUP BY d.name;

-- 3) SUBQUERY – Get patients who visited a specific doctor. Show names of patients who had appointments with 'Dr. Ravi'

SELECT name FROM Patients 
WHERE patient_id IN (
    SELECT patient_id 
    FROM Appointments 
    WHERE doctor_id = (SELECT doctor_id FROM Doctors WHERE name = 'Dr. Ravi')
);

-- 4)  ORDER BY – List appointments in most recent order

SELECT * FROM Appointments ORDER BY appointment_date DESC;

-- 5) LIKE & WILDCARD – Find patients whose name starts with ‘S’

SELECT * FROM Patients WHERE name LIKE 'S%';

-- 6) UNION & UNION ALL – Combine two patient lists

SELECT name, city FROM Patients WHERE city = 'Chennai' UNION SELECT name, city FROM Patients WHERE city = 'Bangalore';
select name from patients where status='Discharged' union select name from patients where status='Admitted';

-- Use `UNION ALL` to include duplicates.

-- 7) NULL & NOT NULL – Find appointments with no fee (NULL)

SELECT * FROM Appointments WHERE fees IS NULL;
SELECT * FROM Appointments WHERE fees IS NOT NULL;

-- 8) MIN & MAX – Find min and max fees

SELECT MIN(fees) AS MinFee, MAX(fees) AS MaxFee FROM Appointments;
SELECT  name,age from patients where age=(select max(age) from patients);

-- 9) EXISTS – Check if a patient has an appointment.

SELECT name FROM Patients WHERE EXISTS (
    SELECT 1 FROM Appointments a WHERE a.patient_id = p.patient_id
);

-- 10) ALTER TABLE – Add column to track patient blood group and add contact number 

ALTER TABLE Patients ADD COLUMN blood_group VARCHAR(5);
update patients set blood_group='A+'where patient_id=1;
update patients set blood_group='B+'where patient_id=2;
update patients set blood_group='B+'where patient_id=3;
update patients set blood_group='A+'where patient_id=4;
update patients set blood_group='B+'where patient_id=5;
update patients set blood_group='O+'where patient_id=6;
update patients set blood_group='AB+'where patient_id=7;
update patients set blood_group='B+'where patient_id=8;
update patients set blood_group='A1+'where patient_id=9;
update patients set blood_group='o+'where patient_id=10;

ALTER TABLE Appointments ADD contact_number VARCHAR(15);
update appointments set contact_number = '9874561235' where appointment_id = 1001;
update appointments set contact_number = '9872636561' where appointment_id = 1003;
update appointments set contact_number = '9236746596' where appointment_id = 1004;
update appointments set contact_number = '8742326421' where appointment_id = 1005;
update appointments set contact_number = '9874513267' where appointment_id = 1006;
update appointments set contact_number = '9826965262' where appointment_id = 1007;

-- 11) list all patients who are older than 40 years
select*from patients where age>40;

-- 12) find the total number of patients 
select count(*) as total_patient from patients;

-- 13) find the average patient age
select avg(age) as average_age from patients;

-- 14) all doctors name in uppercase
select upper(name) as name_upper from doctors;

-- 15) length of each patients name
select name,length(name) as name_length from patients;

-- 16) concatenate patient name and city
select concat(name,'-',city) aspatients_info from patients;

-- 17) add column using alter table  and update billings for each patient
alter table patients add column billings decimal(10,2);
update patients set billings=1500 where patient_id=1;
update patients set billings=2500 where patient_id=2;
update patients set billings=1000 where patient_id=3;
update patients set billings=3500 where patient_id=4;
update patients set billings=1550 where patient_id=5;

-- 18) remove all patients records whose billings are less than 1000
delete from patients where billings<1000;

-- 19) remove the entire patients table from database
 drop table patients;
 
 -- 20) stored procedure that returns all patient details whose billing 
 amount is greater than 2000 using DELIMITER.

 DELIMITER //
CREATE PROCEDURE GetHighBillingPatients()
BEGIN
	SELECT * FROM patients WHERE billings > 2000;
END //
DELIMITER ;
call gethighbillingpatients();

 


select*from Doctors;
select*from Patients;
select*from Appointments;




