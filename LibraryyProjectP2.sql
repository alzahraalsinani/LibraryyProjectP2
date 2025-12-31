CREATE DATABASE LibraryyProjectP2;
USE LibraryyProjectP2;

CREATE TABLE Library (
    LID INT IDENTITY(1,1) PRIMARY KEY,
    LName VARCHAR(100) NOT NULL UNIQUE,
    Location VARCHAR(150) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    EstablishedYear INT
);

CREATE TABLE Member (
    MID INT IDENTITY(1,1) PRIMARY KEY,
    FullName VARCHAR(150) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    PhoneNumber INT NOT NULL,
    MembershipStartDate DATE NOT NULL
);

CREATE TABLE Staff ( 
    SID INT IDENTITY(1,1) PRIMARY KEY, 
    FullName VARCHAR(150) NOT NULL, 
    Position VARCHAR(100) NOT NULL, 
    ContactNumber VARCHAR(20) NOT NULL, 
    LID INT NOT NULL,
    CONSTRAINT FK_Staff_Library FOREIGN KEY (LID)
        REFERENCES Library(LID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Book (
    BID INT IDENTITY(1,1) PRIMARY KEY,
    ISBN VARCHAR(20) NOT NULL UNIQUE,
    Title VARCHAR(150) NOT NULL,
    Genre VARCHAR(20) NOT NULL,
    Price DECIMAL(10,2) CHECK (Price > 0),
    AvailabilityStatus BIT DEFAULT 1,
    ShelfLocation VARCHAR(50) NOT NULL,
    LID INT NOT NULL,
    CONSTRAINT FK_Book_Library FOREIGN KEY (LID)
        REFERENCES Library(LID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT CHK_Book_Genre CHECK (Genre IN ('Fiction', 'Non-fiction', 'Reference', 'Children'))
);

CREATE TABLE Reviews (
    RID INT IDENTITY(1,1) PRIMARY KEY,
    Rating INT NOT NULL,
    Comments VARCHAR(255) DEFAULT 'No comments' NOT NULL,
    ReviewDate DATE NOT NULL,
    MID INT NOT NULL,
    BID INT NOT NULL,
    CONSTRAINT FK_Reviews_Member FOREIGN KEY (MID)
        REFERENCES Member(MID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_Reviews_Book FOREIGN KEY (BID)
        REFERENCES Book(BID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT CHK_Review_Rating CHECK (Rating BETWEEN 1 AND 5),
    CONSTRAINT UQ_Review UNIQUE (MID, BID)
);

CREATE TABLE Loan (
    LID INT IDENTITY(1,1) PRIMARY KEY,
    LoanDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Issued',
    BID INT NOT NULL,
    MID INT NOT NULL,
    CONSTRAINT FK_Loan_Book FOREIGN KEY (BID)
        REFERENCES Book(BID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_Loan_Member FOREIGN KEY (MID)
        REFERENCES Member(MID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT CHK_Loan_Status CHECK (Status IN ('Issued', 'Returned', 'Overdue'))
);

CREATE TABLE Payment (
    PID INT IDENTITY(1,1) PRIMARY KEY,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL CHECK (Amount > 0),
    PaymentMethod VARCHAR (50) NOT NULL,
    LID INT NOT NULL,
    CONSTRAINT FK_Payment_Loan FOREIGN KEY (LID)
        REFERENCES Loan(LID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
----------------------------------------------------------------------
INSERT INTO Library (LName, Location, ContactNumber, EstablishedYear)
VALUES
('Central Library', 'Downtown City', '71117581', 1998),
('Science Library', 'University Campus', '77494911', 2005),
('City Library', 'City Center', '77998877', 2010);
SELECT* FROM Library

INSERT INTO Member (FullName, Email, PhoneNumber, MembershipStartDate)
VALUES
('Noor Abdullah', 'noor@gmail.com', 71117832, '2023-01-15'),
('Sara Ali', 'sara@gmail.com', 77434311, '2023-03-10'),
('Mohamed Salah', 'mohamed@gmail.com', 92934219, '2024-02-01'),
('Ali Hassan', 'ali@gmail.com', 93322110, '2023-05-12'),
('Mona Youssef', 'mona@gmail.com', 95566778, '2024-01-20'),
('Hassan Omar', 'hassan@gmail.com', 98877665, '2024-03-10'),
('Layla Said', 'layla@gmail.com', 97766554, '2023-07-05'),
('Omar Khalid', 'omar@gmail.com', 96655443, '2023-08-20'),
('Salma Nabil', 'salma@gmail.com', 95544332, '2024-02-15'),
('Youssef Sami', 'youssef@gmail.com', 94433221, '2024-04-01');
SELECT* FROM Member

INSERT INTO Staff (FullName, Position, ContactNumber, LID)
VALUES
('Ali Mahmoud', 'Librarian', '01122334455', 1),
('Mona Ibrahim', 'Assistant Librarian', '01199887766', 1),
('Youssef Adel', 'Manager', '01055667788', 2),
('Sara Khalid', 'Librarian', '01111223344', 3),
('Hana Ahmed', 'Assistant Librarian', '01133445566', 2);
SELECT* FROM Staff

INSERT INTO Book (ISBN, Title, Genre, Price, AvailabilityStatus, ShelfLocation, LID)
VALUES
('978-1111111111', 'Database Systems', 'Reference', 150.00, 1, 'A1', 1),
('978-2222222222', 'Learn SQL', 'Non-fiction', 120.50, 1, 'B2', 1),
('978-3333333333', 'Harry Potter', 'Fiction', 200.00, 1, 'C3', 2),
('978-4444444444', 'Kids Stories', 'Children', 80.00, 1, 'D4', 2),
('978-5555555555', 'Advanced SQL', 'Reference', 180.00, 1, 'A2', 1),
('978-6666666666', 'Science Facts', 'Non-fiction', 90.00, 1, 'B3', 3),
('978-7777777777', 'The Great Gatsby', 'Fiction', 140.00, 1, 'C4', 1),
('978-8888888888', 'Math for Kids', 'Children', 70.00, 1, 'D5', 3),
('978-9999999999', 'Physics Principles', 'Reference', 160.00, 1, 'A3', 2),
('978-1010101010', 'Biology 101', 'Non-fiction', 130.00, 1, 'B4', 2),
('978-1212121212', 'World History', 'Non-fiction', 120.00, 1, 'B5', 1),
('978-1313131313', 'Fantasy Tales', 'Fiction', 150.00, 1, 'C5', 3),
('978-1414141414', 'Children Stories 2', 'Children', 85.00, 1, 'D6', 2),
('978-1515151515', 'Algorithms', 'Reference', 190.00, 1, 'A4', 1),
('978-1616161616', 'Chemistry Basics', 'Non-fiction', 110.00, 1, 'B6', 3),
('978-1717171717', 'Hobbit', 'Fiction', 180.00, 1, 'C6', 1),
('978-1818181818', 'Kids Adventure', 'Children', 75.00, 1, 'D7', 2),
('978-1919191919', 'Art of War', 'Non-fiction', 95.00, 1, 'B7', 3),
('978-2020202020', 'C++ Programming', 'Reference', 170.00, 1, 'A5', 2),
('978-2121212121', 'Fairy Tales', 'Children', 80.00, 1, 'D8', 3);
SELECT* FROM Book

INSERT INTO Reviews (Rating, Comments, ReviewDate, MID, BID)
VALUES
(5, 'Excellent book', '2024-04-01', 1, 1),
(4, 'Very useful', '2024-04-03', 2, 2),
(5, 'Amazing story', '2024-04-05', 3, 3),
(3, 'Good reference', '2024-04-06', 4, 5),
(4, 'Fun for kids', '2024-04-07', 5, 8),
(5, 'Loved it', '2024-04-08', 6, 13);
SELECT* FROM Reviews

INSERT INTO Loan (LoanDate, DueDate, ReturnDate, Status, BID, MID)
VALUES
('2024-04-01', '2024-04-15', '2024-04-10', 'Returned', 1, 1),
('2024-04-05', '2024-04-20', NULL, 'Issued', 2, 2),
('2024-04-07', '2024-04-21', NULL, 'Issued', 3, 3),
('2024-04-08', '2024-04-22', NULL, 'Issued', 4, 4),
('2024-04-10', '2024-04-25', NULL, 'Issued', 5, 5),
('2024-04-11', '2024-04-26', NULL, 'Issued', 6, 6),
('2024-04-12', '2024-04-27', NULL, 'Issued', 7, 7),
('2024-04-13', '2024-04-28', NULL, 'Issued', 8, 8),
('2024-04-14', '2024-04-29', NULL, 'Issued', 9, 9),
('2024-04-15', '2024-04-30', NULL, 'Issued', 10, 10),
('2024-04-16', '2024-05-01', NULL, 'Issued', 11, 1),
('2024-04-17', '2024-05-02', NULL, 'Issued', 12, 2),
('2024-04-18', '2024-05-03', NULL, 'Issued', 13, 3),
('2024-04-19', '2024-05-04', NULL, 'Issued', 14, 4),
('2024-04-20', '2024-05-05', NULL, 'Issued', 15, 5);
SELECT* FROM Loan

INSERT INTO Payment (PaymentDate, Amount, PaymentMethod, LID)
VALUES
('2024-04-12', 15.00, 'Cash', 1),
('2024-04-15', 20.00, 'Credit Card', 2),
('2024-04-18', 25.00, 'Cash', 3);
SELECT* FROM Payment

SELECT * FROM Library;
SELECT * FROM Member;
SELECT * FROM Staff;
SELECT * FROM Book;
SELECT * FROM Reviews;
SELECT * FROM Loan;
SELECT * FROM Payment;
-------------------------------------------------Section 1:
-----------------1
SELECT 
    L.LName AS LibraryName,
    COUNT(B.BID) AS TotalBooks,
    SUM(CASE WHEN B.AvailabilityStatus = 1 THEN 1 ELSE 0 END) AS AvailableBooks,
    SUM(CASE WHEN B.AvailabilityStatus = 0 THEN 1 ELSE 0 END) AS BooksOnLoan
FROM Library L
LEFT JOIN Book B ON L.LID = B.LID
GROUP BY L.LName;
-----------------2
SELECT 
    M.FullName AS MemberName,
    M.Email,
    B.Title AS BookTitle,
    L.LoanDate,
    L.DueDate,
    L.Status
FROM Loan L
JOIN Member M ON L.MID = M.MID
JOIN Book B ON L.BID = B.BID
WHERE L.Status IN ('Issued','Overdue');
-----------------3
SELECT 
    M.FullName AS MemberName,
    M.PhoneNumber,
    B.Title AS BookTitle,
    Lib.LName AS LibraryName,
    DATEDIFF(DAY, L.DueDate, GETDATE()) AS DaysOverdue,
    P.Amount AS FinePaid
FROM Loan L
JOIN Member M ON L.MID = M.MID
JOIN Book B ON L.BID = B.BID
JOIN Library Lib ON B.LID = Lib.LID
LEFT JOIN Payment P ON P.LID = L.LID
WHERE L.Status = 'Overdue';
-----------------4
SELECT 
    Lib.LName AS LibraryName,
    S.FullName AS StaffName,
    S.Position,
    COUNT(B.BID) AS BooksManaged
FROM Staff S
JOIN Library Lib ON S.LID = Lib.LID
LEFT JOIN Book B ON B.LID = Lib.LID
GROUP BY Lib.LName, S.FullName, S.Position
ORDER BY Lib.LName, S.FullName;
-----------------5
SELECT 
    B.Title,
    B.ISBN,
    B.Genre,
    COUNT(L.LID) AS TimesLoaned,
    AVG(R.Rating) AS AvgRating
FROM Book B
JOIN Loan L ON L.BID = B.BID
LEFT JOIN Reviews R ON R.BID = B.BID
GROUP BY B.Title, B.ISBN, B.Genre
HAVING COUNT(L.LID) >= 3;
-----------------6
SELECT 
    M.FullName AS MemberName,
    B.Title AS BookTitle,
    L.LoanDate,
    L.ReturnDate,
    R.Rating,
    R.Comments
FROM Member M
JOIN Loan L ON L.MID = M.MID
JOIN Book B ON L.BID = B.BID
LEFT JOIN Reviews R ON R.MID = M.MID AND R.BID = B.BID
ORDER BY M.FullName, L.LoanDate;
-----------------7
SELECT 
    B.Genre,
    COUNT(L.LID) AS TotalLoans,
    SUM(P.Amount) AS TotalFines,
    AVG(P.Amount) AS AvgFinePerLoan
FROM Book B
JOIN Loan L ON L.BID = B.BID
LEFT JOIN Payment P ON P.LID = L.LID
GROUP BY B.Genre;
-------------------------------------------------Section 2:
-----------------8
SELECT 
    DATENAME(MONTH, LoanDate) AS MonthName,
    COUNT(*) AS TotalLoans,
    SUM(CASE WHEN Status='Returned' THEN 1 ELSE 0 END) AS TotalReturned,
    SUM(CASE WHEN Status IN ('Issued','Overdue') THEN 1 ELSE 0 END) AS TotalIssuedOverdue
FROM Loan
WHERE YEAR(LoanDate) = YEAR(GETDATE())
GROUP BY MONTH(LoanDate), DATENAME(MONTH, LoanDate)
ORDER BY MONTH(LoanDate);
-----------------9
SELECT 
    M.FullName,
    COUNT(L.LID) AS TotalBooksBorrowed,
    SUM(CASE WHEN L.Status IN ('Issued','Overdue') THEN 1 ELSE 0 END) AS BooksCurrentlyOnLoan,
    SUM(P.Amount) AS TotalFinesPaid,
    AVG(R.Rating) AS AvgRatingGiven
FROM Member M
JOIN Loan L ON L.MID = M.MID
LEFT JOIN Payment P ON P.LID = L.LID
LEFT JOIN Reviews R ON R.MID = M.MID
GROUP BY M.FullName
HAVING COUNT(L.LID) > 0;
-----------------10
SELECT 
    Lib.LName AS LibraryName,
    COUNT(B.BID) AS TotalBooksOwned,
    COUNT(DISTINCT L.MID) AS TotalActiveMembers,
    SUM(P.Amount) AS TotalRevenueFromFines,
    CAST(COUNT(B.BID) AS FLOAT)/NULLIF(COUNT(DISTINCT L.MID),0) AS AvgBooksPerMember
FROM Library Lib
LEFT JOIN Book B ON B.LID = Lib.LID
LEFT JOIN Loan L ON L.BID = B.BID
LEFT JOIN Payment P ON P.LID = L.LID
GROUP BY Lib.LName;
-----------------11
WITH GenreAvg AS (
    SELECT Genre, AVG(Price) AS AvgPrice
    FROM Book
    GROUP BY Genre
)
SELECT 
    B.Title,
    B.Genre,
    B.Price,
    GA.AvgPrice AS GenreAvgPrice,
    B.Price - GA.AvgPrice AS Difference
FROM Book B
JOIN GenreAvg GA ON B.Genre = GA.Genre
WHERE B.Price > GA.AvgPrice;
-----------------12
WITH TotalRevenue AS (
    SELECT SUM(Amount) AS TotalAmt FROM Payment
)
SELECT 
    PaymentMethod,
    COUNT(*) AS NumberOfTransactions,
    SUM(Amount) AS TotalCollected,
    AVG(Amount) AS AvgPayment,
    CAST(SUM(Amount)*100.0 / (SELECT TotalAmt FROM TotalRevenue) AS DECIMAL(5,2)) AS PercentageOfTotalRevenue
FROM Payment
GROUP BY PaymentMethod;
-------------------------------------------------Section 3:
-----------------13
CREATE VIEW vw_CurrentLoans AS
SELECT 
    L.LID AS LoanID,
    M.FullName AS MemberName,
    M.Email,
    M.PhoneNumber,
    B.Title AS BookTitle,
    B.ISBN,
    B.Genre,
    L.LoanDate,
    L.DueDate,
    L.Status,
    CASE 
        WHEN L.DueDate >= GETDATE() THEN DATEDIFF(DAY, GETDATE(), L.DueDate)
        ELSE DATEDIFF(DAY, L.DueDate, GETDATE())
    END AS DaysUntilDueOrOverdue
FROM Loan L
JOIN Member M ON L.MID = M.MID
JOIN Book B ON L.BID = B.BID
WHERE L.Status IN ('Issued','Overdue');
SELECT* FROM vw_CurrentLoans
-----------------14
CREATE VIEW vw_LibraryStatistics AS
SELECT 
    Lib.LName AS LibraryName,
    COUNT(DISTINCT B.BID) AS TotalBooks,
    SUM(CASE WHEN B.AvailabilityStatus = 1 THEN 1 ELSE 0 END) AS AvailableBooks,
    COUNT(DISTINCT M.MID) AS TotalMembers,
    COUNT(DISTINCT CASE WHEN L.Status IN ('Issued','Overdue') THEN L.LID END) AS ActiveLoans,
    COUNT(DISTINCT S.SID) AS TotalStaff,
    SUM(P.Amount) AS TotalRevenueFines
FROM Library Lib
LEFT JOIN Book B ON B.LID = Lib.LID
LEFT JOIN Loan L ON L.BID = B.BID
LEFT JOIN Member M ON L.MID = M.MID
LEFT JOIN Staff S ON S.LID = Lib.LID
LEFT JOIN Payment P ON P.LID = L.LID
GROUP BY Lib.LName;
SELECT* FROM vw_LibraryStatistics
-----------------15
CREATE VIEW vw_BookDetailsWithReviews AS
SELECT 
    B.Title,
    B.ISBN,
    B.Genre,
    B.Price,
    B.ShelfLocation,
    B.AvailabilityStatus,
    COUNT(R.RID) AS TotalReviews,
    AVG(R.Rating) AS AvgRating,
    MAX(R.ReviewDate) AS LatestReviewDate
FROM Book B
LEFT JOIN Reviews R ON R.BID = B.BID
GROUP BY 
    B.Title, B.ISBN, B.Genre, B.Price, B.ShelfLocation, B.AvailabilityStatus;
SELECT* FROM vw_BookDetailsWithReviews
-------------------------------------------------Section 4:
-----------------16
CREATE PROCEDURE sp_IssueBook
    @MID INT,
    @BID INT,
    @DueDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (
        SELECT 1 FROM Book
        WHERE BID = @BID AND AvailabilityStatus = 1
    )
    BEGIN
        SELECT 'Book is not available' AS Message;
        RETURN;
    END

    IF EXISTS (
        SELECT 1 FROM Loan
        WHERE MID = @MID
          AND Status = 'Issued'
          AND DueDate < GETDATE()
    )
    BEGIN
        SELECT 'Member has overdue loans' AS Message;
        RETURN;
    END

    INSERT INTO Loan (LoanDate, DueDate, Status, BID, MID)
    VALUES (GETDATE(), @DueDate, 'Issued', @BID, @MID);

    UPDATE Book
    SET AvailabilityStatus = 0
    WHERE BID = @BID;

    SELECT 'Book issued successfully' AS Message;
END;
EXEC sp_helptext 'sp_IssueBook';
-----------------17
CREATE PROCEDURE sp_ReturnBook
    @LoanID INT,
    @ReturnDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DueDate DATE, @BID INT;
    DECLARE @DaysLate INT = 0;
    DECLARE @Fine DECIMAL(10,2) = 0;

    SELECT 
        @DueDate = DueDate,
        @BID = BID
    FROM Loan
    WHERE LID = @LoanID;

    IF @ReturnDate > @DueDate
    BEGIN
        SET @DaysLate = DATEDIFF(DAY, @DueDate, @ReturnDate);
        SET @Fine = @DaysLate * 2;
    END

    UPDATE Loan
    SET Status = 'Returned',
        ReturnDate = @ReturnDate
    WHERE LID = @LoanID;

    UPDATE Book
    SET AvailabilityStatus = 1
    WHERE BID = @BID;

    IF @Fine > 0
    BEGIN
        INSERT INTO Payment (PaymentDate, Amount, PaymentMethod, LID)
        VALUES (GETDATE(), @Fine, 'Pending', @LoanID);
    END

    SELECT @Fine AS TotalFine;
END;
-----------------18
CREATE PROCEDURE sp_GetMemberReport
    @MID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Member
    WHERE MID = @MID;

    SELECT *
    FROM Loan
    WHERE MID = @MID AND Status = 'Issued';
	
	SELECT *
    FROM Loan
    WHERE MID = @MID;

    SELECT
        SUM(Amount) AS TotalFines
    FROM Payment p
    JOIN Loan l ON p.LID = l.LID
    WHERE l.MID = @MID;

    SELECT *
    FROM Reviews
    WHERE MID = @MID;
END;
-----------------19
CREATE PROCEDURE sp_MonthlyLibraryReport
    @LibraryID INT,
    @Month INT,
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT COUNT(*) AS TotalLoansIssued
    FROM Loan l
    JOIN Book b ON l.BID = b.BID
    WHERE b.LID = @LibraryID
      AND MONTH(l.LoanDate) = @Month
      AND YEAR(l.LoanDate) = @Year;

    SELECT COUNT(*) AS TotalBooksReturned
    FROM Loan l
    JOIN Book b ON l.BID = b.BID
    WHERE b.LID = @LibraryID
      AND l.Status = 'Returned'
      AND MONTH(l.ReturnDate) = @Month
      AND YEAR(l.ReturnDate) = @Year;

    SELECT SUM(p.Amount) AS TotalRevenue
    FROM Payment p
    JOIN Loan l ON p.LID = l.LID
    JOIN Book b ON l.BID = b.BID
    WHERE b.LID = @LibraryID
      AND MONTH(p.PaymentDate) = @Month
      AND YEAR(p.PaymentDate) = @Year;

    SELECT TOP 1 b.Genre, COUNT(*) AS BorrowCount
    FROM Loan l
    JOIN Book b ON l.BID = b.BID
    WHERE b.LID = @LibraryID
      AND MONTH(l.LoanDate) = @Month
      AND YEAR(l.LoanDate) = @Year
    GROUP BY b.Genre
    ORDER BY BorrowCount DESC;

    SELECT TOP 3 m.FullName, COUNT(*) AS LoanCount
    FROM Loan l
    JOIN Member m ON l.MID = m.MID
    JOIN Book b ON l.BID = b.BID
    WHERE b.LID = @LibraryID
      AND MONTH(l.LoanDate) = @Month
      AND YEAR(l.LoanDate) = @Year
    GROUP BY m.FullName
    ORDER BY LoanCount DESC;
END;


