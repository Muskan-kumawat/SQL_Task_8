-- TASK 1
create database Library;
USE Library;

CREATE TABLE Authors(
	authorID INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Books(
	bookID INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    authorID INT,
    FOREIGN KEY (authorID) REFERENCES Authors(authorID)
);

CREATE TABLE Students(
	studentID INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    class VARCHAR(50)
);

CREATE TABLE IssuedBooks(
	issueID INT PRIMARY KEY,
    studentID INT,
    bookID INT,
    issueDate DATE,
    returnDate DATE,
    FOREIGN KEY (studentID) REFERENCES Students(studentID),
    FOREIGN KEY (bookID) REFERENCES Books(bookID)
);

-- TASK 2

INSERT INTO Authors(authorID, name) VALUES(101,"Joanne Rowling");
INSERT INTO Authors(authorID, name) VALUES(102,"George Orwell");
INSERT INTO Authors(authorID, name) VALUES(103,"Paulo Coelho");
INSERT INTO Authors(authorId, name) VALUES(104,"Jane Austen");

INSERT INTO Books(bookID,title,authorID) VALUES(1001,"Harry Potter-1",101);
INSERT INTO Books(bookID,title,authorID) VALUES(1002,"1984",102);
INSERT INTO Books(bookID,title,authorID) VALUES(1003,"The Alchemist",103);
INSERT INTO Books(bookID,title,authorID) VALUES(1004,"Harry Potter-2",NULL);
INSERT INTO Books(bookID,title,authorID) 
VALUES
(1005,"Animal Farm",102),
(1006, 'Brida', 103),
(1007, 'Pride and Prejudice', 104);

INSERT INTO Students(studentID, name, class) VALUES(1,"Alice Johnson",'10');
INSERT INTO Students(studentID, name, class) VALUES(2,"Bob Smith",NULL);
INSERT INTO Students(studentID, name, class) VALUES(3,"Charlie Brown",'11');
INSERT INTO Students(studentID, name, class) VALUES(4,"Daina",'10');
INSERT INTO Students(studentID, name, class) VALUES(5,"Emanual",'10');
INSERT INTO Students(studentID, name, class)
VALUES
(6,"Emma",'10'),
(7,"Grace",11),
(8,"Hannah",'11'),
(9,"Hazel",'10'),
(10,"Julia",'10');

INSERT INTO IssuedBooks(issueID, studentID, bookID, issueDate, returnDate)
VALUES
(1,1,1003,'2025-05-02','2025-05-10'),
(2,3,1004,'2025-06-20', NULL);

-- Update


UPDATE Authors
SET name = "J.K. Rowling" WHERE authorID = 101;

UPDATE Books
SET authorID = 101 WHERE bookID = 1004;

UPDATE Students
SET class = '11' WHERE studentID = 2;

UPDATE IssuedBooks
SET returnDate = "2025-06-24" WHERE bookID = 1004;

DELETE FROM Books WHERE bookID = 1001;
DELETE FROM Students WHERE studentID = 2;
DELETE FROM IssuedBooks WHERE issueID = 2;

INSERT INTO IssuedBooks(issueID, studentID, bookID, issueDate, returnDate)
VALUES
(2,2, 1007, '2025-05-02', '2025-05-08');

-- TASK 3 

SHOW tables;
SELECT * FROM Authors;
SELECT * FROM Books;
SELECT * FROM Students;
SELECT * FROM IssuedBooks;

-- Where and Or
SELECT * FROM students WHERE class = "10" OR class = '11';

-- Between 
SELECT title FROM books where bookID 
BETWEEN 1001 and 1003;

-- IN
SELECT name FROM Students 
WHERE studentID IN
(SELECT studentID FROM IssuedBooks) ;

-- And, Like, AS
SELECT studentID AS ID,name AS ST_NAME FROM Students
Where class LIKE '10' AND (studentID BETWEEN 1 and 5) ;

-- Order by and Limit
Select * FROM Authors
ORDER BY name;

SELECT name FROM Students
ORDER BY name DESC
LIMIT 4;

-- Distinct
SELECT DISTINCT class FROM Students;

-- Task 4  --

--  SUM() - Total number of books issued
SELECT COUNT(issueId) FROM Issuedbooks;

-- Count
Select class,count(studentID) AS TotalStudents
FROM STUDENTS
GROUP BY class;

-- AVG
SELECT AVG(bookID) AS AverageBookIDIssued FROM IssuedBooks;

-- GROUP BY
SELECT authors.name, COUNT(books.authorID) AS BOOKS
FROM Authors
Join books ON authors.authorID= books.authorID
group by name;

-- Having

SELECT authors.name, COUNT(books.authorID) AS Books
From Authors
JOIN books ON authors.authorID= books.authorID
group by name
HAVING Books>1;


--   TASK-5 --->


ALTER TABLE IssuedBooks
MODIFY issueID INT AUTO_INCREMENT;


INSERT INTO Students(studentID, name, class) VALUES(6,"Emma",'10');
INSERT INTO Students(studentID, name, class) VALUES(7,"Grace",11);
INSERT INTO Students(studentID, name, class) VALUES(8,"Hannah",'11');
INSERT INTO Students(studentID, name, class) VALUES(9,"Hazel",'10');
INSERT INTO Students(studentID, name, class) VALUES(10,"Julia",'10');

INSERT INTO IssuedBooks(studentID, bookID, issueDate, returnDate)
VALUES
(2, 1002, '2025-05-02', '2025-05-08'),
(3,1004,'2025-05-03', '2025-05-11'),
(4,1002,'2025-05-12','2025-05-16'),
(7,1006, '2025-05-12', '2025-05-15'),
(5,1004,'2025-05-12', '2025-05-18'),
(10,1007,'2025-05-13','2025-05-16'),
(5,1006, '2025-05-15', '2025-05-18'),
(7,1001, '2025-05-15', '2025-05-20'),
(1,1003, '2025-05-15', '2025-05-19'),
(3,1005, '2025-05-15', '2025-05-18'),
(7,1002, '2025-05-16', '2025-05-20'),
(6,1006, '2025-05-18', '2025-05-20');

SELECT * FROM issuedbooks;

-- JOIN

						-- INNER Join -- 
SELECT Students.name AS Stu_Names, Books.title, issuedbooks.issueDate
FROM issuedbooks
INNER JOIN students on Issuedbooks.studentID = Students.studentID
INNER JOIN Books ON IssuedBooks.bookID = Books.bookId 
ORDER BY issueDate;

                        -- LEFT Join --
-- No. of book by per student
SELECT Count(issuedBooks.studentId) AS No_of_Books, Students.name, Students.class
From Students
LEFT JOIN issuedBooks ON Students.studentid = issuedbooks.studentID
LEFT JOIN Books ON IssuedBooks.bookID = Books.bookID
GROUP BY Students.name, Students.class;


SELECT Students.studentID, Students.name, Books.title, IssuedBooks.issueDate
FROM Students
LEFT JOIN IssuedBooks ON Students.studentID = IssuedBooks.studentID
LEFT JOIN Books ON IssuedBooks.bookID = Books.bookID;

                      -- RIGHT Join -- 

-- FETCH ALL BOOKS WITH THEIR RESPECTIVE AUTHOR NAME

SELECT 
    Books.bookid, Books.title, Authors.name AS Author
FROM
    authors
        RIGHT JOIN
    Books ON authors.authorID = BOOKS.AUTHORID;
    
    
                      -- UNION Join -- 
-- name of book issue by every student with their Dates (Left join)
-- DATA OF ALL LIBRARY ISSUED BOOKS WITH RESPECT TO STUDENTS (Rigth JOIN)

SELECT Students.studentID, Students.name, Books.title, IssuedBooks.issueDate
FROM Students
LEFT JOIN IssuedBooks ON Students.studentID = IssuedBooks.studentID
LEFT JOIN Books ON IssuedBooks.bookID = Books.bookID
UNION
SELECT Students.studentID, Students.name, Books.title, IssuedBooks.issueDate
FROM Students
RIGHT JOIN IssuedBooks ON Students.studentID = IssuedBooks.studentID
RIGHT JOIN Books ON IssuedBooks.bookID = Books.bookID;



-- Task 6 Subqueries and Nested Queries

-- 1. Subquery in SELECT: Show each student's name along with total books issued
SELECT name,
	(SELECT COUNT(*) from IssuedBooks WHERE IssuedBooks.studentId = Students.StudentId) AS Total_Issued_Books
FROM Students;

-- 2. Subquery in WHERE: Find names of students who issued books by 'J.K. Rowling'
SELECT name 
FROM Students
WHERE studentID IN (
	SELECT studentId
    FROM IssuedBooks
    WHERE bookId IN (
		SELECT bookId
        FROM Books
        WHERE authorId = (
			SELECT authorID
            FROM Authors
            Where name = 'J.K. Rowling'
        )
    )
);

-- 3. Subquery with EXISTS: Get all books that have been issued at least once

SELECT bookId, title
FROM Books AS b
WHERE EXISTS (
	SELECT 1
    FROM IssuedBooks AS i
    WHERE i.bookId = b.bookId);

-- 4. Subquery in FROM clause: Find total books issued by each student

SELECT s.studentId, s.name, b.Total_Books
FROM Students AS s
JOIN (
	SELECT count(*) AS Total_Books, studentID 
	FROM issuedbooks
    GROUP BY studentId
    )as b
ON s.studentId = b.studentId;

-- 5. Correlated Subquery: Find students who issued more books than the average books per student

SELECT name
FROM Students s
WHERE (SELECT COUNT(*) FROM IssuedBooks i WHERE i.studentID = s.studentID) > 
      (SELECT AVG(book_count) FROM (
          SELECT COUNT(*) AS book_count FROM IssuedBooks GROUP BY studentID
      ) AS avg_books);


-- Task 7: Creating Views

-- View 1: View showing student details with their issued book count
CREATE VIEW StudentBookCount AS
SELECT Students.studentID, Students.name, Students.class, COUNT(IssuedBooks.issueID) AS BooksIssued
FROM Students
LEFT JOIN IssuedBooks ON Students.studentID = IssuedBooks.studentID
GROUP BY Students.studentID;

SELECT * FROM StudentBookCount;

-- View 2: View showing books with author names
CREATE VIEW BookAuthorDetail AS
SELECT Books.bookId, Books.title, Authors.name AS Author_Name
FROM Books
LEFT JOIN Authors ON Books.authorId = Authors.authorId;

SELECT * FROM BookAuthorDetail;
SELECT * FROM issuedbooks;
-- drop view BookAuthorDetail;


-- View 3: View for issued book details with student name, book title, and issue date
CREATE VIEW IssuedBookDetails AS
SELECT IssuedBooks.issueId, Students.name, Books.title, issuedbooks.issueDate, issuedbooks.returndate
FROM IssuedBooks
INNER JOIN Students ON issuedbooks.studentID = Students.studentId
INNER JOIN Books ON issuedbooks.bookId = Books.bookid;

SELECT * FROM IssuedBookDetails;



-- Task 8: Stored Procedures and Functions

-- PROCEDURE: Get issued books for a specific student
DELIMITER //

CREATE PROCEDURE GetIssuedBooksForStudent(IN stuID INT)
BEGIN
    SELECT IssuedBooks.issueID, Books.title, IssuedBooks.issueDate, IssuedBooks.returnDate
    FROM IssuedBooks
    INNER JOIN Books ON IssuedBooks.bookID = Books.bookID
    WHERE IssuedBooks.studentID = stuID;
END //

DELIMITER ;

-- Example call:
CALL GetIssuedBooksForStudent(1);


-- FUNCTION: Count how many books are issued to a specific student
DELIMITER //

CREATE FUNCTION CountIssuedBooks(stuID INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE bookCount INT;
    SELECT COUNT(*) INTO bookCount FROM IssuedBooks WHERE studentID = stuID;
    RETURN bookCount;
END //

DELIMITER ;

-- Example call:
SELECT CountIssuedBooks(1) AS TotalBooksIssued;










 
 