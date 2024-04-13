-- This project is created by Diego Damian dad405, 

create database if not exists thecoolproject;
use thecoolproject;
drop table if exists Login;

-- Login table and insertion
CREATE TABLE Login(
	id int,
	username varchar(128),
	password varchar(128),
    primary key (id, username, password)
    );

INSERT INTO `Login` VALUES
	(01,'customer','password'),
    (02,'diego.damian02','cheese'),
    (03,'steven.zamora','password1'),
	(04,'dan.kiel','temp12345'),
	(05,'matteus.coste','123456')
    ;