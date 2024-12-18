CREATE DATABASE Olympics;
USE Olympics;


CREATE TABLE Countries (
    CountryID INT AUTO_INCREMENT PRIMARY KEY,
    CountryName VARCHAR(100),
    CountryCode CHAR(3),
    Continent VARCHAR(50)
);


CREATE TABLE Athletes (
    AthleteID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100),
    Gender ENUM('Male', 'Female'),
    DateOfBirth DATE,
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

CREATE TABLE Events (
    EventID INT AUTO_INCREMENT PRIMARY KEY,
    EventName VARCHAR(100),
    Sport VARCHAR(50),
    EventType ENUM('Individual', 'Team'),
    Gender ENUM('Male', 'Female', 'Mixed')
);

CREATE TABLE Medals (
    MedalID INT AUTO_INCREMENT PRIMARY KEY,
    AthleteID INT,
    EventID INT,
    MedalType ENUM('Gold', 'Silver', 'Bronze'),
    Year INT,
    FOREIGN KEY (AthleteID) REFERENCES Athletes(AthleteID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

INSERT INTO Countries (CountryName, CountryCode, Continent) VALUES
('United States', 'USA', 'North America'),
('China', 'CHN', 'Asia'),
('India', 'IND', 'Asia'),
('Germany', 'GER', 'Europe'),
('Brazil', 'BRA', 'South America'),
('Australia', 'AUS', 'Oceania'),
('South Africa', 'RSA', 'Africa'),
('Canada', 'CAN', 'North America');


INSERT INTO Athletes (FullName, Gender, DateOfBirth, CountryID) VALUES
('John Doe', 'Male', '1995-03-12', 1),
('Jane Smith', 'Female', '1997-06-22', 2),
('Akash Sharma', 'Male', '2000-01-15', 3),
('Anna Müller', 'Female', '1994-10-08', 4);


INSERT INTO Events (EventName, Sport, EventType, Gender) VALUES
('100m Sprint', 'Athletics', 'Individual', 'Male'),
('200m Sprint', 'Athletics', 'Individual', 'Female'),
('4x100m Relay', 'Athletics', 'Team', 'Mixed'),
('Marathon', 'Athletics', 'Individual', 'Male'),
('Basketball', 'Basketball', 'Team', 'Male');


INSERT INTO Medals (AthleteID, EventID, MedalType, Year) VALUES
(1, 1, 'Gold', 2020),
(2, 2, 'Silver', 2020),
(3, 3, 'Bronze', 2020),
(4, 1, 'Gold', 2024);


DELIMITER //
CREATE PROCEDURE PopulateAthletes()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 500 DO
        INSERT INTO Athletes (FullName, Gender, DateOfBirth, CountryID)
        VALUES (
            CONCAT('Athlete_', i),
            IF(i MOD 2 = 0, 'Male', 'Female'),
            DATE_ADD('1990-01-01', INTERVAL FLOOR(RAND() * 10000) DAY),
            FLOOR(1 + RAND() * 8)
        );
        SET i = i + 1;
    END WHILE;
END//
DELIMITER ;

CALL PopulateAthletes();

SELECT * FROM Olympics.Countries;
INSERT INTO Olympics.Countries (CountryName, CountryCode, Continent)  
VALUES
	('Nepal', 'NP', 'Asia'),
    ('Japan', 'JPN', 'Asia'),
    ('South Korea', NULL, 'Asia');
    
INSERT INTO Olympics.Countries (CountryCode)
VALUES ('KR');

DELETE FROM Olympics.Countries WHERE CountryCode = 'KR';

UPDATE Olympics.Countries SET CountryCode = 'KR' WHERE CountryName = 'South Korea';
UPDATE Olympics.Countries SET CountryCode = 'US' WHERE CountryName = 'United States';

SELECT * FROM Athletes;
INSERT INTO Athletes (FullName, Gender, DateOfBirth, CountryID) 
VALUES
	('Heungmin Son', 'Male', '1992-07-08', 11),
    ('Neymar Junior', 'Male', '1992-02-05', 5);
    
SELECT * FROM Events;
INSERT INTO Events (EventName, Sport, EventType, Gender) VALUES
('UEFA Champions League', 'Soccer', 'Team', 'Male'),
('Super Bowl', 'Football', 'Team', 'Male');

SELECT * FROM Medals;
INSERT INTO Medals (AthleteID, EventID, MedalType, Year) VALUES
(505, 6, 'Gold', 2020),
(506, 6, 'Silver', 2024);

INSERT INTO Medals (AthleteID, EventID, MedalType, Year) VALUES
(505, 6, 'Silver', 2020),
(506, 6, 'Bronze', 2024);

UPDATE Medals SET MedalType = 'Gold' WHERE AthleteID = 506 AND MedalType = 'Bronze';


SELECT *
FROM Countries
WHERE Continent = 'Asia';


SELECT *
FROM Countries
WHERE Continent = 'Asia' OR Continent = 'North America';

SELECT *
FROM Countries
WHERE Continent IN ('Asia', 'North America');

SELECT *
FROM Countries
WHERE Continent != 'Asia' AND Continent != 'North America';

SELECT FullName AS 'Athletes Name'
FROM Athletes
WHERE Gender = 'Male';

INSERT INTO Athletes (FullName, Gender, DateOfBirth, CountryID) 
VALUES
	('Sergio Ramos', 'Male', '1986-03-30', 4),
    ('SeNeymar Junior', 'Male', '1992-02-05', 5);
    
    
SELECT *
FROM Athletes
WHERE FullName LIKE 'S%';


INSERT INTO Athletes (FullName, Gender, DateOfBirth, CountryID) 
VALUES
	('Smrgio Ramos', 'Male', '1986-03-30', 4),
    ('SmNeymar Junior', 'Male', '1992-02-05', 5);
 
SELECT * FROM Athletes;
UPDATE Athletes SET FullName = 'Jamal Musiala' WHERE FullName = 'Smrgio Ramos';  
UPDATE Athletes SET FullName = 'Vinicius Junior' WHERE FullName = 'SmNeymar Junior';      
    
SELECT *
FROM Athletes
WHERE FullName LIKE '_m%';

INSERT INTO Athletes (FullName, Gender, DateOfBirth, CountryID) VALUES
('Karlah Darlah', 'Female', '2024-11-25', 1),
('Abel Senoh', 'Male', '2002-11-30', 5),
('Sarah Noor', 'Female', '2001-02-14', 4);

SELECT *
FROM Athletes
WHERE FullName LIKE '%h';

SELECT *
FROM Athletes
WHERE FullName LIKE '%h %';

SELECT a.AthleteID, a.FullName, a.Gender, a.DateOfBirth, a.CountryID, c.CountryCode, c.CountryName
FROM Athletes a, Countries c
WHERE a.CountryID = c.CountryID AND c.CountryCode = 'US';


SELECT *
FROM Athletes
WHERE TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) < 25;

INSERT INTO Athletes (FullName, Gender, DateOfBirth, CountryID) VALUES
('Anna Missler', 'Female', '2012-12-02', 4),
('Mia Karl', 'Female', '2000-12-07', 1);

SELECT *
FROM Athletes
WHERE  DATE_FORMAT(DateOfBirth, '%m-%d') 
BETWEEN DATE_FORMAT(CURDATE(), '%m-%d') AND DATE_FORMAT(CURDATE() + INTERVAL 7 DAY, '%m-%d');


SELECT * FROM Athletes;

DELETE FROM Athletes 
WHERE AthleteID = (SELECT MAX(AthleteID) FROM (SELECT * FROM Athletes) AS temp);


DELETE FROM Athletes
ORDER BY AthleteID DESC
LIMIT 1;

WITH LastAthleteID AS (
    SELECT MAX(AthleteID) AS MaxID
    FROM Athletes
)
DELETE FROM Athletes
WHERE AthleteID = (SELECT MaxID FROM LastAthleteID);