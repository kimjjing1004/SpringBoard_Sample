-- 1.
-- 사원별 주소를 조회
-- 테이블 : EMPBASICS_T, COMCD_T
-- 조회항목 : 사원코드, 사원명, ZIP코드, 주소

SELECT
    A.EMPCD AS "사원코드"
    , A.EMPNM AS "사원명"
    , A.EMPZIPCD AS "ZIP코드"
    , B.VALUE AS "주소"
FROM EMPBASICS_T A
    , COMCD_T B
WHERE B.DIV = 'zip'
    AND A.EMPZIPCD = B.CODE
;

-- 2.
-- 사원별 년차에 해당하는 연봉을 조회
-- 테이블 : EMPBASICS_T, EMPANNUAL, YEARANALLNCO_T
-- 조회항목 : 사원코드, 사원명, 기본급, 수당, 연봉(기본급+수당)

SELECT 
    A.EMPCD AS "사원코드"
    , A.EMPNM AS "사원명"
    , C.BASICS AS "기본급"
    , C.ALLOWANCE AS "수당"
    , C.BASICS + C.ALLOWANCE AS "연봉"
FROM EMPBASICS_T A
    , EMPANNUAL B
    , YEARANALLNCO_T C
WHERE A.EMPCD = B.EMPCD
    AND B.YEAR = C.YEAR
;
    
-- 3.
-- 사원별 가족관계를 조회
-- 테이블 : EMPBASICS_T, EMPFAMILY_T, FAMILYINFO_T, COMCD_T
-- 조회항목 : 사원코드, 가족관계코드, 가족관계명, 가족명(본인포함)

SELECT 
    A.EMPCD AS "사원코드"
    , B.RELACD AS "가족관계코드"
    , C.VALUE AS "가족관계명"
    , DECODE(C.CODE, '1', A.EMPNM, D.FAMILYNAME) AS "가족명"
FROM EMPBASICS_T A
    , EMPFAMILY_T B
    , (SELECT CODE, VALUE FROM COMCD_T WHERE DIV = 'rela') C
    , FAMILYINFO_T D
WHERE A.EMPCD = B.EMPCD
    AND B.RELACD = C.CODE
    AND B.EMPCD = D.EMPCD(+)
    AND B.RELACD = D.RELACD(+)
ORDER BY A.EMPCD, B.RELACD
;

-- 4.
-- 사원별 가족관계 및 자녀수당, 노인수당여부와 수당금액을 조회(사원코드, 가족관계코드 오름차순 정렬)
-- 테이블 : EMPBASICS_T, EMPFAMILY_T, FAMILYINFO_T, COMCD_T,
-- 조회항목 : 사원코드, 가족관계코드, 가족관계명, 가족명, 자녀수당(Y/N), 노인수당(Y/N), 수당금액(없으면 0)
SELECT 
    A.EMPCD AS "사원코드"
    , B.RELACD AS "가족관계코드"
    , C.VALUE AS "가족관계명"
    , DECODE(C.CODE, '1', A.EMPNM, D.FAMILYNAME) AS "가족명"
    , NVL(B.CHILDEATRA, 'N') AS "자녀수당여부" 
    , NVL(B.OLDEATRA, 'N') AS "노인수당여부"
    , (CASE 
            WHEN B.CHILDEATRA = 'Y' THEN E.VALUE
            WHEN B.OLDEATRA = 'Y' THEN F.VALUE
        ELSE '0'
        END) AS "수당"
FROM EMPBASICS_T A
    , EMPFAMILY_T B
    , (SELECT CODE, VALUE FROM COMCD_T WHERE DIV = 'rela') C
    , FAMILYINFO_T D
    , (SELECT CODE, VALUE FROM COMCD_T WHERE DIV = 'eatra' AND CODE = 'child') E
    , (SELECT CODE, VALUE FROM COMCD_T WHERE DIV = 'eatra' AND CODE = 'old') F
WHERE A.EMPCD = B.EMPCD
    AND B.RELACD = C.CODE
    AND B.EMPCD = D.EMPCD(+)
    AND B.RELACD = D.RELACD(+)
ORDER BY A.EMPCD ASC, B.RELACD ASC;


-- 5.
-- 사원별 년차 정보와 수당 조회
-- 테이블 : EMPBASICS_T, EMPANNUAL, COMCD_T
-- 계산조건 : 
	년차수당 = 잔여일수 * 공통코드( div : annual ) 값 
	ex> 잔여일수17일 경우 : (공통코드 '10' 값) + (공통코드 '1' 값 * 7)
-- 조회항목 : 사원코드, 사원명, 사원년차, 년차일수, 사용일수, 잔여일수, 잔여년차수당
SELECT
    A.EMPCD AS "사원코드"
    , A.EMPNM AS "사원명"
    , B.YEAR || '년차' AS "사원년차"
    , B.ANNUALD AS "년차일수"
    , B.QUANTITYD AS "사용일수"
    , (B.ANNUALD - B.QUANTITYD) AS "잔여일수"
    , DECODE(TRUNC((B.ANNUALD - B.QUANTITYD), -1), D.CODE, D.VALUE, E.CODE, E.VALUE, 0) 
      + MOD((B.ANNUALD - B.QUANTITYD), 10) * C.VALUE AS "잔여년차수당"
FROM EMPBASICS_T A
    , EMPANNUAL B
    , (SELECT CODE, VALUE FROM COMCD_T WHERE DIV = 'annual' AND CODE = '1') C
    , (SELECT CODE, VALUE FROM COMCD_T WHERE DIV = 'annual' AND CODE = '10') D
    , (SELECT CODE, VALUE FROM COMCD_T WHERE DIV = 'annual' AND CODE = '20') E
WHERE A.EMPCD = B.EMPCD;

-- 6.
-- 사원별 휴일근무일수 / 휴일수당 조회 및 부서 표시
-- 테이블 : EMPBASICS_T, EMPSCHEDULE
-- 부서표시조건 : 사원코드앞자리로 구분 (A,B,C 는 인사부 / D,E,F 는 총무부)
-- 조회항목 : 사원코드, 사원명, 부서, 휴일근무일수, 휴일근무수당
SELECT
    A.EMPCD AS "사원코드"
    , A.EMPNM AS "사원명"
    , CASE  
        WHEN SUBSTR(A.EMPCD,1,1) IN ('A','B','C') THEN '인사'
        WHEN SUBSTR(A.EMPCD,1,1) IN ('D','E','F') THEN '총무' 
        ELSE '' 
        END AS "부서"
    , COUNT(C.DAYEATRA) AS "휴일근무일수"
    , SUM(C.DAYEATRA) AS "휴일근무수당"
FROM EMPBASICS_T A
    , EMPANNUAL B
    , EMPSCHEDULE C
WHERE A.EMPCD = B.EMPCD
    AND A.EMPCD = C.EMPCD
GROUP BY A.EMPCD, A.EMPNM, B.YEAR
ORDER BY A.EMPCD
;

-- 7.
-- 사원별 세전연봉, 수당을 조회하고 세금을 제외한 최종연봉을 조회
-- 테이블 : EMPBASICS_T, EMPANNUAL, COMCD_T, EMPSCHEDULE, YEARANALLNCO_T, EMPFAMILY_T, EMPTAX_T
-- 조회항목 : 사원코드, 사원명, 연봉(세전), 잔여년차수당, 휴일근무수당, 가족수당, 세금, 최종연봉
-- 조건 : 
	연봉(세전) : 기본급 + 수당
	잔여년차수당 : (년차 - 사용년차) * 공통코드(annual) 값으로 계산
	휴일근무수당 : EMPSCHEDULE 테이블에서 수당 합산
	가족수당 : 아동수당 + 노인수당
	세금 : 세금 + 주민세
	최종연봉 : 연봉(세전) + 잔여년차수당 + 휴일근무수당 + 가족수당 - 세금 
SELECT 
    AA.EMPCD AS "사원코드"
    , AA.EMPNM AS "사원명"
    , (AA.BASICS + AA.ALLOWANCE) AS "연봉(세전)"
    , AA.ANNUAL_PAY AS "잔여년차수당"
    , AA.SCHEDULE_PAY AS "휴일근무수당"
    , (AA.CHILD_PAY + AA.OLD_PAY) AS "가족수당"
    , (AA.BASICSTAX + AA.RESIDENCETAX) AS "세금"
    , (AA.BASICS + AA.ALLOWANCE 
        + AA.ANNUAL_PAY + AA.SCHEDULE_PAY 
        + AA.CHILD_PAY + AA.OLD_PAY 
        - AA.BASICSTAX - AA.RESIDENCETAX) AS "최종연봉"
FROM (
SELECT
    A.EMPCD             /* 사원코드 */
    , A.EMPNM           /* 사원명 */
    , G.BASICS          /* 기본급 */
    , G.ALLOWANCE       /* 수당 */
    , B.ANNUALD         /* 년차 */
    , B.QUANTITYD       /* 사용년차 */
    , DECODE(TRUNC((B.ANNUALD - B.QUANTITYD), -1), D.CODE, D.VALUE, E.CODE, E.VALUE, 0) 
      + MOD((B.ANNUALD - B.QUANTITYD), 10) * C.VALUE AS ANNUAL_PAY                  /* 잔여년차수당 */
    , (SELECT SUM(DAYEATRA) FROM EMPSCHEDULE WHERE EMPCD = A.EMPCD) AS SCHEDULE_PAY /* 휴일근무수당*/
    , H.CHILD_PAY       /* 아동수당 */
    , H.OLD_PAY         /* 노인수당 */
    , F.BASICSTAX       /* 세금 */
    , F.RESIDENCETAX    /* 주민세 */
FROM EMPBASICS_T A
    , EMPANNUAL B
    , (SELECT CODE, VALUE FROM COMCD_T WHERE DIV = 'annual' AND CODE = '1') C
    , (SELECT CODE, VALUE FROM COMCD_T WHERE DIV = 'annual' AND CODE = '10') D
    , (SELECT CODE, VALUE FROM COMCD_T WHERE DIV = 'annual' AND CODE = '20') E
    , EMPTAX_T F
    , YEARANALLNCO_T G
    , (SELECT EMPCD, SUM(DECODE(CHILDEATRA,'Y',XX.VALUE,0)) CHILD_PAY
            , SUM(DECODE(OLDEATRA,'Y',YY.VALUE,0)) OLD_PAY
        FROM EMPFAMILY_T
            , (SELECT CODE,VALUE FROM COMCD_T WHERE CODE = 'child') XX
            , (SELECT CODE,VALUE FROM COMCD_T WHERE CODE = 'old') YY 
        GROUP BY EMPCD) H
WHERE A.EMPCD = B.EMPCD
    AND B.YEAR = G.YEAR
    AND A.EMPCD = H.EMPCD
    AND B.YEAR = F.YEAR
ORDER BY EMPCD
) AA;