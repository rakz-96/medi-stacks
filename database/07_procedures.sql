USE hospital_system;
DROP PROCEDURE IF EXISTS get_patient_appointments;
DELIMITER $$
CREATE PROCEDURE get_patient_appointments(IN p_patient_id BIGINT)
BEGIN
 SELECT appointment_id,patient_name,doctor_name,department_name,appointment_date,appointment_time,reason,status FROM v_appointment_details WHERE patient_id=p_patient_id ORDER BY appointment_date DESC,appointment_time DESC;
END$$
DELIMITER ;
