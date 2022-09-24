use Company_SD

--1)
SELECT d.Dnum,d.Dname,e.Fname as [Manger Name]
FROM Departments d inner join Employee e
on e.SSN = d.MGRSSN;

--2)
SELECT d.Dname,p.Pname
FROM [dbo].[Departments] d,Project p
WHERE d.Dnum=p.Dnum

--3)
SELECT d.*,e.Fname as [employee name]
FROM [dbo].[Dependent] d,Employee e
where e.SSN=d.ESSN

--4)
SELECT Pnumber,Pname,Plocation
FROM Project
WHERE City in('Alex','Cairo')

--5)
SELECT *
FROM Project p
WHERE p.Pname LIKE 'a%'

--6)
SELECT *
FROM Employee e
WHERE e.Dno=30 AND Salary BETWEEN 1000 AND 2000

--7)
SELECT e.Fname
FROM Employee e, Project p,Works_for w
WHERE e.SSN=w.ESSn AND p.Pnumber=w.Pno AND e.Dno=10 AND w.Hours>= 10 AND p.Pname='AL Rabwah'

--8)
SELECT x.Fname + ' ' + x.Lname as full_name
FROM Employee x inner join Employee y on y.SSN = x.Superssn
WHERE y.Fname='Kamel' AND y.Lname='Mohamed'

--9)
SELECT e.Fname , p.Pname
FROM Employee e , Project p, Works_for w
WHERE e.SSN=w.ESSn and p.Pnumber=w.Pno
ORDER BY p.Pname 

--10)
SELECT p.Pname,d.Dname,e.Lname as [Manger Lname],e.Address as [Manger Address],e.Bdate as [Manger Bdate]
FROM [dbo].[Project] p ,[dbo].[Departments] d , [dbo].[Employee] e
WHERE p.Dnum=d.Dnum AND d.MGRSSN=e.SSN AND p.City='Cairo'

--11)
SELECT e.*
FROM Employee e ,Departments d
WHERE e.SSN=d.MGRSSN

--12)
SELECT e.*,d.*
FROM Employee e LEFT OUTER JOIN [dbo].[Dependent] d
ON e.SSN=d.ESSN

--13)
INSERT INTO Employee 
VALUES('Ahmed','Hesham',102672,'1996-08-9','Alexandria','M',3000,112233,30)

--14)
INSERT INTO Employee (Fname,Lname,SSN,Bdate,Address,Sex,Dno)
VALUES('mohamed','etchoo',102660,'1995-07-20','Giza','M',30)

--15)
UPDATE Employee
SET Salary=Salary+.2*Salary
WHERE SSN=102672