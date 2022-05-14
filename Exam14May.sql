Create Table Customer (
 ID int PRIMARY KEY IDENTITY (1, 1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50),
    Password NVARCHAR(50),
)

Create Table Login (
    CUSTOMERID int NOT NULL,
    EnteryDate datetime default GETDATE(),
)


Create Table Contact (
 ID int PRIMARY KEY IDENTITY (1, 1),
 CUSTOMERID int NOT NULL,
 PhoneNumber NVARCHAR(15),
)

Create Table Email (
 ID int PRIMARY KEY IDENTITY (1, 1),
 CUSTOMERID int NOT NULL,
 Email NVARCHAR(30),
)


Create Table Adress (
 ID int PRIMARY KEY IDENTITY (1, 1),
 CUSTOMERID int NOT NULL,
 City NVARCHAR(20),
 Borough NVARCHAR(20),
 Adress NVARCHAR(50)
)

Create Table Personnel(
 ID int PRIMARY KEY IDENTITY (1, 1),
 FirstName NVARCHAR(50) NOT NULL,
 LastName NVARCHAR(50),
 
)


Create Table Product (
 ID int PRIMARY KEY IDENTITY (1, 1),
 CUSTOMERID int NOT NULL,
 ProcessID int ,
 DueDate datetime default GETDATE(),
)


Create Table CustomerReport(
ID int PRIMARY KEY IDENTITY (1, 1),
ProductID int NOT NULL,
Report NVARCHAR(100),
)

Create Table TechincalReport(
ID int PRIMARY KEY IDENTITY (1, 1),
ProductID int NOT NULL,
PersonnelID int NOT NULL,
Report NVARCHAR(100),
DeliveryDate date
)


Create Table Record (
ID int PRIMARY KEY IDENTITY (1, 1),
ProductID int NOT NULL,
CUSTOMERID int NOT NULL,
Price money
)

Create Table Categorie(
ID int PRIMARY KEY IDENTITY (1,1),
Trouble NVARCHAR(20)
)

Create Table ProductCategorie(
ProductID int NOT NULL,
CategoriID int NOT NULL
)

Create Table Process(
ID int PRIMARY KEY IDENTITY (1, 1),
Stage NVARCHAR(20)

)
