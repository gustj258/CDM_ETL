/**************************************
 --encoding : UTF-8
 --Author: 이성원
 --Date: 2017.02.08
 
@bigdata : DB containing NHIS National Sample cohort DB
@cohort_cdm : DB for NHIS-NSC in CDM format
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
 
 --Description: Cost 테이블 생성
 --Generating Table: COST
***************************************/

/**************************************
 1. 테이블 생성
***************************************/ 
CREATE TABLE cohort_cdm.COST (
	cost_id	number
    CONSTRAINT COST_device_cost_id PRIMARY KEY,
	cost_event_id	 number not null,
	cost_domain_id	varchar2(20) not null,
	cost_type_concept_id	number not null,
	currency_concept_id	number,
	total_charge	binary_double,
	total_cost	binary_double,
	total_paid	binary_double,
	paid_by_payer	binary_double,
	paid_by_patient	binary_double,
	paid_patient_copay	binary_double,
	paid_patient_coinsurance	binary_double,
	paid_patient_deductiable	binary_double,
	paid_by_primary	binary_double,
	paid_ingredient_cost	binary_double,
	paid_dispensing_fee	binary_double,
	payer_plan_period_id	number,
	amount_allowed	binary_double,
	revenue_code_concept_id	number,
	drg_concept_id	number,
	revenue_code_source_value	varchar2(50),
	drg_source_value	varchar2(50)
);

/**************************************
 2. 데이터 입력
    1) Visit
	2) Drug
	3) Procedure
	4) Device
***************************************/ 

---------------------------------------------------
-- 1) Visit
---------------------------------------------------
INSERT INTO cohort_cdm.COST
	(cost_id, cost_event_id, cost_domain_id, cost_type_concept_id, currency_concept_id,
	total_charge, total_cost, total_paid, paid_by_payer, paid_by_patient,
	paid_patient_copay, paid_patient_coinsurance, paid_patient_deductiable, paid_by_primary, paid_ingredient_cost,
	paid_dispensing_fee, payer_plan_period_id, amount_allowed, revenue_code_concept_id, drg_concept_id,
	revenue_code_source_value, drg_source_value)
SELECT 
	a.visit_occurrence_id as cost_id,
	a.visit_occurrence_id as cost_event_id,
	'Visit' as cost_domain_id,
	5031 as cost_type_concept_id,
	44818598 as currency_concept_id,
	b.dmd_tramt as total_charge,
	null as total_cost,
	b.edec_tramt as total_paid,
	b.edec_jbrdn_amt as paid_by_payer,
	b.edec_sbrdn_amt as paid_by_patient,
	null as paid_patient_copay,
	null as paid_patient_coinsurance, 
	null as paid_patient_deductiable,
	null as paid_by_primary,
	null as paid_ingredient_cost,
	null as paid_dispensing_fee,
	convert(bigint, to_char (a.person_id) + substr(to_char (visit_start_date, 112), 1, 4)) FROM dual as payer_plan_period_id,
	null as amount_allowed,
	null as revenue_code_concept_id,
	null as drg_concept_id,
	null as revenue_code_source_value,
	b.dmd_drg_no as drg_source_value
from visit_occurrence a, bigdata.NHIS_20T b
where a.visit_occurrence_id=b.key_seq
and a.person_id=b.person_id;



---------------------------------------------------
-- 2) Drug
---------------------------------------------------

-- 원본 테이블이 30T인 경우
INSERT INTO COST
	(cost_id, cost_event_id, cost_domain_id, cost_type_concept_id, currency_concept_id,
	total_charge, total_cost, total_paid, paid_by_payer, paid_by_patient,
	paid_patient_copay, paid_patient_coinsurance, paid_patient_deductiable, paid_by_primary, paid_ingredient_cost,
	paid_dispensing_fee, payer_plan_period_id, amount_allowed, revenue_code_concept_id, drg_concept_id,
	revenue_code_source_value, drg_source_value)
SELECT 
	a.drug_exposure_id as cost_id,
	a.drug_exposure_id as cost_event_id,
	'Drug' as cost_domain_id,
	5031 as cost_type_concept_id,
	44818598 as currency_concept_id,
	null as total_charge,
	b.amt as total_cost,
	null as total_paid,
	null as paid_by_payer,
	null as paid_by_patient,
	null as paid_patient_copay,
	null as paid_patient_coinsurance, 
	null as paid_patient_deductiable,
	null as paid_by_primary,
	null as paid_ingredient_cost,
	null as paid_dispensing_fee,
	convert(bigint, to_char (b.person_id) + substr(to_char (a.drug_exposure_start_date, 112), 1, 4)) FROM dual as payer_plan_period_id,
	null as amount_allowed,
	null as revenue_code_concept_id,
	null as drg_concept_id,
	null as revenue_code_source_value,
	null as drg_source_value
from (select person_id, drug_exposure_id, drug_exposure_start_date
	from drug_exposure
	where drug_type_concept_id=38000180) a, 
	(select m.master_seq, m.key_seq, m.seq_no, m.person_id, n.amt
	from seq_master m, bigdata.NHIS_30T n
	where m.source_table='130'
	and m.key_seq=n.key_seq
	and m.seq_no=n.seq_no) b
where substr(a.drug_exposure_id, 1, 10)=b.master_seq
and a.person_id=b.person_id;


-- 원본 테이블이 60T인 경우
INSERT INTO COST
	(cost_id, cost_event_id, cost_domain_id, cost_type_concept_id, currency_concept_id,
	total_charge, total_cost, total_paid, paid_by_payer, paid_by_patient,
	paid_patient_copay, paid_patient_coinsurance, paid_patient_deductiable, paid_by_primary, paid_ingredient_cost,
	paid_dispensing_fee, payer_plan_period_id, amount_allowed, revenue_code_concept_id, drg_concept_id,
	revenue_code_source_value, drg_source_value)
SELECT 
	a.drug_exposure_id as cost_id,
	a.drug_exposure_id as cost_event_id,
	'Drug' as cost_domain_id,
	5031 as cost_type_concept_id,
	44818598 as currency_concept_id,
	null as total_charge,
	b.amt as total_cost,
	null as total_paid,
	null as paid_by_payer,
	null as paid_by_patient,
	null as paid_patient_copay,
	null as paid_patient_coinsurance, 
	null as paid_patient_deductiable,
	null as paid_by_primary,
	null as paid_ingredient_cost,
	null as paid_dispensing_fee,
	convert(bigint, to_char (b.person_id) + substr(to_char (a.drug_exposure_start_date, 112), 1, 4)) FROM dual as payer_plan_period_id,
	null as amount_allowed,
	null as revenue_code_concept_id,
	null as drg_concept_id,
	null as revenue_code_source_value,
	null as drg_source_value
from (select person_id, drug_exposure_id, drug_exposure_start_date
	from drug_exposure
	where drug_type_concept_id=38000177) a, 
	(select m.master_seq, m.key_seq, m.seq_no, m.person_id, n.amt
	from (select master_seq, key_seq, seq_no, person_id from seq_master where source_table='160') m, 
	bigdata.NHIS_60T n
	where m.key_seq=n.key_seq
	and m.seq_no=n.seq_no) b
where b.master_seq=substr(a.drug_exposure_id, 1, 10)
and a.person_id=b.person_id;


---------------------------------------------------
-- 3) Procedure
---------------------------------------------------

-- 원본 테이블이 30T인 경우
INSERT INTO COST
	(cost_id, cost_event_id, cost_domain_id, cost_type_concept_id, currency_concept_id,
	total_charge, total_cost, total_paid, paid_by_payer, paid_by_patient,
	paid_patient_copay, paid_patient_coinsurance, paid_patient_deductiable, paid_by_primary, paid_ingredient_cost,
	paid_dispensing_fee, payer_plan_period_id, amount_allowed, revenue_code_concept_id, drg_concept_id,
	revenue_code_source_value, drg_source_value)
SELECT 
	a.procedure_occurrence_id as cost_id,
	a.procedure_occurrence_id as cost_event_id,
	'Procedure' as cost_domain_id,
	5031 as cost_type_concept_id,
	44818598 as currency_concept_id,
	null as total_charge,
	b.amt as total_cost,
	null as total_paid,
	null as paid_by_payer,
	null as paid_by_patient,
	null as paid_patient_copay,
	null as paid_patient_coinsurance, 
	null as paid_patient_deductiable,
	null as paid_by_primary,
	null as paid_ingredient_cost,
	null as paid_dispensing_fee,
	convert(bigint, to_char (b.person_id) + substr(to_char (a.procedure_date, 112), 1, 4)) FROM dual as payer_plan_period_id,
	null as amount_allowed,
	null as revenue_code_concept_id,
	null as drg_concept_id,
	null as revenue_code_source_value,
	null as drg_source_value
from procedure_occurrence a, 
	(select m.master_seq, m.key_seq, m.seq_no, m.person_id, n.amt
	from seq_master m, bigdata.NHIS_30T n
	where m.source_table='130'
	and m.key_seq=n.key_seq
	and m.seq_no=n.seq_no) b
where substr(a.procedure_occurrence_id, 1, 10)=b.master_seq
and a.person_id=b.person_id;


-- 원본 테이블이 60T인 경우
INSERT INTO COST
	(cost_id, cost_event_id, cost_domain_id, cost_type_concept_id, currency_concept_id,
	total_charge, total_cost, total_paid, paid_by_payer, paid_by_patient,
	paid_patient_copay, paid_patient_coinsurance, paid_patient_deductiable, paid_by_primary, paid_ingredient_cost,
	paid_dispensing_fee, payer_plan_period_id, amount_allowed, revenue_code_concept_id, drg_concept_id,
	revenue_code_source_value, drg_source_value)
SELECT 
	a.procedure_occurrence_id as cost_id,
	a.procedure_occurrence_id as cost_event_id,
	'Procedure' as cost_domain_id,
	5031 as cost_type_concept_id,
	44818598 as currency_concept_id,
	null as total_charge,
	b.amt as total_cost,
	null as total_paid,
	null as paid_by_payer,
	null as paid_by_patient,
	null as paid_patient_copay,
	null as paid_patient_coinsurance, 
	null as paid_patient_deductiable,
	null as paid_by_primary,
	null as paid_ingredient_cost,
	null as paid_dispensing_fee,
	convert(bigint, to_char (b.person_id) + substr(to_char (a.procedure_date, 112), 1, 4)) FROM dual as payer_plan_period_id,
	null as amount_allowed,
	null as revenue_code_concept_id,
	null as drg_concept_id,
	null as revenue_code_source_value,
	null as drg_source_value
from procedure_occurrence a, 
	(select m.master_seq, m.key_seq, m.seq_no, m.person_id, n.amt
	from (select master_seq, key_seq, seq_no, person_id from seq_master where source_table='160') m, 
	bigdata.NHIS_60T n
	where m.key_seq=n.key_seq
	and m.seq_no=n.seq_no) b
where substr(a.procedure_occurrence_id, 1, 10)=b.master_seq
and a.person_id=b.person_id;


---------------------------------------------------
-- 4) Device
---------------------------------------------------

-- 원본 테이블이 30T인 경우
INSERT INTO COST
	(cost_id, cost_event_id, cost_domain_id, cost_type_concept_id, currency_concept_id,
	total_charge, total_cost, total_paid, paid_by_payer, paid_by_patient,
	paid_patient_copay, paid_patient_coinsurance, paid_patient_deductiable, paid_by_primary, paid_ingredient_cost,
	paid_dispensing_fee, payer_plan_period_id, amount_allowed, revenue_code_concept_id, drg_concept_id,
	revenue_code_source_value, drg_source_value)
SELECT 
	a.device_exposure_id as cost_id,
	a.device_exposure_id as cost_event_id,
	'Device' as cost_domain_id,
	5031 as cost_type_concept_id,
	44818598 as currency_concept_id,
	null as total_charge,
	b.amt as total_cost,
	null as total_paid,
	null as paid_by_payer,
	null as paid_by_patient,
	null as paid_patient_copay,
	null as paid_patient_coinsurance, 
	null as paid_patient_deductiable,
	null as paid_by_primary,
	null as paid_ingredient_cost,
	null as paid_dispensing_fee,
	to_number(to_char (b.person_id) + substr(to_char (a.device_exposure_start_date, 112), 1, 4)) FROM dual as payer_plan_period_id,
	null as amount_allowed,
	null as revenue_code_concept_id,
	null as drg_concept_id,
	null as revenue_code_source_value,
	null as drg_source_value
    from (select device_exposure_id, person_id, device_exposure_start_date
	from device_exposure 
	where device_source_value not in (select sourcecode from procedure_EDI_mapped_20161007)) a, 
	(select m.master_seq, m.key_seq, m.seq_no, m.person_id, n.amt
	from seq_master m, bigdata.NHIS_30T n
	where m.source_table='130'
	and m.key_seq=n.key_seq
	and m.seq_no=n.seq_no) b
where substr(a.device_exposure_id, 1, 10)=b.master_seq
and a.person_id=b.person_id;


-- 원본 테이블이 60T인 경우
INSERT INTO COST
	(cost_id, cost_event_id, cost_domain_id, cost_type_concept_id, currency_concept_id,
	total_charge, total_cost, total_paid, paid_by_payer, paid_by_patient,
	paid_patient_copay, paid_patient_coinsurance, paid_patient_deductiable, paid_by_primary, paid_ingredient_cost,
	paid_dispensing_fee, payer_plan_period_id, amount_allowed, revenue_code_concept_id, drg_concept_id,
	revenue_code_source_value, drg_source_value)
SELECT 
	a.device_exposure_id as cost_id,
	a.device_exposure_id as cost_event_id,
	'Device' as cost_domain_id,
	5031 as cost_type_concept_id,
	44818598 as currency_concept_id,
	null as total_charge,
	b.amt as total_cost,
	null as total_paid,
	null as paid_by_payer,
	null as paid_by_patient,
	null as paid_patient_copay,
	null as paid_patient_coinsurance, 
	null as paid_patient_deductiable,
	null as paid_by_primary,
	null as paid_ingredient_cost,
	null as paid_dispensing_fee,
	to_number(to_char (b.person_id) + substr(to_char (a.device_exposure_start_date, 112), 1, 4)) FROM dual as payer_plan_period_id,
	null as amount_allowed,
	null as revenue_code_concept_id,
	null as drg_concept_id,
	null as revenue_code_source_value,
	null as drg_source_value
    from (select device_exposure_id, person_id, device_exposure_start_date
	from device_exposure 
	where device_source_value not in (select sourcecode from procedure_EDI_mapped_20161007)) a,  
	(select m.master_seq, m.key_seq, m.seq_no, m.person_id, n.amt
	from (select master_seq, key_seq, seq_no, person_id from seq_master where source_table='160') m, 
	bigdata.NHIS_60T n
	where m.key_seq=n.key_seq
	and m.seq_no=n.seq_no) b
where substr(a.device_exposure_id, 1, 10)=b.master_seq
and a.person_id=b.person_id;











