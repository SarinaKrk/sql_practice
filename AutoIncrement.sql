CREATE database autoinc
CREATE TABLE playlist (
	SongID INT AUTO_INCREMENT PRIMARY KEY,
    SongName VARCHAR(100),
    SingerName VARCHAR(100)
);

INSERT INTO playlist(SongName, SingerName)
VALUES ('Riptide', 'Vance Joy'),
	   ('luther', 'Kendrick Lamar'),
       ('NIGHTS LIKE THIS', 'The Kid LAROI'),
       ('No One Noticed', 'The Marias'),
       ('Hate You', 'Jungkook');

SELECT * FROM playlist;