create table User (
ID int PRIMARY KEY IDENTITY (1,1),
FirstName NVARCHAR (MAX),
LastName NVARCHAR (MAX),
ADDRESSID int,
MembershipDate datetime
)

create table Product (
ID int PRIMARY KEY IDENTITY (1,1),
Rank decimal,
Weight decimal,
PublshDate Date,
Price Money
)

create table Category (
TOPID int PRIMARY KEY IDENTITY (1,1),
ID int UNIQUE ,
CategoryName NVARCHAR (MAX),
Description NVARCHAR(MAX)
)

create table ProductCategory (
ProductID int,
CategoryID int
)

Create table Favorite (
UserID int,
ProductID int
)

create table ProductCart (
ID int PRIMARY KEY IDENTITY (1,1),
ProductID int,
Quantity int
)

create table Order (
ID int PRIMARY KEY IDENTITY (1,1),
ProductCartID int,
TotalPrice money
)

create table City (
ID int PRIMARY KEY IDENTITY (1,1),
Name NVARCHAR (MAX),
)
create table District (
ID int PRIMARY KEY IDENTITY (1,1),
Name NVARCHAR (MAX),
)

create table Address (
ID int PRIMARY KEY IDENTITY (1,1),
CityID int,
DistrictID int,
OpenAddress NVARCHAR (MAX),
)
