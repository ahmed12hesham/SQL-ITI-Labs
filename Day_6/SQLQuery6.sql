
use iti
--1
go
create function getmonth(@date date)
returns varchar(10)
	begin
			return datename(month,@date)
	end
go
--2
create function value(@number1 int ,@number2 int)
returns @t table
	(
	numbers int
	)
 begin 
		declare @x as int =@number1
		while @x<@number2
		begin
			insert into @t values(@x)
			set @x=@x+1
		end
		return
 end

 go
 --3

 create function data(@st_num int)
 returns table
 as return
 (select 
 concat(st_fname,' ',st_lname)as fullname ,dept_name 
 from Student s inner join Department d
 on d.Dept_Id=s.Dept_Id 
 where s.St_Id=@st_num)


 /*create function data(@st_num int)
 returns table
 as return
 (select 
 concat(st_fname,' ',st_lname)as fullname ,dept_name 
 from Student s inner join Department d
 on d.Dept_Id=(select s.Dept_Id from Student where s.St_Id=@st_num)*/

 go

 --4
 create function msg(@st_no int)
	returns varchar(200)
		begin
			declare @fname varchar(50)
			declare @lname varchar(50)
			declare @fullname varchar(50)
			select @fname = st_fname from Student
			select @lname = st_lname from Student
			select @fullname = CONCAT(st_fname,' ',st_lname)from Student
			where st_id =@st_no
			if @fname is null and @lname is null 
			return 'First name & last name are null'
			else if @fname is null 
			return 'first name is null'
			else if @lname is null 
			return 'last name is null'
			else 
			return 'First name & last name are not null'
		end

	go

--5

create function mgrdata(@mgrid int)
returns table 
as return (select d.Dept_Name ,d.Manager_hiredate ,i.Ins_Name   
from Department d inner join Instructor i 
on i.Ins_Id = d.Dept_Manager 
where i.Ins_Id=@mgrid)

go

--6

create function st_data(@string varchar(20))
returns @t table
	(
	names varchar(50)
	)
	begin 
		if @string = 'first name'
		insert into @t
		select isnull(st_fname,'') from Student
		else if @string ='last name'
		insert into @t
		select ISNULL(st_lname,'') from Student
		else if @string ='full name'
		insert into @t
		select isnull(CONCAT(st_fname,' ',st_lname),'')as fullname from Student
		return
	end

go

--7
select st_id , SUBSTRING(St_Fname,1,(len(St_Fname)-1) )
from Student

--8
delete from Stud_Course where st_id =
(select st_id from Student 
where Dept_Id= (select dept_id from Department 
where dept_name ='sd'))

--9

create table daily_transaction
	(
	did int ,
	transaction_amount int 
	)

create table last_transaction
	(
	lid int ,
	transaction_amount int 
	)

	merge into last_transaction as t
	using daily_transaction as s
	on t.lid=s.did
	when matched then 
	update set t.transaction_amount=s.transaction_amount
	when not matched then 
	insert values (s.did,s.transaction_amount);

--10
create schema hr 
alter schema hr transfer student
alter schema hr transfer course	

select * from hr.Course

