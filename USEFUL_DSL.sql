# 컬럼명 한글 + 띄어쓰기 표기
# - ex) `수원시 누적 확진자 `,
# ''가 아닌 ``를(~) 사용 


######################## DATE_SUB 사용 ######################## 
# 이전 일자 뽑아내기

## 이전 일자
*| sql "SELECT *, max(REFERENCEDATE) OVER () AS TODAY FROM angora"              # 최신 일자
| fields REFERENCEDATE, TODAY                                                   # 기준일자와 오늘일자만 추출
| sql "SELECT REFERENCEDATE, TODAY, DATE_SUB(TODAY,1) as YESTERDAY FROM angora" # 최신 일자와 최신일자 하루 전날
| where REFERENCEDATE = YESTERDAY                                               # 하루 전날과 일치하는 내용

## 이전 년도

*| substr STANDARD_DATE_NAME 0 4 as YEAR                   # 기준 일자의 맨 앞 4자리를 연도로 사용
| sql "SELECT *, max(YEAR) over() as TODAY FROM angora"    # 기준 일자
| sql "SELECT *, DATE_SUB(TODAY,365) as LYEAR FROM angora" # 기준일자와 365일(1년) 이전 일자 추출
| substr LYEAR 0 4 as LYEAR                                # 1년 이전 일자에서 4자리만 이전 년도로 사용

###############################################################


################ 시도별 진척률 or 현황 표현하기 ################# 
*| fields SI_GUN_NAME, FOOD_WASTE_OCCURRENCE_QUANTITY, POPULATION_COUNT
| case when SI_GUN_NAME = '수원시' then FOOD_WASTE_OCCURRENCE_QUANTITY as 수원시
| case when SI_GUN_NAME = '수원시' then null FOOD_WASTE_OCCURRENCE_QUANTITY as `음식 폐기물 총량`
| sort -FOOD_WASTE_OCCURRENCE_QUANTITY
| fields SI_GUN_NAME, POPULATION_COUNT, 수원시, `음식 폐기물 총량`


##################### 다중 조건 검색 ############################
*| where DATE = NDATE AND CITY_AND_PROVINCES IN ('합계','경기')


####################### 기간 설정 ###############################
레이블 객체에 결과 값 사용 시
## 날짜 설정
- 날짜/시간선택 개체 사용
${date_time_picker_1}
## 기간 설정
- 기간설정 객체 사용
시작시간 : ${date_time_range_picker_1.startDate}
종료시간 : ${date_time_range_picker_1.endDate}
