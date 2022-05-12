Create table  Student (
ID int PRIMARY KEY IDENTITY(1,1),
FirstName nvarchar(50),
LastName nvarchar(50),
StundentNumber nvarchar(15),
EMail nvarchar (30),
Number nvarchar (15),
BirthDay date,
DeparmentID  int NOT NULL
)


CREATE TABLE Academician (
ID int PRIMARY KEY IDENTITY(1,1),
FirstName nvarchar(50),
LastName nvarchar(50)
)



CREATE TABLE Department (
ID int PRIMARY KEY IDENTITY(1,1),
DepartmentName nvarchar (30),
PublishDate date,
FacultyID int NOT NULL
)

CREATE TABLE Faculty
(
ID int PRIMARY KEY IDENTITY(1,1),
FacultyName nvarchar (30),
)

create TABLE AcademicianDepartment (
ID int PRIMARY KEY IDENTITY(1,1),
AcademicianID int,
DepartmentID int

)




-- Öğrenci Ad, Soyad, Bölüm Ad, Fakülte Ad
select s.FirstName,s.LastName,d.DepartmentName,f.FacultyName from Student s 
inner join Department d on s.DeparmentID = d.ID
inner join Faculty f on f.ID  = d.FacultyID where s.ID in (1,2)

-- Eğitmen Ad, Bölüm Ad
select a.FirstName ,d.DepartmentName  from Academician a 
inner join AcademicianDepartment ad on ad.AcademicianID = a.ID
inner join Department d on d.ID = ad.DepartmentID

-- Fen Fakültesindeki EĞİTMENLERİ LİSTELE
select f.FacultyName,a.ID, a.FirstName,a.LastName from AcademicianDepartment ad
inner join Academician a on a.ID = ad.AcademicianID 
inner join Department d on d.ID = ad.DepartmentID
inner join Faculty f on f.ID = d.FacultyID where f.FacultyName like '%Fen%'


-- Fakülte ekleyen bir store procedure yaz
create proc sp_AddFaculty(@Name nvarchar(30))
as
begin 
insert into Faculty (FacultyName) values (@Name)
end

sp_AddFaculty 'İktisadi ve İdari Bilimler Fakültesi'


-- Herhangi bir fakülte eklendiğinde ekrana 'Yeni bir fakülte eklendi!' yazsın (TRIGGER)

create trigger trg_add__faculty
on Faculty 
after insert
as
begin
print ('Yeni bir fakülte eklendi!')
end

-- Bölüm ID, Ad, Fakülte Ad isimli 3 kolonu olan bir VIEW yaz

create view vw_DepartmentandFaculty
as
select d.ID,d.DepartmentName,f.FacultyName from Department d 
inner join Faculty f on f.ID = d.FacultyID 

select * from vw_DepartmentandFaculty


