\/**************************************
 --encoding : UTF-8
 --Author: OHDSI
  
cohort_cdm : DB containing NHIS National Sample cohort DB
cohort_cdm : DB for NHIS-NSC in CDM format
 
 --Description: OHDSI에서 생성한 dose_era 생성 쿼리
 --Generating Table: DOSE_ERA
***************************************/

/**************************************
 1. dose_era 테이블 생성
***************************************/ 
 CREATE TABLE cohort_cdm.DOSE_ERA (
     dose_era_id					INTEGER	 identity(1,1)    NOT NULL , 
     person_id						INTEGER     NOT NULL ,
     drug_concept_id				INTEGER   NOT NULL ,
     unit_concept_id				INTEGER      NOT NULL ,
     dose_value						float  NOT NULL ,
     dose_era_start_date			DATE 		NOT	NULL, 
	 dose_era_end_date				DATE 		NOT	NULL
);


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
	, COALESCE(d.drug_exposure_end_date, last_day(d.days_supply, d.drug_exposure_start_date), last_day(drug_exposure_start_date,'yyyymmdd')) AS drug_exposure_end_date
    
    --, COALESCE(d.drug_exposure_end_date, DATEADD(DAY, d.days_supply, d.drug_exposure_start_date), DATEADD(DAY, 1, drug_exposure_start_date)) AS drug_exposure_end_date 원본코드
    
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
	, last_day(event_date, 'yyyymmdd') AS end_date
    
    --, DATEADD( DAY, -30, event_date) AS end_date 원본코드
INTO cteEndDates FROM
(
	SELECT
		person_id
		, ingredient_concept_id
		, unit_concept_id
		, dose_value
		, event_date
		, event_type
		, MAX(start_ordinal) OVER (PARTITION BY person_id, ingredient_concept_id, unit_concept_id, dose_value ORDER BY event_date, event_type ROWS unbounded preceding) AS start_ordinal
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
			, last_day(drug_exposure_end_date,'yyyymmdd') AS drug_exposure_end_date
            -- DATEADD(DAY, 30, drug_exposure_end_date) AS drug_exposure_end_date 원본코드
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
