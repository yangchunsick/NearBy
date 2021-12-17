DROP TABLE PROFILE;
DROP TABLE FOLLOW;
DROP TABLE REPLY;
DROP TABLE BOARD;
DROP TABLE MEMBER;


DROP SEQUENCE PROFILE_SEQ;
DROP SEQUENCE FOLLOW_SEQ;
DROP SEQUENCE REPLY_SEQ;
DROP SEQUENCE BOARD_SEQ;
DROP SEQUENCE MEMBER_SEQ;


CREATE SEQUENCE PROFILE_SEQ NOCACHE;
CREATE SEQUENCE FOLLOW_SEQ NOCACHE; 
CREATE SEQUENCE REPLY_SEQ NOCACHE; 
CREATE SEQUENCE BOARD_SEQ NOCACHE; 
CREATE SEQUENCE MEMBER_SEQ NOCACHE; 


CREATE TABLE board (
    b_no     NUMBER NOT NULL,
    id       VARCHAR2(32 BYTE) NOT NULL,
    content  VARCHAR2(4000 BYTE),
    origin   VARCHAR2(100 BYTE),
    saved    VARCHAR2(100 BYTE),
    ip        varchar2(40 byte),
    location  varchar2(200 byte),
    path     VARCHAR2(200 BYTE),
    likes     NUMBER,
    created  DATE NOT NULL,
    modified DATE NOT NULL,
    state    NUMBER NOT NULL
);

ALTER TABLE board ADD CONSTRAINT board_pk PRIMARY KEY ( b_no );

CREATE TABLE follow (
    f_no      NUMBER NOT NULL,
    following VARCHAR2(32 BYTE) NOT NULL,
    follower  VARCHAR2(32 BYTE) NOT NULL
);

ALTER TABLE follow ADD CONSTRAINT follow_pk PRIMARY KEY ( f_no );

CREATE TABLE member (
    m_no     NUMBER NOT NULL,
    id       VARCHAR2(32 BYTE) NOT NULL,
    pw       VARCHAR2(64 BYTE) NOT NULL,
    name     VARCHAR2(32 BYTE)NOT NULL,
    email    VARCHAR2(100 BYTE) NOT NULL,
    birthday VARCHAR2(10 BYTE) NOT NULL,
    phone    VARCHAR2(12 BYTE) NOT NULL,
    gender   VARCHAR2(2 BYTE) NOT NULL,
    state    NUMBER(1)
);

ALTER TABLE member ADD CONSTRAINT member_pk PRIMARY KEY ( m_no );

ALTER TABLE member ADD CONSTRAINT member__un UNIQUE ( id );

CREATE TABLE profile (
    p_no     NUMBER NOT NULL,
    id       VARCHAR2(32 BYTE) NOT NULL,
    content  VARCHAR2(1000 BYTE),
    p_origin VARCHAR2(100 BYTE),
    p_saved  VARCHAR2(100 BYTE),
    path     VARCHAR2(100 BYTE)
);

ALTER TABLE profile ADD CONSTRAINT profile_pk PRIMARY KEY ( p_no );

CREATE TABLE reply (
    r_no     NUMBER NOT NULL,
    id       VARCHAR2(32 BYTE) NOT NULL,
    b_no     NUMBER NOT NULL,
    content  VARCHAR2(1000 BYTE) NOT NULL,
    likes   NUMBER,
    created  DATE NOT NULL,
    modified DATE,
    depth    NUMBER(1),
    state    NUMBER(1)
);

ALTER TABLE reply ADD CONSTRAINT reply_pk PRIMARY KEY ( r_no );

ALTER TABLE board
    ADD CONSTRAINT board_member_fk FOREIGN KEY ( id )
        REFERENCES member ( id )
            ON DELETE CASCADE;

ALTER TABLE follow
    ADD CONSTRAINT follow_member_fk FOREIGN KEY ( following )
        REFERENCES member ( id )
            ON DELETE CASCADE;

ALTER TABLE follow
    ADD CONSTRAINT follow_member_fkv2 FOREIGN KEY ( follower )
        REFERENCES member ( id )
            ON DELETE CASCADE;

ALTER TABLE profile
    ADD CONSTRAINT profile_member_fk FOREIGN KEY ( id )
        REFERENCES member ( id )
            ON DELETE CASCADE;

ALTER TABLE reply
    ADD CONSTRAINT reply_board_fk FOREIGN KEY ( b_no )
        REFERENCES board ( b_no )
            ON DELETE CASCADE;

ALTER TABLE reply
    ADD CONSTRAINT reply_member_fk FOREIGN KEY ( id )
        REFERENCES member ( id )
            ON DELETE CASCADE;