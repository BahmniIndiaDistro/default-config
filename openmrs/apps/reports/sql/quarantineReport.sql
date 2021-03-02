select CONCAT(pn.given_name, ' ', pn.family_name) as name,
DATE(pp.date_enrolled) as date_enrolled_in_program,
IF(pp.date_completed IS NULL ,DATEDIFF(CURDATE() , pp.date_enrolled),DATEDIFF(pp.date_completed , pp.date_enrolled)) as No_of_days,
cn.name as Program_state,
cn1.name as Quarantine_status
from patient pt
inner join person_name pn ON pt.patient_id = pn.person_id
inner join patient_program pp ON pt.patient_id = pp.patient_id
inner join patient_state ps ON ps.patient_program_id = pp.patient_program_id
inner join program_workflow_state pws ON pws.program_workflow_state_id = ps.state
inner join concept_name cn ON cn.concept_id = pws.concept_id
inner join obs obs ON obs.person_id = pt.patient_id
inner join concept_name cn1 ON obs.value_coded = cn1.concept_id
inner join program pr ON pr.program_id = pp.program_id
where cn.concept_name_type = "FULLY_SPECIFIED" and pr.name = "COVID-19 Program" and cn1.concept_name_type = "FULLY_SPECIFIED" and obs.form_namespace_and_path = "Bahmni^COVID-19, Initial Screening.1/22-0"
order by Date(pp.date_enrolled);
