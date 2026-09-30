USE hospital_system;
CREATE INDEX idx_patient_phone ON patient(phone);
CREATE INDEX idx_doctor_department ON doctor(department_id);
CREATE INDEX idx_appointment_patient ON appointment(patient_id);
CREATE INDEX idx_appointment_doctor ON appointment(doctor_id);
CREATE INDEX idx_appointment_date ON appointment(appointment_date);
CREATE INDEX idx_bill_patient ON bill(patient_id);
CREATE INDEX idx_payment_bill ON payment(bill_id);
