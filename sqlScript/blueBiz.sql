-- 테이블 생성
CREATE TABLE tbl_board (
    bno number(10, 0),
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
);

-- 외래키 추가
ALTER TABLE tbl_board add constraint pk_board
primary key (bno);

-- 시퀀스 생성
CREATE SEQUENCE seq_board;

-- 더미데이터 추가
INSERT INTO tbl_board (bno, title, content, writer)
VALUES (seq_board.nextval, '테스트 제목', '테스트 내용', 'user00');

SELECT * FROM tbl_board
ORDER BY bno DESC;

-- 게시판 데이터 개수 추가
INSERT INTO tbl_board (bno, title, content, writer)
(SELECT seq_board.nextval, title, content, writer FROM tbl_board);

-- INDEX ORDER BY
-- ROWNUM
-- 인 라인 뷰

-- Paging처리(1 ~ 10)
SELECT /*+ INDEX_DESC(tbl_board pk_board) */ ROWNUM, bno, title, writer, regdate, updateDate
FROM tbl_board
WHERE bno > 0 AND ROWNUM <= 10;

-- Paging처리(11 ~ 20)
SELECT * FROM
(
SELECT /*+ INDEX_DESC(tbl_board pk_board) */ ROWNUM rn, bno, title, writer, regdate, updateDate
FROM tbl_board
WHERE bno > 0 AND ROWNUM > 0 AND ROWNUM <= (2 * 10)
)
WHERE rn > (2 - 1) * 10;

COMMIT;