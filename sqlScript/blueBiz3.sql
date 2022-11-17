
---------------------------------------------------------------------------------------

CREATE TABLE EMPBASICS_T(
             EMPCD VARCHAR2(4) NOT NULL,
             EMPNM VARCHAR2(20) NOT NULL,
             EMPZIPCD VARCHAR2(5) NOT NULL
            );

CREATE TABLE EMPTAX_T (
             YEAR VARCHAR2(2) NOT NULL ,
             BASICSTAX NUMBER(15) NOT NULL,
             RESIDENCETAX NUMBER(20) NOT NULL
             );

CREATE TABLE EMPFAMILY_T (
       EMPCD VARCHAR2(4) NOT NULL,
       RELACD VARCHAR2(1) NOT NULL,
       CHILDEATRA VARCHAR2(1) NULL,
       OLDEATRA VARCHAR2(1) NULL
      );

CREATE TABLE EMPANNUAL (
             EMPCD VARCHAR2(4) NOT NULL,
             ANNUALD NUMBER(2) NOT NULL,
             QUANTITYD NUMBER(2) NOT NULL,
             YEAR VARCHAR2(2) NOT NULL
    );

CREATE TABLE EMPANALLNCO_T (
             EMPCD VARCHAR2(5) NOT NULL,
             ANALLNCO NUMBER(15) NOT NULL
    );

CREATE TABLE COMCD_T (
            DIV VARCHAR2(7) NOT NULL,
            CODE VARCHAR2(10) NOT NULL,
            VALUE VARCHAR2(50) NOT NULL
    );

CREATE TABLE FAMILYINFO_T (
            EMPCD VARCHAR2(4) NOT NULL,
            RELACD VARCHAR2(1) NOT NULL,
            FAMILYNAME VARCHAR2(20) NOT NULL
    );

CREATE TABLE EMPSCHEDULE (
        MONTH NUMBER(2) NOT NULL,
        SCHEDULE NUMBER(2) NOT NULL,
        EMPCD NVARCHAR2(4) NOT NULL,
        DAYEATRA NUMBER(10) NOT NULL
    );

CREATE TABLE YEARANALLNCO_T (
            YEAR VARCHAR2(2) NOT NULL,
            BASICS NUMBER(10) NOT NULL,
            ALLOWANCE NUMBER(10) NOT NULL
    );

CREATE TABLE EMPANNUALHISTORY_T (
            EMPCD VARCHAR2(4) NOT NULL,
            YEAR VARCHAR2(4) NOT NULL,
            REMIANDAY NUMBER(2) NOT NULL
    );

---------------------------------------------------------------------------------------

CREATE UNIQUE INDEX PK_EMPBASICS_T ON EMPBASICS_T(EMPCD);
CREATE UNIQUE INDEX PK_EMPTAX_T ON EMPTAX_T(YEAR);
CREATE UNIQUE INDEX PK_EMPFAMILY_T ON EMPFAMILY_T(EMPCD,RELACD); 
CREATE UNIQUE INDEX PK_EMPANNUAL ON EMPANNUAL(EMPCD); 
CREATE UNIQUE INDEX PK_EMPANALLNCO_T ON EMPANALLNCO_T(EMPCD); 
CREATE UNIQUE INDEX PK_FAMILYINFO_T ON FAMILYINFO_T(EMPCD,RELACD); 
CREATE UNIQUE INDEX PK_YEARANALLNCO_T ON YEARANALLNCO_T(YEAR);
CREATE UNIQUE INDEX PK_EMPANNUALHISTORY_T ON EMPANNUALHISTORY_T(EMPCD,YEAR); 

---------------------------------------------------------------------------------------

COMMENT ON COLUMN EMPBASICS_T.EMPCD IS '사원코드';
COMMENT ON COLUMN EMPBASICS_T.EMPNM IS '사원명';
COMMENT ON COLUMN EMPBASICS_T.EMPZIPCD IS '사원주소코드';
COMMENT ON TABLE EMPBASICS_T  IS '사원관리';

COMMENT ON COLUMN EMPTAX_T.YEAR IS '년도';
COMMENT ON COLUMN EMPTAX_T.BASICSTAX IS '세금';
COMMENT ON COLUMN EMPTAX_T.RESIDENCETAX IS '주민세';
COMMENT ON TABLE EMPTAX_T  IS '년도별세금';

COMMENT ON COLUMN EMPFAMILY_T.EMPCD IS '사원코드';
COMMENT ON COLUMN EMPFAMILY_T.RELACD IS '가족관계코드';
COMMENT ON COLUMN EMPFAMILY_T.CHILDEATRA IS '자녀수당';
COMMENT ON COLUMN EMPFAMILY_T.OLDEATRA IS '노인수당';
COMMENT ON TABLE EMPFAMILY_T  IS '사원가족관계';

COMMENT ON COLUMN EMPANNUAL.EMPCD IS '사원코드';
COMMENT ON COLUMN EMPANNUAL.ANNUALD IS '년차일수';
COMMENT ON COLUMN EMPANNUAL.QUANTITYD IS '사용년차';
COMMENT ON COLUMN EMPANNUAL.YEAR IS '년차';
COMMENT ON TABLE EMPANNUAL  IS '사원별년차일수';

COMMENT ON COLUMN EMPANALLNCO_T.EMPCD IS '사원코드';
COMMENT ON COLUMN EMPANALLNCO_T.ANALLNCO IS '사원연봉';
COMMENT ON TABLE EMPANALLNCO_T  IS '사원별연봉';
   
COMMENT ON COLUMN COMCD_T.DIV IS '구분';
COMMENT ON COLUMN COMCD_T.CODE IS '코드';
COMMENT ON COLUMN COMCD_T.VALUE IS '값';
COMMENT ON TABLE COMCD_T  IS '공통코드';

COMMENT ON COLUMN FAMILYINFO_T.EMPCD IS '사원코드';
COMMENT ON COLUMN FAMILYINFO_T.RELACD IS '가족관계';
COMMENT ON COLUMN FAMILYINFO_T.FAMILYNAME IS '가족명';
COMMENT ON TABLE FAMILYINFO_T  IS '가족관계';

COMMENT ON COLUMN EMPSCHEDULE.MONTH IS '근무월';
COMMENT ON COLUMN EMPSCHEDULE.SCHEDULE IS '근무일';
COMMENT ON COLUMN EMPSCHEDULE.EMPCD IS '사원코드';
COMMENT ON COLUMN EMPSCHEDULE.DAYEATRA IS '일수당';
COMMENT ON TABLE EMPSCHEDULE  IS '사원휴일수당';

COMMENT ON COLUMN YEARANALLNCO_T.YEAR IS '년차';
COMMENT ON COLUMN YEARANALLNCO_T.BASICS IS '기본급';
COMMENT ON COLUMN YEARANALLNCO_T.ALLOWANCE IS '수당';
COMMENT ON TABLE YEARANALLNCO_T  IS '년차별연봉';

COMMENT ON COLUMN EMPANNUALHISTORY_T.EMPCD IS '사원코드';
COMMENT ON COLUMN EMPANNUALHISTORY_T.YEAR IS '년차';
COMMENT ON COLUMN EMPANNUALHISTORY_T.REMIANDAY IS '년차일수';
COMMENT ON TABLE EMPANNUALHISTORY_T  IS '사원별년차일수히스토리';

---------------------------------------------------------------------------------------

INSERT INTO EMPBASICS_T (EMPCD, EMPNM, EMPZIPCD) VALUES ('A001', '박미자', '65434');
INSERT INTO EMPBASICS_T (EMPCD, EMPNM, EMPZIPCD) VALUES ('B001', '홍자연', '54654');
INSERT INTO EMPBASICS_T (EMPCD, EMPNM, EMPZIPCD) VALUES ('C001', '김인식', '23453');
INSERT INTO EMPBASICS_T (EMPCD, EMPNM, EMPZIPCD) VALUES ('D001', '이현상', '54345');
INSERT INTO EMPBASICS_T (EMPCD, EMPNM, EMPZIPCD) VALUES ('E001', '현미경', '65456');
INSERT INTO EMPBASICS_T (EMPCD, EMPNM, EMPZIPCD) VALUES ('F001', '최인섭', '34523');

INSERT INTO EMPTAX_T (YEAR, BASICSTAX, RESIDENCETAX) VALUES (1, 65200000, 6520000);
INSERT INTO EMPTAX_T (YEAR, BASICSTAX, RESIDENCETAX) VALUES (2, 65350000, 6535000);
INSERT INTO EMPTAX_T (YEAR, BASICSTAX, RESIDENCETAX) VALUES (3, 65500000, 6550000);
INSERT INTO EMPTAX_T (YEAR, BASICSTAX, RESIDENCETAX) VALUES (4, 65650000, 6565000);
INSERT INTO EMPTAX_T (YEAR, BASICSTAX, RESIDENCETAX) VALUES (5, 65800000, 6580000);
INSERT INTO EMPTAX_T (YEAR, BASICSTAX, RESIDENCETAX) VALUES (6, 65950000, 6595000);
INSERT INTO EMPTAX_T (YEAR, BASICSTAX, RESIDENCETAX) VALUES (7, 66100000, 6610000);
INSERT INTO EMPTAX_T (YEAR, BASICSTAX, RESIDENCETAX) VALUES (8, 66250000, 6625000);
INSERT INTO EMPTAX_T (YEAR, BASICSTAX, RESIDENCETAX) VALUES (9, 66400000, 6640000);
INSERT INTO EMPTAX_T (YEAR, BASICSTAX, RESIDENCETAX) VALUES (10, 66550000, 6655000);
INSERT INTO EMPTAX_T (YEAR, BASICSTAX, RESIDENCETAX) VALUES (11, 66700000, 6670000);
INSERT INTO EMPTAX_T (YEAR, BASICSTAX, RESIDENCETAX) VALUES (12, 66850000, 6685000);
INSERT INTO EMPTAX_T (YEAR, BASICSTAX, RESIDENCETAX) VALUES (13, 67000000, 6700000);
INSERT INTO EMPTAX_T (YEAR, BASICSTAX, RESIDENCETAX) VALUES (14, 67150000, 6715000);
INSERT INTO EMPTAX_T (YEAR, BASICSTAX, RESIDENCETAX) VALUES (15, 67300000, 6730000);

INSERT INTO EMPFAMILY_T (EMPCD, RELACD) VALUES ('A001', '1'); 
INSERT INTO EMPFAMILY_T (EMPCD, RELACD) VALUES ('A001', '2');
INSERT INTO EMPFAMILY_T (EMPCD, RELACD, CHILDEATRA) VALUES ('A001', '3', 'Y');
INSERT INTO EMPFAMILY_T (EMPCD, RELACD) VALUES ('B001', '1');
INSERT INTO EMPFAMILY_T (EMPCD, RELACD) VALUES ('C001', '1');
INSERT INTO EMPFAMILY_T (EMPCD, RELACD) VALUES ('C001', '2');
INSERT INTO EMPFAMILY_T (EMPCD, RELACD) VALUES ('D001', '1');
INSERT INTO EMPFAMILY_T (EMPCD, RELACD) VALUES ('D001', '2');
INSERT INTO EMPFAMILY_T (EMPCD, RELACD, CHILDEATRA) VALUES ('D001', '3', 'Y');
INSERT INTO EMPFAMILY_T (EMPCD, RELACD, OLDEATRA) VALUES ('D001', '9', 'Y');
INSERT INTO EMPFAMILY_T (EMPCD, RELACD) VALUES ('E001', '1');
INSERT INTO EMPFAMILY_T (EMPCD, RELACD) VALUES ('E001', '2');
INSERT INTO EMPFAMILY_T (EMPCD, RELACD, CHILDEATRA) VALUES ('E001', '4', 'Y');
INSERT INTO EMPFAMILY_T (EMPCD, RELACD, CHILDEATRA) VALUES ('E001', '3', 'Y');
INSERT INTO EMPFAMILY_T (EMPCD, RELACD, OLDEATRA) VALUES ('E001', '9', 'Y');
INSERT INTO EMPFAMILY_T (EMPCD, RELACD) VALUES ('F001', '1');
INSERT INTO EMPFAMILY_T (EMPCD, RELACD) VALUES ('F001', '2');
INSERT INTO EMPFAMILY_T (EMPCD, RELACD, CHILDEATRA) VALUES ('F001', '3', 'Y');

INSERT INTO EMPANNUAL VALUES ('A001', 15, 6, '1');
INSERT INTO EMPANNUAL VALUES ('B001', 20, 9, '6');
INSERT INTO EMPANNUAL VALUES ('C001', 17, 3, '3');
INSERT INTO EMPANNUAL VALUES ('D001', 21, 5, '7');
INSERT INTO EMPANNUAL VALUES ('E001', 23, 11, '9');
INSERT INTO EMPANNUAL VALUES ('F001', 25, 5, '11');

INSERT INTO EMPANALLNCO_T VALUES ('A001', 780000000);
INSERT INTO EMPANALLNCO_T VALUES ('B001', 695000000);
INSERT INTO EMPANALLNCO_T VALUES ('C001', 655000000);
INSERT INTO EMPANALLNCO_T VALUES ('D001', 652000000);
INSERT INTO EMPANALLNCO_T VALUES ('E001', 752000000);
INSERT INTO EMPANALLNCO_T VALUES ('F001', 710000000);

INSERT INTO COMCD_T VALUES ('rela', '1', '본인');
INSERT INTO COMCD_T VALUES ('rela', '2', '배우자');
INSERT INTO COMCD_T VALUES ('rela', '3', '미성년자녀');
INSERT INTO COMCD_T VALUES ('rela', '4', '성인자녀');
INSERT INTO COMCD_T VALUES ('rela', '9', '부모');
INSERT INTO COMCD_T VALUES ('zip', '65434', '서울시 강서구 화곡로68길 82');
INSERT INTO COMCD_T VALUES ('zip', '54654', '인천시 남동구 청각로29');
INSERT INTO COMCD_T VALUES ('zip', '23453', '군산시 미원로 33길');
INSERT INTO COMCD_T VALUES ('zip', '54345', '인천시 남동구 사각로 32');
INSERT INTO COMCD_T VALUES ('zip', '65456', '서울시 강서구 화곡로 32길');
INSERT INTO COMCD_T VALUES ('zip', '34523', '전주시 완주군 완주로 43길');
INSERT INTO COMCD_T VALUES ('eatra', 'child', '20000');
INSERT INTO COMCD_T VALUES ('eatra', 'old', '50000');
INSERT INTO COMCD_T VALUES ('annual', '1', '50000');
INSERT INTO COMCD_T VALUES ('annual', '10', '600000');
INSERT INTO COMCD_T VALUES ('annual', '20', '1500000');

INSERT INTO FAMILYINFO_T VALUES ('A001', '2', '김길동');
INSERT INTO FAMILYINFO_T VALUES ('A001', '3', '김인석');
INSERT INTO FAMILYINFO_T VALUES ('C001', '2', '홍미연');
INSERT INTO FAMILYINFO_T VALUES ('D001', '2', '김연미');
INSERT INTO FAMILYINFO_T VALUES ('D001', '3', '이미현');
INSERT INTO FAMILYINFO_T VALUES ('D001', '9', '최길자');
INSERT INTO FAMILYINFO_T VALUES ('E001', '2', '김자현');
INSERT INTO FAMILYINFO_T VALUES ('E001', '3', '현수');
INSERT INTO FAMILYINFO_T VALUES ('E001', '4', '현미');
INSERT INTO FAMILYINFO_T VALUES ('E001', '9', '박말자');
INSERT INTO FAMILYINFO_T VALUES ('F001', '2', '이숙현');
INSERT INTO FAMILYINFO_T VALUES ('F001', '3', '최미주');

INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (1, 1, 'A001', 500000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (1, 1, 'C001', 500000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (1, 1, 'E001', 500000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (1, 5, 'A001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (1, 19, 'B001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (1, 19, 'D001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (1, 19, 'F001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (1, 19, 'E001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (1, 26, 'B001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (2, 2, 'A001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (2, 2, 'B001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (2, 9, 'C001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (2, 9, 'D001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (2, 16, 'E001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (2, 16, 'F001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (2, 23, 'D001', 500000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (2, 23, 'E001', 500000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (3, 1, 'F001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (3, 1, 'E001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (3, 8, 'D001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (3, 8, 'C001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (3, 15, 'B001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (3, 15, 'A001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (3, 22, 'B001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (3, 22, 'C001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (3, 29, 'D001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (3, 29, 'F001', 350000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (4, 5, 'A001', 150000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (4, 5, 'B001', 150000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (4, 12, 'C001', 150000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (4, 12, 'D001', 150000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (4, 26, 'E001', 150000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (4, 26, 'F001', 150000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (5, 3, 'B001', 100000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (5, 3, 'D001', 100000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (5, 10, 'F001', 100000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (5, 10, 'A001', 100000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (5, 17, 'E001', 100000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (5, 17, 'D001', 100000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (5, 24, 'C001', 100000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (5, 24, 'E001', 100000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (5, 31, 'F001', 100000);
INSERT INTO EMPSCHEDULE (MONTH, SCHEDULE, EMPCD, DAYEATRA) VALUES (5, 31, 'D001', 100000);

INSERT INTO YEARANALLNCO_T VALUES ('1', 652000000,50000000);
INSERT INTO YEARANALLNCO_T VALUES ('2', 660000000,50000000);
INSERT INTO YEARANALLNCO_T VALUES ('3', 670000000, 50000000);
INSERT INTO YEARANALLNCO_T VALUES ('4', 680000000, 50000000);
INSERT INTO YEARANALLNCO_T VALUES ('5', 690000000, 50000000);
INSERT INTO YEARANALLNCO_T VALUES ('6', 700000000, 50000000);
INSERT INTO YEARANALLNCO_T VALUES ('7', 710000000, 50000000);
INSERT INTO YEARANALLNCO_T VALUES ('8', 720000000, 50000000);
INSERT INTO YEARANALLNCO_T VALUES ('9', 730000000, 50000000);
INSERT INTO YEARANALLNCO_T VALUES ('10', 740000000, 55000000);
INSERT INTO YEARANALLNCO_T VALUES ('11', 750000000, 57000000);
INSERT INTO YEARANALLNCO_T VALUES ('12', 760000000, 59000000);
INSERT INTO YEARANALLNCO_T VALUES ('13', 770000000, 61000000);
INSERT INTO YEARANALLNCO_T VALUES ('14', 780000000, 63000000);

INSERT INTO EMPANNUALHISTORY_T VALUES ('A001', 1,9);
INSERT INTO EMPANNUALHISTORY_T VALUES ('B001', 1,5);
INSERT INTO EMPANNUALHISTORY_T VALUES ('B001', 2, 7);
INSERT INTO EMPANNUALHISTORY_T VALUES ('B001', 3, 9);
INSERT INTO EMPANNUALHISTORY_T VALUES ('B001', 4, 3);
INSERT INTO EMPANNUALHISTORY_T VALUES ('B001', 5, 10);
INSERT INTO EMPANNUALHISTORY_T VALUES ('B001', 6, 11);
INSERT INTO EMPANNUALHISTORY_T VALUES ('C001', 1, 5);
INSERT INTO EMPANNUALHISTORY_T VALUES ('C001', 2, 10);
INSERT INTO EMPANNUALHISTORY_T VALUES ('C001', 3, 14);
INSERT INTO EMPANNUALHISTORY_T VALUES ('D001', 1, 7);
INSERT INTO EMPANNUALHISTORY_T VALUES ('D001', 2, 2);
INSERT INTO EMPANNUALHISTORY_T VALUES ('D001', 3, 1);
INSERT INTO EMPANNUALHISTORY_T VALUES ('D001', 4, 15);
INSERT INTO EMPANNUALHISTORY_T VALUES ('D001', 5,11);
INSERT INTO EMPANNUALHISTORY_T VALUES ('D001', 6,10);
INSERT INTO EMPANNUALHISTORY_T VALUES ('D001', 7, 9);
INSERT INTO EMPANNUALHISTORY_T VALUES ('E001', 1, 3);
INSERT INTO EMPANNUALHISTORY_T VALUES ('E001', 2, 5);
INSERT INTO EMPANNUALHISTORY_T VALUES ('E001', 3, 3);
INSERT INTO EMPANNUALHISTORY_T VALUES ('E001', 4, 6);
INSERT INTO EMPANNUALHISTORY_T VALUES ('E001', 5, 7);
INSERT INTO EMPANNUALHISTORY_T VALUES ('E001', 6, 2);
INSERT INTO EMPANNUALHISTORY_T VALUES ('E001', 7, 5);
INSERT INTO EMPANNUALHISTORY_T VALUES ('E001', 8, 8);
INSERT INTO EMPANNUALHISTORY_T VALUES ('E001', 9, 12);
INSERT INTO EMPANNUALHISTORY_T VALUES ('F001', 1,10);
INSERT INTO EMPANNUALHISTORY_T VALUES ('F001', 2, 4);
INSERT INTO EMPANNUALHISTORY_T VALUES ('F001', 3, 15);
INSERT INTO EMPANNUALHISTORY_T VALUES ('F001', 4, 3);
INSERT INTO EMPANNUALHISTORY_T VALUES ('F001', 5, 2);
INSERT INTO EMPANNUALHISTORY_T VALUES ('F001', 6, 10);
INSERT INTO EMPANNUALHISTORY_T VALUES ('F001', 7, 11);
INSERT INTO EMPANNUALHISTORY_T VALUES ('F001', 8, 15);
INSERT INTO EMPANNUALHISTORY_T VALUES ('F001', 9, 18);
INSERT INTO EMPANNUALHISTORY_T VALUES ('F001', 10, 21);
INSERT INTO EMPANNUALHISTORY_T VALUES ('F001', 11, 20);

---------------------------------------------------------------------------------------

COMMIT;
