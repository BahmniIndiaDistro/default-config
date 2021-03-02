SELECT 
	CONCAT(pn.given_name, ' ', pn.family_name) AS `Person Name`,
	DATE(MAX(pp.date_enrolled)) AS `Date Enrolled in Program`,
    DATEDIFF(IFNULL(pp.date_completed, NOW()), pp.date_enrolled) AS `No. of Days in Program`,
	cn.name AS `Current State in Program`
FROM patient pt
    INNER JOIN person_name pn ON pt.patient_id = pn.person_id
    INNER JOIN patient_program pp ON pt.patient_id = pp.patient_id
    INNER JOIN patient_state ps ON ps.patient_program_id = pp.patient_program_id
    INNER JOIN program_workflow_state pws ON pws.program_workflow_state_id = ps.state
    INNER JOIN concept_name cn ON cn.concept_id = pws.concept_id
    INNER JOIN obs obs ON obs.person_id = pt.patient_id
    INNER JOIN program pr ON pr.program_id = pp.program_id
WHERE cn.concept_name_type = "SHORT" AND pr.name = "COVID-19 Program"
GROUP BY pn.person_id;