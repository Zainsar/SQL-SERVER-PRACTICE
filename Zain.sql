select * from Employees;

alter Table employees add Age int;

update Employees SET Age = 21 where EmployeeID = 10;

select DepartmentID , sum(Salary) as total_salary from Employees Group by (DepartmentID);

select D.DepartmentName , sum(Salary) as total_salary from Employees as e join Departments as D on e.DepartmentID = D.DepartmentID Group by (D.DepartmentName);

select D.DepartmentName , sum(Salary) as total_salary from Employees as e join Departments as D on e.DepartmentID = D.DepartmentID Group by (D.DepartmentName) with rollup;

select e.FirstName, D.DepartmentName , sum(Salary) as total_salary from Employees as e join Departments as D on e.DepartmentID = D.DepartmentID Group by cube(e.FirstName,D.DepartmentName,Salary) ;