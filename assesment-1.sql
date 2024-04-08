create database school;
use school;
create table student (
stdid int primary key,
stdname varchar(50) not null,
sex varchar(20),
percentage int,
class int,
sec varchar(10),
Stream varchar(20) not null,
DOB date);

insert into student values
(1001,'surekha joshi','female',82,12,'a','science','1998-03-08');
insert into student values
(1002,'maahi agarwal','female',56,11,'c','commerce','2008-11-23');
insert into student values
(1003,'sanam verma','male',59,11,'c','commerce','2006-06-29');
insert into student values
(1004,'ronit kumar','male',63,11,'c','commerce','1997-11-05');
insert into student values
(1005,'dipesh pulkit','male',78,11,'b','science','2003-09-14');
insert into student values
(1006,'jahanvi puri','female',60,11,'b','commerce','2008-07-11');
insert into student values
(1007,'sanam kumar','male',23,12,'f','commerce','1998-03-08');
insert into student values
(1008,'sahil saras','male',56,11,'c','commerce','2008-07-11');
insert into student values
(1009,'akshara agarwal','female',72,12,'b','commerce','1996-01-10');
insert into student values
(1010,'stuti mishra','female',39,11,'f','science','2008-11-23');
insert into student values
(1011,'harsh agarwal','male',42,11,'c','science','1998-03-08');
insert into student values
(1012,'nikunj agarwal','male',49,12,'c','commerce','1998-06-28');
insert into student values
(1013,'akriti saxena','female',89,12,'a','science','2008-11-23');
insert into student values
(1014,'tani rastogi','female',82,12,'a','science','2008-11-23');
 






-- Question 2: Open school database, then select student table and use following SQL statements. 
-- TYPE THE STATEMENT, PRESS ENTER AND NOTE THE OUTPUT  
-- 1 To display all the records form STUDENT table.
SELECT * FROM student ;  
-- 2. To display any name and date of birth from the table STUDENT.
  SELECT StdName, DOB
  FROM student ;  
-- 3. To display all students record where percentage is greater of equal to 80 FROM student table.
  SELECT * FROM student
  WHERE percentage >= 80;  
-- 4. To display student name, stream and percentage where percentage of student is more than 80
  SELECT StdName, Stream, Percentage from student
  WHERE percentage > 80;  
-- 5. To display all records of science students whose percentage is more than 75 form student table.
  SELECT * from student 
  WHERE Stream = science AND percentage > 75; 