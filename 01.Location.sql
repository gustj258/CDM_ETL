/**************************************
 --encoding : UTF-8
 --Author: 이성원
 --Date: 2017.01.16
 
 @NHISDatabaseSchema : DB containing NHIS National Sample cohort DB
 @NHIS_JK: JK table in NHIS NSC
 @NHIS_20T: 20 table in NHIS NSC
 @NHIS_30T: 30 table in NHIS NSC
 @NHIS_40T: 40 table in NHIS NSC
 @NHIS_60T: 60 table in NHIS NSC
 @NHIS_GJ: GJ table in NHIS NSC

 --Description: Location 테이블 생성
 --Generating Table: LOCATION
***************************************/

/**************************************
 1. 테이블 생성
***************************************/  
Create table LOCATION@cohort_cdm(
	location_id 	number(10) 
     NUMBER CONSTRAINT LOCATION_location_id PRIMARY KEY,
	address_1 		varchar2(50),
	address_2 		varchar2(50), 
	city  			varchar2(50), 
	state 			varchar2(2), 
	zip 			varchar2(9), 
	county 			varchar2(20), 
	location_source_value 	varchar2(50)
);


/**************************************
 2. 데이터 입력
***************************************/  
INSERT INTO LOCATION@cohort_cdm
 SELECT '11110','서울특별시','11110 종로구','서울특별시',null,null,'KOREA','11110' FROM dual UNION ALL 
 SELECT '11140','서울특별시','11140 중구','서울특별시',null,null,'KOREA','11140' FROM dual UNION ALL 
 SELECT '11170','서울특별시','11170 용산구','서울특별시',null,null,'KOREA','11170' FROM dual UNION ALL 
 SELECT '11200','서울특별시','11200 성동구','서울특별시',null,null,'KOREA','11200' FROM dual UNION ALL 
 SELECT '11215','서울특별시','11215 광진구','서울특별시',null,null,'KOREA','11215' FROM dual UNION ALL 
 SELECT '11230','서울특별시','11230 동대문구','서울특별시',null,null,'KOREA','11230' FROM dual UNION ALL 
 SELECT '11260','서울특별시','11260 중랑구','서울특별시',null,null,'KOREA','11260' FROM dual UNION ALL 
 SELECT '11290','서울특별시','11290 성북구','서울특별시',null,null,'KOREA','11290' FROM dual UNION ALL 
 SELECT '11305','서울특별시','11305 강북구','서울특별시',null,null,'KOREA','11305' FROM dual UNION ALL 
 SELECT '11320','서울특별시','11320 도봉구','서울특별시',null,null,'KOREA','11320' FROM dual UNION ALL 
 SELECT '11350','서울특별시','11350 노원구','서울특별시',null,null,'KOREA','11350' FROM dual UNION ALL 
 SELECT '11380','서울특별시','11380 은평구','서울특별시',null,null,'KOREA','11380' FROM dual UNION ALL 
 SELECT '11410','서울특별시','11410 서대문구','서울특별시',null,null,'KOREA','11410' FROM dual UNION ALL 
 SELECT '11440','서울특별시','11440 마포구','서울특별시',null,null,'KOREA','11440' FROM dual UNION ALL 
 SELECT '11470','서울특별시','11470 양천구','서울특별시',null,null,'KOREA','11470' FROM dual UNION ALL 
 SELECT '11500','서울특별시','11500 강서구','서울특별시',null,null,'KOREA','11500' FROM dual UNION ALL 
 SELECT '11530','서울특별시','11530 구로구','서울특별시',null,null,'KOREA','11530' FROM dual UNION ALL 
 SELECT '11545','서울특별시','11545 금천구','서울특별시',null,null,'KOREA','11545' FROM dual UNION ALL 
 SELECT '11560','서울특별시','11560 영등포구','서울특별시',null,null,'KOREA','11560' FROM dual UNION ALL 
 SELECT '11590','서울특별시','11590 동작구','서울특별시',null,null,'KOREA','11590' FROM dual UNION ALL 
 SELECT '11620','서울특별시','11620 관악구','서울특별시',null,null,'KOREA','11620' FROM dual UNION ALL 
 SELECT '11650','서울특별시','11650 서초구','서울특별시',null,null,'KOREA','11650' FROM dual UNION ALL 
 SELECT '11680','서울특별시','11680 강남구','서울특별시',null,null,'KOREA','11680' FROM dual UNION ALL 
 SELECT '11710','서울특별시','11710 송파구','서울특별시',null,null,'KOREA','11710' FROM dual UNION ALL 
 SELECT '11740','서울특별시','11740 강동구','서울특별시',null,null,'KOREA','11740' FROM dual UNION ALL 
 SELECT '21320','서울특별시','21320 강동구','서울특별시',null,null,'KOREA','21320' FROM dual UNION ALL 
 SELECT '22230','서울특별시','22230 강동구','서울특별시',null,null,'KOREA','22230' FROM dual UNION ALL 
 SELECT '24200','서울특별시','24200 강동구','서울특별시',null,null,'KOREA','24200' FROM dual UNION ALL 
 SELECT '25110','서울특별시','25110 강동구','서울특별시',null,null,'KOREA','25110' FROM dual UNION ALL 
 SELECT '26110','부산광역시','26110 중구','부산광역시',null,null,'KOREA','26110' FROM dual UNION ALL 
 SELECT '26140','부산광역시','26140 서구','부산광역시',null,null,'KOREA','26140' FROM dual UNION ALL 
 SELECT '26170','부산광역시','26170 동구','부산광역시',null,null,'KOREA','26170' FROM dual UNION ALL 
 SELECT '26200','부산광역시','26200 영도구','부산광역시',null,null,'KOREA','26200' FROM dual UNION ALL 
 SELECT '26230','부산광역시','26230 부산진구','부산광역시',null,null,'KOREA','26230' FROM dual UNION ALL 
 SELECT '26260','부산광역시','26260 동래구','부산광역시',null,null,'KOREA','26260' FROM dual UNION ALL 
 SELECT '26290','부산광역시','26290 남구','부산광역시',null,null,'KOREA','26290' FROM dual UNION ALL 
 SELECT '26320','부산광역시','26320 북구','부산광역시',null,null,'KOREA','26320' FROM dual UNION ALL 
 SELECT '26350','부산광역시','26350 해운대구','부산광역시',null,null,'KOREA','26350' FROM dual UNION ALL 
 SELECT '26380','부산광역시','26380 사하구','부산광역시',null,null,'KOREA','26380' FROM dual UNION ALL 
 SELECT '26410','부산광역시','26410 금정구','부산광역시',null,null,'KOREA','26410' FROM dual UNION ALL 
 SELECT '26440','부산광역시','26440 강서구','부산광역시',null,null,'KOREA','26440' FROM dual UNION ALL 
 SELECT '26470','부산광역시','26470 연제구','부산광역시',null,null,'KOREA','26470' FROM dual UNION ALL 
 SELECT '26500','부산광역시','26500 수영구','부산광역시',null,null,'KOREA','26500' FROM dual UNION ALL 
 SELECT '26530','부산광역시','26530 사상구','부산광역시',null,null,'KOREA','26530' FROM dual UNION ALL 
 SELECT '26710','부산광역시','26710 기장군','부산광역시',null,null,'KOREA','26710' FROM dual UNION ALL 
 SELECT '27110','대구광역시','27110 중구','대구광역시',null,null,'KOREA','27110' FROM dual UNION ALL 
 SELECT '27140','대구광역시','27140 동구','대구광역시',null,null,'KOREA','27140' FROM dual UNION ALL 
 SELECT '27170','대구광역시','27170 서구','대구광역시',null,null,'KOREA','27170' FROM dual UNION ALL 
 SELECT '27200','대구광역시','27200 남구','대구광역시',null,null,'KOREA','27200' FROM dual UNION ALL 
 SELECT '27230','대구광역시','27230 북구','대구광역시',null,null,'KOREA','27230' FROM dual UNION ALL 
 SELECT '27260','대구광역시','27260 수성구','대구광역시',null,null,'KOREA','27260' FROM dual UNION ALL 
 SELECT '27290','대구광역시','27290 달서구','대구광역시',null,null,'KOREA','27290' FROM dual UNION ALL 
 SELECT '27710','대구광역시','27710 달성군','대구광역시',null,null,'KOREA','27710' FROM dual UNION ALL 
 SELECT '28110','인천광역시','28110 중구','인천광역시',null,null,'KOREA','28110' FROM dual UNION ALL 
 SELECT '28140','인천광역시','28140 동구','인천광역시',null,null,'KOREA','28140' FROM dual UNION ALL 
 SELECT '28170','인천광역시','28170 남구','인천광역시',null,null,'KOREA','28170' FROM dual UNION ALL 
 SELECT '28185','인천광역시','28185 연수구','인천광역시',null,null,'KOREA','28185' FROM dual UNION ALL 
 SELECT '28200','인천광역시','28200 남동구','인천광역시',null,null,'KOREA','28200' FROM dual UNION ALL 
 SELECT '28237','인천광역시','28237 부평구','인천광역시',null,null,'KOREA','28237' FROM dual UNION ALL 
 SELECT '28245','인천광역시','28245 계양구','인천광역시',null,null,'KOREA','28245' FROM dual UNION ALL 
 SELECT '28260','인천광역시','28260 서구','인천광역시',null,null,'KOREA','28260' FROM dual UNION ALL 
 SELECT '28710','인천광역시','28710 강화군','인천광역시',null,null,'KOREA','28710' FROM dual UNION ALL 
 SELECT '28720','인천광역시','28720 옹진군','인천광역시',null,null,'KOREA','28720' FROM dual UNION ALL 
 SELECT '29110','광주광역시','29110 동구','광주광역시',null,null,'KOREA','29110' FROM dual UNION ALL 
 SELECT '29140','광주광역시','29140 서구','광주광역시',null,null,'KOREA','29140' FROM dual UNION ALL 
 SELECT '29155','광주광역시','29155 남구','광주광역시',null,null,'KOREA','29155' FROM dual UNION ALL 
 SELECT '29170','광주광역시','29170 북구','광주광역시',null,null,'KOREA','29170' FROM dual UNION ALL 
 SELECT '29200','광주광역시','29200 광산구','광주광역시',null,null,'KOREA','29200' FROM dual UNION ALL 
 SELECT '30110','대전광역시','30110 동구','대전광역시',null,null,'KOREA','30110' FROM dual UNION ALL 
 SELECT '30140','대전광역시','30140 중구','대전광역시',null,null,'KOREA','30140' FROM dual UNION ALL 
 SELECT '30170','대전광역시','30170 서구','대전광역시',null,null,'KOREA','30170' FROM dual UNION ALL 
 SELECT '30200','대전광역시','30200 유성구','대전광역시',null,null,'KOREA','30200' FROM dual UNION ALL 
 SELECT '30230','대전광역시','30230 대덕구','대전광역시',null,null,'KOREA','30230' FROM dual UNION ALL 
 SELECT '31110','울산광역시','31110 중구','울산광역시',null,null,'KOREA','31110' FROM dual UNION ALL 
 SELECT '31140','울산광역시','31140 남구','울산광역시',null,null,'KOREA','31140' FROM dual UNION ALL 
 SELECT '31170','울산광역시','31170 동구','울산광역시',null,null,'KOREA','31170' FROM dual UNION ALL 
 SELECT '31200','울산광역시','31200 북구','울산광역시',null,null,'KOREA','31200' FROM dual UNION ALL 
 SELECT '31710','울산광역시','31710 울주군','울산광역시',null,null,'KOREA','31710' FROM dual UNION ALL 
 SELECT '36110','세종특별자치시','36110','세종특별자치시',null,null,'KOREA','36110' FROM dual UNION ALL 
 SELECT '41111','경기도','41111 수원시 장안구','경기도',null,null,'KOREA','41111' FROM dual UNION ALL 
 SELECT '41113','경기도','41113 수원시 권선구','경기도',null,null,'KOREA','41113' FROM dual UNION ALL 
 SELECT '41115','경기도','41115 수원시 팔달구','경기도',null,null,'KOREA','41115' FROM dual UNION ALL 
 SELECT '41117','경기도','41117 수원시 영통구','경기도',null,null,'KOREA','41117' FROM dual UNION ALL 
 SELECT '41131','경기도','41131 성남시 수정구','경기도',null,null,'KOREA','41131' FROM dual UNION ALL 
 SELECT '41133','경기도','41133 성남시 중원구','경기도',null,null,'KOREA','41133' FROM dual UNION ALL 
 SELECT '41135','경기도','41135 성남시 분당구','경기도',null,null,'KOREA','41135' FROM dual UNION ALL 
 SELECT '41139','경기도','41139 성남시분당구','경기도',null,null,'KOREA','41139' FROM dual UNION ALL 
 SELECT '41150','경기도','41150 의정부시','경기도',null,null,'KOREA','41150' FROM dual UNION ALL 
 SELECT '41171','경기도','41171 안양시 만안구','경기도',null,null,'KOREA','41171' FROM dual UNION ALL 
 SELECT '41173','경기도','41173 안양시 동안구','경기도',null,null,'KOREA','41173' FROM dual UNION ALL 
 SELECT '41190','경기도','41190 부천시','경기도',null,null,'KOREA','41190' FROM dual UNION ALL 
 SELECT '41192','경기도','41192 부천시원미구','경기도',null,null,'KOREA','41192' FROM dual UNION ALL 
 SELECT '41193','경기도','41193 부천시원미구','경기도',null,null,'KOREA','41193' FROM dual UNION ALL 
 SELECT '41194','경기도','41194 부천시소사구','경기도',null,null,'KOREA','41194' FROM dual UNION ALL 
 SELECT '41195','경기도','41195 부천시 원미구','경기도',null,null,'KOREA','41195' FROM dual UNION ALL 
 SELECT '41197','경기도','41197 부천시 소사구','경기도',null,null,'KOREA','41197' FROM dual UNION ALL 
 SELECT '41199','경기도','41199 부천시 오정구','경기도',null,null,'KOREA','41199' FROM dual UNION ALL 
 SELECT '41210','경기도','41210 광명시','경기도',null,null,'KOREA','41210' FROM dual UNION ALL 
 SELECT '41220','경기도','41220 평택시','경기도',null,null,'KOREA','41220' FROM dual UNION ALL 
 SELECT '41222','경기도','41222 평택시 송탄출장소','경기도',null,null,'KOREA','41222' FROM dual UNION ALL 
 SELECT '41224','경기도','41224 평택시 안중출장소','경기도',null,null,'KOREA','41224' FROM dual UNION ALL 
 SELECT '41250','경기도','41250 동두천시','경기도',null,null,'KOREA','41250' FROM dual UNION ALL 
 SELECT '41270','경기도','41270 안산시','경기도',null,null,'KOREA','41270' FROM dual UNION ALL 
 SELECT '41271','경기도','41271 안산시 상록구','경기도',null,null,'KOREA','41271' FROM dual UNION ALL 
 SELECT '41273','경기도','41273 안산시 단원구','경기도',null,null,'KOREA','41273' FROM dual UNION ALL 
 SELECT '41281','경기도','41281 고양시 덕양구','경기도',null,null,'KOREA','41281' FROM dual UNION ALL 
 SELECT '41283','경기도','41283 고양시일산구','경기도',null,null,'KOREA','41283' FROM dual UNION ALL 
 SELECT '41285','경기도','41285 고양시 일산동구','경기도',null,null,'KOREA','41285' FROM dual UNION ALL 
 SELECT '41287','경기도','41287 고양시 일산서구','경기도',null,null,'KOREA','41287' FROM dual UNION ALL 
 SELECT '41290','경기도','41290 과천시','경기도',null,null,'KOREA','41290' FROM dual UNION ALL 
 SELECT '41310','경기도','41310 구리시','경기도',null,null,'KOREA','41310' FROM dual UNION ALL 
 SELECT '41360','경기도','41360 남양주시','경기도',null,null,'KOREA','41360' FROM dual UNION ALL 
 SELECT '41370','경기도','41370 오산시','경기도',null,null,'KOREA','41370' FROM dual UNION ALL 
 SELECT '41390','경기도','41390 시흥시','경기도',null,null,'KOREA','41390' FROM dual UNION ALL 
 SELECT '41410','경기도','41410 군포시','경기도',null,null,'KOREA','41410' FROM dual UNION ALL 
 SELECT '41430','경기도','41430 의왕시','경기도',null,null,'KOREA','41430' FROM dual UNION ALL 
 SELECT '41450','경기도','41450 하남시','경기도',null,null,'KOREA','41450' FROM dual UNION ALL 
 SELECT '41460','경기도','41460 용인시','경기도',null,null,'KOREA','41460' FROM dual UNION ALL 
 SELECT '41461','경기도','41461 용인시 처인구','경기도',null,null,'KOREA','41461' FROM dual UNION ALL 
 SELECT '41463','경기도','41463 용인시 기흥구','경기도',null,null,'KOREA','41463' FROM dual UNION ALL 
 SELECT '41465','경기도','41465 용인시 수지구','경기도',null,null,'KOREA','41465' FROM dual UNION ALL 
 SELECT '41470','경기도','41470 용인시','경기도',null,null,'KOREA','41470' FROM dual UNION ALL 
 SELECT '41480','경기도','41480 파주시','경기도',null,null,'KOREA','41480' FROM dual UNION ALL 
 SELECT '41490','경기도','41490 파주시','경기도',null,null,'KOREA','41490' FROM dual UNION ALL 
 SELECT '41500','경기도','41500 이천시','경기도',null,null,'KOREA','41500' FROM dual UNION ALL 
 SELECT '41510','경기도','41510 이천시','경기도',null,null,'KOREA','41510' FROM dual UNION ALL 
 SELECT '41550','경기도','41550 안성시','경기도',null,null,'KOREA','41550' FROM dual UNION ALL 
 SELECT '41570','경기도','41570 김포시','경기도',null,null,'KOREA','41570' FROM dual UNION ALL 
 SELECT '41590','경기도','41590 화성시','경기도',null,null,'KOREA','41590' FROM dual UNION ALL 
 SELECT '41592','경기도','41592 화성시 동부출장소','경기도',null,null,'KOREA','41592' FROM dual UNION ALL 
 SELECT '41610','경기도','41610 광주시','경기도',null,null,'KOREA','41610' FROM dual UNION ALL 
 SELECT '41630','경기도','41630 양주시','경기도',null,null,'KOREA','41630' FROM dual UNION ALL 
 SELECT '41650','경기도','41650 포천시','경기도',null,null,'KOREA','41650' FROM dual UNION ALL 
 SELECT '41670','경기도','41670 여주시','경기도',null,null,'KOREA','41670' FROM dual UNION ALL 
 SELECT '41710','경기도','41710 양주군','경기도',null,null,'KOREA','41710' FROM dual UNION ALL 
 SELECT '41730','경기도','41730 여주군','경기도',null,null,'KOREA','41730' FROM dual UNION ALL 
 SELECT '41750','경기도','41750 화성군','경기도',null,null,'KOREA','41750' FROM dual UNION ALL 
 SELECT '41790','경기도','41790 광주군','경기도',null,null,'KOREA','41790' FROM dual UNION ALL 
 SELECT '41800','경기도','41800 연천군','경기도',null,null,'KOREA','41800' FROM dual UNION ALL 
 SELECT '41810','경기도','41810 포천군','경기도',null,null,'KOREA','41810' FROM dual UNION ALL 
 SELECT '41820','경기도','41820 가평군','경기도',null,null,'KOREA','41820' FROM dual UNION ALL 
 SELECT '41830','경기도','41830 양평군','경기도',null,null,'KOREA','41830' FROM dual UNION ALL 
 SELECT '41860','경기도','41860 안성군','경기도',null,null,'KOREA','41860' FROM dual UNION ALL 
 SELECT '41870','경기도','41870 김포군','경기도',null,null,'KOREA','41870' FROM dual UNION ALL 
 SELECT '42110','강원도','42110 춘천시','강원도',null,null,'KOREA','42110' FROM dual UNION ALL 
 SELECT '42130','강원도','42130 원주시','강원도',null,null,'KOREA','42130' FROM dual UNION ALL 
 SELECT '42150','강원도','42150 강릉시','강원도',null,null,'KOREA','42150' FROM dual UNION ALL 
 SELECT '42170','강원도','42170 동해시','강원도',null,null,'KOREA','42170' FROM dual UNION ALL 
 SELECT '42190','강원도','42190 태백시','강원도',null,null,'KOREA','42190' FROM dual UNION ALL 
 SELECT '42210','강원도','42210 속초시','강원도',null,null,'KOREA','42210' FROM dual UNION ALL 
 SELECT '42230','강원도','42230 삼척시','강원도',null,null,'KOREA','42230' FROM dual UNION ALL 
 SELECT '42710','강원도','42710 삼척시','강원도',null,null,'KOREA','42710' FROM dual UNION ALL 
 SELECT '42720','강원도','42720 홍천군','강원도',null,null,'KOREA','42720' FROM dual UNION ALL 
 SELECT '42730','강원도','42730 횡성군','강원도',null,null,'KOREA','42730' FROM dual UNION ALL 
 SELECT '42750','강원도','42750 영월군','강원도',null,null,'KOREA','42750' FROM dual UNION ALL 
 SELECT '42760','강원도','42760 평창군','강원도',null,null,'KOREA','42760' FROM dual UNION ALL 
 SELECT '42770','강원도','42770 정선군','강원도',null,null,'KOREA','42770' FROM dual UNION ALL 
 SELECT '42780','강원도','42780 철원군','강원도',null,null,'KOREA','42780' FROM dual UNION ALL 
 SELECT '42790','강원도','42790 화천군','강원도',null,null,'KOREA','42790' FROM dual UNION ALL 
 SELECT '42800','강원도','42800 양구군','강원도',null,null,'KOREA','42800' FROM dual UNION ALL 
 SELECT '42810','강원도','42810 인제군','강원도',null,null,'KOREA','42810' FROM dual UNION ALL 
 SELECT '42820','강원도','42820 고성군','강원도',null,null,'KOREA','42820' FROM dual UNION ALL 
 SELECT '42830','강원도','42830 양양군','강원도',null,null,'KOREA','42830' FROM dual UNION ALL 
 SELECT '43110','충청북도','43110 청주시','충청북도',null,null,'KOREA','43110' FROM dual UNION ALL 
 SELECT '43111','충청북도','43111 청주시 상당구','충청북도',null,null,'KOREA','43111' FROM dual UNION ALL 
 SELECT '43112','충청북도','43112 청주시 서원구','충청북도',null,null,'KOREA','43112' FROM dual UNION ALL 
 SELECT '43113','충청북도','43113 청주시 흥덕구','충청북도',null,null,'KOREA','43113' FROM dual UNION ALL 
 SELECT '43114','충청북도','43114 청주시 청원구','충청북도',null,null,'KOREA','43114' FROM dual UNION ALL 
 SELECT '43130','충청북도','43130 충주시','충청북도',null,null,'KOREA','43130' FROM dual UNION ALL 
 SELECT '43150','충청북도','43150 제천시','충청북도',null,null,'KOREA','43150' FROM dual UNION ALL 
 SELECT '43710','충청북도','43710 청원군','충청북도',null,null,'KOREA','43710' FROM dual UNION ALL 
 SELECT '43720','충청북도','43720 보은군','충청북도',null,null,'KOREA','43720' FROM dual UNION ALL 
 SELECT '43730','충청북도','43730 옥천군','충청북도',null,null,'KOREA','43730' FROM dual UNION ALL 
 SELECT '43740','충청북도','43740 영동군','충청북도',null,null,'KOREA','43740' FROM dual UNION ALL 
 SELECT '43745','충청북도','43745 증평군','충청북도',null,null,'KOREA','43745' FROM dual UNION ALL 
 SELECT '43750','충청북도','43750 진천군','충청북도',null,null,'KOREA','43750' FROM dual UNION ALL 
 SELECT '43760','충청북도','43760 괴산군','충청북도',null,null,'KOREA','43760' FROM dual UNION ALL 
 SELECT '43770','충청북도','43770 음성군','충청북도',null,null,'KOREA','43770' FROM dual UNION ALL 
 SELECT '43800','충청북도','43800 단양군','충청북도',null,null,'KOREA','43800' FROM dual UNION ALL 
 SELECT '44113','충청북도','44113 단양읍','충청북도',null,null,'KOREA','44113' FROM dual UNION ALL 
 SELECT '41780','충청남도','41780 태안읍','충청남도',null,null,'KOREA','41780' FROM dual UNION ALL 
 SELECT '44130','충청남도','44130 천안시','충청남도',null,null,'KOREA','44130' FROM dual UNION ALL 
 SELECT '44131','충청남도','44131 천안시 동남구','충청남도',null,null,'KOREA','44131' FROM dual UNION ALL 
 SELECT '44133','충청남도','44133 천안시 서북구','충청남도',null,null,'KOREA','44133' FROM dual UNION ALL 
 SELECT '44150','충청남도','44150 공주시','충청남도',null,null,'KOREA','44150' FROM dual UNION ALL 
 SELECT '44180','충청남도','44180 보령시','충청남도',null,null,'KOREA','44180' FROM dual UNION ALL 
 SELECT '44200','충청남도','44200 아산시','충청남도',null,null,'KOREA','44200' FROM dual UNION ALL 
 SELECT '44210','충청남도','44210 서산시','충청남도',null,null,'KOREA','44210' FROM dual UNION ALL 
 SELECT '44230','충청남도','44230 논산시','충청남도',null,null,'KOREA','44230' FROM dual UNION ALL 
 SELECT '44250','충청남도','44250 계룡시','충청남도',null,null,'KOREA','44250' FROM dual UNION ALL 
 SELECT '44270','충청남도','44270 당진시','충청남도',null,null,'KOREA','44270' FROM dual UNION ALL 
 SELECT '44710','충청남도','44710 금산군','충청남도',null,null,'KOREA','44710' FROM dual UNION ALL 
 SELECT '44730','충청남도','44730 연기군','충청남도',null,null,'KOREA','44730' FROM dual UNION ALL 
 SELECT '44760','충청남도','44760 부여군','충청남도',null,null,'KOREA','44760' FROM dual UNION ALL 
 SELECT '44770','충청남도','44770 서천군','충청남도',null,null,'KOREA','44770' FROM dual UNION ALL 
 SELECT '44790','충청남도','44790 청양군','충청남도',null,null,'KOREA','44790' FROM dual UNION ALL 
 SELECT '44800','충청남도','44800 홍성군','충청남도',null,null,'KOREA','44800' FROM dual UNION ALL 
 SELECT '44810','충청남도','44810 예산군','충청남도',null,null,'KOREA','44810' FROM dual UNION ALL 
 SELECT '44825','충청남도','44825 태안군','충청남도',null,null,'KOREA','44825' FROM dual UNION ALL 
 SELECT '44830','충청남도','44830 당진군','충청남도',null,null,'KOREA','44830' FROM dual UNION ALL 
 SELECT '44840','충청남도','44840 당진읍','충청남도',null,null,'KOREA','44840' FROM dual UNION ALL 
 SELECT '44850','충청남도','44850 당진읍','충청남도',null,null,'KOREA','44850' FROM dual UNION ALL 
 SELECT '45110','전라북도','45110 전주시','전라북도',null,null,'KOREA','45110' FROM dual UNION ALL 
 SELECT '45111','전라북도','45111 전주시 완산구','전라북도',null,null,'KOREA','45111' FROM dual UNION ALL 
 SELECT '45113','전라북도','45113 전주시 덕진구','전라북도',null,null,'KOREA','45113' FROM dual UNION ALL 
 SELECT '45130','전라북도','45130 군산시','전라북도',null,null,'KOREA','45130' FROM dual UNION ALL 
 SELECT '45140','전라북도','45140 익산시','전라북도',null,null,'KOREA','45140' FROM dual UNION ALL 
 SELECT '45180','전라북도','45180 정읍시','전라북도',null,null,'KOREA','45180' FROM dual UNION ALL 
 SELECT '45190','전라북도','45190 남원시','전라북도',null,null,'KOREA','45190' FROM dual UNION ALL 
 SELECT '45210','전라북도','45210 김제시','전라북도',null,null,'KOREA','45210' FROM dual UNION ALL 
 SELECT '45710','전라북도','45710 완주군','전라북도',null,null,'KOREA','45710' FROM dual UNION ALL 
 SELECT '45720','전라북도','45720 진안군','전라북도',null,null,'KOREA','45720' FROM dual UNION ALL 
 SELECT '45730','전라북도','45730 무주군','전라북도',null,null,'KOREA','45730' FROM dual UNION ALL 
 SELECT '45740','전라북도','45740 장수군','전라북도',null,null,'KOREA','45740' FROM dual UNION ALL 
 SELECT '45750','전라북도','45750 임실군','전라북도',null,null,'KOREA','45750' FROM dual UNION ALL 
 SELECT '45760','전라북도','45760 임실읍','전라북도',null,null,'KOREA','45760' FROM dual UNION ALL 
 SELECT '45770','전라북도','45770 순창군','전라북도',null,null,'KOREA','45770' FROM dual UNION ALL 
 SELECT '45790','전라북도','45790 고창군','전라북도',null,null,'KOREA','45790' FROM dual UNION ALL 
 SELECT '45800','전라북도','45800 부안군','전라북도',null,null,'KOREA','45800' FROM dual UNION ALL 
 SELECT '45810','전라북도','45810 부안군','전라북도',null,null,'KOREA','45810' FROM dual UNION ALL 
 SELECT '46110','전라남도','46110 목포시','전라남도',null,null,'KOREA','46110' FROM dual UNION ALL 
 SELECT '46130','전라남도','46130 여수시','전라남도',null,null,'KOREA','46130' FROM dual UNION ALL 
 SELECT '46150','전라남도','46150 순천시','전라남도',null,null,'KOREA','46150' FROM dual UNION ALL 
 SELECT '46170','전라남도','46170 나주시','전라남도',null,null,'KOREA','46170' FROM dual UNION ALL 
 SELECT '46190','전라남도','46190 여천시','전라남도',null,null,'KOREA','46190' FROM dual UNION ALL 
 SELECT '46230','전라남도','46230 광양시','전라남도',null,null,'KOREA','46230' FROM dual UNION ALL 
 SELECT '46710','전라남도','46710 담양군','전라남도',null,null,'KOREA','46710' FROM dual UNION ALL 
 SELECT '46720','전라남도','46720 곡성군','전라남도',null,null,'KOREA','46720' FROM dual UNION ALL 
 SELECT '46730','전라남도','46730 구례군','전라남도',null,null,'KOREA','46730' FROM dual UNION ALL 
 SELECT '46750','전라남도','46750 여천군','전라남도',null,null,'KOREA','46750' FROM dual UNION ALL 
 SELECT '46770','전라남도','46770 고흥군','전라남도',null,null,'KOREA','46770' FROM dual UNION ALL 
 SELECT '46780','전라남도','46780 보성군','전라남도',null,null,'KOREA','46780' FROM dual UNION ALL 
 SELECT '46790','전라남도','46790 화순군','전라남도',null,null,'KOREA','46790' FROM dual UNION ALL 
 SELECT '46800','전라남도','46800 장흥군','전라남도',null,null,'KOREA','46800' FROM dual UNION ALL 
 SELECT '46810','전라남도','46810 강진군','전라남도',null,null,'KOREA','46810' FROM dual UNION ALL 
 SELECT '46820','전라남도','46820 해남군','전라남도',null,null,'KOREA','46820' FROM dual UNION ALL 
 SELECT '46830','전라남도','46830 영암군','전라남도',null,null,'KOREA','46830' FROM dual UNION ALL 
 SELECT '46840','전라남도','46840 무안군','전라남도',null,null,'KOREA','46840' FROM dual UNION ALL 
 SELECT '46850','전라남도','46850 무안군','전라남도',null,null,'KOREA','46850' FROM dual UNION ALL 
 SELECT '46860','전라남도','46860 함평군','전라남도',null,null,'KOREA','46860' FROM dual UNION ALL 
 SELECT '46870','전라남도','46870 영광군','전라남도',null,null,'KOREA','46870' FROM dual UNION ALL 
 SELECT '46880','전라남도','46880 장성군','전라남도',null,null,'KOREA','46880' FROM dual UNION ALL 
 SELECT '46890','전라남도','46890 완도군','전라남도',null,null,'KOREA','46890' FROM dual UNION ALL 
 SELECT '46900','전라남도','46900 진도군','전라남도',null,null,'KOREA','46900' FROM dual UNION ALL 
 SELECT '46910','전라남도','46910 신안군','전라남도',null,null,'KOREA','46910' FROM dual UNION ALL 
 SELECT '47012','전라남도','47012 신안군','전라남도',null,null,'KOREA','47012' FROM dual UNION ALL 
 SELECT '47111','경상북도','47111 포항시 남구','경상북도',null,null,'KOREA','47111' FROM dual UNION ALL 
 SELECT '47113','경상북도','47113 포항시 북구','경상북도',null,null,'KOREA','47113' FROM dual UNION ALL 
 SELECT '47130','경상북도','47130 경주시','경상북도',null,null,'KOREA','47130' FROM dual UNION ALL 
 SELECT '47150','경상북도','47150 김천시','경상북도',null,null,'KOREA','47150' FROM dual UNION ALL 
 SELECT '47170','경상북도','47170 안동시','경상북도',null,null,'KOREA','47170' FROM dual UNION ALL 
 SELECT '47190','경상북도','47190 구미시','경상북도',null,null,'KOREA','47190' FROM dual UNION ALL 
 SELECT '47191','경상북도','47191 구미시','경상북도',null,null,'KOREA','47191' FROM dual UNION ALL 
 SELECT '47210','경상북도','47210 영주시','경상북도',null,null,'KOREA','47210' FROM dual UNION ALL 
 SELECT '47230','경상북도','47230 영천시','경상북도',null,null,'KOREA','47230' FROM dual UNION ALL 
 SELECT '47250','경상북도','47250 상주시','경상북도',null,null,'KOREA','47250' FROM dual UNION ALL 
 SELECT '47280','경상북도','47280 문경시','경상북도',null,null,'KOREA','47280' FROM dual UNION ALL 
 SELECT '47290','경상북도','47290 경산시','경상북도',null,null,'KOREA','47290' FROM dual UNION ALL 
 SELECT '47720','경상북도','47720 군위군','경상북도',null,null,'KOREA','47720' FROM dual UNION ALL 
 SELECT '47730','경상북도','47730 의성군','경상북도',null,null,'KOREA','47730' FROM dual UNION ALL 
 SELECT '47750','경상북도','47750 청송군','경상북도',null,null,'KOREA','47750' FROM dual UNION ALL 
 SELECT '47760','경상북도','47760 영양군','경상북도',null,null,'KOREA','47760' FROM dual UNION ALL 
 SELECT '47770','경상북도','47770 영덕군','경상북도',null,null,'KOREA','47770' FROM dual UNION ALL 
 SELECT '47780','경상북도','47780 영덕군','경상북도',null,null,'KOREA','47780' FROM dual UNION ALL 
 SELECT '47795','경상북도','47795 영덕군','경상북도',null,null,'KOREA','47795' FROM dual UNION ALL 
 SELECT '47820','경상북도','47820 청도군','경상북도',null,null,'KOREA','47820' FROM dual UNION ALL 
 SELECT '47830','경상북도','47830 고령군','경상북도',null,null,'KOREA','47830' FROM dual UNION ALL 
 SELECT '47840','경상북도','47840 성주군','경상북도',null,null,'KOREA','47840' FROM dual UNION ALL 
 SELECT '47850','경상북도','47850 칠곡군','경상북도',null,null,'KOREA','47850' FROM dual UNION ALL 
 SELECT '47900','경상북도','47900 예천군','경상북도',null,null,'KOREA','47900' FROM dual UNION ALL 
 SELECT '47910','경상북도','47910 예천읍','경상북도',null,null,'KOREA','47910' FROM dual UNION ALL 
 SELECT '47920','경상북도','47920 봉화군','경상북도',null,null,'KOREA','47920' FROM dual UNION ALL 
 SELECT '47930','경상북도','47930 울진군','경상북도',null,null,'KOREA','47930' FROM dual UNION ALL 
 SELECT '47940','경상북도','47940 울릉군','경상북도',null,null,'KOREA','47940' FROM dual UNION ALL 
 SELECT '48110','경상남도','48110 창원시','경상남도',null,null,'KOREA','48110' FROM dual UNION ALL 
 SELECT '48121','경상남도','48121 창원시 의창구','경상남도',null,null,'KOREA','48121' FROM dual UNION ALL 
 SELECT '48123','경상남도','48123 창원시 성산구','경상남도',null,null,'KOREA','48123' FROM dual UNION ALL 
 SELECT '48125','경상남도','48125 창원시 마산합포구','경상남도',null,null,'KOREA','48125' FROM dual UNION ALL 
 SELECT '48127','경상남도','48127 창원시 마산회원구','경상남도',null,null,'KOREA','48127' FROM dual UNION ALL 
 SELECT '48129','경상남도','48129 창원시 진해구','경상남도',null,null,'KOREA','48129' FROM dual UNION ALL 
 SELECT '48150','경상남도','48150 마산시','경상남도',null,null,'KOREA','48150' FROM dual UNION ALL 
 SELECT '48151','경상남도','48151 마산시합포구','경상남도',null,null,'KOREA','48151' FROM dual UNION ALL 
 SELECT '48153','경상남도','48153 마산시회원구','경상남도',null,null,'KOREA','48153' FROM dual UNION ALL 
 SELECT '48160','경상남도','48160 마산시','경상남도',null,null,'KOREA','48160' FROM dual UNION ALL 
 SELECT '48170','경상남도','48170 진주시','경상남도',null,null,'KOREA','48170' FROM dual UNION ALL 
 SELECT '48190','경상남도','48190 진해시','경상남도',null,null,'KOREA','48190' FROM dual UNION ALL 
 SELECT '48220','경상남도','48220 통영시','경상남도',null,null,'KOREA','48220' FROM dual UNION ALL 
 SELECT '48240','경상남도','48240 사천시','경상남도',null,null,'KOREA','48240' FROM dual UNION ALL 
 SELECT '48250','경상남도','48250 김해시','경상남도',null,null,'KOREA','48250' FROM dual UNION ALL 
 SELECT '48270','경상남도','48270 밀양시','경상남도',null,null,'KOREA','48270' FROM dual UNION ALL 
 SELECT '48310','경상남도','48310 거제시','경상남도',null,null,'KOREA','48310' FROM dual UNION ALL 
 SELECT '48330','경상남도','48330 양산시','경상남도',null,null,'KOREA','48330' FROM dual UNION ALL 
 SELECT '48720','경상남도','48720 의령군','경상남도',null,null,'KOREA','48720' FROM dual UNION ALL 
 SELECT '48730','경상남도','48730 함안군','경상남도',null,null,'KOREA','48730' FROM dual UNION ALL 
 SELECT '48740','경상남도','48740 창녕군','경상남도',null,null,'KOREA','48740' FROM dual UNION ALL 
 SELECT '48820','경상남도','48820 고성군','경상남도',null,null,'KOREA','48820' FROM dual UNION ALL 
 SELECT '48830','경상남도','48830 고성군','경상남도',null,null,'KOREA','48830' FROM dual UNION ALL 
 SELECT '48840','경상남도','48840 남해군','경상남도',null,null,'KOREA','48840' FROM dual UNION ALL 
 SELECT '48850','경상남도','48850 하동군','경상남도',null,null,'KOREA','48850' FROM dual UNION ALL 
 SELECT '48860','경상남도','48860 산청군','경상남도',null,null,'KOREA','48860' FROM dual UNION ALL 
 SELECT '48870','경상남도','48870 함양군','경상남도',null,null,'KOREA','48870' FROM dual UNION ALL 
 SELECT '48880','경상남도','48880 거창군','경상남도',null,null,'KOREA','48880' FROM dual UNION ALL 
 SELECT '48890','경상남도','48890 합천군','경상남도',null,null,'KOREA','48890' FROM dual UNION ALL 
 SELECT '49110','제주도','49110 제주시','제주도',null,null,'KOREA','49110' FROM dual UNION ALL 
 SELECT '49130','제주도','49130 서귀포시','제주도',null,null,'KOREA','49130' FROM dual UNION ALL 
 SELECT '49710','제주도','49710 북제주군','제주도',null,null,'KOREA','49710' FROM dual UNION ALL 
 SELECT '49720','제주도','49720 남제주군','제주도',null,null,'KOREA','49720' FROM dual UNION ALL 
 SELECT '50110','제주특별자치도','50110 제주시','제주특별자치도',null,null,'KOREA','50110' FROM dual UNION ALL 
 SELECT '50130','제주특별자치도','50130 서귀포시','제주특별자치도',null,null,'KOREA','50130' FROM dual UNION ALL 
 SELECT '50710','제주특별자치도','50710 북제주군','제주특별자치도',null,null,'KOREA','50710' FROM dual UNION ALL 
 SELECT '50720','제주특별자치도','50720 남제주군','제주특별자치도',null,null,'KOREA','50720' FROM dual UNION ALL 
 SELECT '90900','황해도','90900 개성시','황해도',null,null,'KOREA','90900' FROM dual--,
--('z','기타값없음','z 기타(값없음)','기타값없음',null,null,'KOREA','z'),
--('{','NONE','{ 값 없음','NONE',null,null,'KOREA','{'),
--('~','값 오류','~ 값 오류','값 오류',null,null,'KOREA','~'),
--('00000','기타','00000 기타','기타',null,null,'KOREA','00000'),
--('X00','기타','X00 기타(값없음)','기타',null,null,'KOREA','X00');
