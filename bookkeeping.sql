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