use Company_SD

--1)
select Dependent_name , d.sex 
from Dependent d , Employee e
where e.SSN = d.ESSN and e.Sex = 'f' and d.Sex = 'f'
union all
select Dependent_name , d.sex 
from Dependent d , Employee e
where e.SSN = d.ESSN and e.Sex = 'm' and d.Sex = 'm' 
--2)
select Pname , sum(hours)*7
from Works_for w,Project p
where p.Pnumber = w.Pno
group by Pname
--3)
select *
from Departments
where Dnum = (
				select Dno 
				from Employee 
				where SSN = (
								select min(ssn) 
								from Employee
							)
			 )
--4)
select max(Salary) as MaxSalary, min(Salary) as MinSalary 
from Employee
group by Dno 
--5)
select e.Fname + ' ' + e.Lname as Full_name
from Employee e , Departments d
where e.SSN in (d.MGRSSN) and not exists(select ESSN from Dependent)			
--6)
select AVG(Salary) as Average , (select AVG(Salary) from Employee) as total_sal, d.Dnum,d.Dname, COUNT(e.SSN)
from Employee e,Departments d
where d.Dnum = e.Dno
group by d.Dnum,d.Dname
having AVG(salary) < (select AVG(Salary) from Employee)
--7)
select e.Fname + ' ' + e.Lname as Full_name , p.Pname
from Employee e, Project p, Works_for
where e.SSN = Works_for.ESSn and Works_for.Pno = p.Pnumber
order by Dno ,  Full_name
--8)
select MAX(Salary) as first_max,(
									select max(Salary)
									from Employee
									where Salary != (select MAX(Salary) from Employee)
								) as Secound_max
from Employee
--9)
select e.Fname + ' ' + e.Lname as Full_name
from Employee e
intersect
select d.Dname
from Departments d
--10)
select SSN , CONCAT(Fname,' ',Lname) as FULL_Name
from Employee
where exists (select ESSN from Dependent where ESSN = SSN)
--11)
insert into Departments values ('DEPT_IT',108,112233,'1-11-2006')

--12)
--a
update Departments
set MGRSSN = 968574
where Dnum = 100
--b
update Departments
set MGRSSN = 102672
where Dnum = 20
--c
update Employee
set Superssn = 102672
where SSN = 102660

--13)
delete from Dependent
where ESSN = 223344

delete from Works_for
where ESSn = 223344

update Departments 
set MGRSSN = null
where MGRSSN = 223344

update Employee 
set Superssn = null
where Superssn = 223344

delete from Employee
where SSN = 223344

--14)
update Employee
set Salary *=1.3
where SSN in (
				select e.SSN
				from Employee e, Works_for w, Project p
				where e.SSN = w.ESSn and w.Pno = p.Pnumber and p.Pname = 'Al Rabwah'
			 )
