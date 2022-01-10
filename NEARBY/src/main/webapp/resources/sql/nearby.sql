
DROP TABLE likes;
DROP TABLE REPLY;
DROP TABLE BOARD;
DROP TABLE FOLLOW;
DROP TABLE PROFILE;
DROP TABLE MEMBER;

CREATE TABLE member (
    m_no     int  NOT NULL  AUTO_INCREMENT  NOT NULL primary key,
    id       varchar(32) NOT NULl unique,
    pw       varchar(64) NOT NULL,
    name     varchar(32) NOT NULL,
    email    varchar(100) NOT NULL,
    birthday varchar(10) NOT NULL,
    phone    varchar(12) NOT NULL,
    gender   varchar(2) NOT NULL,
    state    int,
    m_created datetime,
    unique key(`id`) 
);

CREATE TABLE board (
    b_no     int AUTO_INCREMENT  NOT NULL primary key,
    id       varchar(32) NOT NULL,
    content  varchar(4000),
    ip       varchar(40),
    location varchar(200),
    origin   varchar(100),
    saved    varchar(100),
    path     varchar(200),
    likes    int,
    created  datetime NOT NULL,
    modified datetime NOT NULL,
    state    int NOT NULL,
    depth    int,
    groupno  int,
    groupord int,
    foreign key (`id`) references member(`id`)
);


CREATE TABLE profile (
    p_no       int AUTO_INCREMENT PRIMARY KEY,
    id         varchar(32)  NOT NULL,
    p_content   varchar(1000),
    p_origin   varchar(100),
    p_saved    varchar(100),
    P_PATH     varchar(200),
    foreign key (`id`) references member(`id`)
);

CREATE TABLE follow (
    f_no      int AUTO_INCREMENT primary key,
    following_id varchar(32) NOT NULL,
    followed_id  varchar(32) NOT NULL,
     foreign key (`following_id`) references profile(`id`),
     foreign key (`followed_id`) references profile(`id`),
     unique (`following_id`, `followed_id`)
);



CREATE TABLE reply (
    r_no      int NOT NULL AUTO_INCREMENT primary key,
    id        varchar(32) NOT NULL,
    b_no      int NOT NULL,
    r_content varchar(1000) NOT NULL,
    r_likes   int,
    r_created datetime NOT NULL,
    r_modified datetime,
    state     int,
    depth     int,
    groupno   int,
    groupord  int,
    foreign key (`id`) references member(`id`),
     foreign key (`b_no`) references board(`b_no`)  
);

create table likes (
  like_no  int not null primary key AUTO_INCREMENT,
  b_no int,
  id varchar(32),
  like_check int,
  like_date datetime,
   foreign key (`id`) references member(`id`),
   foreign key (`b_no`) references board(`b_no`)
);