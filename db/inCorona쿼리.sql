--CREATE USER INCORONA IDENTIFIED BY INCORONA;
--GRANT RESOURCE, CONNECT TO INCORONA;

--DROP TABLE HOSPITAL;
--DROP TABLE CLINIC;
--DROP TABLE COMMENTS;
--DROP TABLE POST;
--DROP TABLE BOARD;
--DROP TABLE MEMBER;
--DROP TABLE LOCATION;

--지역
CREATE TABLE LOCATION(
       LOCATION_NUM VARCHAR2(30) PRIMARY KEY,
       LOCATION_NAME VARCHAR2(30),
       LOCATION_CATEGORY VARCHAR2(30)
       );

COMMENT ON COLUMN LOCATION.LOCATION_NUM IS '지역번호';
COMMENT ON COLUMN LOCATION.LOCATION_NAME IS '지역이름';
COMMENT ON COLUMN LOCATION.LOCATION_CATEGORY IS '지역대분류';



--회원
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(30) PRIMARY KEY,
    MEMBER_PW VARCHAR2(100) NOT NULL,
    MEMBER_NICKNAME VARCHAR2(30) NOT NULL UNIQUE,
    MEMBER_EMAIL VARCHAR2(50),
    MEMBER_ENROLLDATE DATE DEFAULT SYSDATE,
    MEMBER_BIRTH DATE DEFAULT SYSDATE,
    MEMBER_LOCATIONNUM VARCHAR2(30) NOT NULL,
    MEMBER_ROLE VARCHAR2(20) DEFAULT 'USER',
    MEMBER_STATUS VARCHAR2(1) DEFAULT 'N' CHECK(MEMBER_STATUS IN('Y', 'N')),
    FOREIGN KEY(MEMBER_LOCATIONNUM) REFERENCES LOCATION(LOCATION_NUM)
);

CREATE SEQUENCE SEQ_MNO;

COMMENT ON TABLE MEMBER IS '회원';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PW IS '비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NICKNAME IS '닉네임';
COMMENT ON COLUMN MEMBER.MEMBER_EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.MEMBER_ENROLLDATE IS '등록일자';
COMMENT ON COLUMN MEMBER.MEMBER_BIRTH IS '생년월일';
COMMENT ON COLUMN MEMBER.MEMBER_LOCATIONNUM IS '지역번호';
COMMENT ON COLUMN MEMBER.MEMBER_ROLE IS '회원구분';
COMMENT ON COLUMN MEMBER.MEMBER_STATUS IS '탈퇴여부';



--게시판
CREATE TABLE BOARD(
    BOARD_ID VARCHAR2(30) PRIMARY KEY,
    BOARD_NAME VARCHAR2(30) NOT NULL
);

COMMENT ON TABLE BOARD IS '게시판';
COMMENT ON COLUMN BOARD.BOARD_ID IS '게시판ID';
COMMENT ON COLUMN BOARD.BOARD_NAME IS '게시판이름';


--게시글
CREATE TABLE POST(
    post_Num NUMBER PRIMARY KEY,
    post_Title VARCHAR2(50) NOT NULL,
    post_Contents VARCHAR2(1000) NOT NULL,
    post_Filename Varchar(300),
    post_FileRename Varchar(300),
    post_EnrollTime DATE DEFAULT SYSDATE,
    post_Views NUMBER DEFAULT 0,
    post_Remove VARCHAR2(1) DEFAULT 'N' CHECK(post_Remove IN('Y', 'N')),
    post_BoardNum VARCHAR2(30) NOT NULL,
    post_MemberId VARCHAR2(30) NOT NULL,
    post_LocationNum VARCHAR2(30) NOT NULL,
    POST_MEMBERNICKNAME VARCHAR2(30) NOT NULL,

    FOREIGN KEY(post_BoardNum) REFERENCES Board(board_Id) ON DELETE CASCADE,
    FOREIGN KEY(post_MemberId) REFERENCES MEMBER(Member_Id) ON DELETE CASCADE,
    FOREIGN KEY(post_LocationNum) REFERENCES Location(location_Num) ON DELETE CASCADE
);

CREATE SEQUENCE SEQ_BOARD_NO;

COMMENT ON TABLE POST IS '게시글';
COMMENT ON COLUMN POST.post_Num IS '글등록번호';
COMMENT ON COLUMN POST.post_Title IS '제목';
COMMENT ON COLUMN POST.post_Contents IS '내용';
COMMENT ON COLUMN POST.post_Filename IS '첨부파일명';
COMMENT ON COLUMN POST.post_FileRename IS 're파일명';
COMMENT ON COLUMN POST.post_Enrolltime IS '등록시간';
COMMENT ON COLUMN POST.post_Views IS '조회수';
COMMENT ON COLUMN POST.post_Remove IS '삭제여부';
COMMENT ON COLUMN POST.post_BoardNum IS '게시판ID';
COMMENT ON COLUMN POST.post_MemberId IS '회원ID';
COMMENT ON COLUMN POST.post_LocationNum IS '지역번호';


--댓글
CREATE TABLE COMMENTS(
    COMMENT_NUM NUMBER PRIMARY KEY,
    COMMENT_CONTENTS VARCHAR2(500) NOT NULL,
    COMMENT_ENROLLTIME DATE DEFAULT SYSDATE,
    COMMENT_REMOVE VARCHAR2(1) DEFAULT 'N' CHECK(COMMENT_REMOVE IN('Y', 'N')),
    COMMENT_MEMBERNICKNAME VARCHAR(30) NOT NULL,
    COMMENT_MEMBERID VARCHAR2(30) NOT NULL,
    COMMENT_ENROLLNUM NUMBER NOT NULL,
    FOREIGN KEY(COMMENT_MEMBERID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE,
    FOREIGN KEY(COMMENT_ENROLLNUM) REFERENCES POST(POST_NUM) ON DELETE CASCADE
);

COMMENT ON TABLE COMMENTS IS '댓글';
COMMENT ON COLUMN COMMENTS.COMMENT_NUM IS '댓글등록번호';
COMMENT ON COLUMN COMMENTS.COMMENT_CONTENTS IS '댓글내용';
COMMENT ON COLUMN COMMENTS.COMMENT_ENROLLTIME IS '댓글등록시간';
COMMENT ON COLUMN COMMENTS.COMMENT_REMOVE IS '댓글삭제여부';
COMMENT ON COLUMN COMMENTS.COMMENT_MEMBERNICKNAME IS '회원닉네임';
COMMENT ON COLUMN COMMENTS.COMMENT_MEMBERID IS '회원ID';
COMMENT ON COLUMN COMMENTS.COMMENT_ENROLLNUM IS '글등록번호';

CREATE SEQUENCE SEQ_CNO;

--병원/진료소는 데이터 추가하면서 같이 생성
--https://github.com/heeejoo0518/KH_semi5/tree/main/db

--1. 국민안심병원, 선별진료소 파일 다운로드 하기 
--2. Oracle db 접속후 세미프로젝트 테이블 마우스 오른쪽 클릭 -> 데이터 임포트 클릭
--3. 다운로드 한 파일 삽입후 다음 
--4. 테이블 이름 지정 (hospital[병원], clinic[진료소]) 다음
--5. 선택된 열에 [기관명, 주소, 전화번호, 지역번호] 추가하고 다음 
--6-1. 병원 - > hospital_Name varchar2(50), hospital_address varchar2(300), hospital_tel varchar2(50), location_num varchar2(30)
--6-2. 진료소 -> clinic_Name varchar2(100), clinic_address varchar2(350), clinic_tel varchar2(100), location_num varchar2(30) 지정 -> 다음 -> 완료

                                                 
comment on column hospital.hospital_name is '병원명';
comment on column hospital.hospital_address is '주소';
comment on column hospital.hospital_tel is '연락처';
comment on column hospital.location_num is '병원지역번호';

comment on column clinic.clinic_name is '진료소명';
comment on column clinic.clinic_address is '주소';
comment on column clinic.clinic_tel is '연락처';
comment on column clinic.location_num is '진료소지역번호';


--데이터추가

--게시판
INSERT INTO BOARD VALUES('1','뉴스');
INSERT INTO BOARD VALUES('2','정보공유게시판');

--지역
INSERT INTO LOCATION VALUES(1,'서울','서울');
INSERT INTO LOCATION VALUES(2,'경기','경기');
INSERT INTO LOCATION VALUES(3,'대구','대구');
INSERT INTO LOCATION VALUES(4,'인천','인천');
INSERT INTO LOCATION VALUES(5,'광주','광주');
INSERT INTO LOCATION VALUES(6,'대전','대전');
INSERT INTO LOCATION VALUES(7,'울산','울산');
INSERT INTO LOCATION VALUES(8,'부산','부산');
INSERT INTO LOCATION VALUES(9,'강원도','강원');
INSERT INTO LOCATION VALUES(10,'충청남도','충청');
INSERT INTO LOCATION VALUES(11,'충청북도','충청');
INSERT INTO LOCATION VALUES(12,'전라남도','전라');
INSERT INTO LOCATION VALUES(13,'전라북도','전라');
INSERT INTO LOCATION VALUES(14,'경상남도','경상');
INSERT INTO LOCATION VALUES(15,'경상북도','경상');
INSERT INTO LOCATION VALUES(16,'제주','제주');
INSERT INTO LOCATION VALUES(17,'세종','세종');


-- 관리자 계정
INSERT INTO MEMBER VALUES('admin','A6xnQhbz4Vx2HuGl4lXwZ5U2I8iziLRFnhP5eNfIRvQ=','관리자',NULL,DEFAULT,DEFAULT,1,'ADMIN',DEFAULT);
