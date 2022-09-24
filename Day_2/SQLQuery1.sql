use Company_SD

select *
from employee

select Fname,Lname,Salary,Dno
from Employee

select Pname,Plocation,Dnum
from Project

select (Salary * 12 * 0.1) as ANNUAL_COMM 
from Employee

select SSN , Fname + ' ' + Lname as Full_name
from Employee
where Salary > 1000

select SSN , Fname + ' ' + Lname as Full_name
from Employee
where Salary * 12  > 10000

select Fname + ' ' + Lname as Full_name
from Employee
where Sex = 'F'

select Dnum,Dname
from Departments
where MGRSSN = 968574

select Pname , Pnumber , Plocation
from Project
where Dnum = 10