select Sum(salary)
from Instructor

Select Max(salary) as Max_val,Min(salary) as Min_Val
from Instructor

select count(st_id),count(*),Count(st_age)
from Student

select avg(st_age)
from Student

select avg(isnull(st_age,0))
from Student

select sum(st_age)/Count(*)
from Student

select sum(salary),dept_id
from Instructor
group by dept_id

select sum(salary),d.dept_id,dept_name
from Instructor i inner join Department d
	 on d.Dept_Id=i.Dept_Id
group by d.dept_id,dept_name

Select avg(st_age),st_address,dept_id
from Student
group by st_address,Dept_Id

select sum(salary),dept_id
from Instructor
group by dept_id

select sum(salary),dept_id
from Instructor
where salary>1000
group by dept_id

select sum(salary),dept_id
from Instructor
where salary>6000
group by dept_id

select sum(salary),dept_id
from Instructor
group by dept_id

select sum(salary),dept_id
from Instructor
group by dept_id
having sum(salary)>50000

select sum(salary),dept_id
from Instructor
group by dept_id
having Count(ins_id)>5

select sum(salary),dept_id
from Instructor
group by dept_id
having sum(salary)>50000

select sum(salary),dept_id
from Instructor
where salary>1000
group by dept_id
having sum(salary)>50000
-------------------------------
-------------------------------
--Subquery
select *
from Student
where st_age<(select avg(St_Age) from student)

select *,(select count(st_id) from Student)
from student

select dept_name
from Department
where dept_id in (select distinct dept_id
				   from Student
					where dept_id is not null)

select distinct dept_name
from Student S inner join Department d
	on d.Dept_Id=s.Dept_Id

--Subqueries +DML
delete from Stud_Course
where st_id=1

delete from Stud_Course
where st_id in (select st_id from Student 
				where st_address='cairo')

--Union family
--union all    union      except   intersect

--Batch
select st_fname as names
from Student
union all
select ins_name
from Instructor

select st_fname,st_id
from Student
union all
select ins_name,ins_id
from Instructor

select convert(varchar(2),st_id)
from Student
union all
select ins_name
from Instructor

select st_fname 
from Student
union 
select ins_name
from Instructor

select st_fname 
from Student
intersect 
select ins_name
from Instructor

select st_fname 
from Student
except
select ins_name
from Instructor

--Agg + grouping
--subquery
--union
--Data Types
--------------------Numermic DT
bit  --bool   false:true   0:1
tinyint 1 Byte  -128:+127  unsigned  0:255
smallint 2B   -32768 : +32767   unsigned 0:65500
int      4B
bigint   8B
--------------------Decimal DT
smallmoney  4B   .0000
money       8B   .0000
real        4B   .0000000
float            .00000000000000000000000
dec   decimal   dec(5,2)  123.90   1.2     12.333 XXX
--------------------String DT  & Character DT
char(10)    [Fixed Length characters]  ahmed 10   ali 10  على ؟؟
varchar(10) [variable length characters] ahmed 5   ali 3
nchar(10) unicode على على  
nvarchar(10)
nvarchar(max) cccccccccccccccccccccc    up to 2GB
-------------------- Date & Time DT
Date  11/10/2020
Time hh:mm:12.897
Time(7) hh:mm:12.9876543
smalldatetime  mm/dd/YYYY hh:mm:00
datetime mm/dd/YYYY hh:mm:ss.786
datetime2(7) mm/dd/YYYY hh:mm:ss.7867654
--------------------Binary DT
binary    011101  111100
image
--------------------others
sql_variant
uniqueidentifier
XML
----------------------------------------------

select  st_fname+' '+st_lname as fullname
from Student
order by fullname

select  st_fname+' '+st_lname as fullname
from Student
where fullname='ahmed ali'

select  st_fname+' '+st_lname as fullname
from Student
where st_fname+' '+st_lname='ahmed ali'

select *
from	(select  st_fname+' '+st_lname as fullname
		 from Student) as newtable
where fullname='ahmed ali'

--from
--join
--on
--where 
--group
--having
--select
--order by
--top

create table test
(
 eid int identity(1,1),
 SSN int  primary key,
 ename varchar(20)
)

select * from test

delete from test

truncate table test

insert into test
values(3388,'eman')

insert into test
values(5467,'eman')

drop table test           ---data  & Metadata

delete from test            ------data
where

truncate table test          ------data

.ldf     .mdf

--Batch  Script   Transaction
insert
go
update


--DDL
create rule
go
sp_bindrule
go
create table
go
drop table

--------------------------
create table parent(pid int primary key)

create table child(cid int foreign key references parent(pid))

insert into parent values(1)
insert into parent values(2)
insert into parent values(3)
insert into parent values(4)

begin transaction
	insert into child values(1)
	insert into child values(10)
	insert into child values(3)
commit


select * from child
truncate table child

begin try
	begin transaction
	insert into child values(1)
	insert into child values(200)
	insert into child values(3)
	commit
end try
begin catch
	ROLLBACK
	select ERROR_LINE() ,ERROR_MESSAGE(), ERROR_NUMBER()
end catch

begin transaction
	insert
	truncate
	update
	delete
--------

--case   IIF
select ins_name,salary,
			case
			when salary>=3000 then 'high sal'
			when salary<3000 then 'low'
			else 'no data'
			end   as newsal
from Instructor

select ins_name,iif(salary>=3000,'high','low')
from Instructor

update Instructor
	set salary=
			case
			when salary >=3000 then salary*1.10
			else salary*1.20
			end


--Agg + grouping
--subquery
--union
--Data Types
--truncate
--transaction
--case  iif




