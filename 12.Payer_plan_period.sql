/**************************************
 --encoding : UTF-8
 --Author: 고인석,박현서
 --Date: 2019.09.17
 
@NHISDatabaseSchema : DB containing NHIS National Sample cohort DB
@ResultDatabaseSchema : DB for NHIS-NSC in CDM format
@NHIS_JK: JK table in NHIS NSC
@NHIS_20T: 20 table in NHIS NSC
@NHIS_30T: 30 table in NHIS NSC
@NHIS_40T: 40 table in NHIS NSC
@NHIS_60T: 60 table in NHIS NSC
@NHIS_GJ: GJ table in NHIS NSC
@CONDITION_MAPPINGTABLE : mapping table between KCD and OMOP vocabulary
@DRUG_MAPPINGTABLE : mapping table between EDI and OMOP vocabulary
@PROCEDURE_MAPPINGTABLE : mapping table between Korean procedure and OMOP vocabulary
@DEVICE_MAPPINGTABLE : mapping table between EDI and OMOP vocabulary
 
 --Description: PAYER_PLAN_PERIOD 테이블 생성
			   1) payer_plan_period_id = person_id+연도 4자로 정의
			   2) payer_plan_period_start_date = 당해 01월 01일로 정의
			   3) payer_plan_period_end_date = 당해 12월 31일 혹은 death date로 정의
 --Generating Table: PAYER_PLAN_PERIOD
***************************************/

/**************************************
 1. 테이블 생성 
***************************************/ 

CREATE TABLE cohort_cdm.PAYER_PLAN_PERIOD
    (
     payer_plan_period_id				NUMBER						NOT NULL , 
     person_id							INTEGER						NOT NULL ,
     payer_plan_period_start_date		DATE						NOT NULL ,
     payer_plan_period_end_date			DATE						NOT NULL ,
     payer_source_value					VARCHAR(50) 				NULL,  
     plan_source_value					VARCHAR(50) 				NULL,  
	 family_source_value				VARCHAR(50) 				NULL   
	); -- DROP TABLE @ResultDatabaseSchema.PAYER_PLAN_PERIOD
    
create global temporary table cohort_cdm.PAYER_PLAN_PERIOD
(
     payer_plan_period_id				NUMBER						NOT NULL , 
     person_id							INTEGER						NOT NULL ,
     payer_plan_period_start_date		DATE						NOT NULL ,
     payer_plan_period_end_date			DATE						NOT NULL ,
     payer_source_value					VARCHAR(50) 				NULL,  
     plan_source_value					VARCHAR(50) 				NULL,  
	 family_source_value				VARCHAR(50) 				NULL   
)
on commit preserve rows;
 
 
/**************************************
 2. 데이터 입력 및 확인 -- 02:57, (12132633개 행이 영향을 받음)
***************************************/  

INSERT INTO cohort_cdm.PAYER_PLAN_PERIOD (payer_plan_period_id, person_id, payer_plan_period_start_date, payer_plan_period_end_date, payer_source_value, plan_source_value, family_source_value)
	SELECT	a.person_id+STND_Y as payer_plan_period_id,
			a.person_id as person_id,
			cast(to_char( STND_Y || '0101' ,23) as date) as payer_plan_period_start_date,
			case when year < death_date then a.year
			when year > death_date then death_date
			else a.year
			end as payer_plan_period_end_date,
			payer_source_value = 'National Health Insurance Service',
			IPSN_TYPE_CD as plan_source_value,
			family_source_value = null
	FROM 
			(select person_id, STND_Y, IPSN_TYPE_CD, cast(to_char(cast(YEAR as varchar) || '1231' ,23) as date) as year from cohort_cdm.NHID_JK ) a left join cohort_cdm.Death b
	  		on a.person_id=b.person_id
