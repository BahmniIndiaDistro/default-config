SELECT obs.PERSON_ID AS PERSON_ID, per_name.PERSON_NAME, per.AGE, per.GENDER,/* PHONE_NUMBER,*/ recepient.RECIPIENT_CATEGORY, vaccine.VACCINE_NAME, obs.DOSE1_DATE, vaccinedose2.DUE_DATE_OF_DOSE2
FROM
	(SELECT person_id, CAST(date_created AS DATE) AS DOSE1_DATE
		from obs
		where concept_id =3833)
	obs,
	(SELECT person_id, Round(DATEDIFF(CURDATE() ,birthdate)/365) AS AGE, gender AS GENDER
		from person) per,
	(SELECT person_id, CONCAT(given_name, ' ', family_name) as PERSON_NAME
		from person_name)
	per_name,
	/*(SELECT person_id,
		CASE
    		WHEN value IS NULL THEN ''
    		ELSE value
    	END AS PHONE_NUMBER
		FROM person_attribute
		WHERE person_attribute_type_id IN (15,16) )
	phone,*/
	(SELECT person_id, NAME AS RECIPIENT_CATEGORY
		FROM obs,concept_name cn
		WHERE obs.concept_id = 3827
				AND
				cn.concept_id = obs.value_coded AND locale_preferred = 0)
	recepient,
	(SELECT person_id, NAME AS VACCINE_NAME
		FROM obs,concept_name cn
			WHERE obs.concept_id = 3822
				AND
				cn.concept_id = obs.value_coded )
	vaccine,
	(SELECT obs_id, person_id, CAST(value_datetime AS DATE) AS DUE_DATE_OF_DOSE2
		FROM obs o
		WHERE concept_id = 3792
				AND
				obs_id = (select MAX(obs_id)
				from obs oo
				where o.person_id = oo.person_id
						and
						concept_id = 3792)
				GROUP BY person_id )
	vaccinedose2
WHERE
	obs.person_id = per.person_id and
	obs.person_id = per_name.person_id AND
	obs.person_id = recepient.person_id AND
	obs.person_id = vaccine.person_id AND
	obs.person_id = vaccinedose2.person_id;
/* TODO: Implement Phone number */