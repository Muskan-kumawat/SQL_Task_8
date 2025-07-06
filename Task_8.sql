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



