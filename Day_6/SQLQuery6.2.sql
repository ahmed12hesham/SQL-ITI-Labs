--1
go
create function getmonth(@date date)
returns varchar(10)
	begin
			return datename(month,@date)
	end

--2
create function valuesbetween(@x int, @y int)
returns @values table(
						numbers int
						)
as
	begin
		while @x < @y -1
			begin
				set @x += 1
				insert into @values
				select @x    --show th x value
			end
		return
	end
select * from valuesbetween(2,6)

--3
create function studentid(@sid int)
returns table
as
return(
	select Dept_Name,St_Fname + ' ' + St_Lname as Full_name
	from Student s, Department d
	where s.Dept_Id = d.Dept_Id and s.St_Id = @sid
)
select * from studentid(10)

--4
create function messages(@mid int)
returns varchar(20)
	begin
		declare @mes varchar(20)
		if(select St_Fname from student where St_Id = @sid) is null and (select St_Lname from student where St_Id = @sid)
			select @mesg = 'First name is null and Last name is null'
		else if(select St_Fname from student where St_Id = @sid) is null
			select @mesg = 'First name is null'
		else if(select St_Lname from student where St_Id = @sid) is null
			select @mesg = 'Last name is null'
	return @mesg
	end
select dbo.messages(15)

--5
create function mgrdata(@mgrid int)
returns table 
as return (select d.Dept_Name ,d.Manager_hiredate ,i.Ins_Name   
from Department d inner join Instructor i 
on i.Ins_Id = d.Dept_Manager 
where i.Ins_Id=@mgrid)

--6
create function st_data(@string varchar(20))
returns @t table
	(
	names varchar(50)
	)
as
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
update Stud_Course
set Grade = null
from Stud_Course inner join hr.Student
on Stud_Course.St_Id = hr.Student.St_Id inner join Department
on hr.Student.Dept_Id = Department.Dept_Id and Dept_Name = 'SD'

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


----------------------------bouns-------------------------------
CREATE TABLE [dbo].[Vessel](
[VesselId] [int] IDENTITY(1,1) NOT NULL,
[VesselName] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Vessel] PRIMARY KEY CLUSTERED
(
[VesselId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Ranks](
[RankId] [int] IDENTITY(1,1) NOT NULL,
[Rank] [varchar](50) NOT NULL,
[RankNode] [hierarchyid] NOT NULL,
[RankLevel] [smallint] NOT NULL,
[ParentRankId] [int]   -- this is redundant but we will use this to compare        
                       -- with parent/child
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_RankId] ON [dbo].[Ranks]
(
[RankId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE UNIQUE CLUSTERED INDEX [IX_RankNode] ON [dbo].[Ranks]
(
[RankNode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Crew](
[CrewId] [int] IDENTITY(1,1) NOT NULL,
[CrewName] [varchar](50) NOT NULL,
[DateHired] [date] NOT NULL,
[RankId] [int] NOT NULL,
[VesselId] [int] NOT NULL,
 CONSTRAINT [PK_Crew] PRIMARY KEY CLUSTERED
(
[CrewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Crew]  WITH CHECK ADD  CONSTRAINT [FK_Crew_Ranks] FOREIGN KEY([RankId])
REFERENCES [dbo].[Ranks] ([RankId])
GO

ALTER TABLE [dbo].[Crew] CHECK CONSTRAINT [FK_Crew_Ranks]
GO

ALTER TABLE [dbo].[Crew]  WITH CHECK ADD  CONSTRAINT [FK_Crew_Vessel] FOREIGN KEY([VesselId])
REFERENCES [dbo].[Vessel] ([VesselId])
GO

ALTER TABLE [dbo].[Crew] CHECK CONSTRAINT [FK_Crew_Vessel]
GO

-----Rank table---------

INSERT INTO dbo.Ranks
([Rank], RankNode, RankLevel)
VALUES
 ('Captain', '/',0)
,('First Officer','/1/',1)
,('Chief Engineer','/2/',1)
,('Hotel Director','/3/',1)
,('Second Officer','/1/1/',2)
,('Second Engineer','/2/1/',2)
,('F&B Manager','/3/1/',2)
,('Chief Housekeeping','/3/2/',2)
,('Chief Purser','/3/3/',2)
,('Casino Manager','/3/4/',2)
,('Cruise Director','/3/5/',2)
,('Third Officer','/1/1/1/',3)
,('Third Engineer','/2/1/1/',3)
,('Asst. F&B Manager','/3/1/1/',3)
,('Asst. Chief Housekeeping','/3/2/1/',3)
,('First Purser','/3/3/1/',3)
,('Asst. Casino Manager','/3/4/1/',3)
,('Music Director','/3/5/1/',3)
,('Asst. Cruise Director','/3/5/2/',3)
,('Youth Staff Director','/3/5/3/',3)
