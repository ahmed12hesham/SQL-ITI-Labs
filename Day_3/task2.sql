--create Database institute
create table instructor
(
id int primary key identity(1,1),
hiredate varchar(20),
Addres  varchar(20) default 'Alex',
salary  int default 3000,
overtime int,
BD  date default getdate(),
fname  varchar(20),
lname  varchar(20),
netsalary as (isnull(salary,0) + isnull(overtime,0)) persisted,
age as (year(getdate()) - year(BD)),
constraint c1 check(Addres in('Alex','zagazig')),
constraint c2 check(salary between 1000 and 5000),
constraint c3 unique(overtime)
)
create table course
(
cid int primary key identity(1,1),
cname  varchar(30),
duration  int,
constraint c1 unique(duration)
)
create table teach
(
cid int identity(1,1),
id int,
constraint c1 primary key(cid,id),
constraint c2 foreign key(id) references instructor(id) on delete cascade on update cascade,
constraint c3 foreign key(cid) references course(cid) on delete cascade on update cascade
)
create table lab
(
lid int identity(1,1),
loc  varchar(20),
capacity  varchar(20),
cid int,
constraint c1 primary key(lid,cid),
constraint c2 foreign key(cid) references course(cid) on delete cascade on update cascade,
constraint c3 check(capacity = 20)
)
