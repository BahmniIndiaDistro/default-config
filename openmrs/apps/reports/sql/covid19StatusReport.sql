SELECT
    CONCAT(person_name.given_name, ' ', person_name.family_name) AS `Patient Name`, 
    patient_program.date_enrolled AS `Date Enrolled in Program`, 
    dateDiff(IFNULL(patient_program.date_completed, now()), patient_program.date_enrolled) AS `No. of Days in Program`,  
    patient_state.state AS `Current State in Program`
FROM patient_program 
    INNER JOIN program ON patient_program.program_id=program.program_id
    INNER JOIN person_name ON person_name.person_id=patient_program.patient_id
    INNER JOIN patient_state ON patient_program.patient_program_id=patient_state.patient_program_id
WHERE 
    program.name="COVID-19 Program" 
GROUP BY 
    person_name.given_name
ORDER BY 
    patient_program.date_enrolled DESC;
