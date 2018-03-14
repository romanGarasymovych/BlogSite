CREATE DATABASE IF NOT EXISTS BlogDB;
USE BlogDB;
grant all on BlogDB.* to 'root'@'localhost' identified by 'admin'; 

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS USERS;
DROP TABLE IF EXISTS POSTS;
DROP TABLE IF EXISTS COMMENTS;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE USERS 
( 
	id varchar(255) PRIMARY KEY, 
	firstname varchar(255),
	lastname varchar(255),
	email varchar(255), 
	phone varchar(255),
	year varchar(255),
	major varchar(255),
	username varchar(255),
	password varchar(255)	
);

CREATE TABLE POSTS(
	id varchar(255) PRIMARY KEY,
	title varchar(255),
	content varchar(255),
	post_date datetime,
	username varchar(255),
	comment_count int
);

CREATE TABLE COMMENTS(
	id varchar(255) PRIMARY KEY,
	content varchar(255),
	post_date datetime,
	username varchar(255),
	post_id varchar(255),
	FOREIGN KEY (post_id) REFERENCES POSTS(id)
);
DROP TRIGGER IF EXISTS BlogDB.users_init_uuid;
DROP TRIGGER IF EXISTS BlogDB.posts_init_uuid;
DROP TRIGGER IF EXISTS BlogDB.comments_init_uuid;
DELIMITER //
CREATE TRIGGER users_init_uuid BEFORE INSERT ON USERS
  FOR EACH ROW SET NEW.id = UUID();
//
DELIMITER ;
DELIMITER //
 CREATE TRIGGER posts_init_uuid BEFORE INSERT ON POSTS
  FOR EACH ROW SET NEW.id = UUID();
  //
 DELIMITER ;
 DELIMITER //
  CREATE TRIGGER comments_init_uuid BEFORE INSERT ON COMMENTS
  FOR EACH ROW SET NEW.id = UUID();
  //
  DELIMITER ;

INSERT INTO `USERS` (`firstname`, `lastname`, `email`, `phone`, `year`, `major`, `username`, `password`) VALUES
('Admin', '', 'admin@domain.ca', NULL, NULL, NULL, 'admin', 'admin');

INSERT INTO `USERS` (`firstname`, `lastname`, `email`, `phone`, `year`, `major`, `username`, `password`) VALUES
('Roman', 'Garasymovych', 'roman.garasymovych@gmail.com', '647-880-6329', '2017', 'Information Technology', 'roman', 'roman');

INSERT INTO POSTS (title, content, post_date, username, comment_count) VALUES ('Welcome', 'Welcome to the blog page', '2016-11-22 12:23', 'admin', 2);

INSERT INTO COMMENTS (content, post_date, post_id, username) VALUES 
('This is a nice blog.', '2016-11-23 13:04', (SELECT id FROM POSTS WHERE username='admin'), 'roman');
INSERT INTO COMMENTS (content, post_date, post_id, username) VALUES 
('Thanks!', '2016-11-23 13:54', (SELECT id FROM POSTS WHERE username='admin'), 'admin');