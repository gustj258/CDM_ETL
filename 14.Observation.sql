/**************************************
 --encoding : UTF-8
 --Author: 조재형
 --Date: 2017.03.15
 
NHISDatabaseSchema : DB containing NHIS National Sample cohort DB
cohort_cdm : DB for NHIS-NSC in CDM format
NHIS_JK: JK table in NHIS NSC
NHIS_20T: 20 table in NHIS NSC
NHIS_30T: 30 table in NHIS NSC
NHIS_40T: 40 table in NHIS NSC
NHIS_60T: 60 table in NHIS NSC
NHIS_GJ: GJ table in NHIS NSC
NHIS_GJ_vertical : GJ table from NHIS NSC, which was vertically transformatted
CONDITION_MAPPINGTABLE : mapping table between KCD and OMOP vocabulary
DRUG_MAPPINGTABLE : mapping table between EDI and OMOP vocabulary
PROCEDURE_MAPPINGTABLE : mapping table between Korean procedure and OMOP vocabulary
DEVICE_MAPPINGTABLE : mapping table between EDI and OMOP vocabulary
 
 --Description: OBSERVATION 테이블 생성
 --Generating Table: OBSERVATION
***************************************/

/**************************************
 1. 테이블 생성 
***************************************/ 
--drop table cohort_cdm.OBSERVATION
--drop tableobservation_mapping
--drop tableobservation_mapping09

--IF OBJECT_ID(cohort_cdm.OBSERVATION', 'U') IS NULL
CREATE TABLE cohort_cdm.OBSERVATION
    (
     observation_id						NUMBER NOT NULL , 
     person_id							NUMBER NOT NULL ,
     observation_concept_id				NUMBER NOT NULL ,
     observation_date					DATE NOT NULL ,
     observation_time					TIMESTAMP NULL,  
     observation_type_concept_id		number NULL,  
	 value_as_number					binary_double NULL,
	 value_as_string					VARCHAR2(50) NULL,
	 value_as_concept_id				number NULL,
	 qualifier_concept_id				number NULL,
	 unit_concept_id					number NULL,
	 provider_id						number NULL,
	 visit_occurrence_id				number NULL,
	 observation_source_value			VARCHAR2(50) NULL,
	 observation_source_concept_id		number NULL,
	 unit_source_value					VARCHAR2(50) NULL,
	 qualifier_source_value				VARCHAR2(50) NULL
	)
;
	
	
-- observation mapping table(temp)
CREATE TABLE observation_mapping
    (
     meas_type						varchar2(50) NULL , 
     id_value						varchar2(50) NULL ,
     answer							number NULL ,
     observation_concept_id			number NULL ,
	 observation_type_concept_id	number NULL ,
	 observation_unit_concept_id	number NULL ,
	 value_as_concept_id			number NULL ,
	 value_as_number				binary_double NULL 
	)
;
INSERT INTO cohort_cdm.observation_mapping	
-- insert mapping data
SELECT'HCHK_PMH_CD1', '20', 1, 4058267, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD1', '20', 2, 43021368, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD1', '20', 3, 4058725, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD1', '20', 4, 4058286, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD1', '20', 5, 4077352, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD1', '20', 6, 4077982, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD1', '20', 7, 4058709, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD1', '20', 8, 4144289, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD1', '20', 9, 4195979, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD2', '21', 1, 4058267, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD2', '21', 2, 43021368, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD2', '21', 3, 4058725, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD2', '21', 4, 4058286, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD2', '21', 5, 4077352, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD2', '21', 6, 4077982, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD2', '21', 7, 4058709, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD2', '21', 8, 4144289, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD2', '21', 9, 4195979, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD3', '22', 1, 4058267, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD3', '22', 2, 43021368, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD3', '22', 3, 4058725, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD3', '22', 4, 4058286, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD3', '22', 5, 4077352, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD3', '22', 6, 4077982, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD3', '22', 7, 4058709, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD3', '22', 8, 4144289, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_PMH_CD3', '22', 9, 4195979, 44814721, null, null, null FROM dual UNION ALL 
SELECT'HCHK_APOP_PMH_YN',	'23',	1,4077982,44814721,	null,	null,	null FROM dual UNION ALL 
SELECT'HCHK_HDISE_PMH_YN',	'24',1,4077352,	44814721,	null,	null,	null FROM dual UNION ALL 
SELECT'HCHK_HPRTS_PMH_YN','25',1,4058286,44814721,	null,	null,	null FROM dual UNION ALL 
SELECT'HCHK_DIABML_PMH_YN','26',1,4058709,44814721,	null,	null,	null FROM dual UNION ALL 
SELECT'HCHK_HPLPDM_PMH_YN',	'27',1,4058275,44814721,	null,	null,	null FROM dual UNION ALL 
SELECT'HCHK_ETCDSE_PMH_YN',	'28',1,44834226,44814721,	null,	null,	null FROM dual UNION ALL 
SELECT'HCHK_PHSS_PMH_YN',	'29',1,	4058267,44814721,	null,	null,	null FROM dual UNION ALL 
SELECT'FMLY_LIVER_DISE_PATIEN_YN', '30', 1,	4144266,44814721, null, null, null FROM dual UNION ALL 
SELECT'FMLY_HPRTS_PATIEN_YN',	'31',	0,	4053372,44814721,	null,	null,	null FROM dual UNION ALL 
SELECT'FMLY_HPRTS_PATIEN_YN',	'31',	1,	4050816,44814721,	null,	null,	null FROM dual UNION ALL 
SELECT'FMLY_APOP_PATIEN_YN',	'32',	0,	4175587,44814721,	null,	null,	null FROM dual UNION ALL 
SELECT'FMLY_APOP_PATIEN_YN',	'32',	1,	4169009,44814721,	null,	null,	null FROM dual UNION ALL 
SELECT'FMLY_HDISE_PATIEN_YN',	'33',	0,	4050792,44814721,	null,	null,	null FROM dual UNION ALL 
SELECT'FMLY_HDISE_PATIEN_YN',	'33',	1,	4173498,	44814721,	null,	null,	null FROM dual UNION ALL 
SELECT'FMLY_DIABML_PATIEN_YN',	'34',	0,	4051106,	44814721,	null,	null,	null FROM dual UNION ALL 
SELECT'FMLY_DIABML_PATIEN_YN',	'34',	1,	4051114,44814721,	null,	null,	null FROM dual UNION ALL 
SELECT'FMLY_CANCER_PATIEN_YN',	'35',	0,	4051100,	44814721,	null,	null,	null FROM dual UNION ALL 
SELECT'FMLY_CANCER_PATIEN_YN',	'35',	1,	4171594,	44814721,	null,	null,	null FROM dual UNION ALL 
SELECT'SMK_STAT_TYPE_RSPS_CD',	'36',	1,	4222303,44814721,	NULL,	NULL,	NULL FROM dual UNION ALL 
SELECT'SMK_STAT_TYPE_RSPS_CD',	'36',	2,	4310250,	44814721,	NULL,	NULL,	NULL FROM dual UNION ALL 
SELECT'SMK_STAT_TYPE_RSPS_CD',	'36',	3,	4276526,44814721,	NULL,	NULL,	NULL FROM dual UNION ALL 
SELECT'SMK_TERM_RSPS_CD',	'37',	1,	40766364,	44818704,	NULL,	NULL,	2.5 FROM dual UNION ALL 
SELECT'SMK_TERM_RSPS_CD',	'37',	2,	40766364,	44818704,	NULL,	NULL,	7.5 FROM dual UNION ALL 
SELECT'SMK_TERM_RSPS_CD',	'37',	3,	40766364,	44818704,	NULL,	NULL,	15 FROM dual UNION ALL 
SELECT'SMK_TERM_RSPS_CD',	'37',	4,	40766364,	44818704,	NULL,	NULL,	25 FROM dual UNION ALL 
SELECT'SMK_TERM_RSPS_CD',	'37',	5,	40766364,	44818704,	NULL,	NULL,	30 FROM dual UNION ALL 
SELECT'CUR_SMK_TERM_RSPS_CD','38',0,	40766364,	44818704,	9448,	NULL,	NULL FROM dual UNION ALL 
SELECT'CUR_DSQTY_RSPS_CD','39',	0,	40766929,	44818704,	45756923,	NULL,	NULL FROM dual UNION ALL 
SELECT'PAST_SMK_TERM_RSPS_CD',	'40',	0,		40766364,		44818704,	9448,		NULL,		NULL FROM dual UNION ALL 
SELECT'PAST_DSQTY_RSPS_CD','41',	0,		40766930,		44818704,	45756923,	NULL,		NULL FROM dual UNION ALL 
SELECT'DSQTY_RSPS_CD',	'42',	1,		40766929,		44818704,	45756954,	NULL,		0.25 FROM dual UNION ALL 
SELECT'DSQTY_RSPS_CD','42',	2,		40766929,		44818704,	45756954,	NULL,		0.75 FROM dual UNION ALL 
SELECT'DSQTY_RSPS_CD','42',	3,		40766929,		44818704,	45756954,	NULL,		1.5 FROM dual UNION ALL 
SELECT'DSQTY_RSPS_CD','42',	4,		40766929,		44818704,	45756954,	NULL,		2 FROM dual UNION ALL 
SELECT'DRNK_HABIT_RSPS_CD',	'43',	1,		40771103,		44818704,	NULL,		45882527,	NULL FROM dual UNION ALL 
SELECT'DRNK_HABIT_RSPS_CD',	'43',	2,		40771103,		44818704,	NULL,		45885249,	NULL FROM dual UNION ALL 
SELECT'DRNK_HABIT_RSPS_CD',	'43',	3,		40771103,		44818704,	NULL,		45881653,	NULL FROM dual UNION ALL 
SELECT'DRNK_HABIT_RSPS_CD',	'43',	4,		40771103,		44818704,	NULL,		45885248,	NULL FROM dual UNION ALL
SELECT'DRNK_HABIT_RSPS_CD',	'43',	5,		40771103,		44818704,	NULL,		45879676,	NULL FROM dual UNION ALL
SELECT'TM1_DRKQTY_RSPS_CD',	'44',	1,		3037705,		44818704,	4045131,	NULL,		3.5  FROM dual UNION ALL
SELECT'TM1_DRKQTY_RSPS_CD',	'44',	2,		3037705,		44818704,	4045131,	NULL,		7  FROM dual UNION ALL
SELECT'TM1_DRKQTY_RSPS_CD',	'44',	3,		3037705,		44818704,	4045131,	NULL,		10.5  FROM dual UNION ALL
SELECT'TM1_DRKQTY_RSPS_CD',	'44',	4,		3037705,		44818704,	4045131,	NULL,		14  FROM dual UNION ALL
SELECT'EXERCI_FREQ_RSPS_CD',	'45',	1,		4036426,		44818704,	NULL,		45882527,	NULL FROM dual UNION ALL
SELECT'EXERCI_FREQ_RSPS_CD',	'45',	2,		4036426,		44818704,	NULL,		45881653,	NULL FROM dual UNION ALL																						   
SELECT'EXERCI_FREQ_RSPS_CD',	'45',	3,		4036426,		44818704,	NULL,		45885248,	NULL FROM dual UNION ALL
SELECT'EXERCI_FREQ_RSPS_CD',	'45',	4,		4036426,		44818704,	NULL,		45883166,	NULL FROM dual UNION ALL
SELECT'EXERCI_FREQ_RSPS_CD',	'45',	5,		4036426,		44818704,	NULL,		45879676,	NULL FROM dual UNION ALL
SELECT'MOV20_WEK_FREQ_ID',		'46',	0,		82020119,		44818704,	NULL,		NULL,		NULL FROM dual UNION ALL 
SELECT'MOV30_WEK_FREQ_ID',		'47',	0,		82020120,		44818704,	NULL,		NULL,		NULL FROM dual UNION ALL 
SELECT'WLK30_WEK_FREQ_ID',		'48',	0,		82020121,		44818704,	NULL,		NULL,		NULL FROM dual UNION ALL 
SELECT'CTRB_PT_TYPE_CD',		'49',	0,		3004572,		44814721,	4155146,	NULL,		NULL FROM dual UNION ALL
SELECT'CTRB_PT_TYPE_CD',		'49',	1,		3004572,		44814721,	4155146,	NULL,		NULL FROM dual UNION ALL
SELECT'CTRB_PT_TYPE_CD',		'49',	2,		3004572,		44814721,	4155146,	NULL,		NULL FROM dual UNION ALL
SELECT'CTRB_PT_TYPE_CD',		'49',	3,		3004572,		44814721,	4155146,	NULL,		NULL FROM dual UNION ALL
SELECT'CTRB_PT_TYPE_CD',		'49',	4,		3004572,		44814721,	4155146,	NULL,		NULL FROM dual UNION ALL
SELECT'CTRB_PT_TYPE_CD',		'49',	5,		3004572,		44814721,	4155146,	NULL,		NULL FROM dual UNION ALL
SELECT'CTRB_PT_TYPE_CD',		'49',	6,		3004572,		44814721,	4155146,	NULL,		NULL FROM dual UNION ALL
SELECT'CTRB_PT_TYPE_CD',		'49',	7,		3004572,		44814721,	4155146,	NULL,		NULL FROM dual UNION ALL
SELECT'CTRB_PT_TYPE_CD',		'49',	8,		3004572,		44814721,	4155146,	NULL,		NULL FROM dual UNION ALL
SELECT'CTRB_PT_TYPE_CD',		'49',	9,		3004572,		44814721,	4155146,	NULL,		NULL FROM dual UNION ALL
SELECT'CTRB_PT_TYPE_CD',		'49',	10,		3004572,		44814721,	4155146,	NULL,		NULL FROM dual 

																																	 


/**************************************
 2. 코드형 데이터 입력 (14768634개 행이 영향을 받음)
***************************************/ 
INSERT INTO cohort_cdm.OBSERVATION(observation_id, person_id, observation_concept_id, observation_date, observation_time, observation_type_concept_id, value_as_number, value_as_string, value_as_concept_id,
										qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value)
	select	 case when a.meas_type = 'HCHK_PMH_CD1' then cast(concat(c.master_seq, b.id_value) as number)
                    when a.meas_type = 'HCHK_PMH_CD2' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'HCHK_PMH_CD3' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'HCHK_APOP_PMH_YN' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'HCHK_HDISE_PMH_YN' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'HCHK_HPRTS_PMH_YN' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'HCHK_DIABML_PMH_YN' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'HCHK_HPLPDM_PMH_YN' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'HCHK_ETCDSE_PMH_YN' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'HCHK_PHSS_PMH_YN' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'FMLY_LIVER_DISE_PATIEN_YN' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'FMLY_HPRTS_PATIEN_YN' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'FMLY_APOP_PATIEN_YN' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'FMLY_HDISE_PATIEN_YN' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'FMLY_DIABML_PATIEN_YN' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'FMLY_CANCER_PATIEN_YN' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'SMK_STAT_TYPE_RSPS_CD' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'SMK_TERM_RSPS_CD' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'DSQTY_RSPS_CD' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'DRNK_HABIT_RSPS_CD' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'TM1_DRKQTY_RSPS_CD' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'EXERCI_FREQ_RSPS_CD' then cast(concat(c.master_seq, b.id_value) as number)
					end as observation_id,
			a.person_id as person_id,
			b.observation_concept_id as observation_concept_id,
			cast(TO_CHAR(a.hchk_year+'0101', 23) as date) as observation_date,
		 null,
			b.observation_type_concept_id as observation_type_concept_id,
				CASE WHEN b.answer is not null
				then b.value_as_number
				else a.meas_value
				END as value_as_number,
		 null,
			b.value_as_concept_id as value_as_concept_id,
		 null,
		 null,
		 null,
		 c.master_seq,
			a.meas_value as observation_source_value,
		 null,
		 null,
		 null oservation_time, value_as_string, qualifier_source_value, unit_concept_id, provider_id, visit_occurrence_id, observation_source_concept_id, unit_source_value, qualifier_source_Value

	from (select hchk_year, person_id, ykiho_gubun_cd, meas_type, 
				--가족력(FMLY_로 시작하는 변수)  유무 변수 08년까진 1, 2로 기록, 09년부터는 0, 1로 기록 고려
				case	when substr(meas_type, 1, 30) in('FMLY_LIVER_DISE_PATIEN_YN', 'FMLY_HPRTS_PATIEN_YN', 'FMLY_APOP_PATIEN_YN', 'FMLY_HDISE_PATIEN_YN', 'FMLY_DIABML_PATIEN_YN', 'FMLY_CANCER_PATIEN_YN') 
							and substr(hchk_year, 1, 4) in ('2002', '2003', '2004', '2005', '2006', '2007', '2008') then to_char(cast(meas_value as number)-1)
				else meas_value
				end as meas_value 			
			from big_data.NHIS_GJ_vertical) a
		JOIN observation_mapping b 
		on NVL(a.meas_type,'') = nvl(b.meas_type,'') 
			and nvl(a.meas_value,'0') = nvl(cast(b.answer as char),'0')
		JOIN cohort_cdm.SEQ_MASTER c
		on a.person_id = cast(c.person_id as char)
			and a.hchk_year = c.hchk_year
	where (a.meas_value != '' and substr(a.meas_type, 1, 30) in ('HCHK_PMH_CD1', 'HCHK_PMH_CD2', 'HCHK_PMH_CD3','HCHK_APOP_PMH_YN', 'HCHK_HDISE_PMH_YN', 'HCHK_HPRTS_PMH_YN', 
																	'HCHK_DIABML_PMH_YN', 'HCHK_HPLPDM_PMH_YN', 'HCHK_ETCDSE_PMH_YN', 'HCHK_PHSS_PMH_YN', 'FMLY_LIVER_DISE_PATIEN_YN', 'FMLY_HPRTS_PATIEN_YN', 
																	'FMLY_APOP_PATIEN_YN', 'FMLY_HDISE_PATIEN_YN', 'FMLY_DIABML_PATIEN_YN', 'FMLY_CANCER_PATIEN_YN', 'SMK_STAT_TYPE_RSPS_CD', 'SMK_TERM_RSPS_CD',
																	 'DSQTY_RSPS_CD', 'EXERCI_FREQ_RSPS_CD')
		or(a.meas_value != '' and substr(a.meas_type, 1, 30) in ('DRNK_HABIT_RSPS_CD', 'TM1_DRKQTY_RSPS_CD') and substr(a.hchk_year, 1, 4) in ('2002', '2003', '2004', '2005', '2006', '2007', '2008')))
			and c.source_table like 'GJT'
;



/**************************************
 2. 수치형 데이터 입력 (4468917개 행이 영향을 받음)
***************************************/ 
INSERT INTO cohort_cdm.OBSERVATION(observation_id, person_id, observation_concept_id, observation_date, observation_time, observation_type_concept_id, value_as_number, value_As_string, value_as_concept_id,
										qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value)

	select	case	when a.meas_type = 'CUR_SMK_TERM_RSPS_CD' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'CUR_DSQTY_RSPS_CD' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'PAST_SMK_TERM_RSPS_CD' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'PAST_DSQTY_RSPS_CD' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'MOV20_WEK_FREQ_ID' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'MOV30_WEK_FREQ_ID' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'WLK30_WEK_FREQ_ID' then cast(concat(c.master_seq, b.id_value) as number)
					end as observation_id,
			a.person_id as person_id,
			b.observation_concept_id as observation_concept_id,
			cast(TO_CHAR (a.hchk_year+'0101', 23)as date) as observation_date,
		 null,
			b.observation_type_concept_id as observation_type_concept_id,
				CASE WHEN b.answer is not null
				then b.value_as_number
				else a.meas_value
				END as value_as_number,
		 null,
			b.value_as_concept_id as value_as_concept_id,
		 null,
			b.observation_unit_concept_id as unit_concept_id ,
		 null,
		 c.master_seq,
			a.meas_value as observation_source_value,
		 null,
		 null,
		 null into oservation_time, value_as_string, qualifier_source_value, provider_id, visit_occurrence_id, observation_source_concept_id, unit_source_value, qualifier_source_Value

	from (select hchk_year, person_id, ykiho_gubun_cd, meas_type, meas_value
			from cohort_cdm.NHIS_GJ_vertical) a
		JOINobservation_mapping b 
		on nvl(a.meas_type,'') = nvl(b.meas_type,'') 
			and nvl(a.meas_value,'0') >= nvl(cast(b.answer as char),'0')
		JOIN cohort_cdm.SEQ_MASTER c
		on a.person_id = cast(c.person_id as char)
			and a.hchk_year = c.hchk_year
	where (a.meas_value != '' and substr(a.meas_type, 1, 30) in ('CUR_SMK_TERM_RSPS_CD', 'CUR_DSQTY_RSPS_CD', 'PAST_SMK_TERM_RSPS_CD', 'PAST_DSQTY_RSPS_CD', 
																	'MOV20_WEK_FREQ_ID', 'MOV30_WEK_FREQ_ID', 'WLK30_WEK_FREQ_ID'))
			and c.source_table like 'GJT'
;


/**************************************
 2. 09년부터 응답이 바뀌는 음주 수치 입력 (693930개 행이 영향을 받음)
***************************************/ 
--temp mapping table



CREATE TABLE observation_mapping09
    (
     meas_type						varchar2(50) NULL , 
     id_value						varchar2(50) NULL ,
     answer							number NULL ,
     observation_concept_id			number NULL ,
	 observation_type_concept_id	number NULL ,
	 observation_unit_concept_id	number NULL ,
	 value_as_concept_id			number NULL ,
	 value_as_number				binary_double NULL 
	)
;
INSERT INTO cohort_cdm.observation_mapping09
-- insert mapping data
SELECT 'DRNK_HABIT_RSPS_CD',	'43',	1,		40771103,		44818704,	45881908,		NULL,		0 FROM dual UNION ALL 
SELECT 'DRNK_HABIT_RSPS_CD',	'43',	2,		40771103,		44818704,	45881908,		NULL,		1 FROM dual UNION ALL 
SELECT 'DRNK_HABIT_RSPS_CD',	'43',	3,		40771103,		44818704,	45881908,		NULL,		2 FROM dual UNION ALL 
SELECT 'DRNK_HABIT_RSPS_CD',	'43',	4,		40771103,		44818704,	45881908,		NULL,		3 FROM dual UNION ALL 
SELECT 'DRNK_HABIT_RSPS_CD',	'43',	5,		40771103,		44818704,	45881908,		NULL,		4 FROM dual UNION ALL 
SELECT 'DRNK_HABIT_RSPS_CD',	'43',	6,		40771103,		44818704,	45881908,		NULL,		5 FROM dual UNION ALL 
SELECT 'DRNK_HABIT_RSPS_CD',	'43',	7,		40771103,		44818704,	45881908,		NULL,		6 FROM dual UNION ALL 
SELECT 'DRNK_HABIT_RSPS_CD',	'43',	8,		40771103,		44818704,	45881908,		NULL,		7 FROM dual UNION ALL 
SELECT 'TM1_DRKQTY_RSPS_CD',	'44',	0,		3037705,		44818704,	4045131,		NULL,		NULL FROM dual



INSERT INTO cohort_cdm.OBSERVATION (observation_id, person_id, observation_concept_id, observation_date, observation_time, observation_type_concept_id, value_as_number, value_As_string, value_as_concept_id,
										qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value)

select	case	when a.meas_type = 'TM1_DRKQTY_RSPS_CD' then cast(concat(c.master_seq, b.id_value) as number)
				end as observation_id,
			a.person_id as person_id,
			b.observation_concept_id as observation_concept_id,
			cast(TO_CHAR (a.hchk_year+'0101', 23)as date) as observation_date,
		 null,
			b.observation_type_concept_id as observation_type_concept_id,
				CASE WHEN b.answer is not null
				then b.value_as_number
				else a.meas_value
				END as value_as_number,
		 null,
			b.value_as_concept_id as value_as_concept_id,
		 null,
			b.observation_unit_concept_id as unit_concept_id ,
		 null,
		 c.master_seq,
			a.meas_value as observation_source_value,
		 null,
		 null,
		 null into oservation_time, value_as_string, qualifier_source_value, provider_id, visit_occurrence_id, observation_source_concept_id, unit_source_value, qualifier_source_Value

	from (select hchk_year, person_id, ykiho_gubun_cd, meas_type, meas_value
			from cohort_cdm.NHIS_GJ_vertical) a
		JOINobservation_mapping09 b 
		on nvl(a.meas_type,'') = nvl(b.meas_type,'') 
			and nvl(a.meas_value,'0') >= nvl(cast(b.answer as char),'0')
		JOIN cohort_cdm.SEQ_MASTER c
		on a.person_id = cast(c.person_id as char)
			and a.hchk_year = c.hchk_year
	where (a.meas_value != '' and substr(a.meas_type, 1, 30) in ('TM1_DRKQTY_RSPS_CD') and substr(a.hchk_year, 1, 4) in ('2009', '2010', '2011', '2012', '2013'))
			and c.source_table like 'GJT'
;

/**************************************
 2. 09년부터 응답이 바뀌는 음주 코드 입력 (1147565개 행이 영향을 받음)
***************************************/ 
--temp mapping table



INSERT INTO OBSERVATION cohort_cdm(observation_id, person_id, observation_concept_id, observation_date, observation_time, observation_type_concept_id, value_as_number, value_As_string, value_as_concept_id,
										qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value)

	select	case	when a.meas_type = 'DRNK_HABIT_RSPS_CD' then cast(concat(c.master_seq, b.id_value) as number)
					end as observation_id,
			a.person_id as person_id,
			b.observation_concept_id as observation_concept_id,
			cast(TO_CHAR (a.hchk_year+'0101', 23)as date) as observation_date,
		 null,
			b.observation_type_concept_id as observation_type_concept_id,
				CASE WHEN b.answer is not null
				then b.value_as_number
				else a.meas_value
				END as value_as_number,
		 null,
			b.value_as_concept_id as value_as_concept_id,
		 null,
			b.observation_unit_concept_id as unit_concept_id ,
		 null,
		 c.master_seq,
			a.meas_value as observation_source_value,
		 null,
		 null,
		 null into oservation_time, value_as_string, qualifier_source_value, provider_id, visit_occurrence_id, observation_source_concept_id, unit_source_value, qualifier_source_Value

	from (select hchk_year, person_id, ykiho_gubun_cd, meas_type, meas_value
			from cohort_cdm.NHIS_GJ_vertical) a
		JOIN observation_mapping09 b 
		on nvl(a.meas_type,'') = nvl(b.meas_type,'') 
			and nvl(a.meas_value,'0') = nvl(cast(b.answer as char),'0')
		JOIN cohort_cdm.SEQ_MASTER c
		on a.person_id = cast(c.person_id as char)
			and a.hchk_year = c.hchk_year
	where (a.meas_value != '' and substr(a.meas_type, 1, 30) in ('DRNK_HABIT_RSPS_CD') and substr(a.hchk_year, 1, 4) in ('2009', '2010', '2011', '2012', '2013'))
			and c.source_table like 'GJT'
;



/**************************************
 2. 소득분위 데이터 입력 (11716257개 행이 영향을 받음)
***************************************/ 
INSERT INTO cohort_cdm.OBSERVATION (observation_id, person_id, observation_concept_id, observation_date, observation_time, observation_type_concept_id, value_as_number, value_As_string, value_as_concept_id,
										qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value)

	


	select	row_number() OVER(order by a.person_id asc) as observation_id,
			a.person_id as person_id,
			b.observation_concept_id as observation_concept_id,
			cast(TO_CHAR (a.STND_Y+'0101', 23)as date) as observation_date,
		 null,
			b.observation_type_concept_id as observation_type_concept_id,
				CASE WHEN b.answer is not null
				then b.value_as_number
				else a.CTRB_PT_TYPE_CD
				END as value_as_number,
		 null,
			b.value_as_concept_id as value_as_concept_id,
		 null,
			b.observation_unit_concept_id as unit_concept_id,
		 null,
		 null ,
			a.CTRB_PT_TYPE_CD as observation_source_value,
		 null,
		 null,
		 null into oservation_time, value_as_string, qualifier_source_value, provider_id, visit_occurrence_id, observation_source_concept_id, unit_source_value, qualifier_source_Value

	from (select STND_Y, PERSON_ID, CTRB_PT_TYPE_CD from bigdata.NHIS_20T) a
		JOIN observation_mapping b 
		on nvl(a.CTRB_PT_TYPE_CD,'') = nvl(b.answer,'') 
	where a.CTRB_PT_TYPE_CD != '' and b.meas_type = 'CTRB_PT_TYPE_CD'
;




/*****************************************************
					테이블 확인
*****************************************************/

--------------변환전 건수
select distinct meas_type, count(meas_type)
from cohort_cdm.NHIS_GJ_vertical
where meas_value != ''  and substr(meas_type, 1, 30) in ('HCHK_PMH_CD1', 'HCHK_PMH_CD2', 'HCHK_PMH_CD3','HCHK_APOP_PMH_YN', 'HCHK_HDISE_PMH_YN', 'HCHK_HPRTS_PMH_YN', 
																	'HCHK_DIABML_PMH_YN', 'HCHK_HPLPDM_PMH_YN', 'HCHK_ETCDSE_PMH_YN', 'HCHK_PHSS_PMH_YN', 'FMLY_LIVER_DISE_PATIEN_YN', 'FMLY_HPRTS_PATIEN_YN', 
																	'FMLY_APOP_PATIEN_YN', 'FMLY_HDISE_PATIEN_YN', 'FMLY_DIABML_PATIEN_YN', 'FMLY_CANCER_PATIEN_YN', 'SMK_STAT_TYPE_RSPS_CD', 'SMK_TERM_RSPS_CD', 
																	'DSQTY_RSPS_CD', 'DRNK_HABIT_RSPS_CD', 'TM1_DRKQTY_RSPS_CD', 'EXERCI_FREQ_RSPS_CD', 'CUR_SMK_TERM_RSPS_CD', 'CUR_DSQTY_RSPS_CD', 'PAST_SMK_TERM_RSPS_CD', 'PAST_DSQTY_RSPS_CD', 
																	'MOV20_WEK_FREQ_ID', 'MOV30_WEK_FREQ_ID', 'WLK30_WEK_FREQ_ID')
group by meas_type 
order by meas_type 