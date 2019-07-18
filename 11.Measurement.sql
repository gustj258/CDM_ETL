/**************************************
 --encoding : UTF-8
 --Author: 유승찬
 --Date: 2017.09.26
 
 bigdata : DB containing NHIS National Sample cohort DB
 NHIS_JK: JK table in NHIS NSC
 NHIS_20T: 20 table in NHIS NSC
 NHIS_30T: 30 table in NHIS NSC
 NHIS_40T: 40 table in NHIS NSC
 NHIS_60T: 60 table in NHIS NSC
 NHIS_GJ: GJ table in NHIS NSC
 --Description: MEASUREMENT 테이블 생성				
 --생성 Table: MEASUREMENT
***************************************/

/**************************************
 0. 테이블 생성  (33440451)
***************************************/ 


IF OBJECT_ID('cohort_cdm.MEASUREMENT', 'U') IS NULL
CREATE TABLE cohort_cdm.MEASUREMENT
    (
     measurement_id						NUMBER NOT NULL , 
     person_id							NUMBER NOT NULL ,
     measurement_concept_id				NUMBER NOT NULL ,
     measurement_date					DATE	NOT NULL ,
     measurement_time					TIMESTAMP NULL,  
     measurement_type_concept_id		number NULL,  
	 operator_concept_id				number NULL,  
	 value_as_number					binary_double NULL,
	 value_as_concept_id				number NULL,
	 unit_concept_id					number NULL,
	 range_low							binary_double NULL,
	 range_high							binary_double NULL,
	 provider_id						number NULL,
	 visit_occurrence_id				number NULL,
	 measurement_source_value			VARCHAR2(50) NULL,
	 measurement_source_concept_id		number NULL,
	 unit_source_value					VARCHAR2(50) NULL,
	 value_source_value					VARCHAR2(50)	 NULL
	);


-- measurement mapping table(temp)

CREATE TABLE measurement_mapping
    (
     meas_type						varchar2(50) NULL , 
     id_value						varchar2(50) NULL ,
     answer							number NULL ,
     measurement_concept_id			number NULL ,
	 measurement_type_concept_id	number NULL ,
	 measurement_unit_concept_id	number NULL ,
	 value_as_concept_id			number NULL ,
	 value_as_number				binary_double NULL 
	)
;

	INSERT INTO cohort_cdm.measurement_mapping
-- insert mapping data
select'HEIGHT',			'01',	0,	3036277,	44818701,	4122378,	NULL,		NULL FROM dual UNION ALL
select'WEIGHT',			'02',	0,	3025315,	44818701,	4122383,	NULL,		NULL FROM dual UNION ALL
select'WAIST',				'03',	0,	3016258,	44818701,	4122378,	NULL,		NULL FROM dual UNION ALL
select'BP_HIGH',			'04',	0,	3028737,	44818701,	4118323,	NULL,		NULL FROM dual UNION ALL
select'BP_LWST',			'05',	0,	3012888,	44818701,	4118323,	NULL,		NULL FROM dual UNION ALL
select'BLDS',				'06',	0,	46235168,	44818702,	4121396,	NULL,		NULL FROM dual UNION ALL
select'TOT_CHOLE',			'07',	0,	3027114,	44818702,	4121396,	NULL,		NULL FROM dual UNION ALL
select'TRIGLYCERIDE',		'08',	0,	3022038,	44818702,	4121396,	NULL,		NULL FROM dual UNION ALL
select'HDL_CHOLE',			'09',	0,	3023752,	44818702,	4121396,	NULL,		NULL FROM dual UNION ALL
select'LDL_CHOLE',			'10',	0,	3028437,	44818702,	4121396,	NULL,		NULL FROM dual UNION ALL
select'HMG',				'11',	0,	3000963,	44818702,	4121395,	NULL,		NULL FROM dual UNION ALL
select'GLY_CD',			'12',	1,	3009261,	44818702,	NULL,		9189,		NULL FROM dual UNION ALL
select'GLY_CD',			'12',	2,	3009261,	44818702,	NULL,		4127785,	NULL FROM dual UNION ALL
select'GLY_CD',			'12',	3,	3009261,	44818702,	NULL,		4123508,	NULL FROM dual UNION ALL
select'GLY_CD',			'12',	4,	3009261,	44818702,	NULL,		4126673,	NULL FROM dual UNION ALL
select'GLY_CD',			'12',	5,	3009261,	44818702,	NULL,		4125547,	NULL FROM dual UNION ALL
select'GLY_CD',			'12',	6,	3009261,	44818702,	NULL,		4126674,	NULL FROM dual UNION ALL
select'OLIG_OCCU_CD',		'13',	1,	437038,		44818702,	NULL,		9189,		NULL FROM dual UNION ALL
select'OLIG_OCCU_CD',		'13',	2,	437038,		44818702,	NULL,		4127785,	NULL FROM dual UNION ALL
select'OLIG_OCCU_CD',		'13',	3,	437038,		44818702,	NULL,		4123508,	NULL FROM dual UNION ALL
select'OLIG_OCCU_CD',		'13',	4,	437038,		44818702,	NULL,		4126673,	NULL FROM dual UNION ALL
select'OLIG_OCCU_CD',		'13',	5,	437038,		44818702,	NULL,		4125547,	NULL FROM dual UNION ALL
select'OLIG_OCCU_CD',		'13',	6,	437038,		44818702,	NULL,		4126674,	NULL FROM dual UNION ALL
select'OLIG_PH',			'14',	0,	3015736,	44818702,	8482,		NULL,		NULL FROM dual UNION ALL
select'OLIG_PROTE_CD',		'15',	1,	3014051,	44818702,	NULL,		9189,		NULL FROM dual UNION ALL
select'OLIG_PROTE_CD',		'15',	2,	3014051,	44818702,	NULL,		4127785,	NULL FROM dual UNION ALL
select'OLIG_PROTE_CD',		'15',	3,	3014051,	44818702,	NULL,		4123508,	NULL FROM dual UNION ALL
select'OLIG_PROTE_CD',		'15',	4,	3014051,	44818702,	NULL,		4126673,	NULL FROM dual UNION ALL
select'OLIG_PROTE_CD',		'15',	5,	3014051,	44818702,	NULL,		4125547,	NULL FROM dual UNION ALL
select'OLIG_PROTE_CD',		'15',	6,	3014051,	44818702,	NULL,		4126674,	NULL FROM dual UNION ALL
select'CREATININE',		'16',	0,	2212294,	44818702,	4121396,	NULL,		NULL FROM dual UNION ALL
select'SGOT_AST',			'17',	0,	2212597,	44818702,	4118000,	NULL,		NULL FROM dual UNION ALL
select'SGPT_ALT',			'18',	0,	2212598,	44818702,	4118000,	NULL,		NULL FROM dual UNION ALL
select'GAMMA_GTP',			'19',	0,	4289475,	44818702,	4118000,	NULL,		NULL FROM dual 																							
																																																																					

/**************************************																																							   
 1. 행을 열로 전환
***************************************/ 
select hchk_year, person_id, ykiho_gubun_cd, meas_type, meas_value into cohort_cdm.GJ_VERTICAL
from bigdata.NHIS_GJ
unpivot (meas_value for meas_type in ( -- 47 검진 항목
	height, weight, waist, bp_high, bp_lwst,
	blds, tot_chole, triglyceride, hdl_chole, ldl_chole,
	hmg, gly_cd, olig_occu_cd, olig_ph, olig_prote_cd,
	creatinine, sgot_ast, sgpt_alt, gamma_gtp, hchk_pmh_cd1,
	hchk_pmh_cd2, hchk_pmh_cd3, hchk_apop_pmh_yn, hchk_hdise_pmh_yn, hchk_hprts_pmh_yn,
	hchk_diabml_pmh_yn, hchk_hplpdm_pmh_yn, hchk_etcdse_pmh_yn, hchk_phss_pmh_yn, fmly_liver_dise_patien_yn, 
	fmly_hprts_patien_yn, fmly_apop_patien_yn, fmly_hdise_patien_yn, fmly_diabml_patien_yn, fmly_cancer_patien_yn, 
	smk_stat_type_rsps_cd, smk_term_rsps_cd, cur_smk_term_rsps_cd, cur_dsqty_rsps_cd, past_smk_term_rsps_cd, 
	past_dsqty_rsps_cd, dsqty_rsps_cd, drnk_habit_rsps_Cd, tm1_drkqty_rsps_cd, exerci_freq_rsps_cd, 
	mov20_wek_freq_id, mov30_wek_freq_id, wlk30_wek_freq_id
)) as unpivortn





/**************************************
 2. 수치형 데이터 입력  
***************************************/ 
INSERT INTO cohort_cdm.MEASUREMENT (measurement_id, person_id, measurement_concept_id, measurement_date, measurement_time, measurement_type_concept_id, operator_concept_id, value_as_number, value_as_concept_id,			
											unit_concept_id, range_low, range_high, provider_id, visit_occurrence_id, measurement_source_value, measurement_source_concept_id, unit_source_value, value_source_value)


	select	case	when a.meas_type = 'HEIGHT' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'WEIGHT' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'WAIST' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'BP_HIGH' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'BP_LWST' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'BLDS' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'TOT_CHOLE' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'TRIGLYCERIDE' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'HDL_CHOLE' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'LDL_CHOLE' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'HMG' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'OLIG_PH' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'CREATININE' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'SGOT_AST' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'SGPT_ALT' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'GAMMA_GTP' then cast(concat(c.master_seq, b.id_value) as number)
					end as measurement_id,
			a.person_id as person_id,
			b.measurement_concept_id as measurement_concept_id,
			cast(TO_CHAR (a.hchk_year+'0101', 23)as date) as measurement_date,
		 null,
			b.measurement_type_concept_id as measurement_type_concept_id,
		 null,
			b.value_as_number as value_as_number,
			b.value_as_concept_id as value_as_concept_id,
			b.measurement_unit_concept_id as unit_concept_id ,
		 null,
		 null,
		 null,
			c.master_seq as visit_occurrence_id,
			a.meas_value as measurement_source_value,
		null,
		 null,
			a.meas_value as value_source_value into measurement_time, operator_concept_id, range_low, range_high, provider_id, measurement_source_concept_id, unit_source_value

	from (select hchk_year, person_id, ykiho_gubun_cd, meas_type, meas_value 			
			from cohort_cdm.GJ_VERTICAL) a
		JOIN #measurement_mapping b 
		on nvl(a.meas_type,'') = nvl(b.meas_type,'') 
			and nvl(a.meas_value,'0') >= nvl(cast(b.answer as char),'0')
		JOIN cohort_cdm.SEQ_MASTER c
		on a.person_id = cast(c.person_id as char)
			and a.hchk_year = c.hchk_year
	where (a.meas_value != '' and substr(a.meas_type, 1, 30) in ('HEIGHT', 'WEIGHT',	'WAIST', 'BP_HIGH', 'BP_LWST', 'BLDS', 'TOT_CHOLE', 'TRIGLYCERIDE',	'HDL_CHOLE',		
																	'LDL_CHOLE', 'HMG', 'OLIG_PH', 'CREATININE', 'SGOT_AST', 'SGPT_ALT', 'GAMMA_GTP')
			and c.source_table like 'GJT')
;

	

/**************************************
 2. 코드형 데이터 입력  
***************************************/ 
INSERT INTO cohort_cdm.MEASUREMENT (measurement_id, person_id, measurement_concept_id, measurement_date, measurement_time, measurement_type_concept_id, operator_concept_id, value_as_number, value_as_concept_id,			
											unit_concept_id, range_low, range_high, provider_id, visit_occurrence_id, measurement_source_value, measurement_source_concept_id, unit_source_value, value_source_value)


	select	case	when a.meas_type = 'GLY_CD' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'OLIG_OCCU_CD' then cast(concat(c.master_seq, b.id_value) as number)
					when a.meas_type = 'OLIG_PROTE_CD' then cast(concat(c.master_seq, b.id_value) as number)
					end as measurement_id,
			a.person_id as person_id,
			b.measurement_concept_id as measurement_concept_id,
			cast(TO_CHAR (a.hchk_year+'0101', 23)as date) as measurement_date,
		 null,
			b.measurement_type_concept_id as measurement_type_concept_id,
		 null,
			b.value_as_number as value_as_number,
			b.value_as_concept_id as value_as_concept_id,
			b.measurement_unit_concept_id as unit_concept_id ,
		 null,
		 null,
		 null,
			c.master_seq as visit_occurrence_id,
			a.meas_value as measurement_source_value,
		null,
		 null,
			a.meas_value as value_source_value into measurement_time, operator_concept_id, range_low, range_high, provider_id, measurement_source_concept_id, unit_source_value

	from (select hchk_year, person_id, ykiho_gubun_cd, meas_type, meas_value 			
			from cohort_cdm.GJ_VERTICAL) a
		JOIN #measurement_mapping b 
		on nvl(a.meas_type,'') = nvl(b.meas_type,'') 
			and nvl(a.meas_value,'0') = nvl(cast(b.answer as char),'0')
		JOIN cohort_cdm.SEQ_MASTER c
		on a.person_id = cast(c.person_id as char)
			and a.hchk_year = c.hchk_year
	where (a.meas_value != '' and substr(a.meas_type, 1, 30) in ('GLY_CD', 'OLIG_OCCU_CD', 'OLIG_PROTE_CD')
			and c.source_table like 'GJT')
;

/**************************************
 3.source_value의 값을 value_as_number에도 입력
***************************************/ 
UPDATE cohort_cdm.MEASUREMENT
SET value_as_number = measurement_source_value
where measurement_source_value is not null