CREATE DATABASE clinic_booking;
USE clinic_booking;
-- PATIENTS TABLE
CREATE TABLE patients(
patient_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
dob DATE,
gender ENUM('Male','Female'),
phone INT UNIQUE,
email VARCHAR(30),
emergency_contact INT,
insurance_number INT UNIQUE
);
-- DOCTORS TABLE
CREATE TABLE doctors(
doctor_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
specialisation VARCHAR(30),
phone INT UNIQUE,
email VARCHAR(30),
hire_date DATE,
active BOOLEAN DEFAULT TRUE
);
-- STAFF TABLE
CREATE TABLE staff(
staff_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
role ENUM('Receptionist','nurse'),
email VARCHAR(30),
phone INT UNIQUE,
hire_date DATE 
);
-- APPOINTMENT TABLE
CREATE TABLE appointments(
appointment_id INT AUTO_INCREMENT PRIMARY KEY,
patient_id INT,
doctor_id INT,
staff_id INT ,
appointment_date DATE,
status ENUM('scheduled','completed','cancelled') DEFAULT'scheduled',
notes TEXT,
FOREIGN KEY(patient_id)REFERENCES patients(patient_id),
FOREIGN KEY(doctor_id) REFERENCES doctors(doctor_id),
FOREIGN KEY(staff_id) REFERENCES staff(staff_id)
);
-- TREATMENT TABLE
CREATE TABLE treatment(
treatment_id INT AUTO_INCREMENT PRIMARY KEY,
appointment_id INT,
description TEXT,
treatment_date DATETIME NOT NULL,
FOREIGN KEY(appointment_id) REFERENCES appointments(appointment_id)
);
-- BILLS TABLE
CREATE TABLE bills(
bill_id INT AUTO_INCREMENT PRIMARY KEY,
treatment_id INT,
total_amount DEC(10,2) NOT NULL CHECK(total_amount>0),
paid_date DATE,
FOREIGN KEY(treatment_id) REFERENCES treatment(treatment_id)
);

-- PAYMENTS TABLE
CREATE TABLE payments(
payment_id INT AUTO_INCREMENT PRIMARY KEY,
bill_id INT,
amount DEC(10,2) NOT NULL CHECK(amount>0),
method ENUM('cash','card'),
payment_date DATE,
FOREIGN KEY(bill_id) REFERENCES bills(bill_id)
);

-- RECORDS TABLE
CREATE TABLE records(
record_id INT AUTO_INCREMENT PRIMARY KEY,
patient_id INT,
doctor_id INT,
diagnosis TEXT,
record_date DATE,
FOREIGN KEY(patient_id) REFERENCES patients(patient_id),
FOREIGN KEY(doctor_id) REFERENCES doctors(doctor_id)
);