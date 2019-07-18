/**************************************
 --encoding : UTF-8
 --Author: OHDSI
  
@NHISDatabaseSchema : DB containing NHIS National Sample cohort DB
@cohort_cdm : DB for NHIS-NSC in CDM format
 
 --Description: OHDSI에서 생성한 dose_era 생성 쿼리
 --Generating Table: DOSE_ERA
***************************************/

/**************************************
 1. dose_era 테이블 생성
***************************************/ 
 CREATE TABLE cohort_cdm.DOSE_ERA (
     dose_era_id					NUMBER NOT NULL , 
     person_id						NUMBER NOT NULL ,
     drug_concept_id				NUMBER NOT NULL ,
     unit_concept_id				NUMBER NOT NULL ,
     dose_value						binary_double  NOT NULL ,
     dose_era_start_date	DATE 	NOT NULL, 
	 dose_era_end_date		DATE 	NOT NULL
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE cohort_cdm.DOSE_ERA_seq  START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER cohort_cdm.DOSE_ERA_seq_tr
  BEFORE INSERT ON cohort_cdm.DOSE_ERA FOR EACH ROW
  WHEN (NEW.dose_era_id IS NULL)
 BEGIN
 SELECT cohort_cdm.DOSE_ERA_seq.NEXTVAL INTO :NEW.dose_era_id FROM DUAL;
END;
/


/**************************************
 2. 1단계: 필요 데이터 조회
***************************************/ 

--------------------------------------------#cteDrugTarget
SELECT
	d.drug_exposure_id
	, d.person_id
	, c.concept_id AS ingredient_concept_id
	, d.dose_unit_concept_id AS unit_concept_id
	, d.effective_drug_dose AS dose_value
	, d.drug_exposure_start_date
	, d.days_supply AS days_supply
	, COALESCE(d.drug_exposure_end_date, d.days_supply * INTERVAL '1' DAY + d.drug_exposure_start_date, INTERVAL '1' DAY + drug_exposure_start_date) AS drug_exposure_end_date
INTO cteDrugTarget 
FROM drug_exposure d
	 JOIN concept_ancestor ca ON ca.descendant_concept_id = d.drug_concept_id
	 JOIN concept c ON ca.ancestor_concept_id = c.concept_id
	 WHERE c.vocabulary_id = 'RxNorm'
	 AND c.concept_class_ID = 'Ingredient';
	
	
--------------------------------------------#cteEndDates
SELECT
	person_id
	, ingredient_concept_id
	, unit_concept_id
	, dose_value
	, INTERVAL '-30'  DAY + event_date AS end_date
INTO cteEndDates FROM
(
	SELECT
		person_id
		, ingredient_concept_id
		, unit_concept_id
		, dose_value
		, event_date
		, event_type
		, MAX(start_ordinal) OVER FROM dual (PARTITION BY person_id, ingredient_concept_id, unit_concept_id, dose_value ORDER BY event_date, event_type ROWS unbounded preceding) AS start_ordinal
		, ROW_NUMBER() OVER (PARTITION BY person_id, ingredient_concept_id, unit_concept_id, dose_value ORDER BY event_date, event_type) AS overall_ord
	FROM
	(
		SELECT
			person_id
			, ingredient_concept_id
			, unit_concept_id
			, dose_value
			, drug_exposure_start_date AS event_date
			, -1 AS event_type, ROW_NUMBER() OVER(PARTITION BY person_id, ingredient_concept_id, unit_concept_id, dose_value ORDER BY drug_exposure_start_date) AS start_ordinal
		FROM cteDrugTarget 

		UNION ALL

		SELECT
			person_id
			, ingredient_concept_id
			, unit_concept_id
			, dose_value
			, INTERVAL '30' DAY(5) + drug_exposure_end_date AS drug_exposure_end_date
			, 1 AS event_type
			, NULL
		FROM cteDrugTarget
	) RAWDATA
) e
WHERE (2 * e.start_ordinal) - e.overall_ord = 0;


--------------------------------------------#cteDoseEraEnds
SELECT
	dt.person_id
	, dt.ingredient_concept_id as drug_concept_id
	, dt.unit_concept_id 
	, dt.dose_value
	, dt.drug_exposure_start_date
	, MIN(e.end_date) AS dose_era_end_date
into cteDoseEraEnds FROM cteDrugTarget dt
JOIN cteEndDates e
ON dt.person_id = e.person_id AND dt.ingredient_concept_id = e.ingredient_concept_id AND dt.unit_concept_id = e.unit_concept_id AND dt.dose_value = e.dose_value AND e.end_date >= dt.drug_exposure_start_date
GROUP BY
	dt.drug_exposure_id
	, dt.person_id
	, dt.ingredient_concept_id
	, dt.unit_concept_id
	, dt.dose_value
	, dt.drug_exposure_start_date;

	
	
/**************************************
 3. 2단계: dose_era에 데이터 입력
***************************************/ 

INSERT INTO cohort_cdm.dose_era (person_id, drug_concept_id, unit_concept_id, dose_value, dose_era_start_date, dose_era_end_date)
SELECT
	person_id
	, drug_concept_id
	, unit_concept_id
	, dose_value
	, MIN(drug_exposure_start_date) AS dose_era_start_date
	, dose_era_end_date
	from cteDoseEraEnds
GROUP BY person_id, drug_concept_id, unit_concept_id, dose_value, dose_era_end_date
ORDER BY person_id, drug_concept_id;