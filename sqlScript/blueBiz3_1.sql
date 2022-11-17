-- 1.
-- 사원별 주소를 조회
-- 테이블 : EMPBASICS_T, COMCD_T
-- 조회항목 : 사원코드, 사원명, ZIP코드, 주소
SELECT A.EMPCD 사원코드,
       A.EMPNM 사원명,
       A.EMPZIPCD ZIP코드,
       B.VALUE 주소
FROM EMPBASICS_T A, COMCD_T B
WHERE B.DIV = 'zip'
  AND A.EMPZIPCD = B.CODE
ORDER BY A.EMPCD;

-- 2.
-- 사원별 년차에 해당하는 연봉을 조회
-- 테이블 : EMPBASICS_T, EMPANNUAL, YEARANALLNCO_T
-- 조회항목 : 사원코드, 사원명, 년차, 기본급, 수당, 연봉(기본급+수당)
SELECT A.EMPCD 사원코드,
       A.EMPNM 사원명,
       B.YEAR 년차,
       C.BASICS 기본급,
       C.ALLOWANCE 수당,
       C.BASICS + C.ALLOWANCE 연봉
FROM EMPBASICS_T A,
     EMPANNUAL B,
     YEARANALLNCO_T C
WHERE A.EMPCD = B.EMPCD
  AND B.YEAR = C.YEAR
ORDER BY TO_NUMBER(B.YEAR);
    
-- 3.
-- 사원별 가족관계를 조회 (본인도 포함하여 조회)
-- 테이블 : EMPBASICS_T, EMPFAMILY_T, FAMILYINFO_T, COMCD_T
-- 조회항목 : 사원코드, 가족관계코드, 가족관계명, 가족명
SELECT A.EMPCD 사원코드,
       B.RELACD 가족관계코드,
       DECODE((SELECT D.CODE FROM COMCD_T WHERE D.DIV = 'rela'), 1, D.VALUE, D.VALUE) 가족관계명,
       C.FAMILYNAME 가족명
FROM EMPBASICS_T A,
     EMPFAMILY_T B,
     FAMILYINFO_T C,
     COMCD_T D
WHERE A.EMPCD = B.EMPCD
  AND A.EMPCD = C.EMPCD
  AND B.RELACD = C.RELACD (+)
  AND B.RELACD = D.CODE(+);

-- 4.
-- 사원별 가족관계 및 자녀수당, 노인수당여부와 수당금액을 조회(사원코드, 가족관계코드 오름차순 정렬)
-- 테이블 : EMPBASICS_T, EMPFAMILY_T, FAMILYINFO_T, COMCD_T
-- 조회항목 : 사원코드, 가족관계코드, 가족관계명, 가족명, 자녀수당(Y/N), 노인수당(Y/N), 수당금액(없으면 0)
SELECT A.EMPCD 사원코드,
       B.RELACD 가족관계코드,
       D.VALUE 가족관계명,
       C.FAMILYNAME 가족명,
       NVL(B.CHILDEATRA, 'N') "자녀수당(Y/N)",
       NVL(B.OLDEATRA, 'N') "노인수당(Y/N)",
       E.VALUE "수당금액(없으면 0)"
FROM EMPBASICS_T A,
     EMPFAMILY_T B,
     FAMILYINFO_T C,
     COMCD_T D,
     COMCD_T E
WHERE A.EMPCD = B.EMPCD
  AND A.EMPCD = C.EMPCD
  AND B.RELACD = C.RELACD
  AND D.DIV = 'rela'
  AND E.DIV = 'eatra'
ORDER BY A.EMPCD, B.RELACD;

-- 5.
-- 사원별 년차정보 조회
-- 테이블 : EMPBASICS_T, EMPANNUAL, COMCD_T
-- 계산조건 : 
-- 년차수당 = 잔여일수 * 공통코드( div : annual ) 값 
-- ex> 잔여일수17일 경우 : (공통코드 '10' 값) + (공통코드 '1' 값 * 7)
-- 조회항목 : 사원코드, 사원명, 사원년차, 년차일수, 사용일수, 잔여일수, 년차수당
SELECT A.EMPCD 사원코드,
       A.EMPNM 사원명,
       B.YEAR 사원년차,
       B.ANNUALD 년차일수,
       B.QUANTITYD 사용일수,
       B.ANNUALD - B.QUANTITYD 잔여일수,
       CASE WHEN B.ANNUALD - B.QUANTITYD > 0
             AND B.ANNUALD - B.QUANTITYD < 10 THEN 50000 * (B.ANNUALD - B.QUANTITYD)
            
            WHEN B.ANNUALD - B.QUANTITYD >= 10
             AND B.ANNUALD - B.QUANTITYD < 20 THEN 600000 + (50000 * ((B.ANNUALD - B.QUANTITYD) - 10))
            
            WHEN B.ANNUALD - B.QUANTITYD >= 20
             AND B.ANNUALD - B.QUANTITYD < 30 THEN 1500000 + (50000 * ((B.AMMUALD - B.QUANTITYD) - 20))
            
            ELSE ''
             END 년차수당
FROM EMPBASICS_T A, EMPANNUAL B, COMCD_T C
WHERE A.EMPCD = B.EMPCD
  AND C.DIV = 'annual' 
ORDER BY TO_NUMBER(B.YEAR);

-- 6.
-- 사원별 휴일근무일수 / 휴일수당 조회 및 부서 표시
-- 테이블 : EMPBASICS_T, EMPSCHEDULE
-- 부서표시조건 : 사원코드앞자리로 구분 (A,B,C 는 인사부 / D,E,F 는 총무부)
-- 조회항목 : 사원코드, 사원명, 부서, 휴일근무일수, 휴일수당
SELECT A.EMPCD 사원코드,
       A.EMPNM 사원명,
       CASE WHEN A.EMPCD LIKE 'A%'
              OR A.EMPCD LIKE 'B%'
              OR A.EMPCD LIKE 'C%' THEN '인사부'
            
            WHEN A.EMPCD LIKE 'D%'
              OR A.EMPCD LIKE 'E%'
              OR A.EMPCD LIKE 'F%' THEN '총무부'
            
            ELSE ''
             END 부서,
       B.SCHEDULE 휴일근무일수,
       B.DAYEATRA 휴일수당
FROM EMPBASICS_T A, EMPSCHEDULE B
WHERE A.EMPCD = B.EMPCD
ORDER BY B.DAYEATRA;

-- 7.
-- 사원별 세전연봉, 수당을 조회하고 세금을 제외한 최종연봉을 조회
-- 테이블 : EMPBASICS_T, EMPANNUAL, COMCD_T, EMPSCHEDULE, YEARANALLNCO_T, EMPFAMILY_T, EMPTAX_T
-- 조회항목 : 사원코드, 사원명, 연봉(세전), 잔여년차수당, 휴일근무수당, 가족수당, 세금, 최종연봉
-- 조건 : 
-- 연봉(세전) : 기본급 + 수당
-- 잔여년차수당 : (년차 - 사용년차) * 공통코드(annual) 값으로 계산
-- 휴일근무수당 : EMPSCHEDULE 테이블에서 수당 합산
-- 가족수당 : 아동수당 + 노인수당
-- 세금 : 세금 + 주민세
-- 최종연봉 : 연봉(세전) + 잔여년차수당 + 휴일근무수당 + 가족수당 - 세금
SELECT A.EMPCD 사원코드,
       A.EMPNM 사원명,
       E.BASICS + E.ALLOWANCE "연봉(세전)",
       (B.ANNUALD - B.QUANTITYD) * C.VALUE 잔여년차수당,
       D.DAYEATRA 휴일근무수당,
       F.CHILDEATRA + F.OLDEATRA 가족수당,
       G.BASICSTAX + G.RESIDENCETAX 세금,
       (E.BASICS + E.ALLOWANCE) + ((B.ANNUALD - B.QUANTITYD) * C.VALUE) + D.DAYEATRA + (F.CHILDEATRA + F.OLDEATRA) - (G.BASICSTAX + G.RESIDENCETAX) 최종연봉
FROM EMPBASICS_T A, EMPANNUAL B, COMCD_T C, EMPSCHEDULE D, YEARANALLNCO_T E, EMPFAMILY_T F, EMPTAX_T G
WHERE A.EMPCD = B.EMPCD
  AND A.EMPCD = D.EMPCD
  AND A.EMPCD = F.EMPCD
  AND C.DIV = 'annual';