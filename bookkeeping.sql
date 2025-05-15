/*
מסד נתונים לניהול מערכת חשבוניות
*/
CREATE DATABASE bookkeeping;
GO
USE bookkeeping;


/*
טבלת תנאי תשלום
שוטף - דורש ללכת לסוף החודש ולהוסיף תקופת זמן
*/
CREATE TABLE PaymentTerms(
    PaymentTermId INT PRIMARY KEY IDENTITY,
	PaymentTermName NVARCHAR(32) UNIQUE NOT NULL,
	Months TINYINT,
	Days TINYINT,
	NeedsEndOfMonth BIT
);
INSERT INTO PaymentTerms(PaymentTermName, Months, Days, NeedsEndOfMonth)
VALUES('מיידי', 0, 0, 0),
      ('שוטף+10', 0, 10, 1),
      ('שוטף+15', 0, 15, 1),
      ('שוטף+30', 1, 0, 1),
      ('שוטף+60', 2, 0, 1),
      ('שוטף+90', 3, 0, 1),
      ('שוטף+120', 4, 0, 1),
      ('10 ימים', 0, 10, 0),
      ('15 ימים', 0, 15, 0),
      ('30 ימים', 0, 30, 0),
      ('60 ימים', 0, 60, 0);


/*
טבלת פרטי מנהלי חשבונות לקישור לרשומות שנוצרות
*/
CREATE TABLE Bookkeepers(
    BookkeeperId INT PRIMARY KEY IDENTITY,
    BookkeeperName NVARCHAR(32) NOT NULL,
    Email NVARCHAR(64) UNIQUE,
    Telephone NVARCHAR(16)
);