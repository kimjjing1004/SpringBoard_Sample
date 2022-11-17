-- 1.
-- ����� �ּҸ� ��ȸ
-- ���̺� : EMPBASICS_T, COMCD_T
-- ��ȸ�׸� : ����ڵ�, �����, ZIP�ڵ�, �ּ�

SELECT
    A.EMPCD AS "����ڵ�"
    , A.EMPNM AS "�����"
    , A.EMPZIPCD AS "ZIP�ڵ�"
    , B.VALUE AS "�ּ�"
FROM EMPBASICS_T A
    , COMCD_T B
WHERE B.DIV = 'zip'
    AND A.EMPZIPCD = B.CODE
;

-- 2.
-- ����� ������ �ش��ϴ� ������ ��ȸ
-- ���̺� : EMPBASICS_T, EMPANNUAL, YEARANALLNCO_T
-- ��ȸ�׸� : ����ڵ�, �����, �⺻��, ����, ����(�⺻��+����)

SELECT 
    A.EMPCD AS "����ڵ�"
    , A.EMPNM AS "�����"
    , C.BASICS AS "�⺻��"
    , C.ALLOWANCE AS "����"
    , C.BASICS + C.ALLOWANCE AS "����"
FROM EMPBASICS_T A
    , EMPANNUAL B
    , YEARANALLNCO_T C
WHERE A.EMPCD = B.EMPCD
    AND B.YEAR = C.YEAR
;
    
-- 3.
-- ����� �������踦 ��ȸ
-- ���̺� : EMPBASICS_T, EMPFAMILY_T, FAMILYINFO_T, COMCD_T
-- ��ȸ�׸� : ����ڵ�, ���������ڵ�, ���������, ������(��������)

SELECT 
    A.EMPCD AS "����ڵ�"
    , B.RELACD AS "���������ڵ�"
    , C.VALUE AS "���������"
    , DECODE(C.CODE, '1', A.EMPNM, D.FAMILYNAME) AS "������"
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
-- ����� �������� �� �ڳ����, ���μ��翩�ο� ����ݾ��� ��ȸ(����ڵ�, ���������ڵ� �������� ����)
-- ���̺� : EMPBASICS_T, EMPFAMILY_T, FAMILYINFO_T, COMCD_T,
-- ��ȸ�׸� : ����ڵ�, ���������ڵ�, ���������, ������, �ڳ����(Y/N), ���μ���(Y/N), ����ݾ�(������ 0)
SELECT 
    A.EMPCD AS "����ڵ�"
    , B.RELACD AS "���������ڵ�"
    , C.VALUE AS "���������"
    , DECODE(C.CODE, '1', A.EMPNM, D.FAMILYNAME) AS "������"
    , NVL(B.CHILDEATRA, 'N') AS "�ڳ���翩��" 
    , NVL(B.OLDEATRA, 'N') AS "���μ��翩��"
    , (CASE 
            WHEN B.CHILDEATRA = 'Y' THEN E.VALUE
            WHEN B.OLDEATRA = 'Y' THEN F.VALUE
        ELSE '0'
        END) AS "����"
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
-- ����� ���� ������ ���� ��ȸ
-- ���̺� : EMPBASICS_T, EMPANNUAL, COMCD_T
-- ������� : 
	�������� = �ܿ��ϼ� * �����ڵ�( div : annual ) �� 
	ex> �ܿ��ϼ�17�� ��� : (�����ڵ� '10' ��) + (�����ڵ� '1' �� * 7)
-- ��ȸ�׸� : ����ڵ�, �����, �������, �����ϼ�, ����ϼ�, �ܿ��ϼ�, �ܿ���������
SELECT
    A.EMPCD AS "����ڵ�"
    , A.EMPNM AS "�����"
    , B.YEAR || '����' AS "�������"
    , B.ANNUALD AS "�����ϼ�"
    , B.QUANTITYD AS "����ϼ�"
    , (B.ANNUALD - B.QUANTITYD) AS "�ܿ��ϼ�"
    , DECODE(TRUNC((B.ANNUALD - B.QUANTITYD), -1), D.CODE, D.VALUE, E.CODE, E.VALUE, 0) 
      + MOD((B.ANNUALD - B.QUANTITYD), 10) * C.VALUE AS "�ܿ���������"
FROM EMPBASICS_T A
    , EMPANNUAL B
    , (SELECT CODE, VALUE FROM COMCD_T WHERE DIV = 'annual' AND CODE = '1') C
    , (SELECT CODE, VALUE FROM COMCD_T WHERE DIV = 'annual' AND CODE = '10') D
    , (SELECT CODE, VALUE FROM COMCD_T WHERE DIV = 'annual' AND CODE = '20') E
WHERE A.EMPCD = B.EMPCD;

-- 6.
-- ����� ���ϱٹ��ϼ� / ���ϼ��� ��ȸ �� �μ� ǥ��
-- ���̺� : EMPBASICS_T, EMPSCHEDULE
-- �μ�ǥ������ : ����ڵ���ڸ��� ���� (A,B,C �� �λ�� / D,E,F �� �ѹ���)
-- ��ȸ�׸� : ����ڵ�, �����, �μ�, ���ϱٹ��ϼ�, ���ϱٹ�����
SELECT
    A.EMPCD AS "����ڵ�"
    , A.EMPNM AS "�����"
    , CASE  
        WHEN SUBSTR(A.EMPCD,1,1) IN ('A','B','C') THEN '�λ�'
        WHEN SUBSTR(A.EMPCD,1,1) IN ('D','E','F') THEN '�ѹ�' 
        ELSE '' 
        END AS "�μ�"
    , COUNT(C.DAYEATRA) AS "���ϱٹ��ϼ�"
    , SUM(C.DAYEATRA) AS "���ϱٹ�����"
FROM EMPBASICS_T A
    , EMPANNUAL B
    , EMPSCHEDULE C
WHERE A.EMPCD = B.EMPCD
    AND A.EMPCD = C.EMPCD
GROUP BY A.EMPCD, A.EMPNM, B.YEAR
ORDER BY A.EMPCD
;

-- 7.
-- ����� ��������, ������ ��ȸ�ϰ� ������ ������ ���������� ��ȸ
-- ���̺� : EMPBASICS_T, EMPANNUAL, COMCD_T, EMPSCHEDULE, YEARANALLNCO_T, EMPFAMILY_T, EMPTAX_T
-- ��ȸ�׸� : ����ڵ�, �����, ����(����), �ܿ���������, ���ϱٹ�����, ��������, ����, ��������
-- ���� : 
	����(����) : �⺻�� + ����
	�ܿ��������� : (���� - ������) * �����ڵ�(annual) ������ ���
	���ϱٹ����� : EMPSCHEDULE ���̺��� ���� �ջ�
	�������� : �Ƶ����� + ���μ���
	���� : ���� + �ֹμ�
	�������� : ����(����) + �ܿ��������� + ���ϱٹ����� + �������� - ���� 
SELECT 
    AA.EMPCD AS "����ڵ�"
    , AA.EMPNM AS "�����"
    , (AA.BASICS + AA.ALLOWANCE) AS "����(����)"
    , AA.ANNUAL_PAY AS "�ܿ���������"
    , AA.SCHEDULE_PAY AS "���ϱٹ�����"
    , (AA.CHILD_PAY + AA.OLD_PAY) AS "��������"
    , (AA.BASICSTAX + AA.RESIDENCETAX) AS "����"
    , (AA.BASICS + AA.ALLOWANCE 
        + AA.ANNUAL_PAY + AA.SCHEDULE_PAY 
        + AA.CHILD_PAY + AA.OLD_PAY 
        - AA.BASICSTAX - AA.RESIDENCETAX) AS "��������"
FROM (
SELECT
    A.EMPCD             /* ����ڵ� */
    , A.EMPNM           /* ����� */
    , G.BASICS          /* �⺻�� */
    , G.ALLOWANCE       /* ���� */
    , B.ANNUALD         /* ���� */
    , B.QUANTITYD       /* ������ */
    , DECODE(TRUNC((B.ANNUALD - B.QUANTITYD), -1), D.CODE, D.VALUE, E.CODE, E.VALUE, 0) 
      + MOD((B.ANNUALD - B.QUANTITYD), 10) * C.VALUE AS ANNUAL_PAY                  /* �ܿ��������� */
    , (SELECT SUM(DAYEATRA) FROM EMPSCHEDULE WHERE EMPCD = A.EMPCD) AS SCHEDULE_PAY /* ���ϱٹ�����*/
    , H.CHILD_PAY       /* �Ƶ����� */
    , H.OLD_PAY         /* ���μ��� */
    , F.BASICSTAX       /* ���� */
    , F.RESIDENCETAX    /* �ֹμ� */
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