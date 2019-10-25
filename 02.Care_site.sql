/**************************************
 --Oracle version: Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
 --Author: 고인석,박현서
 --Date: 2019.08.09
 
 @NHID : DB containing NHID National Sample cohort DB
 @NHID_JK: JK table in NHID NSC
 @NHID_20T: 20 table in NHID NSC
 @NHID_30T: 30 table in NHID NSC
 @NHID_40T: 40 table in NHID NSC
 @NHID_60T: 60 table in NHID NSC
 @NHID_GJ: GJ table in NHID NSC
 
 --Description: Care_site 테이블 생성
			   1) 표본코호트DB에는 요양기관이 년도별로 중복 입력되어 있음. 지역이동, 설립구분의 변화등이 추적 가능함
			      하지만, CDM에서는 1개의 기관으로 들어가야 하므로, 최근 요양기관 데이터를 변환함
			   2) place of service: 한국적 상황을 고려하여 새로운 concept을 생성함 (ETL 정의서 참고할 것)
 --Generating Table: CARE_SITE
***************************************/

/**************************************
 1. 테이블 생성
***************************************/  
Create table CARE_SITE (
	care_site_id 	integer primary key,
	care_site_name	varchar(255),
	place_of_service_concept_id	integer,
	location_id	integer,
	care_site_source_value	varchar(50),
	place_of_service_source_value	varchar(50)
);

/**************************************
 2. 데이터 입력
	: place_of_service_source_value - 요양기관종별코드/요양기관설립구분
									- 요양기관설립구분이 1자리 숫자인 경우, 앞에 0을 붙여줌
***************************************/  
INSERT INTO CARE_SITE
SELECT a.ykiho_id,
	null as care_site_name,
	case when a.ykiho_gubun_cd='10' then 4068130 --종합병원(Tertiary care hospital) 
		 when a.ykiho_gubun_cd between '20' and '27' then 4318944 --일반병원  Hospital
		 when a.ykiho_gubun_cd='28' then 82020103 --요양병원  
		 when a.ykiho_gubun_cd='29' then 4268912 --정신요양병원 Psychiatric hospital 
		 when a.ykiho_gubun_cd between '30' and '39' then 82020105 --의원
		 when a.ykiho_gubun_cd between '40' and '49' then 82020106 --치과병원
		 when a.ykiho_gubun_cd between '50' and '59' then 82020107 --치과의원
		 when a.ykiho_gubun_cd between '60' and '69' then 82020108 --조산원
		 when a.ykiho_gubun_cd='70' then 82020109 --보건소
		 when a.ykiho_gubun_cd between '71' and '72' then 82020110 --보건지소
		 when a.ykiho_gubun_cd between '73' and '74' then 82020111 --보건진료소
		 when a.ykiho_gubun_cd between '75' and '76' then 82020112 --모자보건센터
		 when a.ykiho_gubun_cd='77' then 82020113 --보건의료원
		 when a.ykiho_gubun_cd between '80' and '89' then 4131032 --약국 Pharmacy
		 when a.ykiho_gubun_cd='91' then 82020115 --한방종합병원
		 when a.ykiho_gubun_cd='92' then 82020116 --한방병원
		 when a.ykiho_gubun_cd between '93' and '97' then 82020117 --한의원
		 when a.ykiho_gubun_cd between '98' and '99' then 82020118 --한약방
	end as place_of_service_concept_id,
	a.ykiho_sido as location_id,
	a.ykiho_id as care_site_source_value,
	a.ykiho_gubun_cd||'/'||(case when length(to_number(a.org_type)) = 1 then '0' else org_type end)||org_type as place_of_service_source_value
FROM cohort_cdm.NHID_YK a, (select ykiho_id, max(stnd_y) as max_stnd_y
from cohort_cdm.NHID_YK c
group by ykiho_id) b
where a.ykiho_id=b.ykiho_id
and a.stnd_y=b.max_stnd_y;
