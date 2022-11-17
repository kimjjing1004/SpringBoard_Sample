-- 1.
-- ����� �ּҸ� ��ȸ
-- ���̺� : EMPBASICS_T, COMCD_T
-- ��ȸ�׸� : ����ڵ�, �����, ZIP�ڵ�, �ּ�
SELECT A.EMPCD ����ڵ�,
       A.EMPNM �����,
       A.EMPZIPCD ZIP�ڵ�,
       B.VALUE �ּ�
FROM EMPBASICS_T A, COMCD_T B
WHERE B.DIV = 'zip'
  AND A.EMPZIPCD = B.CODE
ORDER BY A.EMPCD;

-- 2.
-- ����� ������ �ش��ϴ� ������ ��ȸ
-- ���̺� : EMPBASICS_T, EMPANNUAL, YEARANALLNCO_T
-- ��ȸ�׸� : ����ڵ�, �����, ����, �⺻��, ����, ����(�⺻��+����)
SELECT A.EMPCD ����ڵ�,
       A.EMPNM �����,
       B.YEAR ����,
       C.BASICS �⺻��,
       C.ALLOWANCE ����,
       C.BASICS + C.ALLOWANCE ����
FROM EMPBASICS_T A,
     EMPANNUAL B,
     YEARANALLNCO_T C
WHERE A.EMPCD = B.EMPCD
  AND B.YEAR = C.YEAR
ORDER BY TO_NUMBER(B.YEAR);
    
-- 3.
-- ����� �������踦 ��ȸ (���ε� �����Ͽ� ��ȸ)
-- ���̺� : EMPBASICS_T, EMPFAMILY_T, FAMILYINFO_T, COMCD_T
-- ��ȸ�׸� : ����ڵ�, ���������ڵ�, ���������, ������
SELECT A.EMPCD ����ڵ�,
       B.RELACD ���������ڵ�,
       DECODE((SELECT D.CODE FROM COMCD_T WHERE D.DIV = 'rela'), 1, D.VALUE, D.VALUE) ���������,
       C.FAMILYNAME ������
FROM EMPBASICS_T A,
     EMPFAMILY_T B,
     FAMILYINFO_T C,
     COMCD_T D
WHERE A.EMPCD = B.EMPCD
  AND A.EMPCD = C.EMPCD
  AND B.RELACD = C.RELACD (+)
  AND B.RELACD = D.CODE(+);

-- 4.
-- ����� �������� �� �ڳ����, ���μ��翩�ο� ����ݾ��� ��ȸ(����ڵ�, ���������ڵ� �������� ����)
-- ���̺� : EMPBASICS_T, EMPFAMILY_T, FAMILYINFO_T, COMCD_T
-- ��ȸ�׸� : ����ڵ�, ���������ڵ�, ���������, ������, �ڳ����(Y/N), ���μ���(Y/N), ����ݾ�(������ 0)
SELECT A.EMPCD ����ڵ�,
       B.RELACD ���������ڵ�,
       D.VALUE ���������,
       C.FAMILYNAME ������,
       NVL(B.CHILDEATRA, 'N') "�ڳ����(Y/N)",
       NVL(B.OLDEATRA, 'N') "���μ���(Y/N)",
       E.VALUE "����ݾ�(������ 0)"
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
-- ����� �������� ��ȸ
-- ���̺� : EMPBASICS_T, EMPANNUAL, COMCD_T
-- ������� : 
-- �������� = �ܿ��ϼ� * �����ڵ�( div : annual ) �� 
-- ex> �ܿ��ϼ�17�� ��� : (�����ڵ� '10' ��) + (�����ڵ� '1' �� * 7)
-- ��ȸ�׸� : ����ڵ�, �����, �������, �����ϼ�, ����ϼ�, �ܿ��ϼ�, ��������
SELECT A.EMPCD ����ڵ�,
       A.EMPNM �����,
       B.YEAR �������,
       B.ANNUALD �����ϼ�,
       B.QUANTITYD ����ϼ�,
       B.ANNUALD - B.QUANTITYD �ܿ��ϼ�,
       CASE WHEN B.ANNUALD - B.QUANTITYD > 0
             AND B.ANNUALD - B.QUANTITYD < 10 THEN 50000 * (B.ANNUALD - B.QUANTITYD)
            
            WHEN B.ANNUALD - B.QUANTITYD >= 10
             AND B.ANNUALD - B.QUANTITYD < 20 THEN 600000 + (50000 * ((B.ANNUALD - B.QUANTITYD) - 10))
            
            WHEN B.ANNUALD - B.QUANTITYD >= 20
             AND B.ANNUALD - B.QUANTITYD < 30 THEN 1500000 + (50000 * ((B.AMMUALD - B.QUANTITYD) - 20))
            
            ELSE ''
             END ��������
FROM EMPBASICS_T A, EMPANNUAL B, COMCD_T C
WHERE A.EMPCD = B.EMPCD
  AND C.DIV = 'annual' 
ORDER BY TO_NUMBER(B.YEAR);

-- 6.
-- ����� ���ϱٹ��ϼ� / ���ϼ��� ��ȸ �� �μ� ǥ��
-- ���̺� : EMPBASICS_T, EMPSCHEDULE
-- �μ�ǥ������ : ����ڵ���ڸ��� ���� (A,B,C �� �λ�� / D,E,F �� �ѹ���)
-- ��ȸ�׸� : ����ڵ�, �����, �μ�, ���ϱٹ��ϼ�, ���ϼ���
SELECT A.EMPCD ����ڵ�,
       A.EMPNM �����,
       CASE WHEN A.EMPCD LIKE 'A%'
              OR A.EMPCD LIKE 'B%'
              OR A.EMPCD LIKE 'C%' THEN '�λ��'
            
            WHEN A.EMPCD LIKE 'D%'
              OR A.EMPCD LIKE 'E%'
              OR A.EMPCD LIKE 'F%' THEN '�ѹ���'
            
            ELSE ''
             END �μ�,
       B.SCHEDULE ���ϱٹ��ϼ�,
       B.DAYEATRA ���ϼ���
FROM EMPBASICS_T A, EMPSCHEDULE B
WHERE A.EMPCD = B.EMPCD
ORDER BY B.DAYEATRA;

-- 7.
-- ����� ��������, ������ ��ȸ�ϰ� ������ ������ ���������� ��ȸ
-- ���̺� : EMPBASICS_T, EMPANNUAL, COMCD_T, EMPSCHEDULE, YEARANALLNCO_T, EMPFAMILY_T, EMPTAX_T
-- ��ȸ�׸� : ����ڵ�, �����, ����(����), �ܿ���������, ���ϱٹ�����, ��������, ����, ��������
-- ���� : 
-- ����(����) : �⺻�� + ����
-- �ܿ��������� : (���� - ������) * �����ڵ�(annual) ������ ���
-- ���ϱٹ����� : EMPSCHEDULE ���̺��� ���� �ջ�
-- �������� : �Ƶ����� + ���μ���
-- ���� : ���� + �ֹμ�
-- �������� : ����(����) + �ܿ��������� + ���ϱٹ����� + �������� - ����
SELECT A.EMPCD ����ڵ�,
       A.EMPNM �����,
       E.BASICS + E.ALLOWANCE "����(����)",
       (B.ANNUALD - B.QUANTITYD) * C.VALUE �ܿ���������,
       D.DAYEATRA ���ϱٹ�����,
       F.CHILDEATRA + F.OLDEATRA ��������,
       G.BASICSTAX + G.RESIDENCETAX ����,
       (E.BASICS + E.ALLOWANCE) + ((B.ANNUALD - B.QUANTITYD) * C.VALUE) + D.DAYEATRA + (F.CHILDEATRA + F.OLDEATRA) - (G.BASICSTAX + G.RESIDENCETAX) ��������
FROM EMPBASICS_T A, EMPANNUAL B, COMCD_T C, EMPSCHEDULE D, YEARANALLNCO_T E, EMPFAMILY_T F, EMPTAX_T G
WHERE A.EMPCD = B.EMPCD
  AND A.EMPCD = D.EMPCD
  AND A.EMPCD = F.EMPCD
  AND C.DIV = 'annual';