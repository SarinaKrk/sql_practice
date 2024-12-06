CREATE DATABASE School;
USE School;

CREATE TABLE Student(
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

SELECT * FROM Student;

CREATE TABLE Class(
	class_section INT,
    number_of_students INT);

INSERT INTO Student 
VALUES(1, 'Rojin', 'KC', '2003-11-22', 'rojinkc@gmail.com'),
      (2, 'Sarina', 'Karki', '2001-11-27', 'sarinakarki@gmail.com');