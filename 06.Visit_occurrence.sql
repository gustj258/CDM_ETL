/**************************************
 --encoding : UTF-8
 --Author: 이성원
 --Date: 2017.01.26
 
 @bigdata : DB containing NHIS National Sample cohort DB
 @NHIS_JK: JK table in NHIS NSC
 @NHIS_20T: 20 table in NHIS NSC
 @NHIS_30T: 30 table in NHIS NSC
 @NHIS_40T: 40 table in NHIS NSC
 @NHIS_60T: 60 table in NHIS NSC
 @NHIS_GJ: GJ table in NHIS NSC
 --Description: Visit_occurrence 테이블 생성
 --Generating Table: VISIT_OCCURRENCE
***************************************/

/**************************************
 1. 테이블 생성
***************************************/ 
CREATE TABLE cohort_cdm.VISIT_OCCURRENCE(
	visit_occurrence_id	number primary key,
	person_id			number not null,
	visit_concept_id	number not null,
	visit_start_date	date not null,
	visit_start_time	timestamp,
	visit_end_date		date not null,
	visit_end_time		timestamp,
	visit_type_concept_id	number not null,
	provider_id			number,
	care_site_id		number,
	visit_source_value	varchar(50),
	visit_source_concept_id	 number
 );
/**************************************
 2. 데이터 입력
***************************************/ 
insert into cohort_cdm.VISIT_OCCURRENCE (
	visit_occurrence_id, person_id, visit_concept_id, visit_start_date, visit_start_time,
	visit_end_date, visit_end_time, visit_type_concept_id, provider_id, care_site_id,
	visit_source_value, visit_source_concept_id
)
select 
	key_seq as visit_concept_id,
	person_id as person_id,
	case when form_cd in ('02', '04', '06', '07', '10', '12') and in_pat_cors_type in ('11', '21', '31') then 9203 --입원 + 응급
		when form_cd in ('02', '04', '06', '07', '10', '12') and in_pat_cors_type not in ('11', '21', '31') then 9201 --입원 + 입원
		when form_cd in ('03', '05', '08', '09', '11', '13', '20', '21', 'ZZ') and in_pat_cors_type in ('11', '21', '31') then 9203 --외래 + 응급
		when form_cd in ('03', '05', '08', '09', '11', '13', '20', '21', 'ZZ') and in_pat_cors_type not in ('11', '21', '31') then 9202 --외래 + 외래
		else 0
	end as visit_concept_id,
	TO_DATE, recu_fr_dt, 112) from dual as visit_start_date,
	null as visit_start_time,
	case when form_cd in ('02', '04', '06', '07', '10', '12') then vscn * INTERVAL '1' DAY(5)-1 + convert(date, recu_fr_dt, 112)) 
		when form_cd in ('03', '05', '08', '09', '11', '13', '20', '21', 'ZZ') and in_pat_cors_type in ('11', '21', '31') then vscn * INTERVAL '1' DAY(5)-1 + convert(date, recu_fr_dt, 112))
		else convert(date, recu_fr_dt, 112)
	end as visit_end_date,
	null as visit_end_time,
	44818517 as visit_type_concept_id,
	null as provider_id,
	ykiho_id as care_site_id,
	key_seq as visit_source_value,
	null as visit_source_concept_id
from bigdata.NHIS_20T
;


--건강검진 INSERT
 insert into VISIT_OCCURRENCE@cohort_cdm (
	visit_occurrence_id, person_id, visit_concept_id, visit_start_date, visit_start_time,
	visit_end_date, visit_end_time, visit_type_concept_id, provider_id, care_site_id,
	visit_source_value, visit_source_concept_id
)
select 
	(b.master_seq as visit_concept_id,
	a.person_id as person_id,
	9202 as visit_concept_id,
	cast(TO_CHAR (a.hchk_year+'0101', 23)as date) as visit_start_date,
	null as visit_start_time,
	cast(TO_CHAR (a.hchk_year+'0101', 23)as date) as visit_end_date,
	null as visit_end_time,
	44818517 as visit_type_concept_id,
	null as provider_id,
	null as care_site_id,
	b.master_seq as visit_source_value,
	null as visit_source_concept_id)
from @bigdata.@NHIS_GJ a JOIN @cohort_cdm.seq_master b on a.person_id=b.person_id and a.hchk_year=b.hchk_year
;