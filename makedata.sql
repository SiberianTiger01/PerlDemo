DROP  TABLE  COMPANY;

CREATE TABLE COMPANY(
   ID  		SERIAL PRIMARY KEY,
   NAME         TEXT      NOT NULL,
   AGE          INT       NOT NULL,
   ADDRESS      CHAR(50),
   POSITION     TEXT,
   SALARY	FLOAT   
);

INSERT INTO COMPANY (NAME,AGE,ADDRESS,POSITION,SALARY)
VALUES ( 'Paul', 32, 'California', 'perl developer', 20000.00 );

INSERT INTO COMPANY (NAME,AGE,ADDRESS,POSITION,SALARY)
VALUES ('Allen', 25, 'Texas', 'System Engineer', 15000.00 );

INSERT INTO COMPANY (NAME,AGE,ADDRESS,POSITION,SALARY)
VALUES ('Teddy', 23, 'Norway', 'Java Developer', 20000.00 );

INSERT INTO COMPANY (NAME,AGE,ADDRESS,POSITION,SALARY)
VALUES ( 'Mark', 25, 'Rich-Mond ', 'Network Engineer', 65000.00 );

INSERT INTO COMPANY (NAME,AGE,ADDRESS,POSITION,SALARY)
VALUES ( 'David', 27, 'Texas', 'Manager', 85000.00 );


INSERT INTO COMPANY (NAME,AGE,ADDRESS,POSITION,SALARY)
VALUES ( 'Kim', 22, 'South-Hall', 'DevOps Manager', 45000.00 );

INSERT INTO COMPANY (NAME,AGE,ADDRESS,POSITION,SALARY)
VALUES ( 'James', 24, 'Houston', 'Software Tester', 10000.00 );

