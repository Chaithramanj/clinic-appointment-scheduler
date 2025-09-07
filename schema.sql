-- Drop all tables if they already exist
DROP TABLE IF EXISTS Medical_Record;
DROP TABLE IF EXISTS Appointment;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Doctor;

-- Patient Table
CREATE TABLE Patient (
    patient_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER NOT NULL,
    gender TEXT NOT NULL,
    phone TEXT NOT NULL,
    appointment_time TEXT NOT NULL,
    dob TEXT
);

-- Doctor Table
CREATE TABLE Doctor (
    doctor_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    specialization TEXT NOT NULL,
    phone TEXT NOT NULL
);

-- Appointment Table
CREATE TABLE Appointment (
    appointment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    patient_id INTEGER NOT NULL,
    doctor_id INTEGER NOT NULL,
    appointment_date TEXT NOT NULL,
    appointment_time TEXT NOT NULL,
    status TEXT NOT NULL,
    FOREIGN KEY(patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY(doctor_id) REFERENCES Doctor(doctor_id)
);

-- Medical Record Table
CREATE TABLE Medical_Record (
    record_id INTEGER PRIMARY KEY AUTOINCREMENT,
    patient_id INTEGER NOT NULL,
    doctor_id INTEGER NOT NULL,
    diagnosis TEXT NOT NULL,
    treatment TEXT NOT NULL,
    record_date TEXT NOT NULL,
    FOREIGN KEY(patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY(doctor_id) REFERENCES Doctor(doctor_id)
);

-- Insert Patients
INSERT INTO Patient (name, age, gender, phone, appointment_time, dob) VALUES
('Alice Smith', 30, 'Female', '9876543210', '10:30', '1994-04-01'),
('Bob Johnson', 45, 'Male', '8765432109', '14:00', '1979-06-15'),
('Charlie Brown', 29, 'Male', '7654321098', '09:00', '1995-09-10');

-- Insert Doctors
INSERT INTO Doctor (name, specialization, phone) VALUES
('Dr. Emily Clark', 'Cardiology', '1234567890'),
('Dr. Michael Lee', 'Dermatology', '2345678901'),
('Dr. Sarah Davis', 'Pediatrics', '3456789012');

-- Insert Appointments
INSERT INTO Appointment (patient_id, doctor_id, appointment_date, appointment_time, status) VALUES
(1, 1, '2025-06-01', '10:30', 'Scheduled'),
(2, 2, '2025-06-02', '14:00', 'Scheduled'),
(3, 3, '2025-06-03', '09:00', 'Scheduled');

-- Insert Medical Records
INSERT INTO Medical_Record (patient_id, doctor_id, diagnosis, treatment, record_date) VALUES
(1, 1, 'Hypertension', 'Prescribed medication A', '2025-05-01'),
(2, 2, 'Acne', 'Prescribed medication B', '2025-05-03'),
(3, 3, 'Flu', 'Prescribed rest and medication C', '2025-05-05');
a