/* Primary Key,  Attribute, Foreign Key */
/* 
Employee
PK: emp_id (int)
Attribute: name (varchar(20)), birth_date (date), sex (varchar(1)), salary
FK: branch_id (int), sup_id (int)

Branch
PK: branch_id 
Attribute: branch_name (varchar(20))
FK: manager_id (int)

Client
PK: client_id (int)
Attribute: client_name, phone (int)

Works_With
PK & FK: emp_id, client_id
Attribute: total_sales (int)
*/
CREATE DATABASE `company`;
SHOW DATABASES;
USE `company`;

-- create company info
CREATE TABLE `employee`(
	`emp_id` INT PRIMARY KEY,
	`name` VARCHAR(20),
	`birth_date` DATE,
	`sex` VARCHAR(1),
	`salary` INT,
	`branch_id` INT,
	`sup_id` INT
);

CREATE TABLE `branch`(
	`branch_id` INT PRIMARY KEY,
	`branch_name` VARCHAR(20),
	`manager_id` INT,
	FOREIGN KEY (`manager_id`) REFERENCES `employee`(`emp_id`) ON DELETE SET NULL
);

-- add FK for Employee Table
ALTER TABLE `employee`
ADD FOREIGN KEY(`branch_id`)
REFERENCES `branch`(`branch_id`)
ON DELETE SET NULL;

ALTER TABLE `employee`
ADD FOREIGN KEY(`sup_id`)
REFERENCES `employee`(`emp_id`)
ON DELETE SET NULL;

CREATE TABLE `client`(
	`client_id` INT PRIMARY KEY,
	`client_name` VARCHAR(20),
	`phone` VARCHAR(20)
);

CREATE TABLE `works_with`(
	`emp_id` INT,
	`client_id` INT,
	`total_sales` INT,
	PRIMARY KEY(`emp_id`, `client_id`),
	FOREIGN KEY(`emp_id`) REFERENCES `employee`(`emp_id`) ON DELETE CASCADE,
	FOREIGN KEY(`client_id`) REFERENCES `client`(`client_id`) ON DELETE CASCADE
);

-- insert data
INSERT INTO `branch` VALUES(1, 'R&D', NULL);
INSERT INTO `branch` VALUES(2, 'ADMIN', NULL);
INSERT INTO `branch` VALUES(3, 'INFO', NULL);

INSERT INTO `employee` VALUES(206, 'WONG', '1998-10-08', 'F', 5000, 1, NULL);
INSERT INTO `employee` VALUES(207, 'JACK', '1986-11-16', 'M', 3000, 2, 206);
INSERT INTO `employee` VALUES(208, 'ALI', '2000-01-19', 'M', 3500, 3, 206);
INSERT INTO `employee` VALUES(209, 'KELLY', '1997-02-22', 'F', 4000, 3, 207);
INSERT INTO `employee` VALUES(210, 'ANGEL', '1958-12-18', 'F', 15000, 1, 207);

INSERT INTO `client` VALUES(400, 'KEITH', '254343545');
INSERT INTO `client` VALUES(401, 'CHARLES', '254343575');
INSERT INTO `client` VALUES(402, 'JOEY', '254343335');
INSERT INTO `client` VALUES(403, 'TAYLOR', '254343986');
INSERT INTO `client` VALUES(404, 'ERIC', '254343547');

INSERT INTO `works_with` VALUES(206, 400, '70000');
INSERT INTO `works_with` VALUES(207, 401, '24000');
INSERT INTO `works_with` VALUES(208, 402, '9800');
INSERT INTO `works_with` VALUES(208, 403, '76000');
INSERT INTO `works_with` VALUES(210, 404, '87900');

-- add new info
UPDATE `branch`
SET `manager_id` = 206
WHERE `branch_id` = 1;

UPDATE `branch`
SET `manager_id` = 207
WHERE `branch_id` = 2;

UPDATE `branch`
SET `manager_id` = 208
WHERE `branch_id` = 3;


-- to acquire all info of employee
SELECT * FROM `employee`;

-- based on salary order/sex
SELECT * FROM `employee` ORDER BY `salary` DESC;
SELECT * FROM `employee` ORDER BY `sex`;

-- top 3 salary
SELECT * FROM `employee` 
ORDER BY `salary` DESC 
LIMIT 3;

-- only employee's name
SELECT `name` FROM `employee`;

-- show sex/branch with distint to avoid repetitive
SELECT DISTINCT `sex` FROM `employee`; 
SELECT DISTINCT `branch_id` FROM `employee`;




-- aggregate functions
-- 1. find number using COUNT
SELECT COUNT(*) FROM `employee`;
SELECT COUNT(`sup_id`) FROM `employee`;

-- 2. find number of female staff born after 1970-01-01
SELECT COUNT(*) 
FROM `employee` 
WHERE `birth_date` > '1970-01-01' AND `sex` = 'F';

-- 3. find avg salary of emp
SELECT AVG(`salary`) FROM `employee`;

-- 4. find sum of salary
SELECT SUM(`salary`) FROM `employee`;

-- 5. find max salary
SELECT MAX(`salary`) FROM `employee`;

-- 6. find min salary
SELECT MIN(`salary`) FROM `employee`;


-- wildcards
-- % represent > more than one, _ represnt only one
-- 1. Find last 3 digits of phone number are 335
SELECT *
FROM `client`
WHERE `phone` LIKE '%335'; 

-- 2. Find client name starts with 'E'
SELECT *
FROM `client`
WHERE `client_name` LIKE 'E%'; 

-- 3. emp's bday from dec
SELECT *
FROM `employee`
WHERE `birth_date` LIKE '_____12%'; -- 5 underline (1 underline = 1 letter)


-- union
-- 1. emp name union client name
SELECT `name` 
FROM `employee`
UNION
SELECT `client_name`
FROM `client`;

-- 2. emp id + name union client id + name
SELECT `emp_id` AS `total_id` , `name` AS `total_name`
FROM `employee`
UNION
SELECT `client_id`, `client_id`
FROM `client`;

-- 3. emp salary union sales 
SELECT `salary` AS `total_money`
FROM `employee`
UNION
SELECT `total_sales`
FROM `works_with`;



-- join = combine two table
-- get branch manager name
SELECT `employee`.`emp_id`, `employee`.`name`, `branch`.`branch_name`
FROM `employee` 
JOIN `branch` 
ON `employee`.`emp_id` = `branch`.`manager_id`;

-- use left/right join
SELECT `employee`.`emp_id`, `employee`.`name`, `branch`.`branch_name`
FROM `employee` LEFT JOIN `branch` 
ON `employee`.`emp_id` = `branch`.`manager_id`;


-- subquery
-- 1. find R&D manager name
SELECT `name`
FROM `employee`
WHERE `emp_id` = (
		SELECT `manager_id`
		FROM `branch`
		WHERE `branch_name` = `R&D`
);

-- 2. find emp that tele with client >75000 sales
SELECT `name`
FROM `employee`
WHERE `emp_id` IN(
		SELECT `emp_id`
		FROM `work_with` 
		WHERE `total_sales` > 75000
);



-- on delete
DELETE FROM `employee`
WHERE `emp_id` = 207;

SELECT * FROM `branch`; -- on delete set null
SELECT * FROM `works_with`; -- on delete cascade (if its FK & PK, then use cascade, nvr use null)


-- https://www.w3schools.com/sql/func_mysql_substr.asp
	

