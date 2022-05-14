Create Table Customer (
 ID int PRIMARY KEY IDENTITY (1, 1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50),
	Password NVARCHAR(30)
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
 FullAdress NVARCHAR(50)
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
 EntryDate datetime default GETDATE(),
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


--Ürün eklendiğinde ilk servis aşamasına atayan trigger
CREATE TRIGGER trg_ProductProcess
on Product
after insert 
as
begin
update  Product set ProcessID = 1 where ID = @@IDENTITY
end


--Ekleme Prosedürü
Create proc sp_AddCustomer(@FirstName NVARCHAR(50), @LastName NVARCHAR(50), @Password NVARCHAR(30))
as
begin
insert into Customer (FirstName, LastName, Password) values (@FirstName, @LastName, @Password)
end

--sp_AddCustomer 'Burak', 'Yücel', 'Comolokko123'
--sp_AddCustomer 'Mehmet Ergin', 'Bayer', 'Sayfanbolulu1'
--sp_AddCustomer 'Sami', 'Mete', 'Colombialı'
--sp_AddCustomer 'Şivan', 'Miroğlu', 'Batman'
--sp_AddCustomer 'Dilek Eda', 'Gündüz', 'Dilek48'
--sp_AddCustomer 'Veysel Abdullah', 'Tekin', 'Büyücü'
--sp_AddCustomer 'Yunus Emre', 'Polat', 'Bensizekatılmıyorum'
--sp_AddCustomer 'Emre', 'Teke', 'Romalı34'


--Güncelleme prosedürü

create proc sp_UpdateProcess(@ProductID int ,  @ProcessID int)
as
begin
update Product set ProcessID = @ProcessID where ID = @ProductID
end

--sp_UpdateProcess 2,2


--Delete prosedürü

create proc sp_DeleteRecord (@ID int)
as
begin
delete Record where ID = @ID
end

sp_DeleteRecord 3


--•	ID’si girilen ürün, hangi aşamada?


create proc sp_GetByProcessByID ( @ID int) 
as
begin
select * from Product p
inner join Process pcs on p.ProcessID = pcs.ID where p.ID = @ID
end

sp_GetByProcessByID 3


--•	ID’si girilen ürün hangi üye tarafından bırakılmış?
create proc sp_GetCustomerByID ( @ID int) 
as
begin
select FirstName,LastName from Product p
inner join Customer c on p.CUSTOMERID = c.ID where p.ID = @ID
end


sp_GetCustomerByID 1

--•	ID’si girilen üye hangi ürün/ürünleri, hangi tarihte bırakmış ve ürünün sorgu anında teknik servisin hangi aşamasında,
create proc sp_GetProductByID (@ID int)
as
begin
select * from Product p 
inner join Process pcs on pcs.ID = p.ID
where CUSTOMERID = @ID	
end

sp_GetProductByID 1

--•	Hangi arıza kategorisinde ürünlerden kaçar adet servise geldiği günlük, aylık, yıllık olarak sorgulanabilmeli,
--Günlük
create proc sp_DailyCategory(@Day int)
as
begin
select c.Trouble, COUNT(pc.ProductID)  from ProductCategorie pc 
inner join Categorie c on c.ID = pc.CategoriID 
inner join Product p on pc.ProductID = p.ID
where  DAY(p.EntryDate) = @Day group by c.Trouble
end

sp_DailyCategory 14

--Aylık
create proc sp_MonthlyCategory(@Month int)
as
begin
select c.Trouble, COUNT(pc.ProductID)  from ProductCategorie pc 
inner join Categorie c on c.ID = pc.CategoriID 
inner join Product p on pc.ProductID = p.ID
where  Month(p.EntryDate) = @Month group by c.Trouble
end

sp_MonthlyCategory 5

--Yıllık
create proc sp_YearlyCategory(@Year int)
as
begin
select c.Trouble, COUNT(pc.ProductID)  from ProductCategorie pc 
inner join Categorie c on c.ID = pc.CategoriID 
inner join Product p on pc.ProductID = p.ID
where  Year(p.EntryDate) = @Year group by c.Trouble
end

sp_YearlyCategory 2022

--•	Günlük tahsilat ve ciro raporu oluşturan sorgu,
create proc sp_EarningsOfDay(@Day int)
as
begin
select sum(price) from Record r
inner join Product p on r.ProductID= p.ID
where  DAY(p.EntryDate) = @Day 
end

sp_EarningsOfDay 14

--•	Teknik servis personeli, kişi bazlı, aylık performans raporu hazırlayan sorgu
create view vw_PersonnelPerformence
as
select PersonnelID, COUNT(*) Jobs , MONTH(DeliveryDate) Month from TechincalReport tr group by PersonnelID,MONTH(DeliveryDate)

select * from vw_PersonnelPerformence


--insert into Contact(CUSTOMERID,PhoneNumber) values ('8', '555555550')
--insert into Email(CUSTOMERID, Email) values ('1', 'test@gmail.com')
--insert into Personnel (FirstName, LastName) values ('Ali', 'Toprak')
--insert into Product(CUSTOMERID) values (5)
--insert into Process (Stage) values ('Tesim edildi')
--insert into CustomerReport (ProductID, Report) values (

--insert into Adress(CUSTOMERID,City,Borough,FullAdress) values (2,'İstanbul','Kartal', 'asdasd Caddesi 6/1')

--insert into Categorie (Trouble) values ('Piston aşağı indi')

--insert into CustomerReport (ProductID,Report) values (3, 'Görüntü gidiyor')

--insert into ProductCategorie (ProductID, CategoriID) values (3,2)

--insert into Record (CUSTOMERID, ProductID, Price) values (2, 2, 150)

--insert into TechincalReport (ProductID, PersonnelID , Report, DeliveryDate) values (3, 1, 'Ekran değişimi gerekiyor' , '2022-05-22')


Select * from Adress
select * from Categorie
Select * from Contact
select * from Customer
Select * from CustomerReport
select * from Email
select * from Personnel
select * from Product
Select * from ProductCategorie
select * from Record
select * from TechincalReport
