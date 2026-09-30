USE hospital_system;
SELECT * FROM v_appointment_details;
SELECT * FROM v_bill_summary;
SELECT d.department_name,COUNT(a.appointment_id) appointment_count FROM department d LEFT JOIN doctor dr ON dr.department_id=d.department_id LEFT JOIN appointment a ON a.doctor_id=dr.doctor_id GROUP BY d.department_id,d.department_name ORDER BY appointment_count DESC;
SELECT doctor_name,COUNT(*) appointment_count FROM v_appointment_details GROUP BY doctor_id,doctor_name ORDER BY appointment_count DESC;
CALL get_patient_appointments(1);
