use ITI

--1)
select count(St_Id) 
from Student 
where St_Age is not null
--2)
select distinct Ins_Name 
from Instructor
--3)
select St_Id as [Student ID],ISNULL(St_Fname,'')+ISNULL(St_Lname,'') as [Student Full Name] ,dept.Dept_Name as [DepartmentName] from Student as stu
inner join Department as dept
on dept.Dept_Id = stu.Dept_Id
--4)
Select inst.[Ins_Name] as [Instruct Name], dept.[Dept_Name] as [Deparment Name] 
from Instructor as inst left outer join Department as dept
on inst.Dept_Id = dept.Dept_Id
--5)
Select Concat(St_Fname,' ',St_Lname) as [Full Name] ,stuCourse.Grade   
from Student student inner join Stud_Course stuCourse
on stuCourse.St_Id = student.St_Id
inner join Course as cou 
on cou.Crs_Id = stuCourse.Crs_Id
--6)
select  Course.Crs_Name, SUM( Topic.Top_Id) AS [Topic Number]   from Topic inner join Course
on Topic.Top_Id = Course.Top_Id
GROUP by Course.Crs_Name
--7)
select MAX(Salary) as maxi,MIN(Salary)as mini
from Instructor
--8)
Select  * 
from Instructor
where Salary < (select AVG(ISNULL(Salary,0)) from Instructor)
--9)
Select top(1) * 
from Department d , Instructor i
where d.Dept_Id = i.Dept_Id and Salary is not null	
order by Salary asc
--10)
select top(2) * 
from Instructor
where Salary is not null	
order by Salary desc
--11)
Select Ins_Name , coalesce(convert(varchar(20),Salary),'bouns')
from	Instructor
--12)
select AVG(ISNULL(Salary,0)) 
from Instructor
--13)
Select stu.St_Fname, sup.* 
from Student as stu inner join Student sup
on stu.St_Id = sup.St_Id
--14)
select *
from    (select Salary , ROW_NUMBER()over(partition by d.Dept_Id order by i.salary desc) as RN
		from Student s inner join Department d on d.Dept_Id = s.Dept_Id
		inner join Instructor i on i.Ins_Id = d.Dept_Manager
		) as newtable
where RN <= 2
--15)
select *
from (select *,ROW_NUMBER() over(partition by dept_id order by NEWID()) as RN from Student) as newtable
where RN = 1