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

--STORE PROCEDURE

CREATE PROCEDURE spemp
as
begin
select * from Employees
end
go

exec spemp

CREATE PROCEDURE spdepart
as
begin
select e.FirstName , e.LastName , d.DepartmentName from Employees as e join Departments as d on e.DepartmentID = d.DepartmentID where e.DepartmentID = 1;
end
go

exec spdepart

ALTER PROCEDURE spdepart
as
begin
select e.FirstName , e.LastName ,e.Salary, d.DepartmentName from Employees as e join Departments as d on e.DepartmentID = d.DepartmentID where e.DepartmentID = 1;
end
go

exec spdepart


create PROCEDURE Student21
@id int
as
begin
select * from Employees where EmployeeID = @id;
end
go

exec Student21 1

alter procedure zain
@ids int ,
@fname varchar(255)
as
begin
select FirstName , LastName , ((Salary/100)*5) + Salary as salary from Employees where EmployeeID = @ids
end
go

exec zain @ids = 1 , @fname = 'Zain'

select * from Employees
--Show Increment Salary by EmployeeID
Create PROCEDURE IncrementSalary
    @EmployeeID INT,
	@IncrementAmount DECIMAL(10, 2)
AS
BEGIN
    SELECT FirstName, LastName, Salary + @IncrementAmount
    FROM Employees
    WHERE EmployeeID = @EmployeeID;
END;

EXEC IncrementSalary @EmployeeID = 1, @IncrementAmount = 2000;

--Update Increment Salary by EmployeeID
CREATE PROCEDURE UpdateIncrementSalary
    @EmployeeID INT,
    @IncrementAmount DECIMAL(10, 2)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Employees
    SET Salary = Salary + @IncrementAmount
    WHERE EmployeeID = @EmployeeID;

    SELECT FirstName, LastName, Salary
    FROM Employees
    WHERE EmployeeID = @EmployeeID;
END;

EXEC UpdateIncrementSalary @EmployeeID = 1, @IncrementAmount = 1000;

--Show Increment Salary by EmployeeID or FirstName
CREATE PROCEDURE ShowIncrementSalary
    @Identifier NVARCHAR(100),
    @IncrementAmount DECIMAL(10, 2)
AS
BEGIN
        IF EXISTS (
        SELECT 1
        FROM Employees
        WHERE EmployeeID = TRY_CAST(@Identifier AS INT)
            OR FirstName = @Identifier
    )
    BEGIN
        SELECT FirstName, LastName, Salary + @IncrementAmount
        FROM Employees
        WHERE EmployeeID = TRY_CAST(@Identifier AS INT)
            OR FirstName = @Identifier;
    END
    ELSE
    BEGIN
        PRINT 'Employee not found.';
    END
END;

EXEC ShowIncrementSalary @Identifier = '1', @IncrementAmount = 1000;

EXEC ShowIncrementSalary @Identifier = 'Zain', @IncrementAmount = 500;

--Update Increment Salary by EmployeeID or FirstName
CREATE PROCEDURE UpdateIncrementSalary2
    @Identifier NVARCHAR(100),
    @IncrementAmount DECIMAL(10, 2)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM Employees
        WHERE EmployeeID = TRY_CAST(@Identifier AS INT)
            OR FirstName = @Identifier
    )
    BEGIN
        UPDATE Employees
        SET Salary = Salary + @IncrementAmount
        WHERE EmployeeID = TRY_CAST(@Identifier AS INT)
            OR FirstName = @Identifier;

        SELECT FirstName, LastName, Salary
        FROM Employees
        WHERE EmployeeID = TRY_CAST(@Identifier AS INT)
            OR FirstName = @Identifier;
    END
    ELSE
    BEGIN
        PRINT 'Employee not found.';
    END
END;

EXEC UpdateIncrementSalary2 @Identifier = '1', @IncrementAmount = 1000;

EXEC UpdateIncrementSalary2 @Identifier = 'Zain', @IncrementAmount = 500;

alter table employees alter column Gender varchar(255) 

alter Table employees add Gender varchar(255);

update Employees SET Gender = 'Male'

update Employees SET Gender = 'Female' where EmployeeID = 4 or EmployeeID = 6 or EmployeeID = 8 or EmployeeID = 10;

select * from Employees where Gender in (select Gender from Employees where Gender = 'Female')

select * from Employees where Salary in (select Salary from Employees where Salary > 70000)

select * from Employees where DepartmentID = (select DepartmentID from Departments where DepartmentName = 'IT')

create table HR_Emp(
EmployeeID int,
Name Varchar(255),
Salary decimal(10,2),
Gender Varchar(255)
);

select * from HR_Emp

insert into HR_Emp (EmployeeID,Name,Salary,Gender)
select EmployeeID,FirstName,Salary,Gender from Employees where DepartmentID = (select DepartmentID from Departments where DepartmentName = 'HR')

create table IT_Emp(
EmployeeID int,
Name Varchar(255),
Salary decimal(10,2),
Gender Varchar(255)
);

select * from IT_Emp

insert into IT_Emp (EmployeeID,Name,Salary,Gender)
select EmployeeID,FirstName,Salary,Gender from Employees where DepartmentID = (select DepartmentID from Departments where DepartmentName = 'IT')

create table fin_Emp(
EmployeeID int,
Name Varchar(255),
Salary decimal(10,2),
Gender Varchar(255)
);

select * from fin_Emp

insert into fin_Emp (EmployeeID,Name,Salary,Gender)
select EmployeeID,FirstName,Salary,Gender from Employees where DepartmentID = (select DepartmentID from Departments where DepartmentName = 'finance')

select * from Employees where Salary < any (select Salary from Employees where Salary > 70000)

select * from Employees where Salary not in (select Salary from Employees where Salary > 70000)

select * from Employees where Salary in (select Salary from Employees where Salary > 70000)

select * from Employees where Salary <= all (select Salary from Employees where Salary > 70000)

select * from Employees
