use task1;

select * from Employees;

select * from Departments;

alter Table employees add Age int;

update Employees SET Age = 21 where EmployeeID = 10;

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
