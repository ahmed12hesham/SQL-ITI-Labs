use AdventureWorks2012

--1)
Select SalesOrderID ,ShipDate  
from Sales.SalesOrderHeader
where ShipDate Between '7/28/2002' and'7/29/2014'
--2)
Select ProductID,Product.[Name]  from Production.Product 
where StandardCost <110
--3)
Select ProductID, [Name] 
from Production.Product 
where [Weight] is not null	
--4)
select * from Production.Product
where Color in ('Black','Red','Silver')
--5)
select * from Production.Product
where Name like 'B%'
--6)
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3;

select *
from Production.ProductDescription
where Description like '%[_]%' 
--7)
select SUM(totaldue), OrderDate
from Sales.SalesOrderHeader
where OrderDate between '7/1/2001' and '7/31/2014'
group by OrderDate
--8)
select distinct HireDate
from HumanResources.Employee
--9)
Select AVG(ListPrice) from Production.Product
--10)
Select Product.[Name], CONCAT('The ',Product.[Name],' is only price ',Product.ListPrice ) 
from Production.Product
where ListPrice between 100 and 120
--11)
Select rowguid, [Name],SalesPersonID into [store_Archive] 
from Sales.Store

select * 
from store_Archive
--12)
select FORMAT(GETDATE(),'dddd-mmmm-yyyy')
union all
select FORMAT(GETDATE(),'ddd-mmm-yyy')
union all
select FORMAT(GETDATE(),'dd-mm-yy')