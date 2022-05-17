--Çalışanın Adı, Soyadı, DoğumTarihi
select p.FirstName, p.LastName, he.BirthDate from Person.Person p
inner join HumanResources.Employee he on he.BusinessEntityID = p.BusinessEntityID
inner join HumanResources.EmployeeDepartmentHistory edh on edh.BusinessEntityID = p.BusinessEntityID
where edh.EndDate is null


--Çalışanın Adı, Soyadı, Telefon Numarası, Telefon numarasının tipi istiyorum
select p.FirstName, p.LastName , pp.PhoneNumber,pp.PhoneNumberTypeID from Person.Person p
inner join person.PersonPhone pp on pp.BusinessEntityID = p.BusinessEntityID
inner join HumanResources.EmployeeDepartmentHistory edh on edh.BusinessEntityID = p.BusinessEntityID
where edh.EndDate is null

-- Çalışanın Adı, Soyadı Departmanının Adı
select p.FirstName,p.LastName,hd.Name from Person.Person p
inner join HumanResources.EmployeeDepartmentHistory edh on edh.BusinessEntityID = p.BusinessEntityID
inner join HumanResources.Department hd on hd.DepartmentID = edh.DepartmentID
where edh.EndDate is null

-- Finance departmanında kaç adet çalışan var?
select COUNT(*)  from Person.Person p
inner join HumanResources.EmployeeDepartmentHistory edh on edh.BusinessEntityID = p.BusinessEntityID
inner join HumanResources.Department hd on hd.DepartmentID = edh.DepartmentID
where edh.EndDate is null and hd.DepartmentID = '10'

-- Çalışanın adı soyadı ve EV TELEFONUNU ekrana yazdır.
select p.FirstName, p.LastName , pp.PhoneNumber from Person.Person p
inner join person.PersonPhone pp on pp.BusinessEntityID = p.BusinessEntityID
inner join HumanResources.EmployeeDepartmentHistory edh on edh.BusinessEntityID = p.BusinessEntityID
where edh.EndDate is null and pp.PhoneNumberTypeID = '2'



--Satış Soruları
-- ADET BAZINDA en çok siparişi veren müşterimin Id si,
select top 1 CustomerID,count(SalesOrderID) SiparisSayisi from Sales.SalesOrderHeader group by CustomerID order by SiparisSayisi  desc

-- Bugüne kadar verilmiş en yüksek cirolu sipariş
-- Sipariş hesaplamalarında discount kolonu da kullanılacak

select top 1 sum(od.OrderQty * (od.UnitPrice*(1-od.UnitPriceDiscount))) SiparisTutari, od.SalesOrderID  from Sales.SalesOrderDetail od group by od.SalesOrderID order by SiparisTutari desc


-- Sipariş cirolarımı TerriorityID ye göre grupla. 8, 564.000

select oh.TerritoryID, sum(oh.TotalDue) BolgeCirosu from Sales.SalesOrderHeader oh group by oh.TerritoryID order by BolgeCirosu desc 



-- Kaç adet sipariş gecikti?
select COUNT(*) Gecikme from Sales.SalesOrderHeader oh where oh.DueDate < oh.ShipDate


-- En çok siparişim hangi bölgeye gecikti ve kaç adet?
select TerritoryID ,count (*) GecikmeSayisi from Sales.SalesOrderHeader oh
where oh.DueDate < oh.ShipDate group by TerritoryID

-- Vista kredi kartıyla kaç adet sipariş verilmiştir?

select COUNT(*) KrediKartiSiparis from Sales.SalesOrderHeader oh
inner join Sales.CreditCard cc on cc.CreditCardID = oh.CreditCardID
where lower( cc.CardType) = 'vista'


-- Taşıma Ücreti 50 den düşük siparişlerimi yazdır

select * from Sales.SalesOrderHeader soh where soh.Freight < 50



