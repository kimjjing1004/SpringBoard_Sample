DESC EMPANNUAL;

SELECT CONCAT(CONCAT(EMPCD, ' ') ,YEAR) AS CONCAT
    , LOWER(EMPCD) LOWER
    , UPPER(EMPCD) UPPER
    , LPAD(ANNUALD, 10, 0) LPAD
    , RPAD(ANNUALD, 10, 'A') RPAD
    , SUBSTR(EMPCD, 2,3) SUBSTR
    , LTRIM(EMPCD, 'A') LTRIM
    , RTRIM(EMPCD, '1') RTRIM
    , LENGTH(EMPCD) LENGTH
    , MOD(ANNUALD, 10) MOD
FROM EMPANNUAL;

SELECT 
      NVL(CHILDEATRA, '없음') NVL
    , TO_CHAR(SYSDATE, 'YYYY-MM-DD hh24:mm:dd:ss') AS A
    , TO_CHAR(ADD_MONTHS(SYSDATE, 1), 'YYYY-MM-DD hh24:mm:dd:ss') AS B
FROM EMPFAMILY_T;

SELECT 
      EMPCD
    , SUM(REMIANDAY) AS REMIANDAY_SUM
FROM EMPANNUALHISTORY_T
GROUP BY EMPCD
HAVING SUM(REMIANDAY) > 50
;

SELECT DISTINCT EMPCD FROM EMPANNUALHISTORY_T;

SELECT * FROM EMPANNUALHISTORY_T
WHERE REMIANDAY > 10;


/* 
-- MYBATIS
SELECT * FROM EMPANNUALHISTORY_T
WHERE 
<![CDATA[
REMIANDAY > 10
]]>
*/

/* 
MERGE INTO EMPBASICS_T A
 USING DUAL
    ON (A.EMPCD = 'G001')
WHEN MATCHED THEN
    UPDATE
        SET A.EMPZIPCD = '12345' --65434
WHEN NOT MATCHED THEN
    INSERT (A.EMPCD, A.EMPNM, A.EMPZIPCD)
    VALUES('G001','홍길동','23456');
*/

/* SYS계정에서 권한 : grant create view to 계정
CREATE OR REPLACE FORCE VIEW V_EMP_BASIC_01 (EMPCD, EMPNM, EMPZIPCD, VALUE) AS 
SELECT
    A.EMPCD
    , A.EMPNM
    , A.EMPZIPCD
    , B.VALUE
FROM EMPBASICS_T A
    , COMCD_T B
WHERE B.DIV = 'zip'
    AND A.EMPZIPCD = B.CODE
;
*/

SELECT * FROM V_EMP_BASIC_01;

/*
create or replace FUNCTION GET_BLUE_EMP_INFO
    (
    V_EMPCD IN VARCHAR2
    )
RETURN VARCHAR2
IS
    V_EMP_ADDR VARCHAR2(400);
BEGIN
    SELECT
        B.VALUE
    INTO V_EMP_ADDR
    FROM EMPBASICS_T A
        , COMCD_T B
    WHERE B.DIV = 'zip'
        AND A.EMPZIPCD = B.CODE
        AND A.EMPCD = V_EMPCD
    ;

    RETURN V_EMP_ADDR;
END GET_BLUE_EMP_INFO;
*/

SELECT GET_BLUE_EMP_INFO('A001') FROM DUAL;