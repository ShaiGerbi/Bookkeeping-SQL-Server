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
INSERT INTO Bookkeepers(BookkeeperName, Email, Telephone)
VALUES('Coral', 'coral@company.com', '03-1234567'),
      ('Emily', 'emily@company.com', '03-2345678'),
      ('Alma', 'alma@company.com', '03-3456789'),
      ('Shai', 'shai@company.com', '03-4567891');


/*
טבלת שיעור המע"מ לפי תאריך
*/
CREATE TABLE VatRates(
	VatRateId INT PRIMARY KEY IDENTITY,
	[Percent] DECIMAL(4, 2) NOT NULL,
	FromDate DATE NOT NULL UNIQUE
);
INSERT INTO VatRates([Percent], FromDate) 
VALUES(10, '1976-01-01'),
	  (15, '1985-01-01'),
	  (17, '1991-01-01'),
	  (18, '1992-10-01'),
	  (18.5, '1994-01-01'),
	  (18, '2000-01-01'),
	  (15.5, '2005-01-01'),
	  (15, '2006-01-01'),
	  (16, '2009-07-01'),
	  (17, '2015-09-01'),
	  (18, '2025-01-01');


/*
טבלת מטבעות
*/
CREATE TABLE Currencies(
    CurrencyId INT PRIMARY KEY IDENTITY,
	CurrencyName NVARCHAR(32) NOT NULL,
	CurrencyCode NVARCHAR(3) NOT NULL UNIQUE
);
INSERT INTO Currencies(CurrencyName, CurrencyCode)
VALUES('אירו', 'EUR'),
	  ('דולר אוסטרלי', 'AUD'),
	  ('דולר אמריקאי', 'USD'),
	  ('דולר הונג קונגי', 'HKD'),
	  ('דולר טיוואני', 'TWD'),
	  ('דולר ניו זילנדי', 'NZD'),
	  ('דולר סינגפורי', 'SGD'),
	  ('דולר קנדי', 'CAD'),
	  ('יואן סיני', 'CNY'),
	  ('ין יפני', 'JPY'),
	  ('לירה טורקית', 'TRY'),
	  ('פאונד שטרלינג', 'GBP'),
	  ('פזו מקסיקני', 'MXN'),
	  ('פרנק שווייצרי', 'CHF'),
	  ('קוואצ''ה דרום אפריקאי', 'ZAR'),
  	  ('רובל רוסי', 'RUB'),
	  ('רופי הודי', 'INR'),
	  ('רופי פקיסטני', 'PKR'),
	  ('ריאל ברזילאי', 'BRL'),
  	  ('שקל ישראלי', 'ILS');


/*
טבלת לקוחות
יש קישור למנהל חשבונות שאחראי על הלקוח
*/
CREATE TABLE Customers(
	CustomerId INT PRIMARY KEY IDENTITY,

	BookkeeperId INT,
	CONSTRAINT FK_Customers_Bookkeepers 
	FOREIGN KEY (BookkeeperId) 
	REFERENCES Bookkeepers(BookkeeperId),

	CustomerName NVARCHAR(64) NOT NULL,
	VATNumber NVARCHAR(10) NOT NULL UNIQUE,
	CustomerType NVARCHAR(32) NOT NULL DEFAULT 'לקוחות',

	Street NVARCHAR(64) NOT NULL,
	City NVARCHAR(64) NOT NULL,
	ZipCode NVARCHAR(16),
	Country NVARCHAR(32) NOT NULL,

	Email NVARCHAR(64) NOT NULL,
	Telephone NVARCHAR(16)
);