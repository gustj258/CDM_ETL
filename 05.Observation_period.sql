 select 
      a.person_id as person_id,  case when a.stnd_y >= b.year_of_birth then TO_DATE(to_char(a.stnd_y)|| '0101',112) from dual 
            else to_Date(to_char(b.year_of_birth) || '0101', 112) 
      end as observation_period_start_date, 
      case when convert(date, a.stnd_y + '1231', 112) > c.death_date then c.death_date
            else convert(date, a.stnd_y + '1231', 112)
      end as observation_period_end_date
into observation_period_temp1
from BIGDATA.jk_all a,
      cohort_cdm.person b left join cohort_cdm.death c
      on b.person_id=c.person_id
where a.person_id=b.person_id
select *, row_number() over(partition by person_id order by observation_period_start_date, observation_period_end_date) AS id
into observation_period_temp2
from observation_period_temp1
where observation_period_start_date < observation_period_end_date -- ��� ���� ������ �ڰ��� ���ܽ�Ű�� ����
--(12132529�� ���� ������ ����), 00:08


-- step 3
select 
	a.*, b.observation_period_start_date - a.observation_period_end_date as days
	into observation_period_temp3
	from observation_period_temp2 a
		left join
        observation_period_temp2 b
		on a.person_id = b.person_id
			and a.id = cast(b.id as number)-1
	order by person_id, id
--(12132529�� ���� ������ ����), 00:15

-- step 4
select
	a.*, CASE WHEN id=1 THEN 1
   ELSE SUM(CASE WHEN DAYS>1 THEN 1 ELSE 0 END) OVER from dual(PARTITION BY person_id ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)+1
   END AS sumday
   into #observation_period_temp4
   from #observation_period_temp3 a
   order by person_id, id
--(12132529�� ���� ������ ����), 00:12


-- step 5
select rownumint, 1, 1) from dual as observation_period_id,
	person_id,
	min(observation_period_start_date) as observation_period_start_date,
	max(observation_period_end_date) as observation_period_end_date,
	44814725 as PERIOD_TYPE_CONCEPT_ID
INTO OBSERVATION_PERIOD @cohort_cdm
from #observation_period_temp4
group by person_id, sumday
order by person_id, observation_period_start_date
--(1256091�� ���� ������ ����), 00:10

drop table #observation_period_temp1, #observation_period_temp2, #observation_period_temp3, #observation_period_temp4
			case when x.mdcn_exec_freq is not null and isnumeric(x.mdcn_exec_freq)=1 and cast(x.mdcn_exec_freq as binary_double) > '0' then cast(x.mdcn_exec_freq as binary_double) else 1 end as mdcn_exec_freq,
			case when x.dd_mqty_freq is not null and isnumeric(x.dd_mqty_freq)=1 and cast(x.dd_mqty_freq as binary_double) > '0' then cast(x.dd_mqty_freq as binary_double) else 1 end as dd_mqty_freq,
			case when x.dd_exec_freq is not null and isnumeric(x.dd_exec_freq)=1 and cast(x.dd_exec_freq as binary_double) > '0' then cast(x.dd_exec_freq as binary_double) else 1 end as dd_exec_freq,
			y.master_seq, y.person_id			
	FROM @bigdata.@NHIS_60T x, 
	     (select master_seq, person_id, key_seq, seq_no from seq_master where source_Table='160') y
	WHERE x.key_seq=y.key_seq
	AND x.seq_no=y.seq_no) a,
	@cohort_cdm.@DRUG_MAPPINGTABLE b
where a.div_cd=b.source_code



/**************************************
 5. drug_start_date가 사망일자 이전인 데이터 삭제
    총 1,042 건
***************************************/
delete from a
from drug_exposure a, death b
where a.person_id=b.person_id
and b.death_date < a.drug_exposure_start_date



/**************************************
 6. drug_end_date가 사장일자 이전인 데이터의 drug_end_date를 사망일자로 변경
    총 39,186 건
***************************************/
update a
set drug_exposure_end_date=b.death_date
from drug_exposure a, death b
where a.person_id=b.person_id
and (b.death_date < a.drug_exposure_start_date
or b.death_date < a.drug_exposure_end_date)


-------------------------------------------
참고) http://tennesseewaltz.tistory.com/236
UPDATE A
      SET A.SEQ     = B.CMT_NO
        , A.CarType = B.CAR_TYPE
     FROM TABLE_AAA A
          JOIN TABLE_BBB B ON A.OPCode = B.OP_CODE
    WHERE A.LineCode = '조건'
-------------------------------------------