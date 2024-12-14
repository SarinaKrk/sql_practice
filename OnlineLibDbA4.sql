CREATE DATABASE Library;
USE Library;

CREATE TABLE Authors (
	author_id INT PRIMARY KEY,
    author_name VARCHAR(50),
    country VARCHAR(50)
);

INSERT INTO Authors
VALUES (1, "J.K. Rowling", "England"),
	   (2, "Taylor Jenkins Reid", "United States of America"),
       (3, "Haruki Murakami", "Japan");

INSERT INTO Authors
VALUES (4, "Jenny Han", "United States of America");
INSERT INTO Authors
VALUES (5, "Paulo Coelho", "Brazil"),
	   (6, "Charles Dickens", "England");
       
INSERT INTO Authors
VALUES (7, "Anna Hanna", "Venezuela");

SELECT * FROM Authors;

CREATE TABLE Books (
	book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author_id INT,
    genre VARCHAR(100),
    FOREIGN KEY(author_id) REFERENCES Authors(author_id)
);

INSERT INTO Books
VALUES (101,"Harry Potter and the Cahmber of Secrets", 1, "Fantasy"),
	   (102,"The Cuckoo's Calling", 1, "Crime"),
       (201,"The Seven Husbands of Evelyn Hugo", 2, "Drama"),
       (301,"Norwegian Wood", 3, "Romance"),
       (302,"A Wild Sheep Chase", 3, "Mystery");
       

INSERT INTO Books
VALUES (202, "Malibu Rising", 2, "Psychological");
INSERT INTO Books
VALUES (401, "The Summer I Turned Pretty", 4, "Fiction");


INSERT INTO Books
VALUES (501, "The Alchemist", 5, "Adventure"),
       (601, "Great Expectations", 6, "Novel");
       
DELETE FROM Books
WHERE author_id IS NULL;

UPDATE Books
SET genre = "Fantasy"
WHERE book_id = 201;

SELECT * FROM Books;

CREATE TABLE Borrowers (
	borrower_id INT PRIMARY KEY,
    borrower_name VARCHAR(50),
    membership_date DATE
);

INSERT INTO Borrowers
VALUES (1111, "Nicole Howard", "2017-01-15"),
	   (2222, "Ginger Chang", "2020-07-01"),
       (3333, "Mia Norris", "2022-11-22"),
       (4444, "Irene Vanessa Widiaman", "2024-12-01");
       
INSERT INTO Borrowers
VALUES (5555, "Adriana Lima", "2017-01-15", "Brazil");
       
SELECT * FROM Borrowers;

ALTER TABLE Borrowers
ADD coutry VARCHAR(50);

ALTER TABLE Borrowers
CHANGE coutry country VARCHAR(50);

UPDATE Borrowers 
SET country = "England"
WHERE borrower_name = "Irene Vanessa Widiaman";

CREATE TABLE Transactions (
	transaction_id INT PRIMARY KEY,
    book_id INT,
    borrower_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY(book_id) REFERENCES Books(book_id),
    FOREIGN KEY(borrower_id) REFERENCES Borrowers(borrower_id)
);

INSERT INTO Transactions
VALUES (001, 101, 1111, "2018-01-01", "2018-07-22"),
       (002, 101, 2222, "2021-07-11", "2022-03-03"),
       (003, 102, 1111, "2022-02-14", "2022-11-19"),
       (004, 301, 3333, "2023-09-10", NULL),
       (005, 201, 1111, "2023-11-11", "2024-05-23"),
       (006, 302, 1111, "2024-02-15", "2024-12-05"),
       (007, 101, 2222, "2024-08-11", "2024-12-11"),
       (008, 302, 4444, "2024-12-10", NULL);
       
INSERT INTO Transactions
VALUES (009, 102, 2222, "2024-12-11", NULL);

INSERT INTO Transactions
VALUES (010, 501, 5555, "2024-12-11", NULL);

SELECT * FROM Transactions;




SELECT b.title, a.author_name
FROM Authors a
INNER JOIN Books b
ON a.author_id = b.author_id;

SELECT br.borrower_name, b.title
FROM Borrowers br
INNER JOIN Transactions t
ON br.borrower_id = t.borrower_id
INNER JOIN Books b
ON t.book_id = b.book_id;

SELECT a.author_name,  b.title
FROM Authors a
LEFT JOIN Books b
ON a.author_id = b.author_id;

SELECT b.title
FROM Books b
LEFT JOIN Transactions t
ON b.book_id = t.book_id
WHERE t.transaction_id IS NULL;

SELECT br.borrower_name, b.title
FROM Borrowers br
INNER JOIN Transactions t
ON br.borrower_id = t.borrower_id
INNER JOIN Books b
ON t.book_id = b.book_id
WHERE t.return_date IS NULL;

SELECT br.borrower_id, br.borrower_name, COUNT(DISTINCT t.book_id)
FROM Borrowers br
INNER JOIN Transactions t
ON br.borrower_id = t.borrower_id
GROUP BY t.borrower_id;

SELECT b.title, a.author_name, br.borrower_name
FROM Books b
LEFT JOIN Authors a
ON b.author_id = a.author_id
LEFT JOIN Transactions t
ON b.book_id = t.book_id
LEFT JOIN Borrowers br
ON t.borrower_id = br.borrower_id;


SELECT b.title, a.author_name,  COUNT(t.transaction_id)
FROM Books b
INNER JOIN Authors a
ON b.author_id = a.author_id
INNER JOIN Transactions t
ON b.book_id = t.book_id
GROUP BY t.book_id
ORDER BY COUNT(t.transaction_id) DESC
lIMIT 3;


SELECT br.country borrower_country, COUNT(DISTINCT b.book_id), a.country author_country
FROM Authors a 
INNER JOIN Books b
ON a.author_id = b.author_id
INNER JOIN Transactions t
ON b.book_id = t.book_id
INNER JOIN Borrowers br
ON  t.borrower_id = br.borrower_id
WHERE br.country = a.country
GROUP BY br.country;

WITH genre_count AS (
	SELECT genre, COUNT(DISTINCT t.book_id) AS counts, DENSE_RANK() OVER (ORDER BY COUNT(DISTINCT t.book_id) DESC) AS genre_rank
	FROM Books b
	INNER JOIN Transactions t
	ON b.book_id = t.book_id
	GROUP BY genre
)
SELECT genre, counts
FROM genre_count
WHERE genre_rank = 1;

SELECT author_name "Never Borrowed"
FROM Authors a
LEFT JOIN Books b
ON a.author_id = b.author_id
LEFT JOIN Transactions t
ON b.book_id = t.book_id
GROUP BY a.author_id
HAVING COUNT(transaction_id) = 0;

SELECT t.book_id, b.title, COUNT(DISTINCT t.borrower_id) "# of unique borrowers"
FROM Books b
JOIN Transactions t
ON b.book_id = t.book_id
GROUP BY t.book_id;
       
SELECT borrower_name 
FROM Authors a
LEFT JOIN Books b
ON a.author_id = b.author_id
LEFT JOIN Transactions t
ON b.book_id = t.book_id
JOIN Borrowers br
ON t.borrower_id = br.borrower_id
GROUP BY t.borrower_id
HAVING COUNT(DISTINCT a.author_id) >= 3;