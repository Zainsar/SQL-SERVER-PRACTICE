create database Task;

use Task;

CREATE TABLE Employees (
    EmployeeID INT not null unique identity,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10, 2)
	foreign key (DepartmentID) references Departments(DepartmentID)
);

--2. Insert five employees into the Employees table.
--4. Assign each employee to a department in the Employees table.
INSERT INTO Employees (FirstName, LastName, DepartmentID, Salary)
VALUES

    ('John', 'Doe', 1, 60000.00),
    ('Jane', 'Smith', 2, 55000.00),
    ('Mike', 'Johnson', 1, 65000.00),
    ('Emily', 'Williams', 3, 70000.00),
    ('David', 'Brown', 2, 50000.00),
    ('Sarah', 'Miller', 1, 62000.00),
    ('Chris', 'Wilson', 3, 75000.00),
    ('Anna', 'Jones', 2, 53000.00),
    ('Brian', 'Taylor', 1, 58000.00),
    ('Laura', 'Anderson', 3, 72000.00);


-- Departments Table
CREATE TABLE Departments (
    DepartmentID INT not null unique identity,
    DepartmentName VARCHAR(50)

);

--3. Insert three departments into the Departments table.

INSERT INTO Departments (DepartmentName)
VALUES
    ( 'HR'),
    ( 'IT'),
    ( 'Finance');

	--1. Create a new table named Projects with columns ProjectID, ProjectName, and StartDate.
	CREATE TABLE Projects (
    ProjectID INT not null unique identity,
    ProjectName VARCHAR(50),
	EmployeesID int,
	StartDate int
	foreign key (EmployeesID) references Employees(EmployeeID)

);

INSERT INTO Projects (ProjectName ,EmployeesID , StartDate)
VALUES
    ( 'Database' , 3, 2-1-2024),
    ( 'Web Designing', 2 , 4-1-2024),
    ( 'Destop Application',1, 5-1-2024),
	( 'Database' , 4, 2-1-2024),
    ( 'Web Designing', 5 , 4-1-2024),
    ( 'Destop Application',6, 5-1-2024),
	( 'Database' , 7, 2-1-2024),
    ( 'Web Designing', 8 , 4-1-2024),
    ( 'Destop Application',9, 5-1-2024);

-- 5. Retrieve the details of employees whose salary is above 50000.
	select * from Employees as E Join Departments as D on E.DepartmentID = D.DepartmentID join Projects as p on E.EmployeeID = P.EmployeesID where E.Salary > 50000;

-- 6. Fetch a list of all employees along with the department they belong to.
	select * from Employees as E Join Departments as D on E.DepartmentID = D.DepartmentID;

-- 7. Retrieve the employees whose last name starts with 'S'.
	select * from Employees as E where e.LastName like 'S%';

-- 8. Retrieve the projects with names containing the word 'Database'.
	select * from Projects Where ProjectName = 'Database';

-- 9. Calculate the total salary of all employees.
	select sum(salary) from Employees ;

-- 10.Find the department with the highest average salary.
	SELECT DepartmentID , AVG(Salary) AS AverageSalary FROM Employees GROUP BY DepartmentID ORDER BY AverageSalary DESC;

	select * from Employees;

alter Table employees add Age int;

update Employees SET Age = 29 where EmployeeID = 1;

select DepartmentID , sum(Salary) as total_salary from Employees Group by (DepartmentID);

select D.DepartmentName , sum(Salary) as total_salary from Employees as e join Departments as D on e.DepartmentID = D.DepartmentID Group by (D.DepartmentName);

select D.DepartmentName , sum(Salary) as total_salary from Employees as e join Departments as D on e.DepartmentID = D.DepartmentID Group by (D.DepartmentName) with rollup;

select e.FirstName, D.DepartmentName , sum(Salary) as total_salary from Employees as e join Departments as D on e.DepartmentID = D.DepartmentID Group by cube(e.FirstName,D.DepartmentName,Salary) ;

--view
create view emp_view 
as
select * from Employees;

select * from emp_view;

--login
create login Zain with password ='ZainSarfraz';

--Display view Function
--method 1
sp_helptext emp_view;

--method 2
select definition from sys.sql_modules where object_id = object_id ('emp_view');

--method 3
select object_definition(object_id('emp_view'));

Create user Zain for login Zain ;
GO
--grant perimission
grant select,update,insert on dbo.Employees to Zain;

select * from Employees;
update Employees set FirstName = 'Zain' , LastName = 'Sarfraz' where EmployeeID = 1; 
insert into Employees (FirstName,LastName,DepartmentID,Salary,gender,Age) values('Sohaib','Sarfraz',1,70000,'M',21);
delete from employees where EmployeeID = 9;


revoke update on dbo.Employees from Zain;

deny delete on dbo.Employees to Zain;


--scale function = when you write scalar function this function rerturn single value
create function FullName()
returns varchar(255)
begin
return 'Zain Sarfraz'
end

select dbo.FullName() as Name;

--scalar function with parameter
-- parameter declare by @

create function Addition (@num1 as int , @num2 as int)
returns int
begin
return (@num1 + @num2)
end

select dbo.Addition(3,4) as Addition;

--function with variable

create function Student(@age as int)
returns varchar(255)
as
begin
declare @str varchar (100)
if(@age >= 15)
begin
set @str ='Ajao tum bhi pagal hone' 
end
else
begin
set @str = 'Bach Gaye tum Ghar Jao'
end
return @str
end

select dbo.Student(16) as Eligble;

--table-valued functions

create function emp()
returns table
as
return select * from Employees;

select * from emp();

--with parameter

create function depart(@Department as varchar(255))
returns table
as
return select * from Departments where DepartmentName = @Department;

select * from depart('HR') ;

alter function depart()
returns table
as
return select distinct d.DepartmentName from Departments as d

select * from depart();
