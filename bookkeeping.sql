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


/*
טבלת נתוני הכותרת של החשבוניות
קיים קישור ללקוח, מנהל חשבונות אחראי, מטבע המסמך ותנאי תשלום
*/
CREATE TABLE InvoicesHeader(
	InvoiceHeaderId INT PRIMARY KEY IDENTITY,

	CustomerId INT NOT NULL
	CONSTRAINT FK_InvoicesHeader_Customers
	FOREIGN KEY (CustomerId)
	REFERENCES Customers(CustomerId),

	BookkeeperId INT NOT NULL
	CONSTRAINT FK_InvoicesHeader_Bookkeepers
	FOREIGN KEY (BookkeeperId)
	REFERENCES Bookkeepers(BookkeeperId),

	CurrencyId INT NOT NULL
	CONSTRAINT FK_InvoicesHeader_Currencies
	FOREIGN KEY (CurrencyId)
	REFERENCES Currencies(CurrencyId),

	PaymentTermId INT NOT NULL,
	CONSTRAINT FK_InvoicesHeader_PaymentTerms 
	FOREIGN KEY (PaymentTermId) 
	REFERENCES PaymentTerms(PaymentTermId),

	Description NVARCHAR(256),
	ReferenceDate DATE NOT NULL DEFAULT GETDATE()
);
INSERT INTO InvoicesHeader(CustomerId, BookkeeperId, CurrencyId, PaymentTermId, Description, ReferenceDate)
VALUES (6, 3, 6, 3, 'פיתוח אפליקציות למובייל', '2000-09-01'),
       (9, 2, 5, 4, 'שירותי אינטגרציה של מערכות', '2001-01-15'),
       (16, 3, 8, 2, 'פתרונות ענן ושירותי אחסון', '2002-03-16'),
       (15, 1, 10, 1, 'ייעוץ בתחום אבטחת מידע', '2002-12-02'),
       (7, 2, 20, 5, 'פיתוח אתרי אינטרנט מותאמים אישית', '2003-09-12'),
       (5, 2, 8, 1, 'התקנת מערכות ניהול תוכן (CMS)', '2004-06-23'),
       (7, 1, 5, 4, 'שירותי תחזוקת שרתים', '2005-07-23'),
       (20, 1, 3, 4, 'עיצוב חווית משתמש (UX/UI)', '2005-12-25'),
       (10, 3, 8, 6, 'התקנת מערכות ERP ו-CRM', '2006-02-11'),
       (5, 4, 9, 5, 'פתרונות אוטומציה ו-RPA', '2006-05-08'),
       (19, 3, 6, 1, 'פיתוח תוכנה מותאמת לעסקים', '2006-08-02'),
       (9, 2, 3, 5, 'ניהול פרויקטי טכנולוגיה', '2007-12-08'),
       (4, 4, 4, 2, 'שירותי תיקון מחשבים וטלפונים חכמים', '2008-06-17'),
       (1, 1, 9, 3, 'שירותי ניטור ובקרה על מערכות מחשוב', '2008-08-09'),
       (20, 2, 20, 1, 'פתרונות טכנולוגיים בתחום ה-Big Data', '2009-12-28'),
       (10, 2, 4, 6, 'פיתוח מערכות אינטרנט של הדברים (IoT)', '2010-10-17'),
       (2, 3, 5, 7, 'שירותי סייבר ושחזור נתונים', '2010-11-22');


/*
טבלת שורות החשבונית
*/
CREATE TABLE InvoicesItems(
	InvoiceItemId INT PRIMARY KEY IDENTITY,

	InvoiceId INT NOT NULL,
	CONSTRAINT FK_InvoicesItems_InvoicesHeader
	FOREIGN KEY(InvoiceId)
	REFERENCES InvoicesHeader(InvoiceHeaderId),

	VatId INT, --לא בכל עסקה גובים מע"מ
	CONSTRAINT FK_InvoicesItems_VatRates
	FOREIGN KEY(VatId)
	REFERENCES VatRates(VatRateId),

	ItemDescription NVARCHAR(256) NOT NULL,
	Quantity DECIMAL(10, 2) NOT NULL,
	UnitPrice DECIMAL (10, 2) NOT NULL,
	Total AS Quantity * UnitPrice
);
INSERT INTO InvoicesItems(InvoiceId, VatId, ItemDescription, Quantity, UnitPrice)
VALUES (1, 6, 'שעות פיתוח iOS', 50, 400),
       (1, 6, 'שעות פיתוח עבור אנדרואיד', 40, 400),
       (2, 6, 'שעות בדיקות אינטגרציה', 12, 450),
       (2, 6, 'שעות אינטגרציה עם API', 12, 500),
       (2, 6, 'אינטגרציה עם מערכות CRM', 5, 550),
       (3, 6, 'אחסון שרת (50 GB)', 1, 250),
       (3, 6, 'אחסון שרת (100 GB)', 1, 400),
       (3, 6, 'גיבוי בענן (20 GB)', 1, 150),
       (4, 6, 'שעות סקר סיכונים', 10, 800),
       (4, 6, 'שעות סקר איומים', 8, 750),
       (4, 6, 'סדנאות למודעות אבטחה', 3, 2000),
       (5, 6, 'שעות עיצוב', 25, 350),
       (5, 6, 'שעות אופטימיזציה', 20, 350),
       (5, 6, 'פיתוח אתר דינמי', 1, 15000),
       (5, 6, 'עיצוב UI/UX', 15, 500),
       (6, 6, 'התקנה והגדרה', 1, 2000),
       (7, 7, 'שעות תחזוקה', 10, 250),
       (7, 7, 'שעות תחזוקה חודשיות', 6, 300),
       (7, 7, 'שעות תחזוקה מערכת', 20, 350),
       (7, 7, 'תחזוקת מערכת VPS', 1, 800),
       (7, 7, 'התקנה של פתרונות גיבוי', 1, 2000),
       (8, 7, 'שעות עיצוב אינטראקטיבי', 15, 500),
       (9, 8, 'התקנה והגדרה של מערכת', 1, 6500),
       (9, 8, 'הטמעת מודול CRM', 1, 4500),
       (10, 8, 'תכנון וביצוע אוטומציה', 1, 3500),
       (10, 8, 'תכנון אוטומציה ERP', 1, 6000),
       (10, 8, 'בניית אוטומציה למערכת ERP', 1, 5500),
       (11, 8, 'פיתוח מודול מותאם אישית', 1, 8000),
       (11, 8, 'פיתוח מערכת לניהול מלאי', 1, 7500),
       (11, 8, 'פיתוח מערכת CRM מותאמת', 1, 9000),
       (12, 8, 'שעות ניהול פרויקט', 15, 600),
       (12, 8, 'ניהול פרויקט ביג דאטה', 20, 750),
       (12, 8, 'ניהול פרויקט סייבר', 12, 650),
       (13, 8, 'תיקון מכשיר טלפון', 1, 250),
       (13, 8, 'תיקון מחשב נייד', 1, 350),
       (13, 8, 'תיקון טלפון סלולרי', 1, 200),
       (14, 8, 'שעות ניטור ובקרה', 20, 200),
       (14, 8, 'התקנה והגדרה של מערכת', 1, 1500),
       (14, 8, 'ניטור שרתים 24/7', 1, 1200),
       (14, 8, 'פתרון ניטור ותחזוקה', 1, 1500),
       (15, 9, 'שעות ייעוץ ומחקר', 8, 700),
       (15, 9, 'עיבוד נתונים (10 TB)', 1, 4000),
       (15, 9, 'פתרון עיבוד בזמן אמת', 1, 8000),
       (15, 9, 'תכנון פתרונות על פי דרישה', 1, 9500),
       (16, 9, 'שעות פיתוח IoT', 25, 700),
       (16, 9, 'חיישנים IoT ותקשורת', 10, 1000),
       (17, 9, 'שחזור נתונים (10 GB)', 1, 1200),
       (17, 9, 'שדרוג מערכת סייבר', 1, 5000);