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
INSERT INTO Customers(BookkeeperId, CustomerName, VATNumber, CustomerType, Street, City, ZipCode, Country, Email, Telephone)
VALUES (2, 'אולמן את ספרין סוכנויות ', '5199383969', 'לקוחות', '47 Hataasia', 'Nesher', '4757907', 'Israel', 'info@olman-saprin.co.il', '02-4183572'),
       (1, 'אופנהיים ובניו', '5128423757', 'לקוחות', '3 Eli Cohen', 'Tel Aviv', '9273025', 'Israel', 'contact@opfnaheim.co.il', '08-5233067'),
       (4, 'איגר בע"מ', '5198351759', 'לקוחות', '142 Iben Gabirol', 'Tel Aviv', '6220068', 'Israel', 'info@iger.co.il', '08-1659807'),
       (3, 'איסרליש את דון משווקים', '5151583406', 'לקוחות', '4 Morad Hazamir', 'Haifa', '8332414', 'Israel', 'sales@israelish-don.co.', '07-2368335'),
       (4, 'אלישיב ווינברג', '5118660735', 'לקוחות', '4 Hasarig', 'Hod Hasharon', '8414523', 'Israel', 'support@elishiv-winberg.co.il', '05-0652082'),
       (1, 'בינדיגר משווקים', '5152799178', 'לקוחות', '10 Duvnov', 'Tel Aviv', '4418178', 'Israel', 'contact@bindiger.co.il', '02-4196219'),
       (1, 'גורדון ואפשטיין', '5115372211', 'לקוחות', '4 Haetrog', 'Hadera', '7157722', 'Israel', 'info@gordon-epstein.co.il', '07-6204282'),
       (1, 'גינצבורג ואיגר', '5110782711', 'לקוחות', '155 Bialik', 'Ramat Gan', '4861620', 'Israel', 'sales@ginzburg-iger.co.il', '09-1900847'),
       (1, 'גרודזנסקי ובניו', '5119660198', 'לקוחות', '45 Hachatzav', 'Rishon Lezion', '7777538', 'Israel', 'info@grodzinski-bneyu.co.il', '02-9533515'),
       (1, 'גרוסברד ואיסרליש', '5115163377', 'לקוחות', '4 Zohar', 'Ramat Gan', '9608106', 'Israel', 'contact@grossbard-israelish.c', '05-2152620'),
       (1, 'זוננפלד בע"מ', '5120156457', 'לקוחות', '1 Etgar t Carmel', 'Tira', '4355822', 'Israel', 'info@zonnenfeld.co.il', '08-1084979'),
       (3, 'טייכטל את דיסקין משווקים', '5165527465', 'לקוחות', '8 Hamelech Shaul Blvd.', 'Tel Aviv', '1082151', 'Israel', 'sales@teichtel-diskin', '09-3133919'),
       (3, 'לוברבוים וגרוזובסקי', '5143591470', 'לקוחות', '11 Moran Lane', 'Jerusalem', '4680663', 'Israel', 'contact@luberboim-gruzovsk', '05-9829058'),
       (1, 'לוריא את שך סוכנויות', '5118521272', 'לקוחות', '21 Haorgim', 'Holon', '5276319', 'Israel', 'info@luria-shah.co.il', '08-3965115'),
       (1, 'סלנט בע"מ', '5155094419', 'לקוחות', '14 Uri', 'Tel Aviv', '6877819', 'Israel', 'sales@salant.co.il', '07-6912070'),
       (4, 'קרליבך את אייכנשטיין משווקים', '5144188050', 'לקוחות', '16 Ichilov Itzhak', 'Petah Tikva', '1791292', 'Israel', 'info@karlebach-ei', '07-8590834'),
       (2, 'רובין בע"מ', '5136227785', 'לקוחות', '15 Beeri', 'Rishon Lezion', '1050138', 'Israel', 'contact@robin.co.il', '07-6910720'),
       (2, 'רוטשילד את אונגרישר ובניו', '5163035863', 'לקוחות חובות מסופקים', '3 Shimon Hatzadik', 'Tel Aviv', '8343575', 'Israel', 'info@rothschild-ungr', '08-3021886'),
       (4, 'שפירא סוכנויות', '5137084262', 'לקוחות חברה קשורה', '11 Meitav', 'Tel Aviv', '2756017', 'Israel', 'sales@shapira-agencies.co.il', '02-3089729'),
       (4, 'תאומים ובניו', '5148687595', 'לקוחות', '1 Hanassi Weizmann', 'Hadera', '7856513', 'Israel', 'contact@teomim-bneyu.co.il', '09-6860441');