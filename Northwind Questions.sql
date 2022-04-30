select top 1 SUM(od.Quantity * od.UnitPrice) ToplamTutar, od.OrderID from [Order Details] as od group by od.OrderID order by ToplamTutar desc

--1) �r�nleri ada g�re s?rala

select * from Products order by ProductName

--2) �r�nleri ada g�re tersten s?rala

select * from Products order by ProductName desc

--3) �r�n fiyat? 20 den b�y�k ve categoryid si 3 olan �r�nleri fiyata g�re s?rala

select * from Products where UnitPrice > 20 and CategoryID = 3 order by UnitPrice

--4) en pahal? 5 �r�n� getir

select top 5 * from Products order by UnitPrice desc

--5) En pahal? �r�n�m�n fiyat?

select top 1 UnitPrice from Products order by UnitPrice desc --1. ��z�m
 
select MAX(UnitPrice) from Products  --2.��z�m

--6) En ucuz �r�n�m�n fiyat?

select top 1 UnitPrice from Products order by UnitPrice  --1. ��z�m

select MIN(UnitPrice) from Products   --2.��z�m

--7) En ucuz �r�n�m�n KDV li fiyat? nedir?

select top 1 UnitPrice*1.18 from Products order by UnitPrice  --1. ��z�m

select MIN(UnitPrice*1.18) from Products     --2.��z�m

--8) 1996 y?l?ndaki sipari?leri getir

select * from Orders where YEAR(OrderDate) = 1996

--9) 1997 y?l?n?n Mart ay?n?n sipari?lerini getir

select * from Orders where YEAR(OrderDate) = 1997 and MONTH(OrderDate) = 03

--10) ShipCity - 1997 y?l?nda Londra'ya ka� adet sipari? gitti?

select * from Orders where YEAR(OrderDate) = 1997 and ShipCity = 'London'


--11) ProductID si 5 olan �r�n�n kategori ad? nedir

select c.CategoryName from Products as p inner join Categories as c on p.CategoryID= c.CategoryID where p.ProductID =5 

--12) �r�n ad? ve �r�n�n kategorisinin ad?

select p.ProductName ,c.CategoryName from Products as p inner join Categories as c on p.CategoryID= c.CategoryID 


--13) �r�n�n ad?, kategorisinin ad? ve tedarik�isinin ad?

select p.ProductName ,c.CategoryName, s.ContactName  from Products as p 
inner join Categories as c on p.CategoryID= c.CategoryID 
inner join Suppliers as s on s.SupplierID = p.SupplierID

--14) Sipari?i alan personelin ad?,soyad?, sipari? tarihi. S?ralama sipari? tarihine g�re

select FirstName, LastName, o.OrderDate  from Employees as e 
inner join Orders o on e.EmployeeID = o.EmployeeID  order by OrderDate

--15) Son 5 sipari?imin ortalama fiyat? nedir? (sepet toplam? ortalamas?)  


 select TOP 5  AVG(od.Quantity * od.UnitPrice) Toplam   from [Order Details] as od 
 inner join Orders o on  od.OrderID = o.OrderID   group by od.OrderID  order by od.OrderID desc



--16) Ocak ay?nda sat?lan �r�nlerimin ad? ve kategorisinin ad? ve toplam sat?? miktar? nedir?

select p.ProductName, c.CategoryName, od.Quantity from Products as p 
inner join Categories as c on c.CategoryID = p.CategoryID 
inner join [Order Details] as od on od.ProductID = p.ProductID
inner join Orders as ord on ord.OrderID = od.OrderID  where MONTH(OrderDate) = 01


select SUM( od.Quantity) from Products as p 
inner join Categories as c on c.CategoryID = p.CategoryID 
inner join [Order Details] as od on od.ProductID = p.ProductID
inner join Orders as ord on ord.OrderID = od.OrderID  where MONTH(OrderDate) = 01



--17) Hangi personelim hangi personelime rapor veriyor?

select e.EmployeeID , m.ManagerName from Employees e 
inner join Manager m on e.ReportsTo = m.ManagerID

--18) Hangi �lkeden ka� m�?terimiz var (distinc ve count kullan?lacak)

 select DISTINCT country, COUNT(*) as Count from Customers group by Country

--19) Ortalama sat?? miktar?m?n �zerindeki sat??lar?m nelerdir? (order details tablosu)

select * from [Order Details] where  Quantity > (select  avg(Quantity) from  [Order Details])
 
--20) En �ok sat?lan �r�n�m�n(adet baz?nda) ad?, kategorisinin ad? ve tedarik�isinin ad? (4 tablo birle?imi)  order det. prod. cat. sup.

select top 1 ProductName, CategoryName, ContactName from Products p 
inner join [Order Details] od on od.ProductID = p.ProductID 
inner join Categories c on c.CategoryID = p.CategoryID 
inner join Suppliers s on s.SupplierID = p.SupplierID order by od.Quantity desc

--21) 10248 numaral? sipari?i alan �al??an?n ad? ve soyad? ve orderid

select e.FirstName, e.LastName ,o.OrderID from Employees e 
inner join orders o on o.EmployeeID = e.EmployeeID
where o.OrderID = 10248


--22) 1996 y?l?nda, 5 numaral? ID ye sahip �al??an?m ka� adet sipari? ald??

select SUM(Quantity) SiparisAdedi from [Order Details] od 
inner join orders o on o.OrderID = od.OrderID
inner join Employees e on e.EmployeeID = o.EmployeeID
inner join Products p on p.ProductID = od.ProductID
where YEAR(o.OrderDate) = 1996 and e.EmployeeID =5


--23) 1997 y?l?nda kim ne kadar sipari? ge�ti (EmployeeID, Count)

select e.EmployeeID ,SUM(Quantity) SiparisAdedi from [Order Details] od 
inner join orders o on o.OrderID = od.OrderID
inner join Employees e on e.EmployeeID = o.EmployeeID
inner join Products p on p.ProductID = od.ProductID
where YEAR(o.OrderDate) = 1997 group by e.EmployeeID


--24) 10248 numaral? sipari?in �r�nlerinin adlar? ve sipari? miktar?

select p.ProductName , od.Quantity from Products p 
inner join [Order Details] od on od.ProductID = p.ProductID
where od.OrderID = 10248


--25) 10248 numaral? sipari?in toplam fiyat?

select SUM(UnitPrice * Quantity) from Orders o  inner join  [Order Details] od on  o.OrderID = od.OrderID where o.OrderID = 10248


--26) 1996 y?l?nda cirom

select SUM(UnitPrice * Quantity) from [Order Details] od inner join Orders o on o.OrderID = od.OrderID where YEAR(o.OrderDate) = 1996

--27) 1996 y?l?nda en �ok ciro yapan employeeID

select top 1 e.EmployeeID ,SUM(od.UnitPrice * od.Quantity) Ciro from [Order Details] od inner join Orders o on o.OrderID = od.OrderID
inner join Employees e on e.EmployeeID = o.EmployeeID
where YEAR(o.OrderDate) = 1996 group by e.EmployeeID  order by ciro desc

--28) 1997 Mart ay?ndaki sipari?lerimin ortalama fiyat? nedir?

select AVG(od.UnitPrice * od.Quantity) from [Order Details] od 
inner join orders o on o.OrderID = od.OrderID
inner join Products p on p.ProductID = od.ProductID
where YEAR(o.OrderDate) = 1997 and MONTH(o.OrderDate) = 03



--29) 1997 y?l?ndaki ayl?k sat??lar? s?rala. Ocak - 500 gibi toplamda 12 sat?r olacak

select MONTH(o.OrderDate) Ay, sum(od.UnitPrice * od.Quantity) Satis from [Order Details] od 
inner join Orders o on o.OrderID = od.OrderID 
where YEAR(o.OrderDate) = 1997 Group by MONTH(o.OrderDate) order by (MONTH(o.OrderDate))

--30) En de?erli M�?TER?M?N ad? ve soyad? (orders,orderdetails,customers)

select c.ContactName , sum(od.UnitPrice * od.Quantity) Tutar  from Customers c 
inner join Orders o on o.CustomerID = c.CustomerID 
inner join [Order Details] od on od.OrderID = o.OrderID 
group by c.ContactName order by Tutar desc
