-- using MySQL
-- #1 create database 

CREATE database `sql_tutorial`;
SHOW DATABASES;
USE `sql_tutorial`;

/* datatype */
INT          --number
DECIMAL      --decimal number eg. DECIMAL(3,2)
VARCHAR(10)  -- how many letters needed in words
BLOB         --binary large object (image, vid, files）
DATE         --'YYYY-MM-DD' record date
TIMESTAMP    --'YYYY-MM-DD HH:MM:SS' record time  

-- #2 create table
CREATE TABLE `student` (
	`student_id` INT PRIMARY KEY,
    `name` varchar(20), 
    `major` varchar (20)
);

/* another method to define PK*/
CREATE TABLE `student` (
	`student_id` INT,
    `name` varchar(20), 
    `major` varchar (20),
    primary key(`student_id`)
);

/* show table*/
DESCRIBE `student`;	

/*delete table*/
DROP table `student`;

/* modify table by adding column gpa*/
alter table `student` add gpa decimal(3,2); 

/*modify table by deleting column gpa*/
alter table `student` drop column gpa;

-- #3 insert data into database
/*values sequence based on the column insert earlier (id, name, major),
 all data can be insert by just modifying the same codes with different values (data) */

/*default row: student_id, name, major*/
insert into `student` values(3, 'ali', 'english');

/* if there's no data in one of the column = null */
insert into `student` values(2, 'lim', 'null');

/*rearrange the data sequence*/
insert into `student` (`name`, `major`, `student_id`) values('abu', 'english', 4);
insert into `student` (`major`, `student_id`) values ('english', 5);

/* search all data with * sign */
select * from `student`;

-- #4 constraints 限制
/*example 1*/
CREATE TABLE `student` (
	`student_id` INT,
    `name` varchar(20) not null,
    `major` varchar (20) unique,
    primary key(`student_id`)
);

drop table `student`;

/* cannot run as name is null and the constraint for column name is cannot be null*/
insert into `student` values(1, null, 'english');
insert into `student` values(3, 'ali', 'english');

/* cannot run as major has repeated and the constraint for column major is unique*/
insert into `student` values (1, 'abu', 'english');
insert into `student` values (1, 'abu', 'history');

/*example 2*/
CREATE TABLE `student` (
	`student_id` INT,
    `name` varchar(20) ,
    `major` varchar (20) default 'math' , /*means if major dont have value insert, then it will become math*/
    primary key(`student_id`)
);

insert into `student` (`name`, `student_id`) values ('ali', 5);

/*example 3*/
CREATE TABLE `student` (
	`student_id` INT auto_increment,
    `name` varchar(20) ,
    `major` varchar (20) , 
    primary key(`student_id`)
);

insert into `student` (`name`, `major`) values ('ali', 'math');
insert into `student` (`name`, `major`) values ('abu', 'math');
insert into `student` (`name`, `major`) values ('lim', 'science');

-- #5 update & delete

/* need to turn off workbench auto update*/
set sql_safe_updates = 0;

CREATE TABLE `student` (
		`student_id` INT primary key,
    `name` varchar(20) ,
    `major` varchar (20) , 
    `score` int
);

insert into `student` values(5, 'ahok', 'geography', 40);

/* when we want update the value */
update `student`
set `major` = 'english literature'
where `major` = 'english';

update `student`
set `major` = 'biology'
where `student_id` = 5;

update `student`
set `major` = 'biochemistry'
where `major` = 'biology' or `major` = 'math';

update `student`
set `name` = 'lily', `major` = 'physics'
where `student_id` = 1;

/*change all name data to lily */
update `student`
set `name` = 'lily';

/*when we want delete value*/
delete from `student`
where `student_id` = 4;

delete from `student`
where `name` = 'lily' and `major` = 'physics';

delete from `student`
where `score` < 60;

/* delete all values in table*/
delete from `student`;

select * from `student`;

-- #6 select
/* view all (*) data*/
select * from `student`;

select `name` from `student`;
select `name`, `major` from `student`;

select * from `student` order by `score`;
select * from `student` order by `score` desc; 		/* arrange data in descending order*/

select * from `student` order by `score`, `student_id`;  /* arrange the order from score then student_id*/

/* take (limit) only 2 students' data */
select *
from `student`
order by `score` desc 
limit 2;

/*with conditon (same as update and delete) */
select *
from `student` 
where `major` = 'biochemistry' or `score` <> 40 ; 		/* not equal --> <> */

/* both same*/
select *
from `student` 
where `major` in( 'geography', 'biochemistry', 'english literature');
select * from `student`
where `major` = 'biochemistry' or `major` = 'english literature' or `major` = 'geography';
