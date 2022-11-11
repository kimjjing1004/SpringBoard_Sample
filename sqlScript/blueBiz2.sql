  CREATE TABLE "TB_BOARD" 
   (	"BOARD_SEQ" NUMBER(4,0) NOT NULL ENABLE, 
	"BOARD_RE_REF" NUMBER(4,0), 
	"BOARD_RE_LEV" NUMBER(4,0), 
	"BOARD_RE_SEQ" NUMBER(4,0), 
	"BOARD_WRITER" VARCHAR2(20 BYTE), 
	"BOARD_SUBJECT" VARCHAR2(50 BYTE), 
	"BOARD_CONTENT" VARCHAR2(2000 BYTE), 
	"BOARD_HITS" NUMBER(4,0) DEFAULT 0 NOT NULL ENABLE, 
	"DEL_YN" VARCHAR2(1 BYTE) DEFAULT 'N' NOT NULL ENABLE, 
	"INS_USER_ID" VARCHAR2(20 BYTE), 
	"INS_DATE" DATE, 
	"UPD_USER_ID" VARCHAR2(20 BYTE), 
	"UPD_DATE" DATE, 
	 CONSTRAINT "TB_BOARD_PK" PRIMARY KEY ("BOARD_SEQ")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;

   COMMENT ON COLUMN "TB_BOARD"."BOARD_SEQ" IS '게시글순번';
   COMMENT ON COLUMN "TB_BOARD"."BOARD_RE_REF" IS '게시글그룹번호';
   COMMENT ON COLUMN "TB_BOARD"."BOARD_RE_LEV" IS '답변글 LEVEL';
   COMMENT ON COLUMN "TB_BOARD"."BOARD_RE_SEQ" IS '답변글 순서';
   COMMENT ON COLUMN "TB_BOARD"."BOARD_WRITER" IS '게시글 작성자';
   COMMENT ON COLUMN "TB_BOARD"."BOARD_SUBJECT" IS '게시글 제목';
   COMMENT ON COLUMN "TB_BOARD"."BOARD_CONTENT" IS '게시글 내용';
   COMMENT ON COLUMN "TB_BOARD"."BOARD_HITS" IS '게시글 조회수';
   COMMENT ON COLUMN "TB_BOARD"."DEL_YN" IS '삭제유무';
   COMMENT ON COLUMN "TB_BOARD"."INS_USER_ID" IS '입력ID';
   COMMENT ON COLUMN "TB_BOARD"."INS_DATE" IS '입력일시';
   COMMENT ON COLUMN "TB_BOARD"."UPD_USER_ID" IS '수정ID';
   COMMENT ON COLUMN "TB_BOARD"."UPD_DATE" IS '수정일시';
   COMMENT ON TABLE "TB_BOARD"  IS '게시판';


CREATE SEQUENCE TB_BOARD_SEQ
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;