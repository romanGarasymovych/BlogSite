CREATE DATABASE IF NOT EXISTS COMP3095;
USE COMP3095;
grant all on COMP3095.* to 'root'@'localhost' identified by 'admin'; 

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS USERS;
DROP TABLE IF EXISTS POSTS;
DROP TABLE IF EXISTS COMMENTS;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE USERS 
( 
	id int(11) AUTO_INCREMENT PRIMARY KEY, 
	firstname varchar(255),
	lastname varchar(255),
	email varchar(255), 
	phone varchar(20),
	year varchar(10),
	major varchar(20),
	username varchar(20),
	password varchar(20)	
);

CREATE TABLE POSTS(
	id int(11) AUTO_INCREMENT PRIMARY KEY,
	content varchar(255),
	author varchar(255),
	post_date date
);

CREATE TABLE COMMENTS(
	id int(11) AUTO_INCREMENT PRIMARY KEY,
	content varchar(255),
	author varchar(255),
	post_date date,
	post_id int(11),
	FOREIGN KEY (post_id) REFERENCES POSTS(id)
);

INSERT INTO `USERS` (`id`, `firstname`, `lastname`, `email`, `phone`, `year`, `major`, `username`, `password`) VALUES
(99, 'Admin', '', 'admin@domain.ca', NULL, NULL, NULL, 'admin', 'admin');

INSERT INTO POSTS (content, author, post_date) VALUES ('Welcome to the blog page', 'Admin', '2016-11-22');

INSERT INTO COMMENTS (id, content, author, post_date, post_id) VALUES 
(0, 'This is a nice blog.', 'Adam', '2016-11-23', (SELECT id FROM POSTS WHERE id='1'));
INSERT INTO COMMENTS (id, content, author, post_date, post_id) VALUES 
(2, 'Yeah, I agree!', 'Jorge', '2016-11-23', (SELECT id FROM POSTS WHERE id='1'));