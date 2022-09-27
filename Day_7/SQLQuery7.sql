--1
create View Vstudents
as
	select concat(St_Fname,' ',St_Lname) as Full_name , c.Crs_Name
	from Student s,Stud_Course sc ,Course c
	where s.St_Id = sc.St_Id and sc.Crs_Id = c.Crs_Id and sc.Grade > 50

select * from Vstudents

--2
create view vmanage with encryption as 
select ins_name as manger_name , crs_name as course
from Department d inner join Instructor i
on d.Dept_Manager = i.Ins_Id
inner join Ins_Course ic
on ic.Ins_Id = i.Ins_Id
inner join Course c
on c.Crs_Id=ic.Crs_Id
inner join Topic t
on t.Top_Id = c.Top_Id

select * from vmanage

--3
create view V3(i_name,d_name) as
select ins_name ,dept_name 
from Instructor i inner join Department d
on i.Dept_Id = d.Dept_Id
where d.Dept_Name='sd' or d.Dept_Name = 'java'
select * from V3

--4

create view v4
as 
select *
from student
where St_Address in ('Alex','cairo')
with check option
update v4
set St_Address = 'tanta'
where St_Address = 'alex'

--5
create view v5(pname,countemp)
as
select p.Pname, count(e.SSN)
from Company_SD.dbo.Project p, Company_SD.dbo.Works_for w, Company_SD.dbo.Employee e
where e.SSN = w.ESSn and w.Pno = p.Pnumber
group by p.Pname

select * from v5

--6
create schema Company
alter schema Company transfer dbo.departments

create schema HR
alter schema HR transfer dbo.employee

--7
create clustered index hiredindex
on department manager_Hiredate

Declare c1 Cursor
for select manager_Hiredate
from Department
for read only
declare @hiredate date
open c1
Fetch c1 into @hiredate
while @@FETCH_STATUS = 0
	begin
		select @hiredate
		fetch c1 into @hiredate
	end
close c1
deallocatec1

--8
create unique index ageIndex
on student(St_age)             --duplicate key

--9
declare c1 cursor
for select salary
	from employee
for update
declare @sal int
open c1
fetch c1 into @sal
while @@FETCH_STATUS = 0
	begin
		if @sal >= 3000
			update employee
				salary = @sal * 1.20
			where current of c1
		else
			update employee
				salary = @sal * 1.10
			where current of c1 
		fetch c1 into @sal
	end
close c1
deallocate c1

--10
declare c1 cursor
for select Ins_Name, Dept_Name
	from Department d, Instructor i
	where i.Ins_Id = d.Dept_Manager
for read only
declare @dname varchar(20), @mname varchar(20)
open c1
fetch c1 into @dname,@mname
while @@FETCH_STATUS = 0
	begin
		select @dname,@mname
		fetch c1 into @dname,@mname
	end
close c1
deallocate c1
--11
declare c1 cursor
for select distinct Ins_Name
	from Instructor
	where Ins_Name is not null
for read only

declare @name varchar(20),@names varchar(300) = ''
open c1
fetch c1 into @name
while @@FETCH_STATUS = 0
	begin
		set @names = concat(@names,',',@name)
		fetch c1 into @name
	end
select @names
close c1
deallocate c1