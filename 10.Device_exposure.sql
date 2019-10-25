/**************************************
 --encoding : UTF-8
 --Author:고인석,박현서
 --Date: 2019.09.10
 
cohort_cdm : DB containing NHIS National Sample cohort DB
cohort_cdm : DB for NHIS-NSC in CDM format
NHID_JK: JK table in NHIS NSC
NHID_20T: 20 table in NHIS NSC
NHID_30T: 30 table in NHIS NSC
NHID_40T: 40 table in NHIS NSC
NHID_60T: 60 table in NHIS NSC
NHID_GJ: GJ table in NHIS NSC
CONDITION_MAPPINGTABLE : mapping table between KCD and OMOP vocabulary
DRUG_MAPPINGTABLE : mapping table between EDI and OMOP vocabulary
PROCEDURE_MAPPINGTABLE : mapping table between Korean procedure and OMOP vocabulary
DEVICE_MAPPINGTABLE : mapping table between EDI and OMOP vocabulary
 
 --Description: device 테이블 생성
			   1) device_exposure_end_date는 drug_exposure의 end_date와 같은 방법으로 생성
			   2) quantity의 경우 단가(UN_COST) 혹은 금액(AMT)이 비정상이거나, 사용량(DD_MQTY_EXEC_FREQ, MDCN_EXEC_FREQ, DD_MQTY_FREQ)이 비정상인 경우가 많고,
				  정수가 아닌 경우가 많음(메디폼을 잘라서 쓰는 경우 등) 
					1. 단가(UN_COST)와 금액(AMT)이 정상인 경우 (Null이 아니거나 0원이 아닌 경우) AMT/UN_COST
					2. 단가(UN_COST)와 금액(AMT)이 정상이 아닌 경우(0, Null, UN_COST>AMT) 30t의 경우 사용량(DD_MQTY_EXEC_FREQ, MDCN_EXEC_FREQ, DD_MQTY_FREQ)의 곱으로,
					   60t의 경우 사용량 (DD_EXEC_FREQ, MDCN_EXEC_FREQ, DD_MQTY_FREQ)의 곱으로 계산
					3. 단가, 금액, 사용량 모두 비정상(0인 경우)일 경우 1로 정의
 --Generating Table: Device_exposure
***************************************/

/**************************************
 1. 테이블 생성 
***************************************/ 
 

CREATE TABLE cohort_cdm.DEVICE_EXPOSURE ( 
     device_exposure_id				NUMBER	 		PRIMARY KEY , 
     person_id						INTEGER			NOT NULL , 
     divce_concept_id				INTEGER			NOT NULL , 
     device_exposure_start_date		DATE			NOT NULL , 
     device_exposure_end_date		DATE			NULL , 
     device_type_concept_id			INTEGER			NOT NULL , 
     unique_device_id				VARCHAR(20)		NULL , 
     quantity						float			NULL , 
     provider_id					INTEGER			NULL , 
     visit_occurrence_id			NUMBER			NULL , 
	 device_source_value			VARCHAR(50)		NULL ,
	 device_source_concept_id		integer			NULL 
    );

create global temporary table cohort_cdm.DEVICE_EXPOSURE
(
    device_exposure_id				NUMBER	 		PRIMARY KEY , 
     person_id						INTEGER			NOT NULL , 
     divce_concept_id				INTEGER			NOT NULL , 
     device_exposure_start_date		DATE			NOT NULL , 
     device_exposure_end_date		DATE			NULL , 
     device_type_concept_id			INTEGER			NOT NULL , 
     unique_device_id				VARCHAR(20)		NULL , 
     quantity						float			NULL , 
     provider_id					INTEGER			NULL , 
     visit_occurrence_id			NUMBER			NULL , 
	 device_source_value			VARCHAR(50)		NULL ,
	 device_source_concept_id		integer			NULL 
)
on commit preserve rows;

--drop table cohort_cdm.PROCEDURE_OCCURRENCE;

/**************************************
 2. 데이터 입력 및 확인 (30t : 8515647개 행이 영향을 받음, 03:53, 매핑이 안돼서/ 60t : 72개 행이 영향을 받음, 00:48, 매핑이 안돼서) 총 8,515,719건
***************************************/  

--30t 입력 (8515647개 행이 영향을 받음) 02:51
insert into cohort_cdm.DEVICE_EXPOSURE
(device_exposure_id, person_id, divce_concept_id, device_exposure_start_date, 
device_exposure_end_date, device_type_concept_id, unique_device_id, quantity, 
provider_id, visit_occurrence_id, device_source_value, device_source_concept_id)
select	to_number(to_char(a.master_seq) || to_char(row_number() over (partition by a.key_seq, a.seq_no order by b.concept_id))) as device_exposure_id,
		a.person_id as person_id,
		b.concept_id as device_concept_id ,
		to_char(a.recu_fr_dt, 23) as device_source_start_date,
		to_char(last_day(a.mdcn_exec_freq, 'yyyymmdd' a.recu_fr_dt),23) as device_source_end_date,
        --CONVERT(VARCHAR, DATEADD(DAY, a.mdcn_exec_freq-1, a.recu_fr_dt),23) as device_source_end_date, 원본코드
		44818705 as device_type_concept_id,
		null as unique_device_id,
case	when a.AMT is not null and cast(a.AMT as float) > 0 and a.UN_COST is not null and cast(a.UN_COST as float) > 0 and cast(a.AMT as float)>=cast(a.UN_COST as float) then cast(a.AMT as float)/cast(a.UN_COST as float)
		when a.AMT is not null and cast(a.AMT as float) > 0 and a.UN_COST is not null and cast(a.UN_COST as float) > 0 and cast(a.UN_COST as float)>cast(a.AMT as float) then a.DD_MQTY_EXEC_FREQ * a.MDCN_EXEC_FREQ * a.DD_MQTY_FREQ 
		else a.DD_MQTY_EXEC_FREQ * a.MDCN_EXEC_FREQ * a.DD_MQTY_FREQ 
		end as quantity,
		null as provider_id,
		a.key_seq as visit_occurence_id,
		a.div_cd as device_source_value,
		null as device_source_concept_id

FROM 
	(SELECT x.key_seq, x.seq_no, x.recu_fr_dt, x.div_cd, 
			case when x.mdcn_exec_freq is not null and x.mdcn_exec_freq > '0' and REGEXP_INSTR(x.mdcn_exec_freq,'^[+-]?\d*(\.?\d*)$')=1 then cast(x.mdcn_exec_freq as float) else 1 end as mdcn_exec_freq,
			case when x.dd_mqty_exec_freq is not null and x.dd_mqty_exec_freq > '0' and REGEXP_INSTR(x.dd_mqty_exec_freq,'^[+-]?\d*(\.?\d*)$')=1 then cast(x.dd_mqty_exec_freq as float) else 1 end as dd_mqty_exec_freq,
			case when x.dd_mqty_freq is not null and x.dd_mqty_freq > '0' and REGEXP_INSTR(x.dd_mqty_freq,'^[+-]?\d*(\.?\d*)$')=1 then cast(x.dd_mqty_freq as float) else 1 end as dd_mqty_freq,
			cast(x.amt as float) as amt , cast(x.un_cost as float) as un_cost, y.master_seq, y.person_id
	FROM cohort_cdm.NHID_30T x, cohort_cdm.SEQ_MASTER y
	WHERE y.source_table='130'
	AND x.key_seq=y.key_seq
	AND x.seq_no=y.seq_no) a JOIN cohort_cdm.DEVICE_MAPPINGTABLE b 
ON a.div_cd=b.sourcecode




--60t 입력 (72개 행이 영향을 받음) 00:46
insert into cohort_cdm.DEVICE_EXPOSURE
(device_exposure_id, person_id, divce_concept_id, device_exposure_start_date, 
device_exposure_end_date, device_type_concept_id, unique_device_id, quantity, 
provider_id, visit_occurrence_id, device_source_value, device_source_concept_id)
select	to_number(to_char(a.master_seq) || to_char(row_number() over (partition by a.key_seq, a.seq_no order by b.concept_id))) as device_exposure_id,
		a.person_id as person_id,
		b.concept_id as device_concept_id ,
		to_char( a.recu_fr_dt, 23) as device_source_start_date,
		to_char(last_day(a.mdcn_exec_freq, 'yyyymmdd' a.recu_fr_dt),23) as device_source_end_date,
        --CONVERT(VARCHAR, DATEADD(DAY, a.mdcn_exec_freq-1, a.recu_fr_dt),23) as device_source_end_date, 원본코드
		44818705 as device_type_concept_id,
		null as unique_device_id,
case	when a.AMT is not null and cast(a.AMT as float) > 0 and a.UN_COST is not null and cast(a.UN_COST as float) > 0 and cast(a.AMT as float)>=cast(a.UN_COST as float) then cast(a.AMT as float)/cast(a.UN_COST as float)
		when a.AMT is not null and cast(a.AMT as float) > 0 and a.UN_COST is not null and cast(a.UN_COST as float) > 0 and cast(a.UN_COST as float)>cast(a.AMT as float) then a.MDCN_EXEC_FREQ * a.DD_MQTY_FREQ * a.DD_EXEC_FREQ
		else a.MDCN_EXEC_FREQ * a.DD_MQTY_FREQ * a.DD_EXEC_FREQ
		end as quantity,
		null as provider_id,
		a.key_seq as visit_occurence_id,
		a.div_cd as device_source_value,
		null as device_source_concept_id

FROM 
	(SELECT x.key_seq, x.seq_no, x.recu_fr_dt, x.div_cd, 
			case when x.mdcn_exec_freq is not null and x.mdcn_exec_freq > '0' and REGEXP_INSTR(x.mdcn_exec_freq,'^[+-]?\d*(\.?\d*)$')=1 then cast(x.mdcn_exec_freq as float) else 1 end as mdcn_exec_freq,
			case when x.dd_mqty_freq is not null and x.dd_mqty_freq > '0' and REGEXP_INSTR(x.dd_mqty_freq,'^[+-]?\d*(\.?\d*)$')=1 then cast(x.dd_mqty_freq as float) else 1 end as dd_mqty_freq,
			case when x.dd_exec_freq is not null and x.dd_exec_freq > '0' and REGEXP_INSTR(x.dd_exec_freq,'^[+-]?\d*(\.?\d*)$')=1 then cast(x.dd_exec_freq as float) else 1 end as dd_exec_freq,
			cast(x.amt as float) as amt , cast(x.un_cost as float) as un_cost, y.master_seq, y.person_id
	FROM cohort_cdm.NHID_60T x, cohort_cdm.SEQ_MASTER y
	WHERE y.source_table='160'
	AND x.key_seq=y.key_seq
	AND x.seq_no=y.seq_no) a JOIN cohort_cdm.DEVICE_MAPPINGTABLE b
ON a.div_cd=b.sourcecode


-- quantity가 0인 경우 1로 변경 (6268개 행이 영향을 받음) 00:04
update cohort_cdm.DEVICE_EXPOSURE
set quantity = 1
where quantity = 0



/******************* quantity 0인 경우 1로 변경하기 전 결과 확인*********************
select * from @ResultDatabaseSchema.device_exposure where quantity=0 -- 변경 전 -> 6268(정맥내유치침5275건) / 변경 후 -> 0
select * from @ResultDatabaseSchema.device_exposure where quantity=1 -- 변경 전 -> 4548117 / 변경 후 -> 4554385
*************************************************************************************/
